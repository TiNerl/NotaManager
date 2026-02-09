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
