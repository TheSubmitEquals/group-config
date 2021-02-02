#!/usr/bin/env bash

source ./.config

#Variáveis
typeset -ri true=1
typeset -ri false=0

#Criar grupo
function create-group () {

    typeset -r group="${1}"

    groupadd -f "${group}"

}

#Deletar grupo
function delete-group () {

    typeset -r group="${1}"

    groupdel -f "${group}"

}

#Checar grupo
function check-group () {

    typeset -r group="${1}"

    if (grep -q "^${group}:" /etc/group)
    then
        return "${true}"
    else
        return "${false}"
    fi

}

function main () {
    for group in "${!groups[@]}";
    do
        if $(check-group ${group}) 
        then
            if [[ "${groups[${group}]}" == "create" ]]
            then
                create-group "${group}";
            fi
        elif [[ "${groups[${group}]}" == "delete" ]]
        then
            delete-group "${group}";
        fi
    done
}

main
