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
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41598-020-80757-5/tables/2)

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

# Table 2 Statistics of the real long reads, before and after correction with the different methods.

From: [Scalable long read self-correction and assembly polishing with multiple sequence alignment](/articles/s41598-020-80757-5)

| Dataset | Corrector | Number of reads | Number of bases (Mbp) | N50 (bp) | Aligned reads (%) | Alignment identity (%) | Genome coverage (%) | Overlapping | | Correction | | Total | |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Runtime | Memory (MB) | Runtime | Memory (MB) | Runtime | Memory (MB) |
| *S. cerevisiae* | Original | 121,640 | 1083 | 12,048 | 96.27 | 84.63 | 99.65 | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 74,658 | 644 | 11,171 | 99.67 | 96.67 | 99.18 | \_ | \_ | \_ | \_ | 1 h 24 min | 3870 |
| Daccord\(^2\) | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ |
| FLAS | 80,087 | 665 | 10,815 | 99.78 | 97.65 | 99.16 | \_ | \_ | \_ | \_ | 1 h 02 min | 6195 |
| MECAT | 46,614 | 477 | 11,123 | **99.84** | **97.91** | 98.21 | **2 min** | **7176** | **4 min** | **3023** | **6 min** | **7176** |
| CONSENT | **116,391** | **965** | **11,331** | 99.60 | 95.47 | **99.52** | 4 min | 19,828 | 1 h 13 min | 3108 | 1 h 17 min | 19,828 |
| *D. melanogaster* | Original | 1,327,569 | 9064 | 11,853 | 85.52 | 85.43 | 98.47 | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 829,965 | 6993 | **12,694** | 98.05 | 95.20 | 97.89 | \_ | \_ | \_ | \_ | 14 h 04 min | **10,295** |
| Daccord\(^2\) | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ |
| FLAS | 855,275 | 7866 | 11,742 | 95.65 | 94.99 | 98.09 | \_ | \_ | \_ | \_ | 10 h 18 min | 18,820 |
| MECAT | 827,490 | 7288 | 11,676 | **99.87** | 96.52 | 97.34 | **28 min** | **13,443** | **1 h 26 min** | 7724 | **1 h 54 min** | 13,443 |
| CONSENT | **1,096,046** | **8308** | 12,181 | 98.66 | **97.17** | **98.20** | 1 h 07 min | 31,282 | 8 h 53 min | **5639** | 10 h 00 min | 31,282 |
| *H. sapiens* (chr 1) | Original | 1,075,867 | 7256 | 10,568 | 88.24 | 82.40 | 92.46 | N/A | N/A | N/A | N/A | N/A | N/A |
| Canu | 717,436 | 5605 | **11,002** | 97.60 | 90.40 | 92.33 | \_ | \_ | \_ | \_ | 22 h 06 min | 12,802 |
| Daccord\(^{1,2}\) | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ | \_ |
| FLAS\(^1\) | 670,708 | 5695 | 10,198 | 99.06 | 91.00 | 92.37 | \_ | \_ | \_ | \_ | 4 h 57 min | 14,957 |
| MECAT\(^1\) | 655,314 | 5479 | 10,343 | **99.95** | 91.69 | 91.44 | 26 min | **11,075** | **1 h 27 min** | **4591** | **1 h 53 min** | **11,075** |
| CONSENT | **893,738** | **6502** | 10,870 | 98.89 | **93.15** | **92.38** | **23 min** | 17,290 | 2 h 47 min | 4645 | 3 h 10 min | 17,290 |

1. Best results for each metric is highlighted in bold.
2. \(^1\)Reads longer than 50 kbp were filtered out, as ultra-long reads caused the programs to stop with an error. There were 1824 such reads in the original dataset, accounting for a total number of 135,364,312 bp.
3. \(^2\)Daccord could not be run on these two datasets, due to errors reported by DALIGNER.

[Back to article page](/articles/s41598-020-80757-5#Tab2)

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