![U.S. flag](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/favicons/favicon-57.png)

An official website of the United States government

Here's how you know

![Dot gov](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-dot-gov.svg)

**The .gov means it’s official.**

Federal government websites often end in .gov or .mil. Before
sharing sensitive information, make sure you’re on a federal
government site.

![Https](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-https.svg)

**The site is secure.**

The **https://** ensures that you are connecting to the
official website and that any information you provide is encrypted
and transmitted securely.

[![NIH NLM Logo](https://www.ncbi.nlm.nih.gov/coreutils/nwds/img/logos/AgencyLogo.svg)](https://www.ncbi.nlm.nih.gov/)

[Log in](https://account.ncbi.nlm.nih.gov)

Show account info

Close

#### Account

Logged in as:

* [Dashboard](/myncbi/)
* [Publications](/myncbi/collections/bibliography/)
* [Account settings](/account/settings/)
* [Log out](/account/signout/)

[Access keys](https://www.ncbi.nlm.nih.gov/guide/browsers/#ncbi_accesskeys)
[NCBI Homepage](https://www.ncbi.nlm.nih.gov)
[MyNCBI Homepage](/myncbi/)
[Main Content](#maincontent)
Main Navigation

[BLAST ®](../../blast/Blast.cgi)

* [Home](../../blast/Blast.cgi?CMD=Web&PAGE_TYPE=BlastHome "BLAST Home")
* [Recent Results](../../blast/Blast.cgi?CMD=GetSaved&RECENT_RESULTS=on "Unexpired BLAST jobs")
* [Saved Strategies](../../blast/Blast.cgi?CMD=GetSaved "Saved sets of BLAST search parameters")
* [Help](index.html "BLAST documentation")

[BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi)

>

[blast-help](index.html#index)

>

Developer Information

Was this content helpful?

Yes

No

Contents

* [Overview](#overview)
* [Web service interface](#web-service-interface)
* [REST](#rest)
* [C++ Toolkit implementation](#c-toolkit-implementation)

# [Overview](#id1)[¶](#overview "Link to this heading")

BLAST is public domain software.

Public-domain software is software that has been placed in the public domain, in other words, software for which there is absolutely no ownership such as
copyright, trademark, or patent. Software in the public domain can be modified, distributed, or sold even without any attribution by anyone;
this is unlike the common case of software under exclusive copyright, where licenses grant limited usage rights.

# [Web service interface](#id2)[¶](#web-service-interface "Link to this heading")

The NCBI supports RESTful interface to programmatically submit BLAST searches. Users of the service at the NCBI should respect the usage guidelines below.

# [REST](#id3)[¶](#rest "Link to this heading")

A RESTful interface is supported for submission of BLAST searches via an HTTP based interface.
Searches are submitted to the NCBI servers. [Documentation](urlapi.html#urlapi) and [sample perl code](https://blast.ncbi.nlm.nih.gov/docs/web_blast.pl) are available. This is a public resource, so usage limitations apply. Projects
that involve a large number of BLAST searches should use the RESTful interface at a cloud provider or stand-alone BLAST.

## Usage Guidelines[¶](#usage-guidelines "Link to this heading")

The NCBI BLAST servers are a shared resource. We give priority to interactive users. In order to ensure availability of the service to the entire community, we may limit searches
for some high volume users. Interactive users of the NCBI webpages through a web browser should not encounter problems. We will move searches of users who submit more than 100 searches in a
24 hour period to a slower queue, or, in extreme cases, will block the requests. To avoid problems, API users should comply with the following guidelines:

* Do not contact the server more often than once every 10 seconds.
* Do not poll for any single RID more often than once a minute.
* Use the URL parameter email and tool, so that the NCBI can contact you if there is a problem.
* Run scripts weekends or between 9 pm and 5 am Eastern time on weekdays if more than 50 searches will be submitted.

BLAST often runs more efficiently if multiple queries are sent as one search rather than if each query is sent as an individual search. This is especially true for blastn,
megablast, and tblastn. If your queries are short (less than a few hundred bases) we suggest you merge them into one search of up to 1,000 bases

The NCBI servers are a shared resource and not intended for projects that involve a large number of BLAST searches.
We provide the [Stand-alone BLAST+ binaries](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download),
[Docker Image](https://hub.docker.com/r/ncbi/blast) and [Elastic BLAST](https://blast.ncbi.nlm.nih.gov/doc/elastic-blast/) for these purposes.

# [C++ Toolkit implementation](#id4)[¶](#c-toolkit-implementation "Link to this heading")

The currently-maintained implementation of BLAST is part of the [NCBI C++ Toolkit](https://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/).

The algorithm core is written in C and a [documented C++ API](https://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/doxyhtml/group__AlgoBlast.html) is available.

The source code may be [downloaded by FTP](https://www.ncbi.nlm.nih.gov/toolkit/doc/book/ch_getcode_svn/) and
[browsed with LXR](https://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/lxr/source/src/algo/blast/).

Follow NCBI

[Twitter](https://twitter.com/ncbi)
[Facebook](https://www.facebook.com/ncbi.nlm)
[Youtube](https://www.youtube.com/user/NCBINLM)
[LinkedIn](https://www.linkedin.com/company/ncbinlm)
[GitHub](https://github.com/ncbi)

[Follow NLM](https://www.nlm.nih.gov/socialmedia/index.html)

* [SM-Facebook](https://www.facebook.com/nationallibraryofmedicine)
* [SM-Twitter](https://twitter.com/NLM_NIH)
* [SM-Youtube](https://www.youtube.com/user/NLMNIH)

National Library of Medicine
[8600 Rockville Pike
Bethesda, MD 20894](https://www.google.com/maps/place/8600%2BRockville%2BPike%2C%2BBethesda%2C%2BMD%2B20894/%4038.9959508%2C-77.101021%2C17z/data%3D%213m1%214b1%214m5%213m4%211s0x89b7c95e25765ddb%3A0x19156f88b27635b8%218m2%213d38.9959508%214d-77.0988323)

[Copyright](https://www.nlm.nih.gov/copyright.html)
[FOIA](https://www.nih.gov/institutes-nih/nih-office-director/office-communications-public-liaison/freedom-information-act-office)
[HHS Vulnerability Disclosure](https://www.hhs.gov/vulnerability-disclosure-policy/index.html)

[Help](https://support.nlm.nih.gov/)
[Accessibility](https://www.nlm.nih.gov/accessibility.html)
[Careers](https://www.nlm.nih.gov/careers/careers.html)

* [NLM](//www.nlm.nih.gov/)
* [NIH](https://www.nih.gov/)
* [HHS](https://www.hhs.gov/)
* [USA.gov](https://www.usa.gov/)