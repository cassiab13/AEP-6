import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .api_request import submit_url, check_analysis_status, is_url_safe
from .url_utils import extract_url, verify_if_url_is_redirected

@csrf_exempt
def analyze_message(request):
    if request.method == "POST":
        data = json.loads(request.body)
        message = data.get("message", "")
        print('MESSAGE:', message)
        urls = extract_url(message)
        print('URLS: ', urls)
        redirected_urls = verify_if_url_is_redirected(urls)

        results = []
        for url in redirected_urls:
            print(url)
            analysis_id = submit_url(url)
            if analysis_id:
                analysis_result = check_analysis_status(analysis_id)
                safe = is_url_safe(analysis_result)
                results.append({"url": url, "safe": safe})
                
        print (results)
        return JsonResponse({"results": results})
    return JsonResponse({"error": "Método não permitido"}, status=405)
