#def_gradd

#gradd - add a remote for use
#usage - gradd jossey josjacob
function gradd() {
	gr_alias=$1
	gr_actual=$2

	new_gr=`git remote -v | grep origin | grep fetch | awk '{print $2}' | sed -E -e 's/(.*)@(.*):(.*)\/(.*)/\1@\2:'$gr_actual'\/\4/g'`

	`git remote add $gr_alias $new_gr`
}
