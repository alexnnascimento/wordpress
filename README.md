Configuração do WordPress com Docker Compose
Este repositório contém os arquivos necessários para configurar um ambiente WordPress usando Docker Compose.


Versões instaladas:

WordPress: 6.5.4
PHP: 8.3

Clone o repositório para a sua máquina local:

git clone https://github.com/alexnnascimento/wordpress.git
cd wordpress

Crie um arquivo .env na raiz do projeto e configure as variáveis de ambiente necessárias para acesso ao banco de dados:

DB_NAME=nome_do_banco
DB_USER=usuario_do_banco
DB_PASSWORD=senha_do_banco
DB_HOST=host_do_banco

Substitua nome_do_banco, usuario_do_banco, senha_do_banco e host_do_banco pelos dados de acesso corretos do seu banco de dados.

Para iniciar o serviço, execute o seguinte comando:

docker-compose up -d

Isso iniciará o ambiente Docker com WordPress configurado. Você poderá acessar o WordPress através do seu navegador no endereço http://localhost.

