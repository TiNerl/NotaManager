adicionar_tarefa() {
    read -p "Descrição da tarefa: " desc
    read -p "Data de entrega (DD/MM/AAAA): " data
    read -p "Número da tarefa:" id

    if [[ -z "$desc" || -z "$data" || -z "$id" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    echo "[ ] | $desc | $data | $id" >> "$TASK_FILE"
    echo "Tarefa adicionada com sucesso!"
}
