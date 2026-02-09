exportar_tarefas() {
    read -rp "Nome do arquivo para exportação: " arquivo
    cp "$TASK_FILE" "$arquivo"
    
    if [[ -n "$(command -v dialog)" ]]; then
        clear
        dialog --msgbox "Tarefas exportadas para $arquivo" 6 50
        clear
    else
        echo "Tarefas exportadas para $arquivo"
    fi
}
exportar_tarefas() {

    # verifica se o arquivo de tarefas existe
    if [ ! -f "$TASK_FILE" ]; then
        echo "Erro: arquivo de tarefas não encontrado."
        return
    fi

    # solicita o nome do arquivo de exportação
    read -rp "Nome do arquivo para exportação: " arquivo
    
    #Coloca a extensão .txt no arquivo
    [[ "$arquivo" != *.txt ]] && arquivo="$arquivo.txt"

    # verifica se o nome do arquivo foi informado
    if [ -z "$arquivo" ]; then
        echo "Erro: nome do arquivo não pode ser vazio."
        return
    fi

    # verifica se o arquivo de destino já existe
    if [ -e "$arquivo" ]; then
        read -rp "O arquivo já existe. Deseja sobrescrever? (s/n): " resp
        if [[ ! "$resp" =~ ^[sS]$ ]]; then
            echo "Exportação cancelada."
            return
        fi
    fi

    # tenta copiar o arquivo e verifica se houve erro
    if cp "$TASK_FILE" "$arquivo" 2>/dev/null; then
        if [[ -n "$(command -v dialog)" ]]; then
            clear
            dialog --msgbox "Tarefas exportadas para $arquivo" 6 50
            clear
        else
            echo "Tarefas exportadas para $arquivo"
        fi
    else
        echo "Erro ao exportar tarefas. Verifique permissões ou caminho."
        return
    fi
}
