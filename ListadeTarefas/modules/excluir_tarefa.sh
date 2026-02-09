excluir_tarefa() {

  # verifica se o arquivo existe
  if [ ! -f "$TASK_FILE" ]; then
    echo "Arquivo de tarefas não encontrado."
    return
  fi

  echo "Tarefas atuais:"
  nl -w2 -s'. ' "$TASK_FILE"
  echo

  read -rp "Digite o número da tarefa que deseja excluir: " id

  # verifica se é número
  if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo "Por favor, digite apenas números."
    return
  fi

  total=$(wc -l < "$TASK_FILE")

  # verifica intervalo
  if [ "$id" -le 0 ] || [ "$id" -gt "$total" ]; then
    echo "Número fora do intervalo. Digite entre 1 e $total."
    return
  fi

  # exclui a tarefa
  sed -i "${id}d" "$TASK_FILE"
  echo "Tarefa excluída com sucesso."
}
