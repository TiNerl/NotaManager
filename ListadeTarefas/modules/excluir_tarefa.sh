excluir_tarefa() {

  # verifica se o arquivo existe
  if [ ! -f "$TASK_FILE" ]; then
    echo "Arquivo de tarefas não encontrado."
    return
  fi

  listar_tarefas
  read -rp "Digite o ID da tarefa que deseja excluir: " id

  # valida se é número
  if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo "Por favor, digite apenas números."
    return
  fi

  # verifica se a tarefa existe (ID no começo)
  if ! grep -q "^\[[ X]\][[:space:]]*$id[[:space:]]*|" "$TASK_FILE"; then
    echo "Erro: tarefa não encontrada."
    return
  fi

  # exclui SOMENTE a tarefa com esse ID
  sed -i "/^\[[ X]\][[:space:]]*$id[[:space:]]*|/d" "$TASK_FILE"

  echo "Tarefa excluída com sucesso."
}
