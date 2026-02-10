#!/bin/bash
# Define que o script deve ser executado usando o interpretador Bash

# Define o arquivo de configuração do dialog como sendo o .dialogrc que está no diretório atual do projeto
export DIALOGRC="$PWD/.dialogrc"

# Habilita cores nos diálogos do dialog
export DIALOGOPTS="--colors"

# Diretório onde os dados do sistema de tarefas serão armazenados
DATA_DIR="data"

# Arquivo onde as tarefas serão salvas
TASK_FILE="$DATA_DIR/tarefas.txt"

# Cria o diretório de dados caso ele não exista
mkdir -p "$DATA_DIR"

# Cria o arquivo de tarefas caso ele não exista
touch "$TASK_FILE"

# Importa (source) os módulos com as funções do sistema, isso permite usar as funções definidas nesses arquivos aqui
source modules/adicionar_tarefa.sh
source modules/listar_tarefas.sh
source modules/concluir_tarefa.sh
source modules/exportar_tarefas.sh
source modules/excluir_tarefa.sh

# Loop infinito para manter o menu rodando até o usuário escolher sair
while true; do
    # Limpa a tela do terminal
    clear

    # Título do sistema
    echo "===== TaskShell ====="

 # Arte ASCII do sistema (apenas visual)
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
    
    # Menu de opções exibido ao usuário
    echo "Selecione uma das opções a seguir:"
    echo "1 - Adicionar tarefa"
    echo "2 - Listar tarefas"
    echo "3 - Marcar tarefa como concluída"
    echo "4 - Exportar tarefas"
    echo "5 - Excluir tarefa"
    echo "0 - Sair"

     # Lê a opção digitada pelo usuário
    read -p "Escolha uma opção: " opcao

    # Estrutura de decisão baseada na opção escolhida
    case "$opcao" in

        # Chama a função para adicionar tarefa e aguarda o usuário pressionar Enter antes de voltar ao menu
        1) adicionar_tarefa 
        read -rp "Pressione Enter para continuar...";;
        
        # Chama a função para listar tarefas
        2) listar_tarefas 
        read -rp "Pressione Enter para continuar...";;

        # Chama a função para concluir uma tarefa
        3) concluir_tarefa 
        read -rp "Pressione Enter para continuar...";;

        # Chama a função para exportar tarefas
        4) exportar_tarefas 
        read -rp "Pressione Enter para continuar...";;
        
        # Chama a função para excluir uma tarefa
        5) excluir_tarefa 
        read -rp "Pressione Enter para continuar...";;
        
        # Encerra o sistema
        0) echo "Saindo..."; break 
        read -rp "Pressione Enter para continuar...";;

        # Caso o usuário digite uma opção inválida
        *) echo "Opção inválida!" ;;
    esac
done

