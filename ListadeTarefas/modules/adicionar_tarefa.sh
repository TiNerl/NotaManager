adicionar_tarefa() {

    touch "$TASK_FILE"

    read -rp "Número da tarefa: " id
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data

    if [[ -z "$id" || -z "$desc" || -z "$data" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "ID inválido."
        return
    fi

    # VERIFICAÇÃO CORRETA DO ID
    if grep -q "^\[[ X]\][[:space:]]*$id[[:space:]]*|" "$TASK_FILE"; then
        echo "Erro: já existe uma tarefa com esse ID."
        return
    fi

    if ! [[ "$data" =~ ^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
        echo "Data inválida."
        return
    fi

    if [[ "$desc" =~ ^[0-9]+$ ]]; then
        echo "Descrição inválida."
        return
    fi

    echo "[ ] $id | $desc | $data" >> "$TASK_FILE"

    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
        clear
    else
        echo "Tarefa adicionada com sucesso!"
    fi
}
