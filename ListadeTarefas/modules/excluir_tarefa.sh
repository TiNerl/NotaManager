excluir_tarefa() {

  # verifica se o arquivo existe
  if [ ! -f "$TASK_FILE" ]; then
    echo "Arquivo de tarefas não encontrado."
    return
  fi

  listar_tarefas
  read -rp "Digite o ID da tarefa que deseja excluir: " id

  # verifica se é número
  if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo "Por favor, digite apenas números."
    return
  fi

  # verifica se a tarefa existe (ID no começo da linha)
  if ! grep -Eq "^\[[ X]\][[:space:]]*$id[[:space:]]*\|" "$TASK_FILE"; then
    echo "Erro: tarefa não encontrada."
    return
  fi

  # exclui SOMENTE a tarefa com esse ID
  sed -Ei "/^\[[ X]\][[:space:]]*$id[[:space:]]*\|/d" "$TASK_FILE"

  if [[ -n "$(command -v dialog)" ]]; then
    clear
    dialog --msgbox "Tarefa excluída com sucesso." 6 50
    clear
  else
    echo "Tarefa excluída com sucesso."
  fi
}
