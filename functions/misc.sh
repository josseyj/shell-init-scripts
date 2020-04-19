#misc.sh
function mci () { mvn clean install "$@" ; }
function notify () {$@ && say 'Done' || say 'Failed';}
function remind () { sleep $1; shift; say "$@";}  
function min () {expr $1 \* 60;}
function findgrep () {
        find ./ -name $1 -exec grep -Hn $2 {} \;
}

function copy_ssh_id() { 
    ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N "";
    cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys";
}

