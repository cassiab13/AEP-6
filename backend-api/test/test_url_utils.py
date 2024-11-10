import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from ..sms_seguro.url_checker.url_utils import adjust_url, extract_url, verify_if_url_is_redirected

def test_extract_url():
    message = "Qualquer mensagem contendo uma url http://www.unicesumar.edu.br"
    assert extract_url(message) == ['http://www.unicesumar.edu.br']
    
def test_adjust_url():
    url = ['unicesumar.edu.br']
    assert adjust_url(url) == ["https://unicesumar.edu.br"]

def test_verify_if_url_is_redirected():
    url = ['unicesumar.edu.br']
    assert verify_if_url_is_redirected(url) == "https://www.unicesumar.edu.br"