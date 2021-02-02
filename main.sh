#!/usr/bin/env bash

source ./.config

#Variáveis
declare -ri true=1
declare -ri false=0

#Criar grupo
function create-group () {

    typeset -r group="${1}"

    exec groupadd -f "${group}"

}

#Deletar grupo
function delete-group () {

    typeset -r group="${1}"

    exec groupdel -f "${group}"

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
