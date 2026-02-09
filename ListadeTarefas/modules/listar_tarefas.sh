listar_tarefas() {
    if [[ ! -s "$TASK_FILE" ]]; then
        echo "Nenhuma tarefa cadastrada."
        return
    fi

    echo "===== Lista de Tarefas ====="
    nl -w2 -s". " "$TASK_FILE"
}
