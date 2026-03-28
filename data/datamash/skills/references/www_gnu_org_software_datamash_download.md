[**Skip to main text**](#content)

[Free Software Supporter](//www.fsf.org/fss):

[JOIN THE FSF](https://www.fsf.org/associate/support_freedom?referrer=4052)

[![ [A GNU head] ](/graphics/heckert_gnu.transp.small.png)**GNU** Operating System](/)
Supported by the
[Free Software Foundation](#mission-statement)

[![ [Search www.gnu.org] ](/graphics/icons/search.png)](//www.gnu.org/cgi-bin/estseek.cgi)

[Site navigation](#navigation "More...")
[**Skip**](#content)

* [ABOUT GNU](/gnu/gnu.html)
* [PHILOSOPHY](/philosophy/philosophy.html)
* [LICENSES](/licenses/licenses.html)
* [EDUCATION](/education/education.html)
* =
  [SOFTWARE](/software/software.html)

  =
* [DISTROS](/distros/distros.html)
* [DOCS](/doc/doc.html)
* [MALWARE](/proprietary/proprietary.html)
* [HELP GNU](/help/help.html)
* [AUDIO & VIDEO](/audio-video/audio-video.html)
* [GNU ART](/graphics/graphics.html)
* [FUN](/fun/humor.html)
* [GNU'S WHO?](/people/people.html)
* [SOFTWARE DIRECTORY](//directory.fsf.org)
* [HARDWARE](https://h-node.org/)
* [SITEMAP](/server/sitemap.html)

[← back to GNU Datamash main page](../)

## GNU datamash - Downloads

GNU datamash is runs on a wide variety of UNIX platforms, Windows, and MacOS.

* [Build from Source](#source)
* [Prebuilt Packages](#packages)for common systems
* [Alpine Linux](#alpine)
* [Windows](#windows)
* [GNU Hurd](#hurd)
* [BSD systems](#bsd)
* [Galaxy](#galaxy)

### Build from Source

Datamash source code is available at:
<https://ftp.gnu.org/gnu/datamash/>.
Use the following commands to build datamash:

```
wget http://ftp.gnu.org/gnu/datamash/datamash-1.3.tar.gz
tar -xzf datamash-1.3.tar.gz
cd datamash-1.3
./configure
make
make check
sudo make install
```

### Prebuilt Packages for common systems

* Debian (
  [package](https://packages.debian.org/search?keywords=datamash&searchon=names&suite=all§ion=all)):

  ```
  sudo apt-get install datamash
  ```
* Ubuntu (
  [package](http://packages.ubuntu.com/search?keywords=datamash&searchon=names&suite=all§ion=all)):

  ```
  sudo apt install datamash
  ```
* Fedora (
  [package](https://apps.fedoraproject.org/packages/datamash)):

  ```
  sudo dnf install datamash
  ```
* Gentoo (
  [package](https://packages.gentoo.org/packages/sci-calculators/datamash)):

  ```
  sudo emerge sci-calculators/datamash
  ```
* Arch (
  [package](https://www.archlinux.org/packages/?sort=&q=datamash&maintainer=&flagged=)):

  ```
  sudo pacman -S datamash
  ```
* openSUSE (
  [package](https://software.opensuse.org/package/datamash?search_term=datamash)):

  ```
  sudo zypper install datamash
  ```
* Mac OS X using [HomeBrew](https://brew.sh/) (
  [package](http://formulae.brew.sh/formula/datamash)):

  ```
  brew install datamash
  ```
* ChromeOS using [Crew](http://skycocker.github.io/chromebrew/) (
  [package](https://github.com/skycocker/chromebrew/blob/master/packages/datamash.rb)):

  ```
  crew install datamash
  ```

### Alpine Linux

Datamash is available in Alpine's
[aports testing section](https://pkgs.alpinelinux.org/packages?name=datamash&branch=edge).

To install it, ensure 'testing' is included in the
/etc/apk/repositories file:

```
echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk update
```

Then install the package with the following command:

```
apk add datamash@testing
```

### Windows

Prebuilt binaries for windows are available for download at
[https://download.savannah.gnu.org/releases/datamash/windows-binaries/](http://download.savannah.gnu.org/releases/datamash/windows-binaries/).

### GNU Hurd

An older version of GNU Datamash is available as pre-build package for Debian GNU/Hurd:
[datamash\_1.0.6-1\_hurd-i386.deb](http://files.housegordon.org/datamash/bin/datamash_1.0.6-1_hurd-i386.deb).

To install, use the following commands:

```
wget http://files.housegordon.org/datamash/bin/datamash_1.0.6-1_hurd-i386.deb
sudo dpkg -i datamash_1.0.6-1_hurd-i386.deb
```

For other GNU Hurd-based systems, see [building from source](#source) for instructions.

### BSD systems

GNU Datamash is available as a BSD Ports package.
To install, run the following commands (as root):

```
cd /usr/ports/textproc
wget http://files.housegordon.org/datamash/src/BSD_ports_datamash.tar.gz
tar -xzf BSD_ports_datamash.tar.gz
cd datamash
make install
```

### Galaxy

[Galaxy](http://galaxyproject.org/)
is a web-based platform for data-intensive bioinformatics research.

Various Datamash wrappers are available as a pre-packaged tool at the
[Galaxy Toolshed](https://toolshed.g2.bx.psu.edu/)
(search for datamash on the front page).

---

[BACK TO TOP ▲](#header)

> [![ [FSF logo] ](/graphics/fsf-logo-notext-small.png)](//www.fsf.org)**“The Free Software Foundation (FSF) is a nonprofit with a worldwide
> mission to promote computer user freedom. We defend the rights of all
> software users.”**

[JOIN](//www.fsf.org/associate/support_freedom?referrer=4052)
[DONATE](//donate.fsf.org/)
[SHOP](//shop.fsf.org/)

Please send general FSF & GNU inquiries to
<gnu@gnu.org>.
There are also [other ways to contact](/contact/)
the FSF. Broken links and other corrections or suggestions can be sent
to <bug-datamash@gnu.org>.

Please see the [Translations
README](/server/standards/README.translations.html) for information on coordinating and submitting translations
of this article.

Copyright © 2014 Free Software Foundation, Inc.

This page is licensed under a [Creative
Commons Attribution-NoDerivs 3.0 United States License](http://creativecommons.org/licenses/by-nd/3.0/us/).

[Copyright Infringement Notification](//www.fsf.org/about/dmca-notice)

Updated:
$Date: 2019/08/22 07:24:27 $