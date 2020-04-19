#Translates groupId:artifactId:type:version:scope to a dependency tag
# Requires xmllint
function dep () {
		echo $@ | sed -E 's/([^\:]*)\:([^\:]*)(\:([A-Za-z]*))?(\:([^\:]*))?(\:([^\:]*))?/<dependency><groupId>\1<\/groupId><artifactId>\2<\/artifactId><version>\6<\/version><scope>\8<\/scope><\/dependency>/g' | xmllint --format - | sed -e '/<.*\/>/d' -e '/.*xml version.*/d'
	}

