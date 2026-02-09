concluir_tarefa() {

    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    listar_tarefas
    read -rp "Digite o ID da tarefa concluída: " id

    # valida número
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se o ID existe
    if ! grep -q "^\[[ X]\][[:space:]]\+$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi
    
    # apenas troca [ ] por [X] NA LINHA DO ID
    sed -i "${id}s/^\[ \]/[X]/" data/tarefas.txt
    echo "Tarefa marcada como concluída!"

}
