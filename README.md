# CNPJ-socios
## download dos dados

Rode o arquivo em R (qualificacao-socio.R) para criação de arquivo em csv com o codigio e descrição de cada sócio (qualificacao-socio.csv)

Após, executar o script em R, em linha de comando instale as bibliotecas necessárias executando:

pip install -r requirements.txt

Para os próximos passos será necessário o Python 3.6, você deverá rodá-lo em várias etapas:

Primeiro, crie o script que baixa os arquivos:
python socios-CNPJ.py create-download-script

Após executar, um arquivo download.sh será criado. Esse script precisa do wget instalado (que é o padrão em distribuições GNU/Linux - caso use MacOS, instale-o rodando brew install wget). Rode o script para baixar todos os arquivos de sócios da Receita Federal:
sh download.sh

Converta-os para CSV com o seguinte comando:
python socios-CNPJ.py convert-all

Um diretório output será criado com os CSVs (que estarão com codificação UTF-8, separados por vírgula).
