source ./.config

#Variáveis
declare -ri true=1
declare -ri false=0

#Criar grupo
function create-grp () {

    typeset -r group="${1}"

    exec groupadd -f "${group}"

}

#Deletar grupo
function delete-grp () {

    typeset -r group="${1}"

    exec groupdel -f "${group}"

}

#Checar grupo
function check-grp () {

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
        if ("${check-grp}" "${group}" )
        then
            if [[ "${groups[${group}]}" == "create" ]]
            then
                #create-grp "${group}";
                echo 1;
            if [["${groups[${group}]}" == "delete"]]
            then
                #delete-grp "${group}";
                echo 2;
            fi
        fi
    done
}

main
