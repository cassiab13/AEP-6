from url.url_utils import extract_url, verify_if_url_is_redirected
from request.api_request import submit_url, check_analysis_status, is_url_safe

def main():
    message = "Ola. Outubro e o mes da Ciberseguranca. Por isso, compartilharemos com voce dicas para manter sua seguranca digital. Veja mais: https://vivo.tl/dicas?jo6i"
    urls = extract_url(message)
    if not urls:
        print("Nenhuma URL encontrada na mensagem.")
        return

    final_urls = verify_if_url_is_redirected(urls)

    for url in final_urls:
        print(f"Verificando a URL com a API: {url}")
        analysis_id = submit_url(url)
        api_result = check_analysis_status(analysis_id)
        return is_url_safe(api_result)
main()