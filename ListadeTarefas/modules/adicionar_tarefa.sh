adicionar_tarefa()
{
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data
    read -rp "Número da tarefa:" id

    if [[ -z "$desc" || -z "$data" || -z "$id" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    # Formato: STATUS | DESCRICAO | DATA | ID
    echo "[ ] | $desc | $data | $id" >> "$TASK_FILE"

    # Verifica se o usuário tem o dialog instalado
    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
        clear
    else
        echo "Tarefa adicionada com sucesso!"
    fi
}

