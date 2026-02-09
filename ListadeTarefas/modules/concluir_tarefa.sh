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
    awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[2] == id) exit 0
        }
        END { exit 1 }
    ' "$TASK_FILE"

    if [ $? -ne 0 ]; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se já está concluída
    awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[1] == "[X]" && a[2] == id) exit 0
        }
        END { exit 1 }
    ' "$TASK_FILE"

    if [ $? -eq 0 ]; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # marca como concluída (somente essa tarefa)
    awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[2] == id && a[1] == "[ ]") {
                $1 = "[X] " id
            }
            print $1 " | " $2 " | " $3
        }
    ' "$TASK_FILE" > "$TASK_FILE.tmp" && mv "$TASK_FILE.tmp" "$TASK_FILE"

    echo "Tarefa marcada como concluída!"
}
