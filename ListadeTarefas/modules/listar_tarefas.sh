listar_tarefas() {

    # verifica se a variável TASK_FILE está definida
    if [ -z "$TASK_FILE" ]; then
        echo "Erro: variável TASK_FILE não definida."
        return
    fi

    # verifica se o arquivo de tarefas existe
    if [ ! -f "$TASK_FILE" ]; then
        echo "Nenhuma tarefa cadastrada."
        return
    fi

    # verifica se o arquivo existe mas está vazio
    if [ ! -s "$TASK_FILE" ]; then
        echo "Nenhuma tarefa cadastrada."
        return
    fi

    # verifica se o arquivo tem permissão de leitura
    if [ ! -r "$TASK_FILE" ]; then
        echo "Erro: sem permissão para ler o arquivo de tarefas."
        return
    fi

    echo "===== Lista de Tarefas ====="
    echo "ESTADO | ID | TAREFA | DATA "
    echo "-----------------------------------------"

    # exibe o conteúdo do arquivo
    cat "$TASK_FILE"
}
