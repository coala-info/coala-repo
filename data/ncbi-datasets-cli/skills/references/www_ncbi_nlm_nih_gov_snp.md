**Warning:**
The NCBI web site requires JavaScript to function.
[more...](/guide/browsers/#enablejs "Learn how to enable JavaScript")

![U.S. flag](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/favicons/favicon-57.png)

An official website of the United States government

Here's how you know

![Dot gov](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-dot-gov.svg)

**The .gov means it's official.**

Federal government websites often end in .gov or .mil. Before
sharing sensitive information, make sure you're on a federal
government site.

![Https](https://www.ncbi.nlm.nih.gov/coreutils/uswds/img/icon-https.svg)

**The site is secure.**

The **https://** ensures that you are connecting to the
official website and that any information you provide is encrypted
and transmitted securely.

[![NIH NLM Logo](https://www.ncbi.nlm.nih.gov/coreutils/nwds/img/logos/AgencyLogo.svg)](/)

[Log in](https://account.ncbi.nlm.nih.gov)

Show account info

Close

#### Account

Logged in as:
**username**

* [Dashboard](/myncbi/)
* [Publications](/myncbi/collections/bibliography/)
* [Account settings](/account/settings/)
* [Log out](/account/signout/)

[Access keys](https://www.ncbi.nlm.nih.gov/guide/browsers/#ncbi_accesskeys)
[NCBI Homepage](https://www.ncbi.nlm.nih.gov)
[MyNCBI Homepage](/myncbi/)
[Main Content](#maincontent)
Main Navigation

# [dbSNP](/snp)

Database of short genetic variations

Search databaseAll DatabasesAll DatabasesAssemblyBiocollectionsBioProjectBioSampleBooksClinVarConserved DomainsdbGaPdbVarGeneGenomeGEO DataSetsGEO ProfilesGTRIdentical Protein GroupsMedGenMeSHNLM CatalogNucleotideOMIMPMCProteinProtein ClustersProtein Family ModelsPubChem BioAssayPubChem CompoundPubChem SubstancePubMedSNPSRAStructureTaxonomyToolKitToolKitAllToolKitBookgh

Search termSearch

* [Advanced](/snp/advanced)
* [Help](/snp/docs/entrez_help/)

# dbSNP

dbSNP contains human single nucleotide variations, microsatellites, and small-scale insertions and deletions along with publication, population frequency, molecular consequence, and genomic and RefSeq mapping information for both common variations and clinical mutations.

## Getting Started

* [dbSNP 25th Anniversary](https://pubmed.ncbi.nlm.nih.gov/39530225/)
* [Overview of dbSNP](/snp/docs/about)
* [About Reference SNP (rs)](/snp/docs/RefSNP_about)
* [Factsheet](https://ftp.ncbi.nlm.nih.gov/pub/factsheets/Factsheet_SNP.pdf)
* [FAQ](/snp/docs/faq)
* [Entrez Updates (May 26, 2020)](/snp/docs/entrez/refsnp_change/)

## Submission

* [How to Submit](/snp/docs/submission/hts_launch_and_introductory_material)
* [Hold Until Published (HUP) Policies](/snp/docs/submission/hts_sending.data_accessioning_turnaround_Processing.Status/#hup)
* [Submission Search](/snp/docs/submission_info/)

## Access Data

* [Web Search](/snp/docs/entrez_help/)
* [eUtils API](/snp/docs/eutils_help/)
* [Variation Services](/variation/services/)
* [FTP Download](https://ftp.ncbi.nih.gov/snp/)
* [Tutorials on GitHub](https://github.com/ncbi/dbsnp/tree/master/tutorials)

**Important:** When using dbSNP, please cite the resource using the following publication:
[The evolution of dbSNP: 25 years of impact in genomic research](https://pubmed.ncbi.nlm.nih.gov/39530225/).

**## ALFA Project Release 4 with over 900M variants from 400K subjects is now [available](/snp/docs/gsr/alfa/ALFA_20250407153717) (May 15, 2025)**

### The goal is to provide allele frequency from more than 1 million dbGaP subjects with regular updates. Visit the project [page](/snp/docs/gsr/alfa/) for more information or view the introduction video below.

## How to Search dbSNP. Additional search terms are [here](./docs/entrez_help/).

|  |  |
| --- | --- |
| All of dbSNP (then use filters on results page) | [all[sb]](./?term=all%5Bsb%5D) |
| dbSNP RefSNP ID | Single: [328](./?term=328); Multiple [328,226,200](./?term=328%2C226%2C200) |
| Gene | Gene symbol [PTEN[Gene Name]](./?term=PTEN[Gene%20Name]) or gene ID [4023[Gene\_ID]](./?term=4023%5BGene_ID%5D) |
| Genomic location of a single position or range on GRCh38. See the [announcement](./docs/entrez/refsnp_change/#update02202020) and the [guide](./docs/entrez_help/) for using GRCh37 coordinates | [6[Chromosome] AND (1500000:3000000[Base Position] )](./?term=6%5BChromosome%5D+AND+1500000%3A3000000%5BBase+Position%5D) |
| Clinical significance | ["pathogenic"[Clinical Significance]) OR "likely pathogenic"[Clinical Significance]](./?term="pathogenic"%5BClinical+Significance%5D)+OR+"likely+pathogenic"%5BClinical+Significance%5D) |
| Global or study-wide minor allele frequency (GMAF) of a single frequency or range (Note the required zero padding frequency as shown in example for 0.001 and 0.01) | [00000.0010:00000.0100[GLOBAL\_MAF]](./?term=00000.0010%3A+00000.0100%5BGLOBAL_MAF%5D) |

## dbSNP News and Announcements

* [NCBI Insights](https://ncbiinsights.ncbi.nlm.nih.gov/tag/dbsnp/ "dbSNP news and blogs")
* [RSS Feed](/feed/rss.cgi?ChanKey=dbsnpnews)
  ![dbSNP News and Announcements(RSS) Feed](//dev-static.pubmed.gov/portal/portal3rc.fcgi/3251150/img/29146 "RSS feeds")
* [Email List](/mailman/listinfo/dbsnp-announce)

## YouTube

* [NCBI Minute: ALFA Webinar](https://youtu.be/wii-V39YxGk "NCBI Minute: ALFA Webinar ")
* [Accessing Population Allele Frequency](https://www.youtube.com/watch?v=5CzjOI3-qOU "NCBI Minute: Human Population Genetic Data at NCBI")
* [SPDI and Variation Service](https://www.youtube.com/watch?v=gpSI16e59ig "NCBI Minute: New Variation Services for Normalizing, Remapping, and Annotating Variants")
* [Variation Viewer](https://www.youtube.com/watch?v=EAXEg-QS6KQ "Webinar: The NCBI Variation Viewer")

## Variation Databases

* [dbVar](/dbvar)
* [dbGaP](/gap)
* [ClinVar](/clinvar)
* [GTR](https://www.ncbi.nlm.nih.gov/gtr/)

![](/stat?jsdisabled=true&ncbi_app=entrez&ncbi_db=snp&ncbi_pdid=home&ncbi_phid=CE8DC1BF9FBDDEF10000000001130103)

Follow NCBI

[Twitter](https://twitter.com/ncbi)
[Facebook](https://www.facebook.com/ncbi.nlm)
[LinkedIn](https://www.linkedin.com/company/ncbinlm)
[GitHub](https://github.com/ncbi)
[NCBI Insights Blog](https://ncbiinsights.ncbi.nlm.nih.gov/)

[Connect with NLM](https://www.nlm.nih.gov/socialmedia/index.html)

* [Twitter](https://twitter.com/NLM_NIH)
* [Facebook](https://www.facebook.com/nationallibraryofmedicine)
* [Youtube](https://www.youtube.com/user/NLMNIH)

National Library of Medicine
[8600 Rockville Pike
Bethesda, MD 20894](https://www.google.com/maps/place/8600%2BRockville%2BPike%2C%2BBethesda%2C%2BMD%2B20894/%4038.9959508%2C-77.101021%2C17z/data%3D%213m1%214b1%214m5%213m4%211s0x89b7c95e25765ddb%3A0x19156f88b27635b8%218m2%213d38.9959508%214d-77.0988323)

[Web Policies](https://www.nlm.nih.gov/web_policies.html)
[FOIA](https://www.nih.gov/institutes-nih/nih-office-director/office-communications-public-liaison/freedom-information-act-office)
[HHS Vulnerability Disclosure](https://www.hhs.gov/vulnerability-disclosure-policy/index.html)

[Help](https://support.nlm.nih.gov/)
[Accessibility](https://www.nlm.nih.gov/accessibility.html)
[Careers](https://www.nlm.nih.gov/careers/careers.html)

* [NLM](//www.nlm.nih.gov/)
* [NIH](https://www.nih.gov/)
* [HHS](https://www.hhs.gov/)
* [USA.gov](https://www.usa.gov/)