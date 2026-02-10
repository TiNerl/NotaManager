listar_tarefas() {

    #Verifica se a variável TASK_FILE está definida
    if [ -z "$TASK_FILE" ]; then
        echo "Erro: variável TASK_FILE não definida."
        return
    fi

    #Verifica se o arquivo de tarefas existe
    if [ ! -f "$TASK_FILE" ]; then
        echo "Nenhuma tarefa cadastrada."
        return
    fi

    #Verifica se o arquivo existe mas está vazio
    if [ ! -s "$TASK_FILE" ]; then
        echo "Nenhuma tarefa cadastrada."
        return
    fi

    #Verifica se o arquivo tem permissão de leitura
    if [ ! -r "$TASK_FILE" ]; then
        echo "Erro: sem permissão para ler o arquivo de tarefas."
        return
    fi

    #Escreve na tela apenas para tornar o ambiente mais amigavél e simples para o usuário
    echo "===== Lista de Tarefas ====="
    echo "ESTADO | ID | TAREFA | DATA "
    echo "-----------------------------------------"

    #Exibe o conteúdo do arquivo mostrando todas as tarefas adicionadas
    cat "$TASK_FILE"
}
