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

## GNU datamash

GNU datamash is
a command-line program which performs basic numeric, textual and statistical
operations on input textual data files.

```
Examples:

calculate the sum and mean of values 1 to 10:

  $ seq 10 | datamash sum 1 mean 1
  55 5.5

group text file by one column and calculate
mean and sample standard deviation on another,
with automatic sorting and header line processing:

  $ datamash --sort --headers groupby 2 mean 3 sstdev 3 < scores_h.txt
  GroupBy(Major)  mean(Score) sstdev(Score)
  Arts            68.94       10.42
  ...

file validation for pipeline automation and troubleshooting:

  $ datamash check < snp147Common.txt && echo ok || echo fail
  15189820 lines, 26 fields
  ok

  $ datamash check < tmp2.txt && echo ok || echo fail
  line 3816 (7 fields):
    chrY  9544432 9552871 NR_001534 0 - 0.5
  line 3817 (6 fields):
    chrY  9544432 9552871 NR_003592 0 -
  datamash: check failed: line 3817 has 6 fields (previous line had 7)
  fail
```

### Downloading datamash

Datamash is runs on a wide variety of UNIX platforms, Windows, and MacOS.

See the [download section](./download/) for more details.

### Documentation and Help

* Usage [Examples](./examples/)
* Alternative [one-liners](./alternatives/) and more examples
* Online [Datamash Manual](./manual/)
* Brief help screen: `datamash --help`
* Usage details and examples: `man datamash`
* For the complete manual in `info` format run:
  `info datamash`
* Please send questions, suggestions, patches and bug reports to
  bug-datamash@gnu.org
* Searchable archive of questions and discussions at:
  <https://lists.gnu.org/archive/html/bug-datamash/>.
* Subscribe at:
  <https://lists.gnu.org/mailman/listinfo/bug-datamash>

### Source Code

* Stable source releases:
  <https://ftp.gnu.org/gnu/datamash/>
  (FTP).
* Development snapshots:
  <https://alpha.gnu.org/gnu/datamash/>.
* Miscellaneous downloads (e.g. pre-compiled binaries):
  <https://download.savannah.gnu.org/releases/datamash/>.
* View GIT Code Repository:
  <https://git.savannah.gnu.org/gitweb/?p=datamash.git>.
* Clone GIT repository:
  `git clone git://git.sv.gnu.org/datamash.git`

### Development

Development of
Datamash,
and GNU in general, is a volunteer effort, and you can contribute. For
information, please read [How to help GNU](/help/). If you'd
like to get involved, it's a good idea to join the discussion mailing
list (see above).

* Savannah Project Homepage:
  <https://savannah.gnu.org/projects/datamash/>
* To translate Datamash's messages into other languages, please see the
  [Translation Project page for datamash](https://translationproject.org/domain/datamash.html).
* Send bug reports to
  bug-datamash@gnu.org.

### Maintainer

Datamash
is currently being maintained by
Assaf Gordon
and Tim Rice.

For any questions, please send email to
bug-datamash@gnu.org.

### Licensing

GNU Datamash
is free software; you can redistribute it and/or modify it under the
terms of the [GNU General Public License](https://www.gnu.org/licenses/gpl.html) as published by the Free
Software Foundation; either version 3 of the License, or (at your
option) any later version.

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
$Date: 2022/05/24 21:49:32 $