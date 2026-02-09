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
    if ! awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[2] == id) found=1
        }
        END { exit !found }
    ' "$TASK_FILE"; then
        echo "Erro: tarefa não encontrada."
        return
    fi

    # verifica se já está concluída
    if awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[1]=="[X]" && a[2]==id) found=1
        }
        END { exit found }
    ' "$TASK_FILE"; then
        echo "Essa tarefa já está concluída."
        return
    fi

    # marca como concluída (somente essa tarefa)
    awk -F'|' -v id="$id" '
        {
            split($1, a, " ")
            if (a[2] == id && a[1] == "[ ]") {
                a[1] = "[X]"
                $1 = a[1] " " a[2]
            }
            print $1 " | " $2 " | " $3
        }
    ' "$TASK_FILE" > "$TASK_FILE.tmp" && mv "$TASK_FILE.tmp" "$TASK_FILE"

    echo "Tarefa marcada como concluída!"
}
