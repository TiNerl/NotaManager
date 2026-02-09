exportar_tarefas() {
    read -rp "Nome do arquivo para exportação: " arquivo
    cp "$TASK_FILE" "$arquivo"
    dialog --msgbox "Tarefas exportadas para $arquivo" 6 50
}
