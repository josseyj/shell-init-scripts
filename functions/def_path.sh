#set the PATH env variable
function path() {
	_debug=0
	function debug() {
		if [ ${_debug} = 1 ]; then
			echo 'DEBUG: '$*
		fi
	}
	function usage() {
		echo 'path [-b][-r] [path]'
		echo 'path -b aPath 	--> Add "aPath" to the begining of PATH'
		echo 'path -r aPath 	--> Remove "aPath" from the PATH'
		echo 'path aPath	 	--> Add "aPath" to the end of PATH'
		echo 'path	 			--> Show the current PATH'
	}
	declare command
	while getopts 'vbr' opt; do 
		case ${opt} in
			v) 
				_debug=1
			;;
			b) 
				if [ -n "${command}" ];then
					echo "Invalid usage. Command already set to ${command}."
					usage
					return 2
				fi
				command='prefix'
			;;
			r) 
				if [ -n "$command" ];then
					echo "Invalid usage. Command already set to ${command}."
					usage
					return 2
				fi
				command='remove'
			;;
		esac
	done;
	shift $((OPTIND -1))
	arg=$1
	
	if [ -z "$command" ]; then
		if [ -z "$arg" ]; then
			command='show'
		else
			command='suffix'
		fi
	fi
	debug 'command = '${command}
	newPath=''
	if [ "$command" = "show" ]; then
		#show path
		echo $PATH | awk -F: '{for(i=1;i<=NF;i++) print i": "$i}'
		return 0
	
	elif [ "$command" = "suffix" ]; then
		if [ -z $arg ]; then
			echo "Invalid usage. Command already set to ${command}."
			usage
			return 2
		fi
		newPath="$PATH:$arg"
	
	elif [ "$command" = "prefix" ]; then
		if [ -z $arg ]; then
			echo "Invalid usage"
			usage
			return 2
		fi
		newPath="$arg:$PATH"
	
	elif [ "$command" = "remove" ]; then
		if [ -z $arg ]; then
			echo "Invalid usage"
			usage
			return 2
		fi
		newPath=$(echo $PATH | sed -Ee '''s#(:|^)'$arg'(:|$)#\1\2#g' -e 's#:+#:#g' -e 's#^:##' -e 's#:$##''')
	
	else
		echo "Invalid usage"
		usage
		return 2
	fi
	
	if [ -n $newPath ]; then
		debug ${newPath};
		export PATH=${newPath}
	fi
}