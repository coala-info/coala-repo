[Skip to main content](#content)

Thank you for visiting nature.com. You are using a browser version with limited support for CSS. To obtain
the best experience, we recommend you use a more up to date browser (or turn off compatibility mode in
Internet Explorer). In the meantime, to ensure continued support, we are displaying the site without styles
and JavaScript.

Advertisement

[![Advertisement](//pubads.g.doubleclick.net/gampad/ad?iu=/285/nature_communications/article&sz=728x90&c=-540603900&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41467-024-49957-9%26doi%3D10.1038/s41467-024-49957-9%26subjmeta%3D114,2397,2521,255,326,631,692,699,794%26kwrd%3DComputational+models,Infectious-disease+diagnostics,Infectious+diseases,Software)](//pubads.g.doubleclick.net/gampad/jump?iu=/285/nature_communications/article&sz=728x90&c=-540603900&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41467-024-49957-9%26doi%3D10.1038/s41467-024-49957-9%26subjmeta%3D114,2397,2521,255,326,631,692,699,794%26kwrd%3DComputational+models,Infectious-disease+diagnostics,Infectious+diseases,Software)

[![Nature Communications](https://media.springernature.com/full/nature-cms/uploads/product/ncomms/header-7001f06bc3fe2437048388e9f2f44215.svg)](/ncomms)

* [View all journals](https://www.nature.com/siteindex)
* [Search](#search-menu)
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41467-024-49957-9)

* [Content
  Explore content](#explore)
* [About the journal](#about-the-journal)
* [Publish with us](#publish-with-us)

* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41467)
* [RSS feed](https://www.nature.com/ncomms.rss)

1. [nature](/)
2. [nature communications](/ncomms)
3. [articles](/ncomms/articles?type=article)
4. article

Olivar: towards automated variant aware primer design for multiplex tiled amplicon sequencing of pathogens

[Download PDF](/articles/s41467-024-49957-9.pdf)

[Download PDF](/articles/s41467-024-49957-9.pdf)

* Article
* [Open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research)
* Published: 26 July 2024

# Olivar: towards automated variant aware primer design for multiplex tiled amplicon sequencing of pathogens

* [Michael X. Wang](#auth-Michael_X_-Wang-Aff1)
  [ORCID: orcid.org/0000-0001-7009-6958](https://orcid.org/0000-0001-7009-6958)[1](#Aff1),
* [Esther G. Lou](#auth-Esther_G_-Lou-Aff2)
  [ORCID: orcid.org/0000-0001-7230-6517](https://orcid.org/0000-0001-7230-6517)[2](#Aff2),
* [Nicolae Sapoval](#auth-Nicolae-Sapoval-Aff3)
  [ORCID: orcid.org/0000-0002-0736-5075](https://orcid.org/0000-0002-0736-5075)[3](#Aff3),
* [Eddie Kim](#auth-Eddie-Kim-Aff3)
  [ORCID: orcid.org/0000-0002-3770-6838](https://orcid.org/0000-0002-3770-6838)[3](#Aff3),
* [Prashant Kalvapalle](#auth-Prashant-Kalvapalle-Aff2)
  [ORCID: orcid.org/0000-0002-8255-3623](https://orcid.org/0000-0002-8255-3623)[2](#Aff2),
* [Bryce Kille](#auth-Bryce-Kille-Aff3)
  [ORCID: orcid.org/0000-0003-2946-6915](https://orcid.org/0000-0003-2946-6915)[3](#Aff3),
* [R. A. Leo Elworth](#auth-R__A__Leo-Elworth-Aff3)
  [ORCID: orcid.org/0000-0002-3945-0661](https://orcid.org/0000-0002-3945-0661)[3](#Aff3),
* [Yunxi Liu](#auth-Yunxi-Liu-Aff3)
  [ORCID: orcid.org/0000-0003-2657-1816](https://orcid.org/0000-0003-2657-1816)[3](#Aff3),
* [Yilei Fu](#auth-Yilei-Fu-Aff3)
  [ORCID: orcid.org/0000-0002-7721-7027](https://orcid.org/0000-0002-7721-7027)[3](#Aff3),
* [Lauren B. Stadler](#auth-Lauren_B_-Stadler-Aff2)
  [ORCID: orcid.org/0000-0001-7469-1981](https://orcid.org/0000-0001-7469-1981)[2](#Aff2) &
* …
* [Todd J. Treangen](#auth-Todd_J_-Treangen-Aff1-Aff3)
  [ORCID: orcid.org/0000-0002-3760-564X](https://orcid.org/0000-0002-3760-564X)[1](#Aff1),[3](#Aff3)

Show authors

[*Nature Communications*](/ncomms)
**volume 15**, Article number: 6306 (2024)
[Cite this article](#citeas)

* 7518 Accesses
* 10 Citations
* [Metrics details](/articles/s41467-024-49957-9/metrics)

### Subjects

* [Computational models](/subjects/computational-models)
* [Infectious-disease diagnostics](/subjects/infectious-disease-diagnostics)
* [Infectious diseases](/subjects/infectious-diseases)
* [Software](/subjects/software)

## Abstract

Tiled amplicon sequencing has served as an essential tool for tracking the spread and evolution of pathogens. Over 15 million complete SARS-CoV-2 genomes are now publicly available, most sequenced and assembled via tiled amplicon sequencing. While computational tools for tiled amplicon design exist, they require downstream manual optimization both computationally and experimentally, which is slow and costly. Here we present Olivar, a first step towards a fully automated, variant-aware design of tiled amplicons for pathogen genomes. Olivar converts each nucleotide of the target genome into a numeric risk score, capturing undesired sequence features that should be avoided. In a direct comparison with PrimalScheme, we show that Olivar has fewer mismatches overlapping with primers and predicted PCR byproducts. We also compare Olivar head-to-head with ARTIC v4.1, the most widely used primer set for SARS-CoV-2 sequencing, and show Olivar yields similar read mapping rates (~90%) and better coverage to the manually designed ARTIC v4.1 amplicons. We also evaluate Olivar on real wastewater samples and found that Olivar has up to 3-fold higher mapping rates while retaining similar coverage. In summary, Olivar automates and accelerates the generation of tiled amplicons, even in situations of high mutation frequency and/or density. Olivar is available online as a web application at <https://olivar.rice.edu> and can be installed locally as a command line tool with Bioconda. Source code, installation guide, and usage are available at <https://github.com/treangenlab/Olivar>.

### Similar content being viewed by others

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41598-022-06091-0/MediaObjects/41598_2022_6091_Fig1_HTML.png)

### [Development and validation of a high throughput SARS-CoV-2 whole genome sequencing workflow in a clinical laboratory](https://www.nature.com/articles/s41598-022-06091-0?fromPaywallRec=false)

Article
Open access
08 February 2022

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41598-023-42348-y/MediaObjects/41598_2023_42348_Fig1_HTML.png)

### [An Innovative AI-based primer design tool for precise and accurate detection of SARS-CoV-2 variants of concern](https://www.nature.com/articles/s41598-023-42348-y?fromPaywallRec=false)

Article
Open access
22 September 2023

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs43856-024-00582-z/MediaObjects/43856_2024_582_Fig1_HTML.png)

### [A micro-disc-based multiplex method for monitoring emerging SARS-CoV-2 variants using the molecular diagnostic tool Intelli-OVI](https://www.nature.com/articles/s43856-024-00582-z?fromPaywallRec=false)

Article
Open access
09 August 2024

## Introduction

The devastating COVID-19 pandemic has forever highlighted the utility and importance of biosurveillance for tracking the spread of emerging pathogens. Metagenomic sequencing of environmental samples has enabled the discovery of novel pathogens[1](/articles/s41467-024-49957-9#ref-CR1 "Chiu, C. Y. Viral pathogen discovery. Curr. Opin. Microbiol. 16, 468–478 (2013)."), provided real-time insights into the spread and evolution of infectious disease[2](/articles/s41467-024-49957-9#ref-CR2 "Metsky, H. C. et al. Zika virus evolution and spread in the Americas. Nature 546, 411–415 (2017)."), and enabled the exploration of variant-specific effects on the host[3](/articles/s41467-024-49957-9#ref-CR3 "Kousathanas, A. et al. Whole genome sequencing reveals host factors underlying critical Covid-19. Nature 607, 97–103 (2022)."). However, the relatively high cost and long turnaround time of metagenomic sequencing remain impractical when a large number of samples and fast turnaround times are necessary, which is the baseline for monitoring pathogens from the environment. Targeted approaches offer advantages in this setting as the ratio of the targeted pathogen is typically low compared to non-target background sequences[4](/articles/s41467-024-49957-9#ref-CR4 "Quick, J. et al. Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. Nat. Protoc. 12, 1261–1276 (2017)."),[5](/articles/s41467-024-49957-9#ref-CR5 "Metsky, H. C. et al. Capturing sequence diversity in metagenomes with comprehensive and scalable probe design. Nat. Biotechnol. 37, 160–168 (2019).") (e.g., monitoring of SARS-CoV-2 in wastewater[6](/articles/s41467-024-49957-9#ref-CR6 "Lou, E. G. et al. Direct comparison of RT-ddPCR and targeted amplicon sequencing for SARS-CoV-2 mutation monitoring in wastewater. Sci. Total Environ. 833, 155059 (2022).")), making untargeted metagenomic sequencing both more expensive, computationally intensive, and often lacking in sensitivity.

Thus, targeted amplification or enrichment can both decrease sequencing cost and improve the sequencing sensitivity for pathogen genomes of interest[4](/articles/s41467-024-49957-9#ref-CR4 "Quick, J. et al. Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. Nat. Protoc. 12, 1261–1276 (2017)."),[5](/articles/s41467-024-49957-9#ref-CR5 "Metsky, H. C. et al. Capturing sequence diversity in metagenomes with comprehensive and scalable probe design. Nat. Biotechnol. 37, 160–168 (2019)."). PCR tiling and DNA hybridization probes are two common approaches to amplify whole genomes of specific viruses[5](/articles/s41467-024-49957-9#ref-CR5 "Metsky, H. C. et al. Capturing sequence diversity in metagenomes with comprehensive and scalable probe design. Nat. Biotechnol. 37, 160–168 (2019)."),[7](/articles/s41467-024-49957-9#ref-CR7 "Samorodnitsky, E. et al. Evaluation of hybridization capture versus amplicon-based methods for whole-exome sequencing. Hum. Mutat. 36, 903–914 (2015)."). While DNA hybridization probes are better at preserving the relative abundance of different species, PCR tiling has the advantage of simpler experimental workflow, faster turnaround time, and less DNA input requirement[7](/articles/s41467-024-49957-9#ref-CR7 "Samorodnitsky, E. et al. Evaluation of hybridization capture versus amplicon-based methods for whole-exome sequencing. Hum. Mutat. 36, 903–914 (2015)."). Therefore, PCR tiling has been widely used to monitor SARS-CoV-2 and characterize SARS-CoV-2 variants[8](/articles/s41467-024-49957-9#ref-CR8 "Gohl, D. M. et al. A rapid, cost-effective tailed amplicon method for sequencing SARS-CoV-2. BMC Genomics 21, 1–10 (2020)."). As of December 27th, 2022, there are 14.4 million SARS-CoV-2 genomes on GISAID[9](/articles/s41467-024-49957-9#ref-CR9 "Khare, S. et al. GISAID’s role in pandemic response. China CDC Wkly. 3, 1049 (2021)."), and 6.5 million available in NCBI GenBank[10](/articles/s41467-024-49957-9#ref-CR10 "Wheeler, D. L. et al. Database resources of the national center for biotechnology information. Nucleic Acids Res. 36, D13–D21 (2007)."), the vast majority of which were sequenced and assembled via tiled amplicon sequencing. However, when combining hundreds of primers within a single tube, PCR tiling has similar pitfalls as multiplexed PCR, including (i) uneven amplification of different genomic regions and (ii) excessive PCR byproducts (e.g., primer dimers and amplification of non-targeted sequences), resulting in a higher cost to reach a minimum acceptable sequencing depth[11](/articles/s41467-024-49957-9#ref-CR11 "Xie, N. G. et al. Designing highly multiplex PCR primer sets with Simulated Annealing Design using Dimer Likelihood Estimation (SADDLE). Nat. Commun. 13, 1–10 (2022)."). PCR byproducts can also result in false variant calls[12](/articles/s41467-024-49957-9#ref-CR12 "Wilkinson, S. Erroneous Mutations Associated with 64_L-60_R Primer-Dimer in ARTIC 4/4.1 — community.artic.network.
                  https://community.artic.network/t/erroneous-mutations-associated-with-64-l-60-r-primer-dimer-in-artic-4-4-1/419/1

                 (2022). [Accessed 17-Jan-2023]."), requiring manual oversight, re-analysis and slow down the deployment which is critical in the midst of the pandemic. Moreover, PCR primers should be designed to avoid genomic regions with heavy variation[13](/articles/s41467-024-49957-9#ref-CR13 "Davis, J. J. et al. Analysis of the ARTIC version 3 and version 4 SARS-CoV-2 primers and their impact on the detection of the G142D amino acid substitution in the spike protein. Microbiol. Spectr. 9, e01803–21 (2021).") (e.g., single-nucleotide polymorphisms or SNPs) and secondary structures[11](/articles/s41467-024-49957-9#ref-CR11 "Xie, N. G. et al. Designing highly multiplex PCR primer sets with Simulated Annealing Design using Dimer Likelihood Estimation (SADDLE). Nat. Commun. 13, 1–10 (2022).") to prevent amplicon dropout. Altogether, these pitfalls can lead to higher sequencing cost, uneven coverage, and lower sensitivity, which to date requires one or more runs of experimental validation and manual primer redesign, making the development of a PCR tiling assay costly and labor intensive[14](/articles/s41467-024-49957-9#ref-CR14 "Itokawa, K., Sekizuka, T., Hashino, M., Tanaka, R. & Kuroda, M. Disentangling primer interactions improves SARS-CoV-2 genome sequencing by multiplex tiling PCR. PloS One 15, e0239403 (2020).").

Although there are existing tools for designing PCR tiling, some design tiled amplicons as single plex assays[15](/articles/s41467-024-49957-9#ref-CR15 "Gervais, A. L., Marques, M. & Gaudreau, L. PCRTiler: automated design of tiled and specific PCR primer pairs. Nucleic Acids Res. 38, W308–W312 (2010).") or a number of small primer pools (<10 primers)[16](/articles/s41467-024-49957-9#ref-CR16 "Wingo, T. S., Kotlar, A. & Cutler, D. J. MPD: multiplex primer design for next-generation targeted sequencing. BMC Bioinforma. 18, 1–5 (2017)."), instead of multiplexed assays where tens or hundreds of primers are mixed in the same reaction. Furthermore, previous approaches do not optimize all of the aforementioned criteria simultaneously, nor do they adequately explore the solution space of possible primer combinations[4](/articles/s41467-024-49957-9#ref-CR4 "Quick, J. et al. Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. Nat. Protoc. 12, 1261–1276 (2017)."). The current state of the art PCR tiling design software tool, PrimalScheme[4](/articles/s41467-024-49957-9#ref-CR4 "Quick, J. et al. Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. Nat. Protoc. 12, 1261–1276 (2017)."), takes a sequential approach to primer design. Specifically, starting from the le