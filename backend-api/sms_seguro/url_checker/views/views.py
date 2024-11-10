import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from url_checker.machine_learning.random_forest import predict_url
from url_checker.service.message_service import MessageService
from ..service.api_request import submit_url, check_analysis_status, is_url_safe
from ..service.url_utils import extract_url, verify_if_url_is_redirected
import joblib
import os
from django.conf import settings
from ..models.models import Messages, UrlAnalysis
from django.db.models import Prefetch

model_path = os.path.join(settings.BASE_DIR, 'random_forest.pkl')
model = joblib.load(model_path)

@csrf_exempt
def analyze_message(request):
    if request.method == "POST":
        data = json.loads(request.body)
        message = data.get("message", "")
        
        urls = extract_url(message)
        redirected_urls = verify_if_url_is_redirected(urls)
        message_analysis = Messages.objects.create(message_text=message)
        
        results = []
        for url in redirected_urls:
            analysis_id = submit_url(url)
            api_safe = False
            if analysis_id:
                analysis_result = check_analysis_status(analysis_id)
                api_safe = is_url_safe(analysis_result)
            rf_safe = predict_url(model, url)

            url_analysis = UrlAnalysis.objects.create(
                message=message_analysis,
                url=url,
                api_safe=api_safe,
                rf_safe=rf_safe,
                analysis_id=analysis_id
            )
            print(url_analysis.message.message_text, url_analysis.url, url_analysis.api_safe, url_analysis.analysis_id)
            url_analysis.save()  
            results.append({
                "url": url_analysis.url,
                "api_safe": url_analysis.api_safe,
                "rf_safe": url_analysis.rf_safe
            })
            
            response_data = {
                "messages": [
                {
                    "message_text": message_analysis.message_text,
                    "urls": results
                }
            ]
            }
            return JsonResponse(response_data)
    return JsonResponse({"error": "Método não permitido"}, status=405)

def list_messages(request):
    messages = MessageService.get_all_messages().prefetch_related(
        Prefetch('urls', queryset=UrlAnalysis.objects.all())
    )

    messages_data = [
        {
            'message_text': msg.message_text,
            'urls': [
                {
                    'url': url.url,
                    'api_safe': url.api_safe,
                    'rf_safe': url.rf_safe
                }
                for url in msg.urls.all()],
        }
        for msg in messages
    ]
    return JsonResponse({"messages": messages_data})
