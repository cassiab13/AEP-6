import re
import requests

def extract_url(message):                
    urls = re.compile(r'(http[s]?://\S+|(?:www\.)?\w+\.\w{2,}(?:\.\w{2,})?/\w{2,}?)')
    return re.findall(urls, message)

def adjust_url(urls):
    adjusted_urls = []
    for url in urls:
        if not url.startswith("http://") and not url.startswith("https://"):
            url = f"https://{url}"
        adjusted_urls.append(url)
    return adjusted_urls

def verify_if_url_is_redirected(urls):
    final_urls = []
    adjusted_urls = adjust_url(urls)
    for url in adjusted_urls:
        print(f"Verificando URL ajustada: {url}")
        try:
            response = requests.head(url, allow_redirects=True)
            print(f"Status da resposta: {response.status_code}")
            if response.status_code in {301, 302}:
                redirected_url = response.headers.get('Location')
                print(f"Redirecionado para: {redirected_url}")
                final_urls.append(redirected_url)
            else:
                final_urls.append(url)
        except requests.RequestException as e:
            print(f"A URL não existe ou encontra-se indisponível")
    return final_urls

message = "Ola. Outubro e o mes da Ciberseguranca. Por isso, compartilharemos com voce dicas para manter sua seguranca digital. Veja mais: https://vivo.tl/dicas?jo6i "
urls = extract_url(message)