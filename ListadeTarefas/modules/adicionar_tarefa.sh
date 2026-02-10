adicionar_tarefa() {

    touch "$TASK_FILE"
    #Solicita ao usuário dados para adição da tarefa
    read -rp "Número da tarefa: " id
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data

    #Verifica se os campos foram preenchidos
    if [[ -z "$id" || -z "$desc" || -z "$data" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    #Verifica se o ID contém apenas números (0 a 9) e pelo menos um dígito
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "ID inválido."
        return
    fi

    #Verifica se já existe tarefa com esse ID
    if grep -q "^\[[ X]\][[:space:]]*$id[[:space:]]*|" "$TASK_FILE"; then
        echo "Erro: já existe uma tarefa com esse ID."
        return
    fi

    #Verifica o formato da data
    if ! [[ "$data" =~ ^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
        echo "Data inválida."
        return
    fi

    #Verifica se foi adicionado apenas números na descrição, pois deve conter texto
    if [[ "$desc" =~ ^[0-9]+$ ]]; then
        echo "Descrição inválida."
        return
    fi

    #Formato padrão da tarefa
    echo "[ ] $id | $desc | $data" >> "$TASK_FILE"

    #Uso de dialog para textbox quando der certo a adição
    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
        clear
    else
        echo "Tarefa adicionada com sucesso!"
    fi
}
