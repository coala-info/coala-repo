# GNU Core Utilities Frequently Asked Questions

Next: [Fileutils shellutils and textutils](#Fileutils-shellutils-and-textutils)

|  |  |  |
| --- | --- | --- |
| • [Fileutils, shellutils and textutils](#Fileutils-shellutils-and-textutils) |  |  |
| • [Where can I get more information about GNU coreutils?](#Where-can-I-get-more-information-about-GNU-coreutils_003f) |  |  |
| • [Where can I get the latest version of GNU coreutils?](#Where-can-I-get-the-latest-version-of-GNU-coreutils_003f) |  |  |
| • [How do I add a question to the FAQ?](#How-do-I-add-a-question-to-the-FAQ_003f) |  |  |
| • [How do I report a bug?](#How-do-I-report-a-bug_003f) |  |  |
| • [I reported a bug but did not get a response.](#I-reported-a-bug-but-did-not-get-a-response_002e) |  |  |
| • [I use the Cygwin toolset and I have a problem.](#I-use-the-Cygwin-toolset-and-I-have-a-problem_002e) |  |  |
| • [Why can only root chown files?](#Why-can-only-root-chown-files_003f) |  |  |
| • [chown fails when the username contains a ’.’ in it.](#chown-fails-when-the-username-contains-a-_0027_002e_0027-in-it_002e) |  |  |
| • [How do I remove files that start with a dash?](#How-do-I-remove-files-that-start-with-a-dash_003f) |  |  |
| • [I have a file called `--help`. How do I remove it?](#I-have-a-file-called-_002d_002dhelp_002e-How-do-I-remove-it_003f) |  |  |
| • [I have a file ’-f’ and it affects rm.](#I-have-a-file-_0027_002df_0027-and-it-affects-rm_002e) |  |  |
| • [Why doesn’t rm -r \*.pattern recurse like it should?](#Why-doesn_0027t-rm-_002dr-_002a_002epattern-recurse-like-it-should_003f) |  |  |
| • [I used rm to remove a file. How can I get it back now?](#I-used-rm-to-remove-a-file_002e-How-can-I-get-it-back-now_003f) |  |  |
| • [Why don’t the utilities have built in directory recursion?](#Why-don_0027t-the-utilities-have-built-in-directory-recursion_003f) |  |  |
| • [ls -d does not list directories!](#ls-_002dd-does-not-list-directories_0021) |  |  |
| • [ls -a \* does not list dot files](#ls-_002da-_002a-does-not-list-dot-files) |  |  |
| • [Argument list too long](#Argument-list-too-long) |  |  |
| • [I am trying to compile a C program ...](#I-am-trying-to-compile-a-C-program-_002e_002e_002e) |  |  |
| • [I am having a problem with kill, nice, pwd, sleep, or test.](#I-am-having-a-problem-with-kill-nice-pwd-sleep-or-test_002e) |  |  |
| • [echo test printf kill](#echo-test-printf-kill) |  |  |
| • [Sort does not sort in normal order!](#Sort-does-not-sort-in-normal-order_0021) |  |  |
| • [The ls command is not listing files in a normal order!](#The-ls-command-is-not-listing-files-in-a-normal-order_0021) |  |  |
| • [The date command is not working right.](#The-date-command-is-not-working-right_002e) |  |  |
| • [ln -s did not link my files together](#ln-_002ds-did-not-link-my-files-together) |  |  |
| • [How do I change the ownership or permissions of a symlink?](#How-do-I-change-the-ownership-or-permissions-of-a-symlink_003f) |  |  |
| • [Value too large for defined data type](#Value-too-large-for-defined-data-type) |  |  |
| • [Tar created a Large File but I can’t remove it.](#Tar-created-a-Large-File-but-I-can_0027t-remove-it_002e) |  |  |
| • [The ’od -x’ command prints bytes in the wrong order.](#The-_0027od-_002dx_0027-command-prints-bytes-in-the-wrong-order_002e) |  |  |
| • [expr 2 \* 3 does not work](#expr-2-_002a-3-does-not-work) |  |  |
| • [df and du report different information](#df-and-du-report-different-information) |  |  |
| • [df Size and Used and Available do not add up](#df-Size-and-Used-and-Available-do-not-add-up) |  |  |
| • [Old tail plus N syntax now fails](#Old-tail-plus-N-syntax-now-fails) |  |  |
| • [join requires sorted input files](#join-requires-sorted-input-files) |  |  |
| • [cp and mv: the –reply=X option is deprecated](#cp-and-mv-the-reply-option-is-deprecated) |  |  |
| • [uname is system specific](#uname-is-system-specific) |  |  |

## 1 GNU Core Utilities Frequently Asked Questions

Welcome to the GNU Core Utilities FAQ. This document answers the most
frequently asked questions about the core utilities of the GNU
Operating System.

The master location of this document is available online at
<http://www.gnu.org/software/coreutils/faq/>.

If you have a question that is not answered in this FAQ then please
check the mailing list archives. If you find a useful question and
answer please send a message to the bug list and I will add it to the
FAQ so that this document can be improved. If you still don’t find a
suitable answer, consider posting the question to the bug list.

An excellent collection of FAQs is available by anonymous FTP at
rtfm.mit.edu and in particular the Unix FAQ is pertinent here.
ftp://rtfm.mit.edu/pub/usenet/news.answers/unix-faq/faq/contents

This FAQ was written by Bob Proulx
<bob@proulx.com> as an amalgamation of
the many questions asked and answered on the bug lists.

Copyright © 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008,
2009, 2010, 2011, 2012, 2013, 2014, 2015 Free Software Foundation

This document is free documentation; you can redistribute it and/or
modify it under the terms of the GNU General Public License as published
by the Free Software Foundation; either version 3 of the License, or (at
your option) any later version.

This document and any included programs in the document are distributed
in the hope that they will be useful, but WITHOUT ANY WARRANTY; without
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE. See the GNU General Public License for more details.

If you have not received a copy of the GNU General Public License see
<http://www.gnu.org/licenses/>.

|  |  |  |
| --- | --- | --- |
| • [Fileutils shellutils and textutils](#Fileutils-shellutils-and-textutils) |  |  |
| • [Where can I get more information about GNU coreutils?](#Where-can-I-get-more-information-about-GNU-coreutils_003f) |  |  |
| • [Where can I get the latest version of GNU coreutils?](#Where-can-I-get-the-latest-version-of-GNU-coreutils_003f) |  |  |
| • [How do I add a question to the FAQ?](#How-do-I-add-a-question-to-the-FAQ_003f) |  |  |
| • [How do I report a bug?](#How-do-I-report-a-bug_003f) |  |  |
| • [I reported a bug but did not get a response.](#I-reported-a-bug-but-did-not-get-a-response_002e) |  |  |
| • [I use the Cygwin toolset and I have a problem.](#I-use-the-Cygwin-toolset-and-I-have-a-problem_002e) |  |  |
| • [Why can only root chown files?](#Why-can-only-root-chown-files_003f) |  |  |
| • [chown fails when the username contains a '.' in it.](#chown-fails-when-the-username-contains-a-_0027_002e_0027-in-it_002e) |  |  |
| • [How do I remove files that start with a dash?](#How-do-I-remove-files-that-start-with-a-dash_003f) |  |  |
| • [I have a file called `--help`. How do I remove it?](#I-have-a-file-called-_002d_002dhelp_002e-How-do-I-remove-it_003f) |  |  |
| • [I have a file '-f' and it affects rm.](#I-have-a-file-_0027_002df_0027-and-it-affects-rm_002e) |  |  |
| • [Why doesn't rm -r \*.pattern recurse like it should?](#Why-doesn_0027t-rm-_002dr-_002a_002epattern-recurse-like-it-should_003f) |  |  |
| • [I used rm to remove a file. How can I get it back now?](#I-used-rm-to-remove-a-file_002e-How-can-I-get-it-back-now_003f) |  |  |
| • [Why don't the utilities have built in directory recursion?](#Why-don_0027t-the-utilities-have-built-in-directory-recursion_003f) |  |  |
| • [ls -d does not list directories!](#ls-_002dd-does-not-list-directories_0021) |  |  |
| • [ls -a \* does not list dot files](#ls-_002da-_002a-does-not-list-dot-files) |  |  |
| • [Argument list too long](#Argument-list-too-long) |  |  |
| • [I am trying to compile a C program ...](#I-am-trying-to-compile-a-C-program-_002e_002e_002e) |  |  |
| • [I am having a problem with kill nice pwd sleep or test.](#I-am-having-a-problem-with-kill-nice-pwd-sleep-or-test_002e) |  |  |
| • [echo test printf kill](#echo-test-printf-kill) |  |  |
| • [Sort does not sort in normal order!](#Sort-does-not-sort-in-normal-order_0021) |  |  |
| • [The ls command is not listing files in a normal order!](#The-ls-command-is-not-listing-files-in-a-normal-order_0021) |  |  |
| • [The date command is not working right.](#The-date-command-is-not-working-right_002e) |  |  |
| • [ln -s did not link my files together](#ln-_002ds-did-not-link-my-files-together) |  |  |
| • [How do I change the ownership or permissions of a symlink?](#How-do-I-change-the-ownership-or-permissions-of-a-symlink_003f) |  |  |
| • [Value too large for defined data type](#Value-too-large-for-defined-data-type) |  |  |
| • [Tar created a Large File but I can't remove it.](#Tar-created-a-Large-File-but-I-can_0027t-remove-it_002e) |  |  |
| • [The 'od -x' command prints bytes in the wrong order.](#The-_0027od-_002dx_0027-command-prints-bytes-in-the-wrong-order_002e) |  |  |
| • [expr 2 \* 3 does not work](#expr-2-_002a-3-does-not-work) |  |  |
| • [df and du report different information](#df-and-du-report-different-information) |  |  |
| • [df Size and Used and Available do not add up](#df-Size-and-Used-and-Available-do-not-add-up) |  |  |
| • [Old tail plus N syntax now fails](#Old-tail-plus-N-syntax-now-fails) |  |  |
| • [join requires sorted input files](#join-requires-sorted-input-files) |  |  |
| • [cp and mv the reply option is deprecated](#cp-and-mv-the-reply-option-is-deprecated) |  |  |
| • [uname is system specific](#uname-is-system-specific) |  |  |

---

Next: [Where can I get more information about GNU coreutils?](#Where-can-I-get-more-information-about-GNU-coreutils_003f), Previous: [Top](#Top), Up: [Top](#Top)

## 2 Fileutils, shellutils and textutils

Previously a set of three packages combined implemented the core set
of GNU utilities. These were the GNU fileutils, shellutils and
textutils. (Additionally shellutils with the version number attached
as a suffix was one letter too long for 14 character limited
filesystems and was also known as sh-utils.) Each had its own web
page. Each had their own mailing list. But the three were generally
considered a set.

In 2003 these three packages of `fileutils`, `shellutils`,
and `textutils` were combined into the current `coreutils`
package. This greatly simplified the maintenance and management of
this project. The older packages are deprecated. All users are
requested to update to the latest stable release of `coreutils`.

---

Next: [Where can I get the latest version of GNU coreutils?](#Where-can-I-get-the-latest-version-of-GNU-coreutils_003f), Previous: [Fileutils shellutils and textutils](#Fileutils-shellutils-and-textutils), Up: [Top](#Top)

## 3 Where can I get more information about GNU coreutils?

The online `info` documentation is always the most up to date
source of information. It should always be consulted first for the
latest information on your particular installation. Here are example
commands to invoke `info` to browse the documentation.

```
info coreutils
info coreutils ls
info coreutils sort
info coreutils head
```

Additionally the home page contains the canonical top level
information and pointers to all things GNU coreutils.

<http://www.gnu.org/software/coreutils/>
:   The online web home page for the GNU coreutils.

Please browse the mailing list archives. It is possible, even likely,
that your question has been asked before. You might find just the
information you were looking for. Many questions are asked here and at
least a few are answered.

<http://lists.gnu.org/archive/html/bug-coreutils/>
:   The GNU Core Utilities mailing list archives of the bug list.

<http://lists.gnu.org/mailman/listinfo/bug-coreutils>
:   The GNU Core Utilities bug mailing list subscription interface.

<http://lists.gnu.org/archive/html/coreutils/>
:   The GNU Core Utilities mailing list archives of the discussion list.

<http://lists.gnu.org/mailman/listinfo/coreutils>
:   The GNU Core Utilities discussion mailing list subscription interface.

---

Next: [How do I add a question to the FAQ?](#How-do-I-add-a-question-to-the-FAQ_003f), Previous: [Where can I get more information about GNU coreutils?](#Where-can-I-get-more-information-about-GNU-coreutils_003f), Up: [Top](#Top)

## 4 Where can I get the latest version of GNU coreutils?

<http://ftp.gnu.org/pub/gnu/coreutils>
:   The GNU coreutils main stable release distribution site.

ftp://alpha.gnu.org/gnu/coreutils
:   The GNU coreutils alpha and beta test release distribution site.

<https://savannah.gnu.org/git/?group=coreutils>
:   The GNU coreutils developer’s site on Savannah documenting source code
    access.

<http://git.savannah.gnu.org/gitweb/?p=coreutils.git>
:   Browse the source code using the online web interface to the git
    version control system source code repository.

Development releases of GNU coreutils source code can be downloaded
from ftp://alpha.gnu.org/gnu/coreutils. These are test
releases and although they are generally of good quality they have not
been tested well enough nor matured enough to be considered stable
releases. Also by definition stable means stable and the test
releases change frequently. Use with care.

The source code is maintained in the git version control system. The
home page for git is <http://git.or.cz/>. A wiki page on
Savannah documenting git use is at
<http://savannah.gnu.org/maintenance/UsingGit>. A local working
copy of the latest source code may be obtained using this command.

```
git clone git://git.savannah.gnu.org/coreutils
```

When possible it helps to report any bugs as seen against the
latest development version. However the latest development version
has dependencies upon the latest version of several other projects.
See the README-hacking file available in the project source and here
on the web at
<http://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=blob;f=README-hacking>
for details of how to build the latest
development version from checkout sources.

To avoid needing the latest development tools the maintainers
periodically make available snapshot releases. These may be built
with only normal system dependencies. These are frequently short
lived and available directly from the developer’s site. To find out
information about these it is best to read the mailing list and look
for the latest snapshot announcement. Here are search links that may
be useful.

```
http://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=%2Bsubject%3Asnapshot&submit=Search%21&idxname=bug-coreutils
http://lists.gnu.org/archive/cgi-bin/namazu.cgi?query=%2Bsubject%3Asnapshot&submit=Search%21&idxname=coreutils
```

Great effort is spent to ensure that the software builds easily on a
large number of different systems. If you have not done it before
then compiling the coreutils from a release or snapshot is probably
easier than you think. If possible please build and test the latest
test release to see if your problem is resolved there.

A note for Cygwin users. The MS-Windows platform requires special
handling. For Cygwin I recommend using the latest precompiled
bina