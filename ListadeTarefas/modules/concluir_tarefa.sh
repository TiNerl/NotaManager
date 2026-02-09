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

    # verifica se o ID existe (qualquer estado)
    if ! grep -q "^\[[ X]\][[:space:]]+$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se JÁ está concluída (SOMENTE [X])
    if grep -q "^\[X\][[:space:]]+$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # marca como concluída (somente se estiver aberta)
    sed -i "s/^\[ \][[:space:]]\+$id[[:space:]]*\|/[X] $id |/" "$TASK_FILE"

    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa marcada como concluída!" 6 50
        clear
    else
        echo "Tarefa marcada como concluída!"
    fi
}
