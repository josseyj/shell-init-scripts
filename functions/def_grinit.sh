function grinit() {
	repoName=$1
	userName=$(whoami)
	if [ "$repoName" = "" ] 
		then
			echo "Usage: $0 <repo-name>";
			return 4001;
	fi

	if [ "$GITHUB_TOKEN" = "" ] 
		then
			echo "Please set GITHUB_TOKEN env variable.";
			return 4221;
	fi
	if [ "$GITHUB_API_BASEPATH" = "" ] 
		then
			echo "Please set GITHUB_API_BASEPATH env variable.";
			return 4222;
	fi
	
	jq --help > /dev/null 2> /dev/null;
	if [ $? != 0 ] 
		then
			echo "Missing dependency 'jq'"
			echo "Run 'brew install jq'"
			return 4223;
	fi
	
	create_repo_response_raw=$(curl -s -w "HTTP_RESPONSE_STATUS_CODE=%{http_code}\n" -u "$userName:$GITHUB_TOKEN" -X POST "$GITHUB_API_BASEPATH"/user/repos -d '{"name":"'$repoName'"}')
	if [ $? != 0 ] 
		then
			echo "Repo creation failed: $create_repo_response_raw"
			return 5001;
	fi

	create_repo_response_code=$(echo "$create_repo_response_raw" | grep "HTTP_RESPONSE_STATUS_CODE" | sed -n -E -e 's/HTTP_RESPONSE_STATUS_CODE=([0-9])/\1/p')

	if [ "$create_repo_response_code" != "201" ] 
		then
			echo "Repo creation failed: $create_repo_response_raw"
			return 5002;
	fi

	create_repo_response_json=$(echo "$create_repo_response_raw" | sed -E -e '/HTTP_RESPONSE_STATUS_CODE/d')

	repo_clone_url=$(echo "$create_repo_response_json" | jq '.ssh_url' | sed -E 's/^"(.*)"$/\1/')

	echo "INFO: Created the remote repo. Cloning $repo_clone_url"
 	git clone $repo_clone_url
	if [ $? != 0 ] 
		then
			echo "Repo cloning failed."
			return 5002;
	fi

	cd $repoName
}

