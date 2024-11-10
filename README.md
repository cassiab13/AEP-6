# SMS Seguro
Este é um projeto desenvolvido para a Atividade de Estudo Programado do 6º semestre do curso de Engenharia de Software da Unicesumar.
O aplicativo utiliza Flutter no frontend e em Python no backend e possui como objetivo analisar as mensagens SMS do usuário, verificando a segurança das URLs contidas nas mensagens.
Para isso, o projeto utiliza uma API (Virus Total) para verificar a segurança das URLs e um modelo de machine learning (Random Forest) para realizar a análise.

## Visão Geral
O aplicativo utiliza Flutter para a interface com o usuário e Python no backend, onde faz uso da API VirusTotal para verificar a segurança das URLs e de um modelo de Machine Learning (Random Forest) para análises adicionais.

## Como funciona?
- **Análise de segurança da URL em mensagens SMS:** Verifique URLs de mensagens, identificando se são seguras ou inseguras.
- **Exibição de mensagens e URLs analisadas:** Traz uma lista das mensagens e URLs analisadas com o resultado da verificação efetuada.
- **Interface do usuário em Flutter:** Navegação intuitiva e exibição dos resultados.


## Tecnologias

- **Front-end**: Flutter
- **Back-end**: Python (Django)

## Pré-requisitos

- Flutter SDK
- Python instalado com as dependências do arquivo requirements.txt
- Conta e chave de API na API do VirusTotal

## Rodar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/cassiab13/aep-6.git

2. Configuração do frontend (Flutter)
   Navegue até a pasta do aplicativo Flutter e execute o projeto:
 - cd aplicativo/gerenciador_mensagens
 - flutter run

3. Configuração do backend (Python)
   Navegue até a pasta backend/sms_seguro e inicie o servidor Django:
  - cd backend/sms_seguro
  - python manage.py runserver

4. Acesse o site do Virustotal (https://www.virustotal.com/gui/home/url), faça o cadatro e gere a API key
  - Adicione um arquivo .env na pasta backend-api com as seguintes variáveis:
  - API_URL = "https://www.virustotal.com/api/v3"
  - API_KEY = "(chave gerada)"

Agora o projeto estará disponível para teste e uso. Acesse o aplicativo e insira uma mensagem SMS para verificar a segurança das URLs!

Desenvolvedores
  - Cassia Basso
  - Jean Soares - https://github.com/jeanunicesumar
