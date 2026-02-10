excluir_tarefa() {

  #Verifica se o arquivo existe
  if [ ! -f "$TASK_FILE" ]; then
    echo "Arquivo de tarefas não encontrado."
    return
  fi
  
  #Solicita o ID da tarefa que deve ser excluído e mostra as tarefas adicionadas
  listar_tarefas
  read -rp "Digite o ID da tarefa que deseja excluir: " id

  #Verifica se o ID é apenas números (0 a 9) e tem pelo menos um dígito
  if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo "Por favor, digite apenas números."
    return
  fi

  #Verifica se existe uma tarefa com o ID informado dentro do arquivo de tarefas
  if ! grep -q "^\[[ X]\][[:space:]]*$id[[:space:]]*|" "$TASK_FILE"; then
    echo "Erro: tarefa não encontrada."
    return
  fi

  #Exclui SOMENTE a tarefa com esse ID
  sed -i "/^\[[ X]\][[:space:]]*$id[[:space:]]*|/d" "$TASK_FILE"

  #Mostra um textbox com dialog no caso de dar certo excluir
  if [[ -n "$(command -v dialog)" ]]; then
    clear
    dialog --msgbox "Tarefa excluida com sucesso!" 6 50
    clear
  else
    echo "Tarefa excluida com sucesso!"
  fi
}
