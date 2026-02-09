concluir_tarefa() {

    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    listar_tarefas
    read -rp "Digite o número da tarefa concluída: " id

    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se a tarefa existe
    if ! grep -q "^\[[ X]\][[:space:]]*$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se já está concluída
    if grep -q "^\[X\][[:space:]]*$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # MARCA COMO CONCLUÍDA (regex corrigido)
    sed -i "s/^\[ \][[:space:]]*$id[[:space:]]*\|/[X] $id |/" "$TASK_FILE"

    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa marcada como concluída!" 6 50
        clear
    else
        echo "Tarefa marcada como concluída!"
    fi
}
