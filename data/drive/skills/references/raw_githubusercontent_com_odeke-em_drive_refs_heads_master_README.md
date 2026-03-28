# drive
[![Build Status](https://travis-ci.org/odeke-em/drive.png?branch=master)](https://travis-ci.org/odeke-em/drive)
`drive` is a tiny program to pull or push [Google Drive](https://drive.google.com) files.
`drive` was originally developed by [Burcu Dogan](https://github.com/rakyll) while working on the Google Drive team. Since she is very busy and no longer able to maintain it, I took over drive on `Thursday, 1st January 2015`. This repository contains the latest version of the code.
## Table of Contents
- [Installing](#installing)
- [Requirements](#requirements)
- [From sources](#from-sources)
- [Godep](#godep)
- [Platform Packages](#platform-packages)
- [Automation Scripts](#automation-scripts)
- [Cross Compilation](#cross-compilation)
- [API keys](#api-keys)
- [Usage](#usage)
- [Hyphens: - vs --](#hyphens---vs---)
- [Initializing](#initializing)
- [De Initializing](#de-initializing)
- [Traversal Depth](#traversal-depth)
- [Configuring General Settings](#configuring-general-settings)
- [Excluding And Including Objects](#excluding-and-including-objects)
- [Sample .driveignore with the exclude and include clauses combined](sample-.driveignore-with-the-exclude-and-include-clauses-combined)
- [Pulling](#pulling)
- [Verifying Checksums](#verifying-checksums)
- [Exporting Docs](#exporting-docs)
- [Pushing](#pushing)
- [Pulling And Pushing Notes](#pulling-and-pushing-notes)
- [End to End Encryption](#end-to-end-encryption)
- [Publishing](#publishing)
- [Unpublishing](#unpublishing)
- [Sharing and Emailing](#sharing-and-emailing)
- [Unsharing](#unsharing)
- [Starring Or Unstarring](#starring-or-unstarring)
- [Diffing](#diffing)
- [Touching](#touching)
- [Trashing And Untrashing](#trashing-and-untrashing)
- [Emptying The Trash](#emptying-the-trash)
- [Deleting](#deleting)
- [Listing](#listing)
- [Stating](#stating)
- [Printing URL](#printing-url)
- [Editing Description](#editing-description)
- [Retrieving MD5 Checksums](#retrieving-md5-checksums)
- [Retrieving FileId](#retrieving-fileid)
- [Retrieving Quota](#retrieving-quota)
- [Retrieving Features](#retrieving-features)
- [Creating](#creating)
- [Opening](#opening)
- [Copying](#copying)
- [Moving](#moving)
- [Renaming](#renaming)
- [Command Aliases](#command-aliases)
- [Detecting And Fixing Clashes](#detecting-and-fixing-clashes)
- [.desktop Files](#desktop-files)
- [Fetching And Pruning Missing Index Files](#fetching-and-pruning-missing-index-files)
- [Drive Server](#drive-server)
- [QR Code Share](#qr-code-share)
- [About](#about)
- [Help](#help)
- [Filing Issues](#filing-issues)
- [Revoking Account Access](#revoking-account-access)
- [Uninstalling](#uninstalling)
- [Applying Patches](#applying-patches)
- [Why Another Google Drive Client?](#why-another-google-drive-client)
- [Known Issues](#known-issues)
- [Reaching Out](#reaching-out)
- [Disclaimer](#disclaimer)
- [LICENSE](#license)
## Installing
### Requirements
go 1.9.X or higher is required. See [here](https://golang.org/doc/install) for installation instructions and platform installers.
\* Make sure to set your GOPATH in your env, .bashrc or .bash\\_profile file. If you have not yet set it, you can do so like this:
```shell
cat << ! >> ~/.bashrc
> export GOPATH=\$HOME/gopath
> export PATH=\$GOPATH:\$GOPATH/bin:\$PATH
> !
source ~/.bashrc # To reload the settings and get the newly set ones # Or open a fresh terminal
```
The above setup will ensure that the drive binary after compilation can be invoked from your current path.
### From sources
To install from the latest source, run:
```shell
go get -u github.com/odeke-em/drive/cmd/drive
```
Otherwise:
\* In order to address [issue #138](https://github.com/odeke-em/drive/issues/138), where debug information should be bundled with the binary, you'll need to run:
```shell
go get github.com/odeke-em/drive/drive-gen && drive-gen
```
In case you need a specific binary e.g for Debian folks [issue #271](https://github.com/odeke-em/drive/issues/271) and [issue 277](https://github.com/odeke-em/drive/issues/277)
```shell
go get -u github.com/odeke-em/drive/drive-google
```
That should produce a binary `drive-google`
OR
To bundle debug information with the binary, you can run:
```shell
go get -u github.com/odeke-em/drive/drive-gen && drive-gen drive-google
```
### Godep
+ Using godep
```
cd $GOPATH/src/github.com/odeke-em/drive/drive-gen && godep save
```
+ Unravelling/Restoring dependencies
```
cd $GOPATH/src/github.com/odeke-em/drive/drive-gen && godep restore
```
Please see file `drive-gen/README.md` for more information.
### Platform Packages
For packages on your favorite platform, please see file [Platform Packages.md](https://github.com/odeke-em/drive/blob/master/platform\_packages.md).
Is your platform missing a package? Feel free to prepare / contribute an installation package and then submit a PR to add it in.
#### Automation Scripts
You can install scripts for automating major drive commands and syncing from [drive-google wiki](https://gitlab.com/jean-christophe-manciot/Drive/wikis/Drive-Automation-Scripts:-Startup-Guide-and-Screenshots), also described in [platform\_packages.md](https://github.com/odeke-em/drive/blob/master/platform\_packages.md).
Some screenshots are available [here](https://gitlab.com/jean-christophe-manciot/Drive/wikis/Drive-Automation-Scripts:-Startup-Guide-and-Screenshots#drive-menu-screenshots).
### Cross Compilation
See file `Makefile` which currently supports cross compilation. Just run `make` and then inspect the binaries in directory `bin`.
\* Supported platforms to cross compile to:
- ARMv5.
- ARMv6.
- ARMv7.
- ARMv8.
- Darwin (OS X).
- Linux.
Also inspect file `bin/md5Sums.txt` after the cross compilation.
### API keys
Optionally set the `GOOGLE\_API\_CLIENT\_ID` and `GOOGLE\_API\_CLIENT\_SECRET` environment variables to use your own API keys.
## Usage
### Hyphens: - vs --
A single hyphen `-` can be used to specify options. However two hyphens `--` can be used with any options in the provided examples below.
### Initializing
Before you can use `drive`, you'll need to mount your Google Drive directory on your local file system:
#### OAuth2.0 credentials
```shell
drive init ~/gdrive
cd ~/gdrive
```
#### Google Service Account credentials
```shell
drive init --service-account-file  ~/gdrive
cd ~/gdrive
```
Where  must be a [Google Service Account credentials](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount) file in JSON form.
This feature was implemented as requested by:
+ https://github.com/odeke-em/drive/issues/879
### De Initializing
The opposite of `drive init`, it will remove your credentials locally as well as configuration associated files.
```shell
drive deinit [-no-prompt]
```
For a complete deinitialization, don't forget to revoke account access, [please see revoking account access](#revoking-account-access)
### Traversal Depth
Before talking about the features of drive, it is useful to know about "Traversal Depth".
Throughout this README the usage of the term "Traversal Depth" refers to the number of
nodes/hops/items that it takes to get from one parent to children. In the options that allow it, you'll have a flag option `-depth ` where n is an integer
\* Traversal terminates on encountering a zero `0` traversal depth.
\* A negative depth indicates infinity, so traverse as deep as you can.
\* A positive depth helps control the reach.
Given:
|- A/
|- B/
|- C/
|- C1
|- C2
|- C10/
|- CTX/
| - Music
| - Summary.txt
+ Items on the first level relative to A/ ie `depth 1`, we'll have:
B, C
+ On the third level relative to C/ ie `depth 3`
\* We'll have:
Items: Music, Summary.txt
\* The items encountered in `depth 3` traversal relative to C/ are:
|- C1
|- C2
|- C10/
|- CTX/
| - Music
| - Summary.txt
+ No items are within the reach of `depth -1` relative to B/ since B/ has no children.
+ Items within the reach of `depth -` relative to CTX/ are:
| - Music
| - Summary.txt
### Configuring General Settings
drive supports resource configuration files (.driverc) that you can place both globally (in your home directory)
and locally(in the mounted drive dir) or in the directory that you are running an operation from, relative to the root.
The entries for a .driverc file is in the form a key-value pair where the key is any of the arguments that you'd get
from running
```shell
drive  -h
# e.g
drive push -h
```
and the value is the argument that you'd ordinarily supply on the commandline.
.driverc configurations can be optionally grouped in sections. See https://github.com/odeke-em/drive/issues/778.
For example:
```shell
cat << ! >> ~/.driverc
> # My global .driverc file
> export=doc,pdf
> depth=100
> no-prompt=true
>
> # For lists
> [list]
> depth=2
> long=true
>
> # For pushes
> [push]
> verbose=false
>
> # For stats
> [stat]
> depth=3
>
> # For pulls and pushes
> [pull/push]
> no-clobber=true
> !
cat << ! >> ~/emm.odeke-drive/.driverc
> # The root main .driverc
> depth=-1
> hidden=false
> no-clobber=true
> exports-dir=$HOME/exports
> !
cat << $ >> ~/emm.odeke-drive/fall2015Classes/.driverc
> # My global .driverc file
> exports-dir=$HOME/Desktop/exports
> export=pdf,csv,txt
> hidden=true
> depth=10
> exclude-ops=delete,update
> $
```
### Excluding and Including Objects
drive allows you to specify a '.driveignore' file similar to your .gitignore, in the root
directory of the mounted drive. Blank lines and those prefixed by '#' are considered as comments and skipped.
For example:
```shell
cat << $ >> .driveignore
> # My drive ignore file
> \.gd$
> \.so$
> \.swp$
> $
```
Note:
\* Pattern matching and suffixes are done by regular expression matching so make sure to use a valid regular expression suffix.
\* Go doesn't have a negative lookahead mechanism ie `exclude all but` which would
normally be achieved in other languages or regex engines by "?!". See https://groups.google.com/forum/#!topic/golang-nuts/7qgSDWPIh\_E.
This was reported and requested in [issue #535](https://github.com/odeke-em/drive/issues/535).
A use case might be ignoring all but say .bashrc files or .dotfiles.
To enable this, prefix "!" at the beginning of the path to achieve this behavior.
#### Sample .driveignore with the exclude and include clauses combined
```shell
cat << $ >> .driveignore
> ^\.
> !^\.bashrc # .bashrc files won't be ignored
> \_export$ # \_export files are to be ignored
> !must\_export$ # the exception to the clause anything with "must\_export"$ won't be ignored
```
### Pulling
The `pull` command downloads data that does not exist locally but does remotely on Google drive, and may delete local data that is not present on Google Drive.
Run it without any arguments to pull all of the files from the current path:
```shell
drive pull
```
To pull and decrypt your data that is stored encrypted at rest on Google Drive, use flag `-decryption-password`:
See [Issue #543](https://github.com/odeke-em/drive/issues/543)
```shell
drive pull -decryption-password '$JiME5Umf' influx.txt
```
Pulling by matches is also supported
```shell
cd ~/myDrive/content/2015
drive pull -matches vines docx
```
To force download from paths that otherwise would be marked with no-changes
```shell
drive pull -force
```
To pull specific files or directories, pass in one or more paths:
```shell
drive pull photos/img001.png docs
```
Pulling by id is also supported
```shell
drive pull -id 0fM9rt0Yc9RTPaDdsNzg1dXVjM0E 0fM9rt0Yc9RTPaTVGc1pzODN1NjQ 0fM9rt0Yc9RTPV1NaNFp5WlV3dlU
```
`pull` optionally allows you to pull content up to a desired depth.
Say you would like to get just folder items until the second level
```shell
drive pull -depth 2 heavy-files summaries
```
Traverse deep to infinity and beyond
```shell
drive pull -depth -1 all-my-files
```
Pulling starred files is allowed as well
```shell
drive pull -starred
drive pull -starred -matches content
drive pull -starred -all # Pull all the starred files that aren't in the trash
drive pull -starred -all -trashed # Pull all the starred files in the trash
```
Like most commands [.driveignore](#excluding-and-including-objects) can be used to filter which files to pull.
+ Note: Use `drive pull -hidden` to also pull files starting with `.` like `.git`.
To selectively pull by type e.g file vs directory/folder, you can use flags
- `files`
- `directories`
```shell
drive pull -files a1/b2
drive pull -directories tf1
```
#### Verifying Checksums
Due to popular demand, by default, checksum verification is turned off. It was deemed to be quite vigorous and unnecessary for most cases, in which size + modTime differences are sufficient to detect file changes. The discussion stemmed from issue [#117](https://github.com/odeke-em/drive/issues/117).
However, modTime differences on their own do not warrant a resync of the contents of file.
Modification time changes are operations of their own and can be made:
+ locally by, touching a file (chtimes).
+ remotely by just changing the modTime meta data.
To turn checksum verification back on:
```shell
drive pull -ignore-checksum=false
```
drive also supports piping pulled content to stdout which can be accomplished by:
```shell
drive pull -piped path1 path2
```
+ In relation to issue #529, you can change the max retry counts for exponential backoff. Using a count < 0 falls back to the
default count of 20:
```shell
drive pull -retry-count 14 documents/2016/March videos/2013/September
```
#### Exporting Docs
By default, the `pull` command will export Google Docs documents as PDF files. To specify other formats, use the `-export` option:
```shell
drive pull -export pdf,rtf,docx,txt
```
To explicitly export instead of using `-force`
```shell
drive pull -export pdf,rtf,docx,txt -explicitly-export
```
By default, the exported files will be placed in a new directory suffixed by `\\_exports` in the same path. To export the files to a different directory, use the `-exports-dir` option:
```shell
drive pull -export pdf,rtf,docx,txt -exports-dir ~/Desktop/exports
```
Otherwise, you can export files to the same directory as requested in [issue #660](https://github.com/odeke-em/drive/issues/660),
by using pull flag `-same-exports-dir`. For example:
```shell
drive pull -explicitly-export -exports-dir ~/Desktop/exp -export pdf,txt,odt -same-exports-dir
Resolving...
+ /test-exports/few.docs
+ /test-exports/few
+ /test-exports/influx
Addition count 3
Proceed with the changes? [Y/n]:y
Exported '/Users/emmanuelodeke/emm.odeke@gmail.com/test-exports/influx' to '/Users/emmanuelodeke/Desktop/exp/influx.pdf'
Exported '/Users/emmanuelodeke/emm.odeke@gmail.com/test-exports/influx' to '/Users/emmanuelodeke/Desktop/exp/influx.txt'
Exported '/Users/emmanuelodeke/emm.odeke@gmail.com/test-exports/few' to '/Users/emmanuelodeke/Desktop/exp/few.pdf'
Exported '/Users/emmanuelodeke/emm.odeke@gmail.com/test-exports/few.docs' to '/Users/emmanuelodeke/Desktop/exp/few.docs.txt'
Exported '/Users/emmanuelodeke/emm.odeke@gmail.com/test-exports/few.docs' to '/Users/emmanuelodeke/Desktop/exp/few.docs.odt'
Exported '/Users/e