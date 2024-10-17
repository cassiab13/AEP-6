import requests
import os
from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv('API_KEY')
api_url = os.getenv('API_URL')

def make_request(method, url, headers, data=None):
    if method == 'POST':
        response = requests.post(url, headers=headers, data=data)
        
    if method == 'GET':
        response = requests.get(url, headers=headers)
    return response

def submit_url(url_to_check):
    
    headers = {
        "accept": "application/json",
        "x-apikey": api_key
    }

    response = make_request('POST', f'{api_url}/urls', headers, data={"url": url_to_check})

    if response.status_code != 200:
        print(f"Erro ao submeter URL: {response.status_code} - {response.text}")
        return None
    
    return response.json()['data']['id']

def check_analysis_status(analysis_id):
    if not api_key:
        raise ValueError("API_KEY não encontrada no ambiente")

    headers = {
        "accept": "application/json",
        "x-apikey": api_key
    }

    analysis_url = f"{api_url}/analyses/{analysis_id}"
    response = make_request('GET', analysis_url, headers)

    if response.status_code != 200:
        print(f"Erro ao verificar análise: {response.status_code}")
        return None
    
    return response.json()['data']['attributes']['stats']

def is_url_safe(api_result):
    if api_result['malicious'] == 0 and api_result['suspicious'] == 0:
        print("true")
        return True
    return False
