#!/bin/bash

export DIALOGRC="$PWD/.dialogrc"
export DIALOGOPTS="--colors"

DATA_DIR="data"
TASK_FILE="$DATA_DIR/tarefas.txt"

mkdir -p "$DATA_DIR"
touch "$TASK_FILE"

source modules/adicionar_tarefa.sh
source modules/listar_tarefas.sh
source modules/concluir_tarefa.sh
source modules/exportar_tarefas.sh
source modules/excluir_tarefa.sh

while true; do
    clear
    echo "===== TaskShell ====="

echo "|====================----------------------------------======================|"                                                                                
echo "|   ▄▄     ▄▄▄               ▄▄▄     ▄▄▄                                     |"
echo "|   ██▄   ██▀      █▄         ███▄ ▄███                                      |"
echo "|   ███▄  ██      ▄██▄        ██ ▀█▀ ██         ▄              ▄▄       ▄    |"
echo "|   ██ ▀█▄██ ▄███▄ ██ ▄▀▀█▄   ██     ██   ▄▀▀█▄ ████▄ ▄▀▀█▄ ▄████ ▄█▀█▄ ████▄|"
echo "|   ██   ▀██ ██ ██ ██ ▄█▀██   ██     ██   ▄█▀██ ██ ██ ▄█▀██ ██ ██ ██▄█▀ ██   |"
echo "| ▀██▀    ██▄▀███▀▄██▄▀█▄██ ▀██▀     ▀██▄▄▀█▄██▄██ ▀█▄▀█▄██▄▀████▄▀█▄▄▄▄█▀   |"
echo "|                                                              ██            |"
echo "|                                                            ▀▀▀             |"
echo "|====================----------------------------------======================|"
    echo "Selecione uma das opções a seguir:"
    echo "1 - Adicionar tarefa"
    echo "2 - Listar tarefas"
    echo "3 - Marcar tarefa como concluída"
    echo "4 - Exportar tarefas"
    echo "5 - Excluir tarefa"
    echo "0 - Sair"
    read -p "Escolha uma opção: " opcao

    case "$opcao" in
        1) adicionar_tarefa 
        read -rp "Pressione Enter para continuar...";;
        2) listar_tarefas 
        read -rp "Pressione Enter para continuar...";;
        3) concluir_tarefa 
        read -rp "Pressione Enter para continuar...";;
        4) exportar_tarefas 
        read -rp "Pressione Enter para continuar...";;
        5) excluir_tarefa 
        read -rp "Pressione Enter para continuar...";;
        0) echo "Saindo..."; break 
        read -rp "Pressione Enter para continuar...";;
        *) echo "Opção inválida!" ;;
    esac
done

