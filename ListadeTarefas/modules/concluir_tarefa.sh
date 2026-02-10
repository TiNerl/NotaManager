concluir_tarefa() {

    #Verifica se existe o arquivo com as tarefas
    if [ ! -f "$TASK_FILE" ]; then
        echo "Arquivo de tarefas não encontrado."
        return
    fi

    #Solicita ID ao usuário para marcar a tarefa concluída e mostra as tarefas já adicionadas
    listar_tarefas
    read -rp "Digite o ID da tarefa concluída: " id

    #Verifica se o ID é apenas números (0 a 9) e tem pelo menos um dígito
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        echo "Erro: digite um número válido."
        return
    fi

    # verifica se existe uma tarefa com o ID informado dentro do arquivo de tarefas.
    if ! grep -q "^\[[ X]\][[:space:]]\+$id[[:space:]]*\|" "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi
    
    #Troca [ ] por [X] NA LINHA DO ID
    sed -i "/^\[ \][[:space:]]*$id[[:space:]]*|/s/^\[ \]/[X]/" "$TASK_FILE"

    #Mostra um textbox com dialog no caso de dar certo marcar a tarefa como concluída
    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa concluida com sucesso!" 6 50
        clear
    else
        echo "Tarefa concluida com sucesso!"
    fi

}
