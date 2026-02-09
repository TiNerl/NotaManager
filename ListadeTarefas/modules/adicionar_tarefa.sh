adicionar_tarefa()
{
    #Solicita o usuário para adicionar os dados ID, Descrição e Data de entrega da tarefa
    read -rp "Número da tarefa:" id
    read -rp "Descrição da tarefa: " desc
    read -rp "Data de entrega (DD/MM/AAAA): " data

    # Verifica se o ID é um número posivo e inteiro
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
      echo "ID inválido."
      return
    fi
    
    # Verificar se a data está no formato correto
    if ! [[ "$data" =~ ^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/[0-9]{4}$ ]]; then
      echo "Data inválida."
      return
    fi
    
    # Verificar se a descrição é um texto válido e não permite números
    if [ -z "$desc" ] || [[ "$desc" =~ ^[0-9]+$ ]]; then
      echo "Descrição inválida."
      return
    fi

    #Verifica se os campos estão vazios
    if [[ -z "$desc" || -z "$data" || -z "$id" ]]; then
        echo "Erro: campos não podem ser vazios."
        return
    fi

    # Formato: STATUS | DESCRICAO | DATA | ID
    echo "[ ] $id | $desc | $data  " >> "$TASK_FILE"

    # Verifica se o usuário tem o dialog instalado
    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefa adicionada com sucesso!" 6 50
        clear
    else
        echo "Tarefa adicionada com sucesso!"
    fi
}

