Package ‘rappdirs’
January 17, 2026

Type Package

Title Application Directories: Determine Where to Save Data, Caches,

and Logs

Version 0.3.4

Description An easy way to determine which directories on the users
computer you should use to save data, caches and logs. A port of
Python's 'Appdirs' (<https://github.com/ActiveState/appdirs>) to R.

License MIT + file LICENSE

URL https://rappdirs.r-lib.org, https://github.com/r-lib/rappdirs

BugReports https://github.com/r-lib/rappdirs/issues

Depends R (>= 4.1)

Suggests covr, roxygen2, testthat (>= 3.2.0), withr

Config/Needs/website tidyverse/tidytemplate

Config/testthat/edition 3

Config/usethis/last-upkeep 2025-05-05

Copyright Original python appdirs module copyright (c) 2010

ActiveState Software Inc. R port copyright Hadley Wickham,
Posit, PBC. See file LICENSE for details.

Encoding UTF-8

RoxygenNote 7.3.3

NeedsCompilation yes

Author Hadley Wickham [trl, cre, cph],
Sridhar Ratnakumar [aut],
Trent Mick [aut],
ActiveState [cph] (R/appdir.r, R/cache.r, R/data.r, R/log.r translated
from appdirs),
Eddy Petrisor [ctb],
Trevor Davis [trl, aut] (ORCID:
<https://orcid.org/0000-0001-6341-4639>),
Gabor Csardi [ctb],
Gregory Jefferis [ctb],
Posit Software, PBC [cph, fnd] (ROR: <https://ror.org/03wc8by49>)

1

2

site_data_dir

Maintainer Hadley Wickham <hadley@posit.co>

Repository CRAN

Date/Publication 2026-01-17 08:40:02 UTC

Contents

site_data_dir .
user_cache_dir
user_data_dir
user_log_dir .

.

.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .

2
3
5
6

8

Index

site_data_dir

Path to shared data/config directories

Description

site_data_dir returns full path to the user-shared data dir for this application. site_config_dir
returns full path to the user-specific configuration directory for this application which returns the
same path as site data directory in Windows and Mac but a different one for Unix. Typical user-
shared data directories are:

Usage

site_data_dir(

appname = NULL,
appauthor = appname,
version = NULL,
multipath = FALSE,
expand = TRUE,
os = NULL

)

site_config_dir(

appname = NULL,
appauthor = appname,
version = NULL,
multipath = FALSE,
expand = TRUE,
os = NULL

)

user_cache_dir

Arguments

appname
appauthor

version

multipath

expand

os

Details

3

is the name of application. If NULL, just the system directory is returned.
(only required and used on Windows) is the name of the appauthor or distribut-
ing body for this application. Typically it is the owning company name. This
falls back to appname.
is an optional version path element to append to the path. You might want to use
this if you want multiple versions of your app to be able to run independently. If
used, this would typically be "<major>.<minor>". Only applied when appname
is not NULL.
is an optional parameter only applicable to *nix which indicates that the entire
list of data dirs should be returned By default, the first directory is returned
If TRUE (the default) will expand the R_LIBS specifiers with their equivalents.
See R_LIBS() for list of all possibly specifiers.
Operating system whose conventions are used to construct the requested direc-
tory. Possible values are "win", "mac", "unix". If NULL (the default) then the
current OS will be used.

• Mac OS X: /Library/Application Support/<AppName>
• Unix: /usr/local/share:/usr/share/
• Win XP: C:\\Documents and Settings\\All Users\\Application Data\\<AppAuthor>\\<AppName>
• Vista: (Fail! C:\\ProgramData is a hidden system directory on Vista.)
• Win 7: C:\\ProgramData\\<AppAuthor>\\<AppName>. Hidden, but writeable on Win 7.
Unix also specifies a separate location for user-shared configuration data in $XDG_CONFIG_DIRS.

• Unix: /etc/xdg/<AppName>, in $XDG_CONFIG_HOME if defined

For Unix, this returns the first default. Set the multipath=TRUE to guarantee returning all directo-
ries.

Warning

Do not use this on Windows. See the note above for why.

user_cache_dir

Path to user cache directory

Description

This functions uses R_USER_CACHE_DIR if set. Otherwise, they follow platform conventions. Typi-
cal user cache directories are:

• Mac OS X: ~/Library/Caches/<AppName>
• Linux: ~/.cache/<AppName>
• Win XP: C:\\Documents and Settings\\<username>\\Local Settings\\Application Data\\<AppAuthor>\\<AppName>\\Cache
• Vista: C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>\\Cache

user_cache_dir

4

Usage

user_cache_dir(

appname = NULL,
appauthor = appname,
version = NULL,
opinion = TRUE,
expand = TRUE,
os = NULL

)

Arguments

appname

appauthor

version

opinion

expand

os

Opinion

is the name of application. If NULL, just the system directory is returned.

(only required and used on Windows) is the name of the appauthor or distribut-
ing body for this application. Typically it is the owning company name. This
falls back to appname.

is an optional version path element to append to the path. You might want to use
this if you want multiple versions of your app to be able to run independently. If
used, this would typically be "<major>.<minor>". Only applied when appname
is not NULL.

(logical) Use FALSE to disable the appending of Cache on Windows. See dis-
cussion below.

If TRUE (the default) will expand the R_LIBS specifiers with their equivalents.
See R_LIBS() for list of all possibly specifiers.

Operating system whose conventions are used to construct the requested direc-
tory. Possible values are "win", "mac", "unix". If NULL (the default) then the
current OS will be used.

On Windows the only suggestion in the MSDN docs is that local settings go in the CSIDL_LOCAL_APPDATA
directory. This is identical to the non-roaming app data dir (i.e. user_data_dir()). But apps typ-
ically put cache data somewhere under this directory so user_cache_dir() appends Cache to the
CSIDL_LOCAL_APPDATA value, unless opinion = FALSE.

See Also

tempdir() for a non-persistent temporary directory.

Examples

user_cache_dir("rappdirs")

user_data_dir

5

user_data_dir

Path to user config/data directories

Description

user_data_dir() returns path to the user-specific data directory and user_config_dir() returns
full path to the user-specific configuration directory. These are the same on Windows and Mac but
different on Linux.

These functions first use R_USER_DATA_DIR and R_USER_CONFIG_DIR if set. Otherwise, they follow
platform conventions. Typical user config and data directories are:

• Mac OS X: ~/Library/Application Support/<AppName>

• Win XP (not roaming): C:\\Documents and Settings\\<username>\\Data\\<AppAuthor>\\<AppName>

• Win XP (roaming): C:\\Documents and Settings\\<username>\\Local Settings\\Data\\<AppAuthor>\\<AppName>

• Win 7 (not roaming): C:\\Users\\<username>\\AppData\\Local\\<AppAuthor>\\<AppName>

• Win 7 (roaming): C:\\Users\\<username>\\AppData\\Roaming\\<AppAuthor>\\<AppName>

Only Linux makes the distinction between config and data:

• Data: ~/.local/share/<AppName>

• Config: ~/.config/<AppName>

Usage

user_data_dir(

appname = NULL,
appauthor = appname,
version = NULL,
roaming = FALSE,
expand = TRUE,
os = NULL

)

user_config_dir(

appname = NULL,
appauthor = appname,
version = NULL,
roaming = TRUE,
expand = TRUE,
os = NULL

)

6

Arguments

appname
appauthor

version

roaming

expand

os

user_log_dir

is the name of application. If NULL, just the system directory is returned.
(only required and used on Windows) is the name of the appauthor or distribut-
ing body for this application. Typically it is the owning company name. This
falls back to appname.
is an optional version path element to append to the path. You might want to use
this if you want multiple versions of your app to be able to run independently. If
used, this would typically be "<major>.<minor>". Only applied when appname
is not NULL.
(logical, default FALSE) can be set TRUE to use the Windows roaming appdata di-
rectory. That means that for users on a Windows network setup for roaming pro-
files, this user data will be sync’d on login. See <https://learn.microsoft.com/en-
us/previous-versions/windows/it-pro/windows-vista/cc766489(v=ws.10). for a
discussion of issues.
If TRUE (the default) will expand the R_LIBS specifiers with their equivalents.
See R_LIBS() for list of all possibly specifiers.
Operating system whose conventions are used to construct the requested direc-
tory. Possible values are "win", "mac", "unix". If NULL (the default) then the
current OS will be used.

Examples

user_data_dir("rappdirs")

user_config_dir("rappdirs", roaming = TRUE, os = "win")
user_config_dir("rappdirs", roaming = FALSE, os = "win")
user_config_dir("rappdirs", os = "unix")
user_config_dir("rappdirs", os = "mac")
user_config_dir("rappdirs", version = "%p-platform/%v")

user_log_dir

Path to user log directory

Description

Typical user cache directories are:

Usage

user_log_dir(

appname = NULL,
appauthor = appname,
version = NULL,
opinion = TRUE,
expand = TRUE,
os = NULL

)

user_log_dir

Arguments

appname

appauthor

version

opinion

expand

os

Details

7

is the name of application. If NULL, just the system directory is returned.

(only required and used on Windows) is the name of the appauthor or distribut-
ing body for this application. Typically it is the owning company name. This
falls back to appname.

is an optional version path element to append to the path. You might want to use
this if you want multiple versions of your app to be able to run independently. If
used, this would typically be "<major>.<minor>". Only applied when appname
is not NULL.

(logical) can be FALSE to disable the appending of ‘Logs’ to the base app data
dir for Windows, and ‘log’ to the base cache dir for Unix. See discussion below.

If TRUE (the default) will expand the R_LIBS specifiers with their equivalents.
See R_LIBS() for list of all possibly specifiers.

Operating system whose conventions are used to construct the requested direc-
tory. Possible values are "win", "mac", "unix". If NULL (the default) then the
current OS will be used.

• Mac OS X: ‘~/Library/Logs/<AppName>’

• Unix: ‘~/.cache/<AppName>/log’, or under $XDG_CACHE_HOME if defined

• Win XP: ‘C:\Documents and Settings\<username>\Local Settings\Application Data\<AppAuthor>\<AppName>\Logs’

• Vista: ‘C:\Users\<username>\AppData\Local\<AppAuthor>\<AppName>\Logs’

On Windows the only suggestion in the MSDN docs is that local settings go in the CSIDL_LOCAL_APPDATA
directory.

Opinion

This function appends ‘Logs’ to the CSIDL_LOCAL_APPDATA value for Windows and appends ‘log’
to the user cache dir for Unix. This can be disabled with the opinion = FALSE option.

Examples

user_log_dir()

Index

R_LIBS(), 3, 4, 6, 7

site_config_dir (site_data_dir), 2
site_data_dir, 2

tempdir(), 4

user_cache_dir, 3
user_config_dir (user_data_dir), 5
user_data_dir, 5
user_data_dir(), 4
user_log_dir, 6

8

