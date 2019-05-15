# this script updates any folders that are actually complete from "-pending" to "-complete"

# PENDING 

# get all of the folders in fy2019 paperless (merge folder)
$folderRegex = ".jd.*pending$"

# test path...
$FolderPath = '\\msnas1\IRD\Enterprise Support\Team EAM\ESS\EAMT\requests\merges\fy2019 paperless'

$folderfullname = Get-ChildItem -Path $FolderPath | Select-Object Fullname | Where-Object {$_.Fullname -match $folderRegex}

$folders = $folderfullname.Fullname

$apprRegex = "jd-\d+-approved-completed-merged.msg"
$afterRegex = "jd-\d+-after-report.pdf"
$beforeRegex = "jd-\d+-before-report.pdf"

$deniedRegex = "jd.*denied.msg"



foreach ($folder in $folders) {
	$appr = Get-ChildItem -Path $folder | Select-Object Fullname | Where-Object {$_.Fullname -match $apprRegex}
	$after = Get-ChildItem -Path $folder | Select-Object Fullname | Where-Object {$_.Fullname -match $afterRegex}
	$before = Get-ChildItem -Path $folder | Select-Object Fullname | Where-Object {$_.Fullname -match $beforeRegex}
	$denied = Get-ChildItem -Path $folder | Select-Object Fullname | Where-Object {$_.Fullname -match $deniedRegex}

	$apprmatch = $appr -match $apprRegex
	$aftermatch = $after -match $afterRegex
	$beforematch = $before -match $beforeRegex

	$deniedmatch = $denied -match $deniedRegex
	
	

	if ($apprmatch -eq "True"){
		if ($aftermatch -eq "True") { 
			if ($beforematch -eq "True") {
				Get-Item -path $folder | Rename-Item -NewName {$_.name -replace "pending","complete"} 

} # 1st if
} # 2nd if 
} # 3rd if 
	elseif ($deniedmatch -eq "True") {
				Get-Item -path $folder | Rename-Item -NewName {$_.name -replace "pending","denied"}
} # elif
} # for each 
