concluir_tarefa() {

    # verifica se o arquivo existe
    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    listar_tarefas
    read -rp "Digite o número da tarefa concluída: " id

    # verifica se é número
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se a tarefa existe (padrão flexível)
    if ! grep -q "\|[[:space:]]*$id[[:space:]]*$" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se a tarefa já está concluída 
    if grep -q "^\[X\].*\|[[:space:]]*$id[[:space:]]*$" "$TASK_FILE"; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # marca como concluída
    sed -i "/\|[[:space:]]*$id[[:space:]]*$/ s/^\[ \]/[X]/" "$TASK_FILE"

    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa marcada como concluída!" 6 50
        clear
    else
        echo "Tarefa marcada como concluída!"
    fi
}
