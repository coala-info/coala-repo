* [HOME](home.html)
* [NEWS](news.html)
* [FEATURES](features.html)
* [DOWNLOADS](downloads.html)
* [DOCUMENTATION](documentation.html)
* [DEVELOPMENT](development.html)
* [GROUP](group.html)
* [PUBLICATIONS](publications.html)
* [LINKS](links.html)

# Copyrights[\_](#Copyrights)

ARB software and documentation are copyrighted by *The ARB-project*.
External software distributed together with ARB is copyrighted by their respective authors.

ARB and bundled software may be copied on a non-profit basis.
Use is permitted for non-profit purposes. For usage conditions in commercial environments
please read the [detailed copyright notices](http://help.arb-home.de/copyright.html).

# ARB releases[\_](#ARB_releases)

* [current stable release (arb-7.0)](http://download.arb-home.de/release/latest/)
* Last Update : 2021-Sep-1

View log of [changes](http://vc.arb-home.de/readonly/tags/arb-7.0/arb_CHANGES.txt)

Also have a look at the
[production version](#Production_version)
of arb (=more recent than release).

* [OLD stable linux release (arb-6.0.6)](http://download.arb-home.de/release/arb-6.0.6/)
* Last Update : 2016-Aug-22

View log of [changes](http://vc.arb-home.de/readonly/tags/arb-6.0.6/arb_CHANGES.txt)

* [ANCIENT stable linux release (arb-5.5)](http://download.arb-home.de/release/arb-5.5/)
* Last Update : 2012-Nov-15

View log of [changes](http://vc.arb-home.de/readonly/tags/arb_5.5/arb_CHANGES.txt)

* [older releases](http://download.arb-home.de/release/)

* NOTE
* Don't ask - there IS no version for Windows

* HINT
* **Linux-Requirements**: A recent version of Linux (based on libc 6).

  To detect which version you have type 'ldd /bin/su'.
  If libc.so.6 shows up you have a version based on libc 6.

# Hardware Requirements [\_](#Hardware_Requirements)

ARB can be quite hungry for memory, depending on the database.

Please have a look at the
[ARB hardware requirements](http://bugs.arb-home.de/wiki/SystemRequirements).

# Installation instructions[\_](#Installation_instructions)

First, go through the readme:

* [arb\_README.txt](http://download.arb-home.de/release/latest/arb_README.txt)

Then choose version to install from this page.

Click on the respective link and download the following files:

|  |  |  |
| --- | --- | --- |
|  | **arb\_install.sh** | : Installation script |
|  | **arb-\*.tgz** | : ARB program (choose one of the provided versions, not all!) |

Once you have downloaded these files,
put them into a directory,
open a console window in that directory and
run the "arb\_install.sh" script there.

Answer the queries to install the "ARB program".

Happy ARBing!

* WARNING
* Do not uncompress and untar arb.tgz directly, instead, use the install script (arb\_install.sh)!

# Production version[\_](#Production_version)

* NOTE
* The production version of arb is installed and used inhouse at
  *MPI for Marine Microbiology*
  in Bremen.

It frequently updates from development changes, i.e. it contains recent
bugfixes and newest features, but also may break working things.
It is updated at least every few months.

Check out features and bugfixes for the next arb release which are already
[included in the production version](http://help.arb-home.de/changes.html#Major_changes_for_next_release:).

Please test these features and
[report problems](http://bugs.arb-home.de/wiki/BugReport).

Information about downloadable
[production version builds](http://bugs.arb-home.de/wiki/WikiStart#productionversion)
is provided in the arb wiki.

# ARB ports[\_](#ARB_ports)

ARB versions in this section are maintained by ARB users

**Mac OSX:**
Initial port was done by Ben Hines and Mike Dyall-Smith.

From 2008 until 2013 ongoing mac ports by Matt Cottrell.
We included Matts build instructions into the ARB tarball (and online at
[arb\_OS\_X\_MacPorts.txt](http://vc.arb-home.de/readonly/trunk/arb_OS_X_MacPorts.txt) and
[arb\_OS\_X.txt](http://vc.arb-home.de/readonly/trunk/arb_OS_X.txt)).

Since 2018 Jan Gerken from the [arb-silva](https://www.arb-silva.de/) team maintains a
[homebrew recipe for arb](https://github.com/arb-project/homebrew-arb).

**Debian Distribution:**
UNTESTED and/or EXPERIMENTAL version of ARB is available as Debian package and the same can be downloaded [here](http://packages.debian.org/unstable/science/arb).

Debian version is maintained by Andreas Tille.

# Code[\_](#Code)

Please access the source using our
[SVN-repository](http://bugs.arb-home.de/wiki/ARB-SVN-Repository)
or if you just wanna look, simply browse the [source](http://bugs.arb-home.de/browser/).

You´ll also find a tarball (arbsrc.tgz) in every build.

See also:
[Instructions to compile ARB from source](http://bugs.arb-home.de/wiki/building-arb-from-svn)
(on Ubuntu).

* NOTE
* If you make changes to the source code and think the public should benefit
  from them, please send a diff against the latest SVN version (instructions
  howto do this can be found [here](http://bugs.arb-home.de/wiki/ARB-SVN-Repository#ExternalSVNaccess)).

# ARB Databases[\_](#ARB_Databases)

* [databases](http://download.arb-home.de/data/)
* Last Update : 2007-Apr-16

* WARNING
* If you download databases using windows, only download the .gz files!
  Otherwise the file will be corrupted.

A central directory of ARB databases available on the web can be found at
[ARB database central](http://db-central.arb-home.de/).

We encourage you to share your work with others and to publish a link to your own database there.

|  |  |  |
| --- | --- | --- |
| Last updated on  10.Mar 2022 | Please feel free to EnableJavaScript@otherwiseSeeNoMail.de for any queries and suggestions! | [Privacy](pg/arb_dse_dt.html) |