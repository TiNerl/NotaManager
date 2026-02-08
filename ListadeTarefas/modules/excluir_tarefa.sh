# excluir_tarefa.sh

#lista as tarefas e pede ao usuário o número da tarefa que ele deseja excluir
excluir_tarefa() {
  echo "Tarefas atuais:"
  cat tarefas.txt
  echo
  read -rp "Digite o número da tarefa que deseja excluir: " id

#verifica se o número da tarefa é válido
  if ! [[ "$id" =~ ^[0-100000]+$ ]]; then
    echo "Número inválido. Por favor, digite um número válido."
    return
  fi

#verifica se a tarefa existe
  if ! [ -f tarefas.txt ]; then
    echo "Arquivo de tarefas não encontrado."
    return
  fi

#verifica se o número digitado é negativo ou se é maior do que a quantidade de tarefas existentes
  if [ "$id" -le 0 ] || [ "$id" -gt "$(wc -l < tarefas.txt)" ]; then
    echo "Número fora do intervalo. Por favor, digite um número válido."
    return
  fi

#exclui a tarefa
  sed -i "${id}d" tarefas.txt
  echo "Tarefa excluída com sucesso."
}
