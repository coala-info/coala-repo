# drive CWL Generation Report

## drive_about

### Tool Description
Gives information about the drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/drive/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kamranahmedse/driver.js
- **Stars**: N/A
### Original Help Text
```text
Usage of about:
  -features
    	gives information on features present on this drive
  -filesize
    	prints out information about file sizes e.g the max upload size for a specific file size
  -h	
  -quiet
    	if set, do not log anything but errors
  -quota
    	prints out quota information for this drive
```


## drive_copy

### Tool Description
Copy files or directories

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of copy:
  -h	
  -id
    	copy by id instead of path
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursive copying
```


## drive_cp

### Tool Description
Copy files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of cp:
  -h	
  -id
    	copy by id instead of path
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursive copying
```


## drive_del

### Tool Description
Deletes files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of del:
  -h	
  -hidden
    	allows trashing hidden paths
  -id
    	delete by id instead of path
  -matches
    	search by prefix and delete
  -no-prompt
    	disables the prompt
  -quiet
    	if set, do not log anything but errors
```


## drive_delete

### Tool Description
Deletes files or folders from Google Drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of delete:
  -h	
  -hidden
    	allows trashing hidden paths
  -id
    	delete by id instead of path
  -matches
    	search by prefix and delete
  -no-prompt
    	disables the prompt
  -quiet
    	if set, do not log anything but errors
```


## drive_diff

### Tool Description
Compares files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of diff:
  -base-local
    	when set uses local as the base other remote will be used as the base (default true)
  -depth int
    	max traversal depth (default -1)
  -h	
  -hidden
    	allows pulling of hidden paths
  -ignore-checksum
    	avoids computation of checksums as a final check.
Use cases may include:
	* when you are low on bandwidth e.g SSHFS.
	* Are on a low power device (default true)
  -ignore-conflict
    	turns off the conflict resolution safety
  -ignore-name-clashes
    	ignore name clashes
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursively diff (default true)
  -skip-content-check
    	skip diffing actual body content, show only name, time, type changes
  -u	unified diff (default true)
```


## drive_edit-desc

### Tool Description
Edit the description of a drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of edit-desc:
  -description string
    	set the description
  -h	
  -id
    	open by id instead of path
  -piped
    	get content in from standard input (stdin)
```


## drive_emptytrash

### Tool Description
Empties the trash

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of emptytrash:
  -h	
  -no-prompt
    	shows no prompt before emptying the trash
  -quiet
    	if set, do not log anything but errors
```


## drive_features

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
no drive context found; run `drive init` or go into one of the directories (sub directories) that you performed `drive init`
```


## drive_init

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Visit this URL to get an authorization code
https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=354790962074-7rrlnuanmamgg1i4feed12dpuq871bvd.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=2026-02-25+15%3A40%3A15.295790473+%2B0000+UTC2596996162
Paste the authorization code:
```


## drive_list

### Tool Description
List files and directories

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of list:
  -depth int
    	maximum recursion depth (default 1)
  -directories
    	list all directories
  -exact-owner string
    	elements with the exact owner
  -exact-title string
    	get elements with the exact titles
  -files
    	list only files
  -h	
  -hidden
    	list all paths even hidden ones
  -id
    	list by id instead of path
  -long
    	long listing of contents
  -match-mime string
    	get elements with the exact mimeTypes derived from extensions
  -match-owner string
    	elements with matching owners
  -matches
    	list by prefix
  -no-prompt
    	shows no prompt before pagination
  -owners
    	shows the owner names per file
  -pagesize int
    	number of results per pagination (default 100)
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursively list subdirectories
  -shared
    	show files that are shared with me
  -skip-mime string
    	skip elements with mimeTypes derived from these extensions
  -skip-owner string
    	ignore elements owned by these users
  -sort string
    	sort items by a combination of attributes
	* modtime.
	* md5.
	* name.
	* size.
	* type.
	* version
comma separated e.g modtime,md5_r,name
  -trashed
    	list content in the trash
  -version
    	show the number of times that the file has been modified on 
		the server even with changes not visible to the user
```


## drive_ls

### Tool Description
List files and directories in Google Drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of ls:
  -depth int
    	maximum recursion depth (default 1)
  -directories
    	list all directories
  -exact-owner string
    	elements with the exact owner
  -exact-title string
    	get elements with the exact titles
  -files
    	list only files
  -h	
  -hidden
    	list all paths even hidden ones
  -id
    	list by id instead of path
  -long
    	long listing of contents
  -match-mime string
    	get elements with the exact mimeTypes derived from extensions
  -match-owner string
    	elements with matching owners
  -matches
    	list by prefix
  -no-prompt
    	shows no prompt before pagination
  -owners
    	shows the owner names per file
  -pagesize int
    	number of results per pagination (default 100)
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursively list subdirectories
  -shared
    	show files that are shared with me
  -skip-mime string
    	skip elements with mimeTypes derived from these extensions
  -skip-owner string
    	ignore elements owned by these users
  -sort string
    	sort items by a combination of attributes
	* modtime.
	* md5.
	* name.
	* size.
	* type.
	* version
comma separated e.g modtime,md5_r,name
  -trashed
    	list content in the trash
  -version
    	show the number of times that the file has been modified on 
		the server even with changes not visible to the user
```


## drive_move

### Tool Description
Move files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of move:
  -h	
  -id
    	move by id instead of path
  -keep-parent
    	ensures that when moving a file into a destination, that we also retain its original parent so that it will exist in more than one folder
  -quiet
    	if set, do not log anything but errors
```


## drive_mv

### Tool Description
Move files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of mv:
  -h	
  -id
    	move by id instead of path
  -keep-parent
    	ensures that when moving a file into a destination, that we also retain its original parent so that it will exist in more than one folder
  -quiet
    	if set, do not log anything but errors
```


## drive_open

### Tool Description
Open files or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of open:
  -file-browser
    	open file with the local file manager (default true)
  -h	
  -id
    	open by id instead of path
  -web-browser
    	open file in default browser (default true)
```


## drive_pub

### Tool Description
Usage of pub

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of pub:
  -h	
  -hidden
    	allows publishing of hidden paths
  -id
    	publish by id instead of path
  -quiet
    	if set, do not log anything but errors
```


## drive_pull

### Tool Description
Pulls files and directories from Google Drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of pull:
  -all
    	all the starred files
  -decryption-password string
    	decryption password
  -depth int
    	max traversal depth (default -1)
  -desktop-links
    	allows docs + sheets to be pulled as .desktop files or URL linked files (default true)
  -directories
    	pull only directories
  -exclude-ops string
    	exclude operations
  -explicitly-export
    	explicitly pull exports
  -export string
    	comma separated list of formats to export your docs + sheets files
  -exports-dir string
    	directory to place exports
  -files
    	pull only files
  -fix-clashes
    	fix clashes by renaming or trashing files
  -force
    	forces a pull even if no changes present
  -h	
  -hidden
    	allows pulling of hidden paths
  -id
    	pull by id instead of path
  -ignore-checksum
    	avoids computation of checksums as a final check.
Use cases may include:
	* when you are low on bandwidth e.g SSHFS.
	* Are on a low power device (default true)
  -ignore-conflict
    	turns off the conflict resolution safety
  -ignore-name-clashes
    	ignore name clashes
  -matches
    	search by prefix
  -no-clobber
    	prevents overwriting of old content
  -no-prompt
    	shows no prompt before applying the pull action
  -piped
    	get content in from standard input (stdin)
  -quiet
    	if set, do not log anything but errors
  -recursive
    	performs the pull action recursively (default true)
  -retry-count int
    	max number of retries for exponential backoff (default 20)
  -same-exports-dir
    	exports are put in the same directory
  -skip-mime string
    	skip elements with mimeTypes derived from these extensions
  -starred
    	operate only on starred files
  -trashed
    	pull content in the trash
  -verbose
    	show step by step information verbosely
```


## drive_push

### Tool Description
Pushes files and directories to Google Drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of push:
  -coerced-mime string
    	the mimeType you are trying to coerce this file to be
  -convert
    	toggles conversion of the file to its appropriate Google Doc format
  -depth int
    	max traversal depth (default -1)
  -destination string
    	specify the final destination of the contents of an operation
  -directories
    	push only directories
  -encryption-password string
    	encryption password
  -exclude-ops string
    	exclude operations
  -files
    	push only files
  -fix-clashes
    	fix clashes by renaming or trashing files
  -force
    	forces a push even if no changes present
  -h	
  -hidden
    	allows pushing of hidden paths
  -ignore-checksum
    	avoids computation of checksums as a final check.
Use cases may include:
	* when you are low on bandwidth e.g SSHFS.
	* Are on a low power device (default true)
  -ignore-conflict
    	turns off the conflict resolution safety
  -ignore-name-clashes
    	ignore name clashes
  -m	allows pushing of mounted paths
  -no-clobber
    	prevents overwriting of old content
  -no-prompt
    	shows no prompt before applying the push action
  -ocr
    	if true, attempt OCR on gif, jpg, pdf and png uploads
  -piped
    	get content in from standard input (stdin)
  -quiet
    	if set, do not log anything but errors
  -recursive
    	performs the push action recursively (default true)
  -retry-count int
    	max number of retries for exponential backoff (default 20)
  -skip-mime string
    	skip elements with mimeTypes derived from these extensions
  -verbose
    	show step by step information verbosely
```


## drive_quota

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
no drive context found; run `drive init` or go into one of the directories (sub directories) that you performed `drive init`
```


## drive_rename

### Tool Description
Rename a file or directory on Google Drive.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of rename:
  -force
    	coerce rename even if remote already exists
  -h	
  -id
    	unshare by id instead of path
  -local
    	rename local as well (default true)
  -quiet
    	if set, do not log anything but errors
  -remote
    	rename remote as well (default true)
```


## drive_share

### Tool Description
Share a file

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of share:
  -emails string
    	emails to share the file to
  -h	
  -id
    	share by id instead of path
  -message string
    	message to send receipients
  -no-prompt
    	disables the prompt
  -notify
    	toggle whether to notify receipients about share (default true)
  -quiet
    	if set, do not log anything but errors
  -role string
    	role to set to receipients of share. Possible values: 
	* owner.
	* reader.
	* writer.
	* commenter.
  -type string
    	scope of accounts to share files with. Possible values: 
	* anyone.
	* user.
	* domain.
	* group
  -verbose
    	show step by step information verbosely (default true)
  -with-link
    	turn off file indexing so that only those with the link can view it
```


## drive_stat

### Tool Description
Statistics about files and directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of stat:
  -depth int
    	max traversal depth (default 1)
  -h	
  -hidden
    	discover hidden paths
  -id
    	stat by id instead of path
  -md5sum
    	produce output compatible with md5sum(1)
  -quiet
    	if set, do not log anything but errors
  -recursive
    	recursively discover folders
```


## drive_touch

### Tool Description
Touch files with specified modification times.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of touch:
  -depth int
    	max traversal depth (default -1)
  -duration string
    	the duration offset from now that each file's modification time should be set to e.g -32h
See https://golang.org/pkg/time/#ParseDuration
  -format string
    	the custom layout that you'd like your time to be set in, representative of the way 'Mon Jan 2 15:04:05 -0700 MST 2006' should be represented
See https://golang.org/pkg/time/#Parse (default "20060102150405")
  -h	
  -hidden
    	allows pushing of hidden paths
  -id
    	share by id instead of path
  -matches
    	search by prefix and touch
  -quiet
    	if set, do not log anything but errors
  -recursive
    	toggles recursive touching
  -time string
    	the time each file's modification time should be set to
  -verbose
    	show step by step information verbosely (default true)
```


## drive_trash

### Tool Description
Trash files and directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of trash:
  -h	
  -hidden
    	allows trashing hidden paths
  -id
    	trash by id instead of path
  -matches
    	search by prefix and trash
  -quiet
    	if set, do not log anything but errors
  -verbose
    	show step by step information verbosely
```


## drive_unpub

### Tool Description
Unpublish paths or IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/drive:0.3.9--0
- **Homepage**: https://github.com/kamranahmedse/driver.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage of unpub:
  -h	
  -hidden
    	allows pulling of hidden paths
  -id
    	unpublish by id instead of path
  -quiet
    	if set, do not log anything but errors
```


## Metadata
- **Skill**: not generated
