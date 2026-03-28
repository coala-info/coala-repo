[Skip to main content](#main-content)

[![bioRxiv](https://www.biorxiv.org/sites/default/files/biorxiv_article_logo.jpg)](/)

* [Home](/)
* [About](/about-biorxiv)
* [Submit](/submit-a-manuscript)
* [ALERTS / RSS](/alertsrss)

Search for this keyword

[Advanced Search](/search)

New Results

# bronko: ultrafast, alignment-free detection of viral genome variation

[View ORCID Profile](http://orcid.org/0009-0001-8355-0926)Ryan D. Doughty,  [View ORCID Profile](http://orcid.org/0000-0003-1168-1617)Michael J. Tisza,  [View ORCID Profile](http://orcid.org/0000-0002-3760-564X)Todd J. Treangen

doi: https://doi.org/10.64898/2025.12.01.691650

Ryan D. Doughty

1Department of Computer Science, Rice University, Houston TX 77005, USA

* [Find this author on Google Scholar](/lookup/google-scholar?link_type=googlescholar&gs_type=author&author%5B0%5D=Ryan%2BD.%2BDoughty%2B "Open in new tab")
* [Find this author on PubMed](/lookup/external-ref?access_num=Doughty%20RD&link_type=AUTHORSEARCH "Open in new tab")
* [Search for this author on this site](/search/author1%3ARyan%2BD.%2BDoughty%2B)
* [ORCID record for Ryan D. Doughty](http://orcid.org/0009-0001-8355-0926 "Open in new tab")

Michael J. Tisza

2Department of Molecular Virology and Microbiology, Baylor College of Medicine, Houston TX 77030, USA

* [Find this author on Google Scholar](/lookup/google-scholar?link_type=googlescholar&gs_type=author&author%5B0%5D=Michael%2BJ.%2BTisza%2B "Open in new tab")
* [Find this author on PubMed](/lookup/external-ref?access_num=Tisza%20MJ&link_type=AUTHORSEARCH "Open in new tab")
* [Search for this author on this site](/search/author1%3AMichael%2BJ.%2BTisza%2B)
* [ORCID record for Michael J. Tisza](http://orcid.org/0000-0003-1168-1617 "Open in new tab")

Todd J. Treangen

1Department of Computer Science, Rice University, Houston TX 77005, USA

3Department of Bioengineering, Rice University, Houston TX 77005

4Ken Kennedy Institute, Rice University, Houston TX 77005, USA

* [Find this author on Google Scholar](/lookup/google-scholar?link_type=googlescholar&gs_type=author&author%5B0%5D=Todd%2BJ.%2BTreangen%2B "Open in new tab")
* [Find this author on PubMed](/lookup/external-ref?access_num=Treangen%20TJ&link_type=AUTHORSEARCH "Open in new tab")
* [Search for this author on this site](/search/author1%3ATodd%2BJ.%2BTreangen%2B)
* [ORCID record for Todd J. Treangen](http://orcid.org/0000-0002-3760-564X "Open in new tab")
* For correspondence:
  [treangen{at}gmail.com](/cdn-cgi/l/email-protection#90e4e2f5f1fef7f5feebf1e4edf7fdf1f9fcbef3fffd)

* [Abstract](/content/10.64898/2025.12.01.691650v2)
* [Full Text](/content/10.64898/2025.12.01.691650v2.full-text)
* [Info/History](/content/10.64898/2025.12.01.691650v2.article-info)
* [Metrics](/content/10.64898/2025.12.01.691650v2.article-metrics)
* [Supplementary material](/content/10.64898/2025.12.01.691650v2.supplementary-material)
* [Preview PDF](/content/10.64898/2025.12.01.691650v2.full.pdf%2Bhtml)

![Loading](https://www.biorxiv.org/sites/all/modules/contrib/panels_ajax_tab/images/loading.gif "Loading")

## Abstract

As viral sequencing datasets continue to grow, traditional alignment-based variant calling pipelines are becoming computationally prohibitive. To address these challenges, we developed *bronko*, an ultrafast alignment-free framework for detecting viral variation directly from sequencing data. The novel computational approach implemented in *bronko* allows scaling to massive viral sequencing datasets and has three key components: i) a locality-sensitive bucketing function to rapidly identify single-nucleotide polymorphisms (SNPs) relative to reference(s), ii) a direct k-mer count pseudo-mapping approach that approximates a pileup without alignment, and iii) a streaming-based sliding window outlier test to estimate baseline noise across the genome and precisely differentiate real minor variants from noise. Together, these components yield near-linear computational complexity with respect to sequencing depth, enabling *bronko* to process thousands of viral samples rapidly on modest hardware. Our results are threefold: 1) On simulated amplicon sequencing, *bronko* recovers variants with higher precision and comparable recall to existing tools while running up to one to three orders of magnitude faster; 2) *bronko* generates sequence alignments directly from sequencing data, with SNP content similar to that of whole-genome alignment while also running in a fraction of the time, and 3) applying *bronko* to longitudinal sequencing data from chronically infected SARS-CoV-2 patients revealed consistent patterns of intrahost diversification and adaptive mutations over time. Altogether, these results demonstrate *bronko*’s potential as a scalable tool for large-scale viral genomic analyses, overcoming longstanding computational barriers for intrahost and interhost characterization of viral variation.

**Availability** *bronko* is implemented in Rust and publicly available at <https://github.com/treangenlab/bronko> or via conda at <https://anaconda.org/channels/bioconda/packages/bronko/overview>. All results, evaluations, and other code used in this study are available at <https://github.com/treangenlab/bronko-test>.

### Competing Interest Statement

The authors have declared no competing interest.

## Footnotes

* Supplementary updated with new benchmarking results, data descriptions; minor updates to text in both results and discussion; added new funding source and acknowledgements

## Funder Information Declared

NIH Common Fund, https://ror.org/001d55x84, 1U54AG089335-01, P01-AI152999

U.S. National Science Foundation, https://ror.org/021nxhr62, IIS-2239114, EF-2126387

United States National Library of Medicine, https://ror.org/0060t0j89, T15LM007093

NIH NIAID, 1U19AI144297

Copyright

The copyright holder for this preprint is the author/funder, who has granted bioRxiv a license to display the preprint in perpetuity. It is made available under a [CC-BY-NC-ND 4.0 International license](http://creativecommons.org/licenses/by-nc-nd/4.0/).

[View the discussion thread.](http://biorxivstage.disqus.com/?url=https%3A%2F%2Fwww.biorxiv.org%2Fcontent%2F10.64898%2F2025.12.01.691650v2)

[Back to top](#page)

[Previous](/content/10.1101/2025.12.01.691188v2 "Environmental effects overtake selection to shape avian body size")[Next](/content/10.1101/2025.04.09.648012v2 "Plasticity and Language in the Anesthetized Human Hippocampus")

Posted February 24, 2026.

[Download PDF](/content/10.64898/2025.12.01.691650v2.full.pdf)

[Supplementary Material](/content/10.64898/2025.12.01.691650v2.supplementary-material)

[Email](/ "Email this Article")

Thank you for your interest in spreading the word about bioRxiv.

NOTE: Your email address is requested solely to identify you as the sender of this article.

Your Email \*

Your Name \*

Send To \*

Enter multiple addresses on separate lines or separate them with commas.

You are going to email the following
[bronko: ultrafast, alignment-free detection of viral genome variation](/content/10.64898/2025.12.01.691650v2)

Message Subject
(Your Name) has forwarded a page to you from bioRxiv

Message Body
(Your Name) thought you would like to see this page from the bioRxiv website.

Your Personal Message

CAPTCHA

This question is for testing whether or not you are a human visitor and to prevent automated spam submissions.

[Share](/)

bronko: ultrafast, alignment-free detection of viral genome variation

Ryan D. Doughty, Michael J. Tisza, Todd J. Treangen

bioRxiv 2025.12.01.691650; doi: https://doi.org/10.64898/2025.12.01.691650

Share This Article:

Copy

[![Twitter logo](https://www.biorxiv.org/sites/all/modules/highwire/highwire/images/twitter.png)](http://twitter.com/share?url=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&text=bronko%3A%20ultrafast%2C%20alignment-free%20detection%20of%20viral%20genome%20variation "Share this on Twitter") [![Facebook logo](https://www.biorxiv.org/sites/all/modules/highwire/highwire/images/fb-blue.png)](http://www.facebook.com/sharer.php?u=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&t=bronko%3A%20ultrafast%2C%20alignment-free%20detection%20of%20viral%20genome%20variation "Share on Facebook") [![LinkedIn logo](https://www.biorxiv.org/sites/all/modules/highwire/highwire/images/linkedin-32px.png)](http://www.linkedin.com/shareArticle?mini=true&url=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&title=bronko%3A%20ultrafast%2C%20alignment-free%20detection%20of%20viral%20genome%20variation&summary=&source=bioRxiv "Publish this post to LinkedIn") [![Mendeley logo](https://www.biorxiv.org/sites/all/modules/highwire/highwire/images/mendeley.png)](http://www.mendeley.com/import/?url=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&title=bronko%3A%20ultrafast%2C%20alignment-free%20detection%20of%20viral%20genome%20variation "Share on Mendeley")

[Citation Tools](/ "Citation Tools")

bronko: ultrafast, alignment-free detection of viral genome variation

Ryan D. Doughty, Michael J. Tisza, Todd J. Treangen

bioRxiv 2025.12.01.691650; doi: https://doi.org/10.64898/2025.12.01.691650

## Citation Manager Formats

* [BibTeX](/highwire/citation/5266735/bibtext)
* [Bookends](/highwire/citation/5266735/bookends)
* [EasyBib](/highwire/citation/5266735/easybib)
* [EndNote (tagged)](/highwire/citation/5266735/endnote-tagged)
* [EndNote 8 (xml)](/highwire/citation/5266735/endnote-8-xml)
* [Medlars](/highwire/citation/5266735/medlars)
* [Mendeley](/highwire/citation/5266735/mendeley)
* [Papers](/highwire/citation/5266735/papers)
* [RefWorks Tagged](/highwire/citation/5266735/refworks-tagged)
* [Ref Manager](/highwire/citation/5266735/reference-manager)
* [RIS](/highwire/citation/5266735/ris)
* [Zotero](/highwire/citation/5266735/zotero)

* [Tweet Widget](http://twitter.com/share?url=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&count=horizontal&via=&text=bronko%3A%20ultrafast%2C%20alignment-free%20detection%20of%20viral%20genome%20variation&counturl=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2 "Tweet This")
* [Facebook Like](http://www.facebook.com/plugins/like.php?href=https%3A//www.biorxiv.org/content/10.64898/2025.12.01.691650v2&layout=button_count&show_faces=false&action=like&colorscheme=light&width=100&height=21&font=&locale= "I Like it")
* [Google Plus One](https://www.biorxiv.org/content/10.64898/2025.12.01.691650v2 "Plus it")

## Subject Area

* [Bioinformatics](/collection/bioinformatics)

**Subject Areas**

[**All Articles**](/content/early/recent)

* [Animal Behavior and Cognition](/collection/animal-behavior-and-cognition) (7464)
* [Biochemistry](/collection/biochemistry) (17144)
* [Bioengineering](/collection/bioengineering) (13404)
* [Bioinformatics](/collection/bioinformatics) (40693)
* [Biophysics](/collection/biophysics) (20892)
* [Cancer Biology](/collection/cancer-biology) (18009)
* [Cell Biology](/collection/cell-biology) (24804)
* [Clinical Trials](/collection/clinical-trials) (138)
* [Developmental Biology](/collection/developmental-biology) (13082)
* [Ecology](/collection/ecology) (19413)
* [Epidemiology](/collection/epidemiology) (2067)
* [Evolutionary Biology](/collection/evolutionary-biology) (23825)
* [Genetics](/collection/genetics) (15337)
* [Genomics](/collection/genomics) (22016)
* [Immunology](/collection/immunology) (17267)
* [Microbiology](/collection/microbiology) (39359)
* [Molecular Biology](/collection/molecular-biology) (16701)
* [Neuroscience](/collection/neuroscience) (86309)
* [Paleontology](/collection/paleontology) (655)
* [Pathology](/collection/pathology) (2762)
* [Pharmacology and Toxicology](/collection/pharmacology-and-toxicology) (4678)
* [Physiology](/collection/physiology) (7427)
* [Plant Biology](/collection/plant-biology) (14722)
* [Scientific Communication and Education](/collection/scientific-communication-and-education) (2016)
* [Synthetic Biology](/collection/synthetic-biology) (4165)
* [Systems Biology](/collection/systems-biology) (9600)
* [Zoology](/collection/zoology) (2221)