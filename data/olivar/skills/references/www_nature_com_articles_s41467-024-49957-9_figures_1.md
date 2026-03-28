[Skip to main content](#content)

Thank you for visiting nature.com. You are using a browser version with limited support for CSS. To obtain
the best experience, we recommend you use a more up to date browser (or turn off compatibility mode in
Internet Explorer). In the meantime, to ensure continued support, we are displaying the site without styles
and JavaScript.

Advertisement

[![Advertisement](//pubads.g.doubleclick.net/gampad/ad?iu=/285/nature_communications/article&sz=728x90&c=-1289058785&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41467-024-49957-9%26doi%3D10.1038/s41467-024-49957-9%26subjmeta%3D114,2397,2521,255,326,631,692,699,794%26kwrd%3DComputational+models,Infectious-disease+diagnostics,Infectious+diseases,Software)](//pubads.g.doubleclick.net/gampad/jump?iu=/285/nature_communications/article&sz=728x90&c=-1289058785&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41467-024-49957-9%26doi%3D10.1038/s41467-024-49957-9%26subjmeta%3D114,2397,2521,255,326,631,692,699,794%26kwrd%3DComputational+models,Infectious-disease+diagnostics,Infectious+diseases,Software)

[![Nature Communications](https://media.springernature.com/full/nature-cms/uploads/product/ncomms/header-7001f06bc3fe2437048388e9f2f44215.svg)](/ncomms)

* [View all journals](https://www.nature.com/siteindex)
* [Search](#search-menu)
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41467-024-49957-9/figures/1)

* [Content
  Explore content](#explore)
* [About the journal](#about-the-journal)
* [Publish with us](#publish-with-us)

* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41467)
* [RSS feed](https://www.nature.com/ncomms.rss)

1. [nature](/)
2. [nature communications](/ncomms)
3. [articles](/ncomms/articles?type=article)
4. [article](/articles/s41467-024-49957-9)
5. figure

Fig. 1: Overall workflow of Olivar and example output. | Nature Communications

# Fig. 1: Overall workflow of Olivar and example output.

From: [Olivar: towards automated variant aware primer design for multiplex tiled amplicon sequencing of pathogens](/articles/s41467-024-49957-9)

![Fig. 1: Overall workflow of Olivar and example output.](//media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41467-024-49957-9/MediaObjects/41467_2024_49957_Fig1_HTML.png)

**a** The input of Olivar consists of three components: the targeted sequence, a BLAST database built with non-targeted sequences, and single nucleotide polymorphisms (SNPs) to be avoided by primers. Based on the provided inputs, a risk score is calculated for each nucleotide of the targeted sequence. Primer design regions are optimized according to the array of risk scores. One or more primer candidates are generated for each primer design region, and the primer set with minimum primer dimerization is selected with the previously published algorithm SADDLE. **b** A primer design region (PDR) is a short region (40nt by default) on the targeted genome. A pair of PDRs (blue or orange solid lines) covers the genomic region between them, and a valid set of PDRs should cover the whole targeted genome. Primer candidates (blue dashed lines) are generated from each PDR by SADDLE. PDRs are assigned into two pools (pool 1 in blue and pool 2 in orange) to avoid overlapping amplicons. **c** A risk array consists of four components: SNPs, extreme GC content, low sequence complexity and non-specificity, and all of them are calculated for each nucleotide of target and range between 0 and 1. The final risk is calculated as the weighted sum of the four risk components. **d** An example of the risk landscape of the SARS-CoV-2 genome, as well as primers designed by Olivar. The beginning of the S gene is shown, and each risk component is shown in a different color. Different risk components shown in the figure are stacked together instead of overlapping. Primers are assigned into two pools to avoid overlapping amplicons. Together the two pools cover the whole genome.

[Back to article page](/articles/s41467-024-49957-9#Fig1)

## Explore content

* [Research articles](/ncomms/research-articles)
* [Reviews & Analysis](/ncomms/reviews-and-analysis)
* [News & Comment](/ncomms/news-and-comment)
* [Videos](/ncomms/video)
* [Collections](/ncomms/collections)
* [Subjects](/ncomms/browse-subjects)

* [Follow us on Facebook](https://www.facebook.com/NatureCommunications)
* [Follow us on X](https://twitter.com/NatureComms)
* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41467)
* [RSS feed](https://www.nature.com/ncomms.rss)

## About the journal

* [Aims & Scope](/ncomms/aims)
* [Editors](/ncomms/editors)
* [Journal Information](/ncomms/journal-information)
* [Open Access Fees and Funding](/ncomms/open-access)
* [Calls for Papers](/ncomms/calls-for-papers)
* [Editorial Values Statement](/ncomms/editorial-values-statement)
* [Journal Metrics](/ncomms/journal-impact)
* [Editors' Highlights](/ncomms/editorshighlights)
* [Contact](/ncomms/contact)
* [Editorial policies](/ncomms/editorial-policies)
* [Top Articles](/ncomms/top-articles)

## Publish with us

* [For authors](/ncomms/submit)
* [For Reviewers](/ncomms/for-reviewers)
* [Language editing services](https://authorservices.springernature.com/go/sn/?utm_source=For+Authors&utm_medium=Website_Nature&utm_campaign=Platform+Experimentation+2022&utm_id=PE2022)
* [Open access funding](/ncomms/open-access-funding)
* [Submit manuscript](https://mts-ncomms.nature.com/)

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

Nature Communications
(*Nat Commun*)

ISSN 2041-1723 (online)

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