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
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41598-020-80757-5/tables/4)

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

# Table 4 Statistics of the assemblies, before and after polishing with RACON and CONSENT.

From: [Scalable long read self-correction and assembly polishing with multiple sequence alignment](/articles/s41598-020-80757-5)

| Dataset | Method | Contigs | Aligned contigs (%) | NGA50 (bp) | NGA75 (bp) | Genome coverage (%) | Errors / 100 kbp | Misassemblies | Runtime | Memory (MB) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| *E. coli 60x* | Original | **1** | **100.00** | **4,939,014** | **4,939,014** | **99.91** | 10,721 | **0** | N/A | N/A |
| RACON | **1** | **100.00** | 4,663,914 | 4,663,914 | 99.90 | 499 | **0** | 5 min 55 sec | **643** |
| CONSENT | **1** | **100.00** | 4,638,842 | 4,638,842 | **99.91** | **117** | **0** | **30 sec** | 786 |
| *S. cerevisiae 60x* | Original | **29** | **100.00** | **579,247** | **456,470** | **96.14** | 10,694 | **5** | N/A | N/A |
| RACON | **29** | **100.00** | 539,472 | 346,116 | 96.09 | 637 | **5** | 15 min 47 sec | 1703 |
| CONSENT | **29** | **100.00** | 532,189 | 332,977 | 96.05 | **217** | 7 | **1 min 49 sec** | **1052** |
| *C. elegans 60x* | Original | **47** | **100.00** | 5,201,998 | 2,511,520 | **99.78** | 10,974 | 5 | N/A | N/A |
| RACON | **47** | 97.87 | **6,405,523** | **2,726,529** | 99.74 | 819 | **2** | 2 h 24 min | 14,288 |
| CONSENT | **47** | **100.00** | 6,340,451 | 2,699,930 | 99.73 | **375** | 3 | **11 min** | **3648** |
| *S. cerevisiae* real | Original | **29** | 93.10 | 408,751 | 179,653 | 84.67 | 10,514 | **45** | N/A | N/A |
| RACON | **29** | **100.00** | 518,943 | 330,455 | 93.74 | **1193** | 52 | 1 h 17 min | 3708 |
| CONSENT | **29** | **100.00** | **522,799** | **411,537** | **94.23** | 1400 | **50** | **2 min** | **1667** |
| *D. melanogaster* | Original | **423** | 96.45 | 864,011 | 159,590 | 83.20 | 10,690 | **810** | N/A | N/A |
| RACON | 422 | 98.34 | **1,446,703** | **552,532** | **93.03** | **961** | 1013 | 3 h 29 min | 19,508 |
| CONSENT | 422 | **98.82** | 1,235,999 | 465,133 | 92.00 | 2213 | 1024 | **1 h 14 min** | **5358** |
| *H. sapiens* (chr 1) | Original\(^1\) | **201** | 93.53 | 1,008,692 | \_ | 77.52 | 11,318 | 98 | N/A | N/A |
| RACON | **201** | 97.01 | **3,481,900** | **1,282,763** | **95.69** | **2393** | **57** | 2 h 30 min | 16,202 |
| CONSENT | **201** | **97.51** | 3,295,244 | 924,899 | 94.16 | 4727 | 65 | **31 min** | **5399** |

1. The missing contig for the CONSENT and RACON polishings on the *D. melanogaster* dataset is 428 bp long, and could not be polished, due to the window size of the two methods being larger (500).
2. Best results for each metric is highlighted in bold.
3. \(^1\)For the assembly of the original reads on the *H. sapiens* (chr 1) dataset, QUAST-LG did not provide a metric for the NGA75.

[Back to article page](/articles/s41598-020-80757-5#Tab4)

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