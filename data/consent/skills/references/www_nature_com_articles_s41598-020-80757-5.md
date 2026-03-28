[Skip to main content](#content)

Thank you for visiting nature.com. You are using a browser version with limited support for CSS. To obtain
the best experience, we recommend you use a more up to date browser (or turn off compatibility mode in
Internet Explorer). In the meantime, to ensure continued support, we are displaying the site without styles
and JavaScript.

Advertisement

[![Advertisement](//pubads.g.doubleclick.net/gampad/ad?iu=/285/scientific_reports/article&sz=728x90&c=-532206410&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41598-020-80757-5%26doi%3D10.1038/s41598-020-80757-5%26subjmeta%3D114,2785,631,794%26kwrd%3DComputational+biology+and+bioinformatics,Genome+informatics,Software)](//pubads.g.doubleclick.net/gampad/jump?iu=/285/scientific_reports/article&sz=728x90&c=-532206410&t=pos%3Dtop%26type%3Darticle%26artid%3Ds41598-020-80757-5%26doi%3D10.1038/s41598-020-80757-5%26subjmeta%3D114,2785,631,794%26kwrd%3DComputational+biology+and+bioinformatics,Genome+informatics,Software)

[![Scientific Reports](https://media.springernature.com/full/nature-cms/uploads/product/srep/header-d3c533c187c710c1bedbd8e293815d5f.svg)](/srep)

* [View all journals](https://www.nature.com/siteindex)
* [Search](#search-menu)
* [Log in](https://idp.nature.com/auth/personal/springernature?redirect_uri=https://www.nature.com/articles/s41598-020-80757-5)

* [Content
  Explore content](#explore)
* [About the journal](#about-the-journal)
* [Publish with us](#publish-with-us)

* [Sign up for alerts](https://journal-alerts.springernature.com/subscribe?journal_id=41598)
* [RSS feed](https://www.nature.com/srep.rss)

1. [nature](/)
2. [scientific reports](/srep)
3. [articles](/srep/articles?type=article)
4. article

Scalable long read self-correction and assembly polishing with multiple sequence alignment

[Download PDF](/articles/s41598-020-80757-5.pdf)

[Download PDF](/articles/s41598-020-80757-5.pdf)

* Article
* [Open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research)
* Published: 12 January 2021

# Scalable long read self-correction and assembly polishing with multiple sequence alignment

* [Pierre Morisse](#auth-Pierre-Morisse-Aff1)[1](#Aff1),
* [Camille Marchet](#auth-Camille-Marchet-Aff2)[2](#Aff2),
* [Antoine Limasset](#auth-Antoine-Limasset-Aff2)[2](#Aff2),
* [Thierry Lecroq](#auth-Thierry-Lecroq-Aff3)[3](#Aff3) &
* …
* [Arnaud Lefebvre](#auth-Arnaud-Lefebvre-Aff3)[3](#Aff3)

Show authors

[*Scientific Reports*](/srep)
**volume 11**, Article number: 761 (2021)
[Cite this article](#citeas)

* 10k Accesses
* 56 Citations
* 24 Altmetric
* [Metrics details](/articles/s41598-020-80757-5/metrics)

### Subjects

* [Computational biology and bioinformatics](/subjects/computational-biology-and-bioinformatics)
* [Genome informatics](/subjects/genome-informatics)
* [Software](/subjects/software)

## Abstract

Third-generation sequencing technologies allow to sequence long reads of tens of kbp, that are expected to solve various problems. However, they display high error rates, currently capped around 10%. Self-correction is thus regularly used in long reads analysis projects. We introduce CONSENT, a new self-correction method that relies both on multiple sequence alignment and local de Bruijn graphs. To ensure scalability, multiple sequence alignment computation benefits from a new and efficient segmentation strategy, allowing a massive speedup. CONSENT compares well to the state-of-the-art, and performs better on real Oxford Nanopore data. Specifically, CONSENT is the only method that efficiently scales to ultra-long reads, and allows to process a full human dataset, containing reads reaching up to 1.5 Mbp, in 10 days. Moreover, our experiments show that error correction with CONSENT improves the quality of Flye assemblies. Additionally, CONSENT implements a polishing feature, allowing to correct raw assemblies. Our experiments show that CONSENT is 2-38x times faster than other polishing tools, while providing comparable results. Furthermore, we show that, on a human dataset, assembling the raw data and polishing the assembly is less resource consuming than correcting and then assembling the reads, while providing better results. CONSENT is available at <https://github.com/morispi/CONSENT>.

### Similar content being viewed by others

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41598-025-01486-1/MediaObjects/41598_2025_1486_Fig1_HTML.png)

### [ConsensuSV-ONT – A modern method for accurate structural variant calling](https://www.nature.com/articles/s41598-025-01486-1?fromPaywallRec=false)

Article
Open access
17 May 2025

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41598-023-34257-x/MediaObjects/41598_2023_34257_Fig1_HTML.png)

### [Large scale sequence alignment via efficient inference in generative models](https://www.nature.com/articles/s41598-023-34257-x?fromPaywallRec=false)

Article
Open access
04 May 2023

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41592-022-01440-3/MediaObjects/41592_2022_1440_Fig1_HTML.png)

### [Chasing perfection: validation and polishing strategies for telomere-to-telomere genome assemblies](https://www.nature.com/articles/s41592-022-01440-3?fromPaywallRec=false)

Article
31 March 2022

## Introduction

Third-generation sequencing technologies Pacific Biosciences (PacBio) and Oxford Nanopore Technologies (ONT) have become widely used since their inception in 2011. In contrast to second-generation technologies, producing reads reaching lengths of a few hundreds base pairs, they allow the sequencing of much longer reads (10 kbp on average[1](/articles/s41598-020-80757-5#ref-CR1 "Sedlazeck, F. J., Lee, H., Darby, C. A. & Schatz, M. C. Piercing the dark matter: Bioinformatics of long-range sequencing and mapping. Nat. Rev. Genet. 39, 329–346 (2018)."), and up to \(>1\) million bps[2](/articles/s41598-020-80757-5#ref-CR2 "Jain, M. et al. Nanopore sequencing and assembly of a human genome with ultra-long reads. Nat. Biotechnol. 36, 338 (2018).")). These long reads are expected to solve various problems, such as contig and haplotype assembly[3](/articles/s41598-020-80757-5#ref-CR3 "Patterson, M. et al. Whatshap: Weighted haplotype assembly for future-generation sequencing reads. J. Comput. Biol. 22, 498–509 (2015)."),[4](/articles/s41598-020-80757-5#ref-CR4 "Kamath, G. M., Shomorony, I., Xia, F., Courtade, T. & David, N. T. Hinge: long-read assembly achieves optimal repeat resolution. Genome Res. 27, 747–756 (2017)."), scaffolding[5](/articles/s41598-020-80757-5#ref-CR5 "Cao, M. D. et al. Scaffolding and completing genome assemblies in real-time with nanopore sequencing. Nat. Commun. 8, 14515 (2017)."), and structural variant calling[6](/articles/s41598-020-80757-5#ref-CR6 "Sedlazeck, F. J. et al. Accurate detection of complex structural variations using single-molecule sequencing. Nat. Methods 15, 461–468 (2018)."). However, they are very noisy. More precisely, basic ONT and non-CCS PacBio reads can reach error rates of 10 to 30%, whereas second-generation short reads usually display error rates of 1%. The error profiles of these long reads are also much more complex than those of the short reads. Indeed, they are mainly composed of insertions and deletions, whereas short reads mostly contain substitutions. As a result, error correction is often required, as the first step of projects dealing with long reads. As the error profiles and error rates of the long reads are much different from those of the short reads, correcting long reads requires specific algorithmic developments.

The error correction of long reads has thus been tackled by two main approaches. The first approach, hybrid correction, makes use of additional short reads data to perform correction. The second approach, self-correction, aims at correcting the long reads solely based on the information contained in their sequences.

Hybrid correction methods rely on different techniques such as: 1. Alignment of short reads to the long reads (CoLoRMAP[7](/articles/s41598-020-80757-5#ref-CR7 "Haghshenas, E., Hach, F., Sahinalp, S. C. & Chauve, C. CoLoRMap: Correcting long reads by mapping short reads. Bioinformatics 32, i545–i551 (2016)."), HECiL[8](/articles/s41598-020-80757-5#ref-CR8 "Choudhury, O., Chakrabarty, A. & Emrich, S. J. HECIL: A hybrid error correction algorithm for long reads with iterative learning. Sci. Rep. 8, 1–9 (2018).")) ; 2. Exploration of de Bruijn graphs, built from short reads *k*-mers (LoRDEC[9](/articles/s41598-020-80757-5#ref-CR9 "Salmela, L. & Rivals, E. LoRDEC: Accurate and efficient long read error correction. Bioinformatics 30, 3506–3514 (2014)."), Jabba[10](/articles/s41598-020-80757-5#ref-CR10 "Miclotte, G. et al. Jabba: hybrid error correction for long sequencing reads. Algorithms Mol. Biol. 11, 10 (2016)."), FMLRC[11](/articles/s41598-020-80757-5#ref-CR11 "Wang, J. R., Holt, J., McMillan, L. & Jones, C. D. FMLRC: Hybrid long read error correction using an FM-index. BMC Bioinform. 19, 1–11 (2018).")) ; 3. Alignment of the long reads to contigs built from the short reads (MiRCA[12](/articles/s41598-020-80757-5#ref-CR12 "Kchouk, M. & Elloumi, M. An error correction and DeNovo assembly approach for nanopore reads using short reads. Curr. Bioinform. 13, 241–252 (2018)."), HALC[13](/articles/s41598-020-80757-5#ref-CR13 "Bao, E. & Lan, L. HALC: High throughput algorithm for long read error correction. BMC Bioinform. 18, 204 (2017).")) ; 4. Hidden Markov Models, initialized from the long reads sequences and trained using the short reads (Hercules[14](/articles/s41598-020-80757-5#ref-CR14 "Firtina, C., Bar-joseph, Z., Alkan, C. & Cicek, A. E. Hercules: a profile HMM-based hybrid error correction algorithm for long reads. Nucleic Acids Res. 46, e125 (2018).")) ; 5. Combination of different strategies (NaS[15](/articles/s41598-020-80757-5#ref-CR15 "Madoui, M.-A. et al. Genome assembly using Nanopore-guided long and error-free DNA reads. BMC Genomics 16, 327 (2015).") (1 + 3), HG-CoLoR[16](/articles/s41598-020-80757-5#ref-CR16 "Morisse, P., Lecroq, T. & Lefebvre, A. Hybrid correction of highly noisy long reads using a variable-order de Bruijn graph. Bioinformatics 34, 4213–4222 (2018).") (1 + 2)).

Self-correction methods usually build around the alignment of the long reads against each other (PBDAGCon[17](/articles/s41598-020-80757-5#ref-CR17 "Chin, C.-S. et al. Nonhybrid, finished microbial genome assemblies from long-read SMRT sequencing data. Nat. Methods 10, 563–569 (2013)."), PBcR[18](/articles/s41598-020-80757-5#ref-CR18 "Koren, S. et al. Reducing assembly complexity of microbial genomes with single-molecule sequencing. Genome Biol. 14, R101 (2013).")). We give further details on the state-of-the-art of self-correction in the “[Related works](/articles/s41598-020-80757-5#Sec2) ”.

As first long reads sequencing experiments resulted in highly erroneous long reads (15–30% error rates on average), most methods relied on the additional use of short reads data. As a result, hybrid correction used to be much more widespread. Indeed, in 2014, for five hybrid correction tools, only two self-correction tools were available.

However, third-generation sequencing technologies evolve fast, and now manage to produce long reads reaching error rates of 10–12%. Moreover, the evolution of long-read sequencing technologies also allows to produce higher throughputs of data, at a reduced cost. Consequently, such data became more widely available. As a result, self-correction can now efficiently be used in place of hybrid correction in data analysis projects dealing with long reads.

### Related works

Since third-generation sequencing technologies evolve fast, and now reach lower error rates, various efficient self-correction methods have recently been developed. Most of them share a common first step of computing overlaps between the long reads, which can be performed in two different ways. First, a mapping approach can be used, to simply provide the positions of similar regions of the long reads (Canu[19](/articles/s41598-020-80757-5#ref-CR19 "Koren, S. et al. Canu: Scalable and accurate long-read assembly via adaptive k-mer weighting and repeat separation. Genome Res. 27, 722–736 (2017)."), MECAT[20](/articles/s41598-020-80757-5#ref-CR20 "Xiao, C. L. et al. MECAT: Fast mapping, error correction, and de novo assembly for single-molecule sequencing reads. Nat. Methods 14, 1072–1074 (2017)."), FLAS[21](/articles/s41598-020-80757-5#ref-CR21 "Bao, E., Xie, F., Song, C. & Dandan, S. HALS: Fast and high throughput algorithm for PacBio long read self-correction. RECOMB-SEQ 35, 3953–3960 (2019).")). Second, an alignment approach can be used, to provide the positions of similar regions, but also their actual base to base correspondence in terms of matches, mismatches, insertions, and deletions (PBDAGCon, PBcR, Daccord[22](/articles/s41598-020-80757-5#ref-CR22 "Tischler, G. & Myers, E. W. Non hybrid long read consensus using local de Bruijn graph assembly. bioRxiv (2017).")). A directed acyclic graph (DAG) is then usually built, in order to summarize the 1V1 alignments and compute consensus, after recomputing actual alignments of mapped regions, if necessary. Other methods rely on de Bruijn graphs, either built from small windows of the alignments (Daccord), or directly from the long reads sequences with no prior overlapping step (LoRMA[23](/articles/s41598-020-80757-5#ref-CR23 "Salmela, L., Walve, R., Rivals, E. & Ukkonen, E. Accurate selfcorrection of errors in long reads using de Bruijn graphs. Bioinformatics 33, 799–806 (2017).")). These graphs are explored, using the solid *k*-mers (*i.e.* *k*-mers occurring more frequently than a given threshold) from the reads as anchor points, in order to correct low quality, weak *k*-mers regions.

However, methods relying on direct alignment of the long reads are prohibitively time and memory consuming, and current implementations thus do not scale to large genomes. Methods solely relying on de Bruijn graphs, and avoiding the overlapping step altogether, usually require deep long reads coverage, since the graphs are usually built from large, solid *k*-mers. As a result, methods relying on a mapping strategy constitute the core of the current state-of-the-art for long read self-correction.

### Contribution

We present CONSENT, a new self-correction method that combines different efficient approaches from the state-of-the-art. CONSENT indeed starts by computing multiple sequence alignments (MSA) between overlapping regions of the long reads, in order to compute consensus sequences. These consensus sequences are then polished with local de Bruijn graphs, in order to correct remaining errors, and further reduce the final error rate. Moreover, unlike current state-of-the-art methods, CONSENT computes actual MSA, using a method based o