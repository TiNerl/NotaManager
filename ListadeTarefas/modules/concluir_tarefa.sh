concluir_tarefa() {

    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    listar_tarefas
    read -rp "Digite o ID da tarefa concluída: " id

    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se a tarefa existe e está aberta
    if ! grep -q "^\[ \][[:space:]]\+$id[[:space:]]*\|" "$TASK_FILE"; then
        if grep -q "^\[X\][[:space:]]\+$id[[:space:]]*\|" "$TASK_FILE"; then
            echo "Essa tarefa já está concluída."
        else
            echo "Erro: tarefa não encontrada."
        fi
        return
    fi

    # marca como concluída
    sed -i "s/^\[ \][[:space:]]\+$id[[:space:]]*\|/[X] $id |/" "$TASK_FILE"

    echo "Tarefa marcada como concluída!"
}
