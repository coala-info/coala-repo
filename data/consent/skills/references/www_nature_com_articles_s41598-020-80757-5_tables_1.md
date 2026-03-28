[Skip to main content](#content)

Thank you for visiting nature.com. You are using a browser version with limited support for CSS. To obtain
the best experience, we recommend you use a more up to date browser (or turn off compatibility mode in
Internet Explorer). In the meantime, to ensure continued support, we are displaying the site without styles
and JavaScript.

Advertisement

[![Advertisement](//pubads.g.doubleclick.net/gampad/ad?iu=/285/scientific_reports/article&sz=728x90&c=1382928459&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41598-020-80757-5%26doi%3D10.1038/s41598-020-80757-5%26subjmeta%3D114,2785,631,794%26kwrd%3DComputational+biology+and+bioinformatics,Genome+informatics,Software)](//pubads.g.doubleclick.net/gampad/jump?iu=/285/scientific_reports/article&sz=728x90&c=1382928459&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41598-020-80757-5%26doi%3D10.1038/s41598-020-80757-5%26subjmeta%3D114,2785,631,794%26kwrd%3DComputational+biology+and+bioinformatics,Genome+informatics,Software)

[![Scientific Reports](https://media.springernature.com/full/nature-cms/uploads/product/srep/header-d3c533c187c710c1bedbd8e293815d5f.svg)](/srep)

* [View all journals](https://www.nature.com/siteindex)
* [Search](#search-menu)
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41598-020-80757-5/tables/1)

* [Content
  Explore content](#explore)
* [About the journal](#about-the-journal)
* [Publish with us](#publish-with-us)

* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41598)
* [RSS feed](https://www.nature.com/srep.rss)

1. [nature](/)
2. [scientific reports](/srep)
3. [articles](/srep/articles?type=article)
4. [article](/articles/s41598-020-80757-5)
5. table

# Table 1 Metrics output by ELECTOR on the simulated PacBio datasets.

From: [Scalable long read self-correction and assembly polishing with multiple sequence alignment](/articles/s41598-020-80757-5)

| Dataset | Corrector | Number of bases (Mbp) | Error rate (%) | Recall (%) | Precision (%) | Overlapping | | Correction | | Total | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Runtime | Memory (MB) | Runtime | Memory (MB) | Runtime | Memory (MB) |
| *E. coli* 30x | Original | 140 | 12.2862 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 130 | 0.4156 | 99.7647 | 99.5887 | \_ | \_ | \_ | \_ | 19 min | 4613 |
| Daccord | **131** | **0.0248** | **99,9965** | **99,9757** | 1 min | 6813 | 13 min | 639 | 14 min | 6813 |
| FLAS | 130 | 0.2720 | 99.9291 | 99.7385 | \_ | \_ | \_ | \_ | 12 min | 1639 |
| MECAT | 107 | 0.2569 | 99.9302 | 99.7533 | 25 s | **1600** | **1 min 14 s** | 1083 | **1 min 39 s** | **1600** |
| CONSENT | 130 | 0.3111 | 99.9328 | 99.6934 | **18 s** | 2345 | 7 min 16 s | **532** | 7 min 34 s | 2345 |
| *E. coli* 60x | Original | 279 | 12.2788 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 219 | 0.7404 | 99.4781 | 99.2658 | \_ | \_ | \_ | \_ | 24 min | 3674 |
| Daccord | **261** | **0.0214** | **99.9971** | **99.9790** | 3 min | 18,450 | 51 min | 1191 | 54 min | 18,450 |
| FLAS | 260 | 0.1547 | 99.9546 | 99.8526 | \_ | \_ | \_ | \_ | 38 min | 2428 |
| MECAT | 233 | 0.1714 | 99.9547 | 99.8362 | **1 min** | **2387** | **4 min** | **1553** | **5 min** | **2387** |
| CONSENT | 259 | 0.1833 | 99.9771 | 99.8196 | **1 min** | 4693 | 25 min | 1757 | 26 min | 4693 |
| *S. cerevisiae* 30x | Original | 371 | 12.283 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 226 | 1.1052 | 99.1766 | 98.9036 | \_ | \_ | \_ | \_ | 29 min | 3681 |
| Daccord | **348** | **0.1259** | **99.9874** | **99.8762** | 7 min | 31,798 | 1 h 12 min | 3487 | 1 h 19 min | 31,798 |
| FLAS | 344 | 0.3272 | 99.9131 | 99.6843 | \_ | \_ | \_ | \_ | 29 min | 2935 |
| MECAT | 285 | 0.3040 | 99.9160 | 99.7072 | **1 min** | **2907** | **4 min** | 1612 | **5 min** | **2907** |
| CONSENT | 344 | 0.4102 | 99.9192 | 99.5956 | **1 min** | 5519 | 21 min | **1503** | 22 min | 5519 |
| *S. cerevisiae* 60x | Original | 742 | 12.2886 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 599 | 0.7919 | 99.4488 | 99.2148 | \_ | \_ | \_ | \_ | 1 h 11 min | **3710** |
| Daccord | **695** | **0.0400** | **99.9928** | **99.9606** | 10 min | 32,190 | 2 h 16 min | 1160 | 2 h 26 min | 32,190 |
| FLAS | 689 | 0.2034 | 99.9418 | 99.8049 | \_ | \_ | \_ | \_ | 1 h 30 min | 4984 |
| MECAT | 616 | 0.2088 | 99.9428 | 99.7996 | 4 min | **4954** | **12 min** | **2412** | **16 min** | 4954 |
| CONSENT | 688 | 0.2897 | 99.9532 | 99.7145 | **2 min** | 11,378 | 1 h 11 min | 4754 | 1 h 13 min | 11,378 |
| *C. elegans* 30x | Original | 3006 | 12.2806 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 2773 | 0.5008 | 99.7103 | 99.5040 | \_ | \_ | \_ | \_ | 9 h 09 min | **6921** |
| Daccord | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ |
| FLAS | 2729 | 0.7613 | 99.8613 | 99.2541 | \_ | \_ | \_ | \_ | 3 h 07 min | 10,565 |
| MECAT | 2084 | **0.3908** | **99.8903** | **99.6212** | 27 min | **10,535** | **21 min** | **2603** | **48 min** | 10,535 |
| CONSENT | **2789** | 0.6495 | 99.8846 | 99.3596 | **16 min** | 16,711 | 3 h 40 min | 5338 | 3 h 56 min | 16,711 |
| *C. elegans 60x* | Original | 6024 | 12.2825 | \_ | \_ | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 5112 | 0.7934 | 99.4573 | 99.2131 | \_ | \_ | \_ | \_ | 9 h 30 min | **7050** |
| Daccord | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ |
| FLAS | 5584 | 0.3997 | 99.9175 | 99.6104 | \_ | \_ | \_ | \_ | 10 h 45 min | 13,682 |
| MECAT | 4938 | **0.2675** | **99.9258** | **99.7415** | 1 h 28 min | **10,563** | **1 h 15 min** | **3775** | **2 h 43 min** | 10,563 |
| CONSENT | **5587** | 0.3858 | 99.9428 | 99.6201 | **56 min** | 15,732 | 12 h 50 min | 7921 | 13 h 46 min | 15,732 |

1. Daccord results are missing for the two *C. elegans* datasets, as DALIGNER failed to perform alignment, reporting an error upon start, even when ran on a cluster node with 28 2.4 GHz cores and 128 GB of RAM. Recall and precision are not reported for original reads, since they cannot be computed from uncorrected reads.
2. Best results for each metric is highlighted in bold.

[Back to article page](/articles/s41598-020-80757-5#Tab1)

## Explore content

* [Research articles](/srep/research-articles)
* [News & Comment](/srep/news-and-comment)
* [Collections](/srep/collections)
* [Subjects](/srep/browse-subjects)

* [Follow us on Facebook](https://www.facebook.com/scientificreports)
* [Follow us on X](https://twitter.com/SciReports)
* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41598)
* [RSS feed](https://www.nature.com/srep.rss)

## About the journal

* [About Scientific Reports](/srep/about)
* [Contact](/srep/contact)
* [Journal policies](/srep/journal-policies)
* [Guide to referees](/srep/guide-to-referees)
* [Calls for Papers](/srep/calls-for-papers)
* [Editor's Choice](/srep/editorschoice)
* [Journal highlights](/srep/highlights)
* [Open Access Fees and Funding](/srep/open-access)

## Publish with us

* [For authors](/srep/author-instructions)
* [Language editing services](https://authorservices.springernature.com/go/sn/?utm_source=For+Authors&utm_medium=Website_Nature&utm_campaign=Platform+Experimentation+2022&utm_id=PE2022)
* [Open access funding](/srep/open-access-funding)
* [Submit manuscript](https://author-welcome.nature.com/41598)

## Search

Search articles by subject, keyword or author

Show results from

All journals
This journal

Search

[Advanced search](/search/advanced)

### Quick links

* [Explore articles by subject](/subjects)
* [Find a job](/naturecareers)
* [Guide to authors](/authors/index.html)
* [Editorial policies](/authors/editorial_policies/)

Scientific Reports
(*Sci Rep*)

ISSN 2045-2322 (online)

## nature.com footer links

### About Nature Portfolio

* [About us](https://www.nature.com/npg_/company_info/index.html)
* [Press releases](https://www.nature.com/npg_/press_room/press_releases.html)
* [Press office](https://press.nature.com/)
* [Contact us](https://support.nature.com/support/home)

### Discover content

* [Journals A-Z](https://www.nature.com/siteindex)
* [Articles by subject](https://www.nature.com/subjects)
* [protocols.io](https://www.protocols.io/)
* [Nature Index](https://www.natureindex.com/)

### Publishing policies

* [Nature portfolio policies](https://www.nature.com/authors/editorial_policies)
* [Open access](https://www.nature.com/nature-research/open-access)

### Author & Researcher services

* [Reprints & permissions](https://www.nature.com/reprints)
* [Research data](https://www.springernature.com/gp/authors/research-data)
* [Language editing](https://authorservices.springernature.com/language-editing/)
* [Scientific editing](https://authorservices.springernature.com/scientific-editing/)
* [Nature Masterclasses](https://masterclasses.nature.com/)
* [Research Solutions](https://solutions.springernature.com/)

### Libraries & institutions

* [Librarian service & tools](https://www.springernature.com/gp/librarians/tools-services)
* [Librarian portal](https://www.springernature.com/gp/librarians/manage-your-account/librarianportal)
* [Open research](https://www.nature.com/openresearch/about-open-access/information-for-institutions)
* [Recommend to library](https://www.springernature.com/gp/librarians/recommend-to-your-library)

### Advertising & partnerships

* [Advertising](https://partnerships.nature.com/product/digital-advertising/)
* [Partnerships & Services](https://partnerships.nature.com/)
* [Media kits](https://partnerships.nature.com/media-kits/)
* [Branded
  content](https://partnerships.nature.com/product/branded-content-native-advertising/)

### Professional development

* [Nature Awards](https://www.nature.com/immersive/natureawards/index.html)
* [Nature Careers](https://www.nature.com/naturecareers/)
* [Nature
  Conferences](https://conferences.nature.com)

### Regional websites

* [Nature Africa](https://www.nature.com/natafrica)
* [Nature China](http://www.naturechina.com)
* [Nature India](https://www.nature.com/nindia)
* [Nature Japan](https://www.natureasia.com/ja-jp)
* [Nature Middle East](https://www.nature.com/nmiddleeast)

* [Privacy
  Policy](https://www.nature.com/info/privacy)
* [Use
  of cookies](https://www.nature.com/info/cookies)
* Your privacy choices/Manage cookies
* [Legal
  notice](https://www.nature.com/info/legal-notice)
* [Accessibility
  statement](https://www.nature.com/info/accessibility-statement)
* [Terms & Conditions](https://www.nature.com/info/terms-and-conditions)
* [Your US state privacy rights](https://www.springernature.com/ccpa)

[![Springer Nature](/static/images/logos/sn-logo-white-c8f7a9c061.svg)](https://www.springernature.com/)

© 2026 Springer Nature Limited

![](https://verify.nature.com/verify/nature.png)