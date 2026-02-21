Package ‘BiocInstaller’

April 15, 2019

Title Install/Update Bioconductor, CRAN, and github Packages

Description This package is used to install and update Bioconductor,

CRAN, and (some) github packages.

Version 1.32.1

Author Dan Tenenbaum and Biocore Team

Maintainer Bioconductor Package Maintainer <maintainer@bioconductor.org>

biocViews Infrastructure

Depends R (>= 3.5.0), R (< 3.6.0)

Suggests remotes, RUnit, BiocGenerics

License Artistic-2.0

PackageStatus Deprecated

git_url https://git.bioconductor.org/packages/BiocInstaller

git_branch RELEASE_3_8

git_last_commit 4c2a39e

git_last_commit_date 2018-11-01

Date/Publication 2019-04-15

R topics documented:

.

.

.

.
biocinstallRepos .
biocLite .
.
.
biocUpdatePackages
.
.
BiocUpgrade .
.
.
.
biocValid .
.
.
biocVersion .
.
.
.
Package Groups .
.
.
useDevel .

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
.
.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

2
3
5
6
7
8
8
9

13

1

Index

2

biocinstallRepos

biocinstallRepos

Display current Bioconductor and CRAN repositories.

Description

Displays the URLs of the repositories used by biocLite to install Bioconductor and CRAN pack-
ages.

Usage

biocinstallRepos(siteRepos=character(), version=biocVersion())

Arguments

siteRepos

(Optional) character(1) representing an additional repository (e.g., a URL to
an organization’s internally maintained repository) in which to look for packages
to install. This repository will be prepended to the default repositories returned
by the function.

version

(Optional) character(1) or package_version indicating the Bioconductor
version (e.g., “3.1”) for which repositories are required.

Value

Named character() of repositories.

See Also

biocLite Installs/updates Bioconductor/CRAN packages.

install.packages installs the packages themselves.

chooseBioCmirror lets you choose from a list of all public Bioconductor mirror URLs.

chooseCRANmirror lets you choose from a list of all public CRAN mirror URLs.

Examples

biocinstallRepos()

## Choose mirrors
## Not run:
chooseCRANmirror()
chooseBioCmirror()

## End(Not run)

biocLite

3

biocLite

Install or update Bioconductor and CRAN packages

Description

biocLite installs or updates Bioconductor and CRAN packages in a Bioconductor release. Up-
grading to a new Bioconductor release requires additional steps; see https://bioconductor.org/
install.
BIOCINSTALLER_ONLINE_DCF is an environment variable or global options() which, when set to
FALSE, uses conﬁguration information from a local archive rather than consulting the current online
version.

Usage

biocLite(pkgs=c("Biobase", "IRanges", "AnnotationDbi"),

suppressUpdates=FALSE,
suppressAutoUpdate=FALSE,
siteRepos=character(),
ask=TRUE, ...)

Arguments

pkgs

suppressUpdates

character() of package names to install or update. A missing value and
suppressUpdates=FALSE updates installed packages, perhaps also installing
Biobase, IRanges, and AnnotationDbi if they are not already installed. Pack-
age names containing a ‘/’ are treated as github repositories and installed using
the install_github() function of the remotes package.

logical(1) or character(). When FALSE, biocLite asks the user whether old
packages should be update. When TRUE, the user is not prompted to update
old packages. When character() a vector specifying which packages to NOT
update.

suppressAutoUpdate

siteRepos

ask

...

logical(1) indicating whether the BiocInstaller package updates itself.
character() representing an additional repository in which to look for pack-
ages to install. This repository will be prepended to the default repositories
(which you can see with biocinstallRepos).
logical(1) indicating whether to prompt user before installed packages are
updated, or the character string ’graphics’, which brings up a widget for choos-
ing which packages to update. If TRUE, user can choose whether to update all
outdated packages without further prompting, to pick and choose packages to
update, or to cancel updating (in a non-interactive session, no packages will be
updated). Otherwise, the value is passed to update.packages.

Additional arguments.
When installing CRAN or Bioconductor packages, typical arguments include:
lib.loc, passed to old.packages and used to determine the library location
of installed packages to be updated; and lib, passed to install.packages to
determine the library location where pkgs are to be installed.

4

Details

When installing github packages, ... is passed to the remotes package func-
tions install_github and install (internally). A typical use is to build vi-
gnettes, via dependencies=TRUE, build_vignettes=TRUE.

biocLite

Installation of Bioconductor and CRAN packages use R’s standard functions for library man-
agement – install.packages(), available.packages(), update.packages(). Installation of
github packages uses the install_github() function from the remotes package. For this reason
it usually makes sense, when complicated installation options are needed, to invoke biocLite()
separately for Bioconductor / CRAN packages and for github packages.
Setting BIOCINSTALLER_ONLINE_DCF to FALSE can speed package loading when internet access
is slow or non-existent, but may result in out-of-date information about the current release and
development versions of Bioconductor.

Value

biocLite() returns the pkgs argument, invisibly.

See Also

biocinstallRepos returns the Bioconductor and CRAN repositories used by biocLite.
install.packages installs the packages themselves.
update.packages updates all installed packages.
chooseBioCmirror lets you choose from a list of all public Bioconductor mirror URLs.
chooseCRANmirror lets you choose from a list of all public CRAN mirror URLs.
monograph_group, RBioinf_group and biocases_group return package names associated with
Bioconductor publications.
all_group returns the names of all Bioconductor software packages.

Examples

## Not run:
## Change default Bioconductor and CRAN mirrors
chooseBioCmirror()
chooseCRANmirror()

## If you don't have the BiocInstaller package installed, you can
## quickly install and load it as follows:
source("https://bioconductor.org/biocLite.R")

# 'http' if 'https' unavailable

## The most recent version of the BiocInstaller package is now loaded.
## No need to load it with library().

## installs default packages (if not already installed) and updates
## previously installed packages
biocLite()

## Now install a CRAN package:
biocLite("survival")

## install a Bioconductor package, but don't update all installed
## packages as well:

biocUpdatePackages

5

biocLite("GenomicRanges", suppressUpdates=TRUE)

## Install default packages, but do not update any package whose name
## starts with "org." or "BSgenome."
biocLite(suppressUpdates=c("^org\.", "^BSgenome\."))

## install a package from source:
biocLite("IRanges", type="source")

## install all Bioconductor software packages
biocLite(all_group())

## End(Not run)
## Show the Bioconductor and CRAN repositories that will be used to
## install/update packages.
biocinstallRepos()

## Use local archive rather than current online configuration
## information. Set this prior to loading the BiocInstaller package.
options(BIOCINSTALLER_ONLINE_DCF = FALSE)

biocUpdatePackages

Update previously installed Bioconductor or CRAN packages and
their dependencies.

Description

Update previously installed Bioconductor and CRAN packages and their dependencies. Use biocLite
to install new packages or to update all out-of-date packages. Upgrading to a new Bioconductor re-
lease requires additional steps; see https://bioconductor.org/install.

Usage

biocUpdatePackages(pkgs, dependencies = NA, repos=biocinstallRepos(), ...)

Arguments

pkgs

dependencies

repos

...

Value

‘NULL’, invisibly.

character() of package names to install or update.
character() describing out-of-date dependencies that are also updated. De-
faults to c("Depends",
"Imports", "LinkingTo") but can be a subset of
"Imports", "LinkingTo", "Suggests", "Enhances").
c("Depends",
character() of named repositories in which to look for package updates, in the
style of biocinstallRepos().
Additional arguments, passed to update.packages. For example, ask=FALSE
to avoid prompts to update individual packages.

BiocUpgrade

6

Author(s)

Martin Morgan mtmorgan@fhcrc.org

See Also

biocLite

Examples

## Not run:
biocUpdatePackages("GenomicRanges", ask=FALSE)

## End(Not run)

BiocUpgrade

Upgrade Bioconductor to the latest version available for this version
of R

Description

Downloads the latest version of the BiocInstaller package, and upgrades all currently installed pack-
ages to the latest repositories for this version of R.

To upgrade, use:

## 'http' if 'https' unavailable
source("https://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")

See Also

biocLite Installs/updates Bioconductor/CRAN packages.
chooseBioCmirror lets you choose from a list of all public Bioconductor mirror URLs.
chooseCRANmirror lets you choose from a list of all public CRAN mirror URLs.
biocinstallRepos returns the Bioconductor and CRAN repositories used by biocLite.
install.packages installs the packages themselves.

Examples

## Not run:
source("https://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")

## End(Not run)

biocValid

7

biocValid

Validate installed package versions against biocLite versions.

Description

Check that installed packages are consistent (neither out-of-date nor too new) with the version of R
and Bioconductor in use, using biocLite for validation.

Usage

biocValid(pkgs = installed.packages(lib.loc, priority = priority),
lib.loc = NULL, priority = "NA", type = getOption("pkgType"),
filters = NULL, silent = FALSE, ..., fix=FALSE)

Arguments

pkgs

lib.loc

priority

type

filters

silent

...

fix

Details

A character list of package names for checking, or a matrix as returned by
installed.packages.
The library location(s) of packages to be validated; see installed.packages.
check validity of all, “base”, or “recommended” packages; see installed.packages.
The type of available package (e.g., binary, source) to check validity against; see
available.packages.
Filter available packages to check validity against; see available.packages.
Report how packages are invalid (silent=FALSE, default) and abort execution,
or return a logical(1) (silent=TRUE) indicating the overall validity of installed
packages.
Additional arguments, passed to biocLite when fix=TRUE.
When TRUE, invoke biocLite to reinstall (update or downgrade, as appropriate)
invalid packages.

This function compares the version of installed packages to the version of packages associated with
the version of R and Bioconductor appropriate for the BiocInstaller package currently in use.

Packages are reported as ‘out-of-date’ if a more recent version is available at the repositories spec-
iﬁed by biocinstallRepos(). Usually, biocLite() is sufﬁcient to update packages to their most
recent version.

Packages are reported as ‘too new’ if the installed version is more recent than the most recent
available in the biocinstallRepos() repositories. It is possible to down-grade by re-installing a
too new package “PkgA” with biocLite("PkgA"). It is important for the user to understand how
their installation became too new, and to avoid this in the future.

Value

logical(1) indicating overall validity of installed packages.

Author(s)

Martin Morgan mtmorgan@fhcrc.org

Package Groups

8

See Also

biocLite to update installed packages.

Examples

try(biocValid())

biocVersion

Bioconductor version

Description

This function reports the Bioconductor version in use, as determined by the BiocInstaller package.

Usage

biocVersion()

Value

package_version representing the Bioconductor version in use.

See Also

biocLite Installs/updates Bioconductor/CRAN packages.
BiocUpgrade Upgrading to new versions.

Examples

biocVersion()

Package Groups

Convenience functions to return package names associated with Bio-
conductor publications.

Description

Returns character vectors of packages associated with Bioconductor publications, which can then
be passed to biocLite()

Usage

monograph_group()
RBioinf_group()
biocases_group()
all_group()

Value

character() of package names.

useDevel

See Also

9

biocLite Installs/updates Bioconductor/CRAN packages.
biocinstallRepos returns the Bioconductor and CRAN repositories used by biocLite.
install.packages installs the packages themselves.
chooseBioCmirror lets you choose from a list of all public Bioconductor mirror URLs.
chooseCRANmirror lets you choose from a list of all public CRAN mirror URLs.

Examples

## Get the names of packages used in the book
## "Bioconductor Case Studies":
biocases_group()

## Get the names of packages used in the book
## "R Programming for Bioinformatics":
RBioinf_group()

## Get the names of packages used in the monograph
## "Bioinformatics and Computational Biology Solutions
## Using R and Bioconductor":
monograph_group()

## Get the names of all Bioconductor software packages
all_group()

useDevel

Get the ’devel’ version of the BiocInstaller package.

Description

Downloads the ’devel’ version of the BiocInstaller package so that all subsequent invocations of
biocLite and biocinstallRepos use the devel repositories.
Displays the URLs of the repositories used by biocLite to install Bioconductor and CRAN pack-
ages.

Should only be used with a release (or patched) version of R, freshly installed.

Usage

isDevel()
useDevel(devel=TRUE)

Arguments

devel

Whether to look in the devel (TRUE) or release (FALSE) repositories in subse-
quent invocations of biocLite and biocinstallRepos.

10

Details

useDevel

Bioconductor has a ’release’ branch and a ’devel’ branch. The branch in use depends on the version
of R and the version of the BiocInstaller.
useDevel() installs the correct version of the BiocInstaller package for use of the devel version of
Bioconductor, provided it is supported by the version of R in use.
isDevel() returns TRUE when the version of BiocInstaller in use corresponds to the ’devel’ version
of Bioconductor.

In more detail, the version number of the BiocInstaller package determines whether to download
packages from the release or devel repositories of Bioconductor. In keeping with Bioconductor
versioning conventions, if the middle number (y in x.y.z) is even, the package is part of a release
version; if odd, it’s part of a devel version.

By default, when BiocInstaller is ﬁrst installed and when the version of R supports the current
release version of Bioconductor, BiocInstaller will use the release repository.
To change the version of BiocInstaller to support the ’devel’ branch of Bioconductor, run useDevel().
With argument TRUE (the default), it will download the devel version of BiocInstaller and subse-
quently all packages downloaded with biocLite will be from the devel repository. You should run
useDevel only once.
During release cycles where both the release and devel version of Bioconductor use the same version
of R, it is possible to use release and devel versions of Bioconductor with the same installation of
R. To do this, use the R_LIBS_USER environment variable. First, create two separate directories for
your BioC release and devel packages. Suggested directory names are as follows:

Linux:

~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-release

~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-devel

Mac OS:

~/Library/R/3.2-bioc-release/library

~/Library/R/3.2-bioc-devel/library

Windows:

C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.2-bioc-release

C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.2-bioc-devel

(change YOUR_USER_NAME to your user name)

Invoke "R for bioc-devel" or "R for bioc-release" from the command line as follows:

Linux:

R_LIBS_USER=~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-release R

R_LIBS_USER=~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-devel R

Mac OS X:

R_LIBS_USER=~~/Library/R/3.2-bioc-release/library R R_LIBS_USER=~~/Library/R/3.2-bioc-
devel/library R

Windows:

cmd /C "set R_LIBS_USER=C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.2-bioc-
release && R"

cmd /C "set R_LIBS_USER=C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.2-bioc-
devel && R"

(Note: this assumes that R.exe is in your PATH.)

useDevel

11

If you launch R in this way and then invoke .libPaths, you’ll see that the ﬁrst item is your special
release or devel directory. Packages will be installed to that directory and that is the ﬁrst place
that library will look for them. biocLite, install.packages, update.packages and friends all
respect this setting.

On Linux and Mac OS X, you can create a bash alias to save typing. Add the following to your
~/bash_proﬁle:

Linux

alias Rdevel=’R_LIBS_USER=~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-devel R’

alias Rrelease=’R_LIBS_USER=~/R/x86_64-unknown-linux-gnu-library/3.2-bioc-release R’

Mac OS X

alias Rdevel=’R_LIBS_USER=~/Library/R/3.2-bioc-devel/library R’ alias Rrelease=’R_LIBS_USER=~/Library/R/3.2-
bioc-release/library R’

You can then invoke these from the command line as

Rdevel

...and...

Rrelease

On Windows, you can create two shortcuts, one for devel and one for release. Go to My Computer
and navigate to a directory that is in your PATH. Then right-click and choose New->Shortcut.

in the "type the location of the item" box, put:

cmd /C "set R_LIBS_USER=C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.2-bioc-
release && R"

...for release and

cmd /C "set R_LIBS_USER=C:\Users\YOUR_USER_NAME\Documents\R\win-library\3.0-bioc-
devel && R"

...for devel.

(again, it’s assumed R.exe is in your PATH)

Click "Next".

In the "Type a name for this shortcut" box, type

Rdevel

or

Rrelease

You can invoke these from the command line as

Rdevel.lnk

...and...

Rrelease.lnk

(You must type in the .lnk extension.)
Because R_LIBS_USER is an environment variable, its value should be inherited by any subprocesses
started by R, so they should do the right thing as well.

Value

useDevel(): Invisible NULL.
isDevel(): logical(1) TRUE or FALSE.

12

See Also

useDevel

biocinstallRepos returns the Bioconductor and CRAN repositories used by biocLite.
biocLite Installs/updates Bioconductor/CRAN packages.
install.packages installs the packages themselves.
chooseBioCmirror lets you choose from a list of all public Bioconductor mirror URLs.
chooseCRANmirror lets you choose from a list of all public CRAN mirror URLs.

Examples

isDevel()

## Not run: useDevel()

Index

∗Topic environment

biocinstallRepos, 2
biocLite, 3
biocUpdatePackages, 5
BiocUpgrade, 6
biocValid, 7
biocVersion, 8
Package Groups, 8
useDevel, 9

.libPaths, 11

all_group, 4
all_group (Package Groups), 8
available.packages, 7

biocases_group, 4
biocases_group (Package Groups), 8
BIOCINSTALLER_ONLINE_DCF (biocLite), 3
biocinstallRepos, 2, 3, 4, 6, 9, 12
biocLite, 2, 3, 5–12
biocUpdatePackages, 5
BiocUpgrade, 6, 8
biocValid, 7
biocVersion, 8

chooseBioCmirror, 2, 4, 6, 9, 12
chooseCRANmirror, 2, 4, 6, 9, 12

install.packages, 2–4, 6, 9, 11, 12
install_github, 4
installed.packages, 7
isDevel (useDevel), 9

library, 11

monograph_group, 4
monograph_group (Package Groups), 8

old.packages, 3

Package Groups, 8

RBioinf_group, 4
RBioinf_group (Package Groups), 8

update.packages, 3–5, 11
useDevel, 9, 10

13

