#!groovy


def buildStartTime = ""
def committerUserName = ""
def commitId = ""

def CleanUp(location){
	echo "Removing directory - " + location
	//bat "rmdir /s /Q $location"
}


def GetUserName (commitHash)
	{
		// Git committer User id
		bat "pushd %workspace% & git show -s --format=%%an ${commitHash} > commandResult"
		result = readFile('commandResult').trim()
		result = result.replace(" ", "").replace("," ,"")
		if (result.contains("\\"))
			{
			result = result.split("\\\\")[1]		
			}
		//echo "Git committer email: ${result}"
		return result

	}	
	

pipeline
	{
		agent { node { label 'JENKINS-Bldnode74' } }
		stages
			{
			// clean up
			stage('cleanup at Beginning') 
				{
				steps
					{
					CleanUp('%workspace%')
					}
				}

			// Source code checkout
			stage('Checkout SourceCode') 
				{
				steps
					{					
					echo 'Pulling...' + env.BRANCH_NAME
					script 
						{						
							def now = new Date()
							buildStartTime = now.format("yyyy-MM-dd'T'HH:mm:ss.SSS+00:00", TimeZone.getTimeZone("UTC")) 
							println "starttime:" + buildStartTime
																
							commitId = checkout(scm).GIT_COMMIT //checkout scm
							echo 'Commit id is : ' + commitId

							committerUserName = GetUserName(commitId)
							echo 'UserName:'+committerUserName
						}										
					}
				}							

			// build
			stage('Build') 
				{
				steps
					{
					script 
						{		
                            echo "executing ${WORKSPACE}\\src\\build.sh"						
							def sout = new StringBuffer(), serr = new StringBuffer()

							def proc ="${WORKSPACE}\\src\\build.sh".execute()

							proc.consumeProcessOutput(sout, serr)
							proc.waitForOrKill(1000)
							println sout
						}
					}
				}				
			}    	
	}					