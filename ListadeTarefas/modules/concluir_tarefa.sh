concluir_tarefa() {
    listar_tarefas
    read -rp "Digite o número da tarefa concluída: " id

    sed -i "${id}s/^\[ \]/[X]/" "$TASK_FILE"
    dialog --msgbox "Tarefa marcada como concluída!" 6 50
}
