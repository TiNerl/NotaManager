adicionar_tarefa() {

    # verifica se o arquivo existe (ou cria)
    touch "$TASK_FILE"

    # solicita dados
    read -rp "Número da tarefa: " id
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data

    # verifica se os campos estão vazios
    if [[ -z "$id" || -z "$desc" || -z "$data" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    # verifica se o ID é número inteiro positivo
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "ID inválido."
        return
    fi

    # verifica se o ID já existe
    if grep -q "\|[[:space:]]*$id[[:space:]]*$" "$TASK_FILE"; then
        echo "Erro: já existe uma tarefa com esse ID."
        return
    fi

    # verifica formato da data
    if ! [[ "$data" =~ ^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
        echo "Data inválida."
        return
    fi

    # descrição não pode ser só números
    if [[ "$desc" =~ ^[0-9]+$ ]]; then
        echo "Descrição inválida."
        return
    fi

    # FORMATO PADRÃO: STATUS | ID | DESCRIÇÃO | DATA 
    echo "[ ] $id | $desc | $data" >> "$TASK_FILE"

    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
        clear
    else
        echo "Tarefa adicionada com sucesso!"
    fi
}
