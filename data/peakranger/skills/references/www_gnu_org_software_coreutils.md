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

## Coreutils - GNU core utilities

The GNU Core Utilities are the basic file, shell and text manipulation
utilities of the GNU operating system.
These are the core utilities
which are expected to exist on every operating system.

---

### Table of Contents

* [Getting Help](#help)
* [Downloads](#download)
* [Source Code](#source)
* [Third Party Testing Resources](#testing)
* [Mailing Lists](#mailinglists)
* [Maintainers](#maintainers)

---

### Getting Help

* Check Questions and Answers for common problems:
  [Coreutils FAQ](faq/coreutils-faq.html)
* Read the manual locally using `info coreutils` or see the latest [online manual](manual/)
  ([日本語](https://linuxjm.sourceforge.io/info/GNU_coreutils/coreutils-ja.html)).
* The [Coreutils Gotchas](https://www.pixelbeat.org/docs/coreutils-gotchas.html)
  contains a list of some quirks and unexpected behaviour (which are often
  mistaken for bugs).
* Search the archives for previous questions and answers:
  + Search mailing lists:
  + General usage and advice: [coreutils mailing list](https://lists.gnu.org/archive/html/coreutils/).
  + Bug reports: [bug-coreutils mailing List](https://lists.gnu.org/archive/html/bug-coreutils/).
* Send general questions or suggestions to the mailing list at <coreutils@gnu.org>.
* Send translation requests to the language team at the
  [Translation Project](https://translationproject.org/domain/coreutils.html).
* Report bugs, including version and distribution variant, to the list at
  <bug-coreutils@gnu.org>.
  Before sending the bug, please consult the FAQ and mailing list archives (above).
  Often these perceived bugs are simply due to wrong program usage.
  To learn more about reporting bugs, see [Getting help with GNU software](/software/gethelp.html).

### Downloads

Stable source releases are available on the main GNU download server
([via HTTPS](https://ftp.gnu.org/gnu/coreutils/),
[HTTP](http://ftp.gnu.org/gnu/coreutils/) or
FTP), and its
[mirrors](/prep/ftp.html). Please
[use a mirror](https://ftpmirror.gnu.org/gnu/coreutils/) if
possible.

### Source Code

The latest source with revision history can be browsed using
[cgit](https://git.sv.gnu.org/cgit/coreutils.git),
[gitweb](https://git.sv.gnu.org/gitweb/?p=coreutils.git) or
[GitHub](https://github.com/coreutils/coreutils).
Assuming you have [git](https://git-scm.com/) installed, you
can retrieve the latest version with this command:

```
git clone git://git.sv.gnu.org/coreutils
```

A [Coreutils code structure overview](http://www.maizure.org/projects/decoded-gnu-coreutils/) is available,
which is useful for educational purposes, or for those interested in contributing changes.
To build from the latest sources please follow the instructions in
[README-hacking](https://git.sv.gnu.org/cgit/coreutils.git/plain/README-hacking).
Please note that we do not suggest using test versions of Coreutils
for production use.

### Third Party Testing Resources

* [Hydra continuous integration jobs](https://hydra.nixos.org/jobset/gnu/coreutils-master)
* [Coverity static analysis](https://scan.coverity.com/projects/coreutils?tab=overview)
* [Open coverage test coverage report](http://www.opencoverage.net/coreutils)
* [Latest Hydra test coverage results](https://hydra.nixos.org/job/gnu/coreutils-master/coverage/latest/)

### Mailing Lists

You do not need to be subscribed in order to post messages to any GNU
mailing list. However non-subscribers are moderated by humans so
please be patient when waiting for your email to arrive.

You can subscribe to any GNU mailing list via the web as described
below. Or you can send an empty mail with a *Subject:* header line of
just “subscribe” to the relevant *-request* list. For example, to
subscribe yourself to the main coreutils list, you would
send mail to <coreutils-request@gnu.org>
with no body and a *Subject:* header line of just “subscribe”.

It has been necessary to moderate the Coreutils mailing lists to prevent the
flood of spam. Postings to the lists are held for release by
the list moderator. Sometimes the moderators are unavailable for
brief periods of time. Please be patient when posting. If you
don't eventually see the message in the list archive then it did not
get posted.

Announcements
:   The low-volume mailing list
    [coreutils-announce@gnu.org](https://lists.gnu.org/mailman/listinfo/coreutils-announce)
    contains all announcements about Coreutils.

    Important announcements about Coreutils and most other GNU software are
    also made on
    [info-gnu@gnu.org](https://lists.gnu.org/mailman/listinfo/info-gnu).

    There are also [periodic summaries](https://www.pixelbeat.org/patches/coreutils/)
    of committed, rejected and pending changes, to which one can subscribe.

Discussion List
:   The main discussion list for all things related to coreutils is
    [coreutils@gnu.org](https://lists.gnu.org/mailman/listinfo/coreutils).
    This is a recent change as previously general discussion took place on
    the bug list. If you have questions, comments, or other general
    discussion about Coreutils then this is the mailing list for that
    discussion. If you don't know where to start then this is the place
    to start. You can browse and search past postings to the
    [coreutils archive](https://lists.gnu.org/archive/html/coreutils/).
    Discussion prior to its creation in March 2010 is available in the bug
    mailing list archive.

Bug Reports
:   If you think you have found a bug in Coreutils, then please send
    as complete a bug report as possible to
    [bug-coreutils@gnu.org](https://lists.gnu.org/mailman/listinfo/bug-coreutils),
    and it will automatically be entered into the [Coreutils bug tracker](https://bugs.gnu.org/coreutils).
    Before reporting bugs please read the [FAQ](faq/coreutils-faq.html).
    A very useful and often referenced guide on how to write bug reports
    and ask good questions is the document
    [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html).
    You can browse previous postings and search the
    [bug-coreutils archive](https://lists.gnu.org/archive/html/bug-coreutils/).

Platform Testing
:   Trying the latest test release (when available) is always appreciated.
    Test releases of Coreutils are typically announced on the
    [platform-testers](https://lists.gnu.org/mailman/listinfo/platform-testers) mailing list.

Enhancement Requests
:   If you would like any new feature to be included in future versions of
    Coreutils, please send a request to [coreutils@gnu.org](https://lists.gnu.org/mailman/listinfo/coreutils).
    This is the general discussion list and a good place to start
    discussion of a new feature. After consideration you may be asked to
    log a request into the bug tracker so that the issue is not lost.
    If you would like to implement yourself, then note that non trivial changes
    require copyright assignment to the FSF as detailed in the “Copyright Assignment”
    section of the Coreutils [HACKING](https://git.sv.gnu.org/cgit/coreutils.git/plain/HACKING) notes.

    Note also the list of [rejected feature requests](rejected_requests.html).

Mailing List Etiquette
:   Please do not send messages encoded as HTML nor encoded as base64 MIME
    nor included as multiple formats.
    Please send messages as
    [plain text](https://web.archive.org/web/20160520201722/http%3A//stagecraft.theprices.net%3A80/nomime.html).
    Please include a descriptive subject line. If all of the subjects are
    *bug* then it is impossible to differentiate them.
    Please avoid sending large messages, such as log files, system call
    trace output, and other content resulting in messages over about 40 kB,
    to the mailing lists without prior contact. Those are best sent
    directly to those requesting that information after initial contact.

    Please remember that development of Coreutils is a volunteer effort, and you
    can also contribute to its development. For information about contributing
    to the GNU Project, please read [How to help GNU](/help/).

Previous Mailing Lists
:   Previously these utilities were offered as three individual sets of
    GNU utilities, [Fileutils](../fileutils/fileutils.html),
    [Shellutils](../shellutils/shellutils.html), and [Textutils](../textutils/textutils.html). Those three were
    combined into the single set of utilities called Coreutils.

    Since Coreutils had existed as the three individual packages for a
    long time you may want to read the archives of those previous mailing
    lists.
    [Fileutils archive](https://lists.gnu.org/archive/html/bug-fileutils/),
    [Shellutils archive](https://lists.gnu.org/archive/html/bug-sh-utils/),
    [Textutils archive](https://lists.gnu.org/archive/html/bug-textutils/).

### Maintainers

Coreutils is currently being maintained by
Jim Meyering <jim@meyering.net>,
Paul Eggert <eggert@cs.ucla.edu>,
Pádraig Brady <P@draigBrady.com>,
Bernhard Voelker <mail@bernhard-voelker.de>,
and
Collin Funk <collin.funk1@gmail.com>.

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
to <bug-coreutils@gnu.org>.

Please see the [Translations
README](/server/standards/README.translations.html) for information on coordinating and contributing translations
of this article.

Copyright © 2016 Free Software Foundation, Inc.

This page is licensed under a [Creative
Commons Attribution-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nd/4.0/).

[Copyright Infringement Notification](//www.fsf.org/about/dmca-notice)

Updated:
$Date: 2025/12/05 11:58:51 $