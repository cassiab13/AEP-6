import sys
import os
from dotenv import load_dotenv

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from  request.api_request import make_request, submit_url, check_analysis_status, is_url_safe
load_dotenv()
api_key = os.getenv('API_KEY')
api_url = os.getenv('API_URL')

def test_make_request():
    headers = {
        "accept": "application/json",
        "x-apikey": api_key
    }
    response = make_request('POST', f'{api_url}/urls', headers, data = {'url': 'https://vivo.tl/dicas?jo6i'})
    assert response.status_code == 200

