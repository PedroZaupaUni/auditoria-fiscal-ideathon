from flask import Flask, request, jsonify

app = Flask(__name__)

# Endpoint de verificação de saúde, continua o mesmo.
@app.route('/')
def health_check():
    return "Serviço de IA em Python está no ar!"

# Novo endpoint para receber os dados para análise
@app.route('/analisar', methods=['POST'])
def analisar():
    # Por enquanto, vamos apenas confirmar que recebemos a chamada.
    # No futuro, o 'request.data' conteria o XML da nota fiscal.
    print("Requisição de análise recebida!")

    # Retorna uma resposta JSON simples para o serviço Java
    return jsonify({
        "status_analise": "Recebido com sucesso",
        "servico": "Python IA Service"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)