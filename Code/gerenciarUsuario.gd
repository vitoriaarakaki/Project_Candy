extends Node2D

func _on_Button_Ok_pressed():
	$ColorRect.visible = false

func limpar_campos():
	$LineEdit_ID.text          = ""
	$LineEdit_Nome.text      = ""
	$LineEdit_Email.text      = ""
	$LineEdit_Pontuacao.text = ""
	$LineEdit_Senha.text      = ""

func salvar_http_get():
	var url_requisicao = "http://localhost/jogos/jogador_dao.php?"
	var cabecalho   = ["Content-Type: application/json"] #para GET usamos application/json
	var dados_envio = ""
	if ($LineEdit_ID.text==""):
		dados_envio = get_dados_para_envio("insert")
		$HTTP_Insert.request(url_requisicao + dados_envio, cabecalho, false)# requisicao para GET
	else:
		dados_envio = get_dados_para_envio("update")
		$HTTP_Update.request(url_requisicao + dados_envio, cabecalho, false)# requisicao para GET

func select_http_get():
	var url_requisicao = "http://localhost/jogos/jogador_dao.php?"
	var cabecalho   = ["Content-Type: application/json"]
	var dados_envio = get_dados_para_envio("select")    
	$HTTP_Select.request(url_requisicao + dados_envio, cabecalho, false)
	#    var cabecalho   = ["Content-Type: application/x-www-form-urlencoded"] #para POST usamos application/json
#    $HTTPRequest.request(url_requisicao, cabecalho, false,HTTPClient.METHOD_POST, dados_envio) # requisicao para POST

func delete_http_get():
	var url_requisicao = "http://localhost/jogos/jogador_dao.php?"
	var cabecalho   = ["Content-Type: application/json"]
	var dados_envio = get_dados_para_envio("delete")        
	$HTTP_Delete.request(url_requisicao + dados_envio, cabecalho, false)

func get_dados_para_envio(acao):
	var dados_envio = "acao=" + acao.http_escape()
	dados_envio    += "&id="         + $LineEdit_ID.text.http_escape()
	dados_envio    += "&nome="         + $LineEdit_Nome.text.http_escape()
	dados_envio    += "&email="        + $LineEdit_Email.text.http_escape()
	dados_envio    += "&pontuacao="    + $LineEdit_Pontuacao.text.http_escape()
	dados_envio    += "&senha="         + $LineEdit_Senha.text.http_escape()
	return dados_envio
	
func _on_HTTP_Insert_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$ColorRect/Label_Mensagem.text     = json.result["resultado"]
	$LineEdit_ID.text                 = str(json.result["idGerado"])
	$ColorRect.visible = true

func _on_HTTP_Update_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$ColorRect/Label_Mensagem.text     = json.result["resultado"]
	$ColorRect.visible = true

func _on_HTTP_Delete_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$ColorRect/Label_Mensagem.text     = json.result["resultado"]
	$ColorRect.visible = true
	limpar_campos()
	
func _on_HTTP_Select_request_completed(result, response_code, headers, body):
	var json  = JSON.parse(body.get_string_from_utf8())    
	var auxId = $LineEdit_ID.text
	limpar_campos()
	$LineEdit_ID.text = auxId
	if (typeof(json.result["resultado"]) == TYPE_STRING):
		$ColorRect/Label_Mensagem.text     = json.result["resultado"]
		$ColorRect.visible = true
	else:
		$LineEdit_Nome.text      = json.result["resultado"][0].nome
		$LineEdit_Email.text     = json.result["resultado"][0].email
		$LineEdit_Pontuacao.text = json.result["resultado"][0].pontuacao
		$LineEdit_Senha.text     = json.result["resultado"][0].senha


