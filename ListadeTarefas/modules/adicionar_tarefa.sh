adicionar_tarefa()
{
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data
    read -rp "Número da tarefa:" id

    if [[ -z "$desc" || -z "$data" || -z "$id" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    echo "[ ] | $desc | $data | $id" >> "$TASK_FILE"
    dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
}

