node('compose-node') {	
	properties([    	       
		buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '7', numToKeepStr: '')), 
		parameters([
		string(defaultValue: 'https://download.alfresco.com/release/community/201707-build-00028/alfresco-community-distribution-201707.zip', description: '', name: 'COMMUNITY_DISTRIBUTION_URL'),
		string(defaultValue: 'http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.3.7/jolokia-war-1.3.7.war', description: '', name: 'JOLOKIA_WAR_URL')
		])
	])
		
	stage('Checkout') {
		git branch: '5.2.N', url: 'https://github.com/paulbrodner/alfresco-community-deployment'      
	}

	stage('Start Alfresco') {
	    	sh '''export JOLOKIA_WAR=${JOLOKIA_WAR_URL}
	export BACKGROUND=true
	export COMMUNITY_DISTRIBUTION=distribution/$(basename ${COMMUNITY_DISTRIBUTION_URL}) && ./start.sh ${COMMUNITY_DISTRIBUTION_URL}'''
	}

	stage('Awaiting Destroy'){
		input message: 'Click \'Destroy\' button to terminate this instance of Alfresco Community Edition', ok: 'Destroy'
	    	sh 'docker-compose kill'
	}
}
