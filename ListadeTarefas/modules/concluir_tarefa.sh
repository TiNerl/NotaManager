concluir_tarefa() {

    # verifica se o arquivo existe
    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    listar_tarefas
    read -rp "Digite o número da tarefa concluída: " id

    # valida se é número
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se a tarefa existe
    if ! grep -q "\|[[:space:]]*$id[[:space:]]*$" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se já está concluída
    if grep -q "^\[X\].*\|[[:space:]]*$id[[:space:]]*$" "$TASK_FILE"; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # marca SOMENTE a tarefa correta como concluída
    sed -i "/^\[ \].*\|[[:space:]]*$id[[:space:]]*$/ s/^\[ \]/[X]/" "$TASK_FILE"

    echo "Tarefa marcada como concluída!"
}

