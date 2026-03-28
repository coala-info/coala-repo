[Skip to main content](#main)

BMC journals have moved to Springer Nature Link. [Learn more about website changes.](https://support.springernature.com/en/support/solutions/articles/6000281876-springer-nature-brand-websites-are-moving-to-springer-nature-link)

[![Springer Nature Link](/oscar-static/images/darwin/header/img/logo-springer-nature-link-05805fde18.svg)](https://link.springer.com)

[Log in](https://idp.springer.com/auth/personal/springernature?redirect_uri=https://link.springer.com/article/10.1186/s12859-019-3019-7)

[Menu](#eds-c-header-nav)

[Find a journal](https://link.springer.com/journals/)
[Publish with us](https://www.springernature.com/gp/authors)
[Track your research](https://link.springernature.com/home/)

[Search](#eds-c-header-popup-search)

[Saved research](/saved-research)

[Cart](https://order.springer.com/public/cart)

1. [Home](/)
2. [BMC Bioinformatics](/journal/12859)
3. Article

# HH-suite3 for fast remote homology detection and deep protein annotation

* Software
* [Open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research)
* Published: 14 September 2019

* Volume 20, article number 473, (2019)
* [Cite this article](#citeas)

You have full access to this [open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research) article

[Download PDF](/content/pdf/10.1186/s12859-019-3019-7.pdf)

[Save article](/article/10.1186/s12859-019-3019-7/save-research?_csrf=LauZnuI4yFtMSKF0ZItR3YuLo1hYJvOE)

[View saved research](/saved-research)

[![](https://media.springernature.com/w72/springer-static/cover-hires/journal/12859?as=webp)
BMC Bioinformatics](/journal/12859)
[Aims and scope](/journal/12859/aims-and-scope)
[Submit manuscript](https://submission.nature.com/new-submission/12859/3)

HH-suite3 for fast remote homology detection and deep protein annotation

[Download PDF](/content/pdf/10.1186/s12859-019-3019-7.pdf)

* [Martin Steinegger](#auth-Martin-Steinegger-Aff1-Aff2)[1](#Aff1),[2](#Aff2),
* [Markus Meier](#auth-Markus-Meier-Aff1)[1](#Aff1),
* [Milot Mirdita](#auth-Milot-Mirdita-Aff1)[1](#Aff1),
* [Harald Vöhringer](#auth-Harald-V_hringer-Aff1-Aff3)[1](#Aff1),[3](#Aff3),
* [Stephan J. Haunsberger](#auth-Stephan_J_-Haunsberger-Aff4)[4](#Aff4) &
* …
* [Johannes Söding](#auth-Johannes-S_ding-Aff1)
  [ORCID: orcid.org/0000-0001-9642-8244](https://orcid.org/0000-0001-9642-8244)[1](#Aff1)

Show authors

* 35k Accesses
* 1202 Citations
* 53
  Altmetric
* 10 Mentions
* [Explore all metrics](/article/10.1186/s12859-019-3019-7/metrics)

## Abstract

### Background

HH-suite is a widely used open source software suite for sensitive sequence similarity searches and protein fold recognition. It is based on pairwise alignment of profile Hidden Markov models (HMMs), which represent multiple sequence alignments of homologous proteins.

### Results

We developed a single-instruction multiple-data (SIMD) vectorized implementation of the Viterbi algorithm for profile HMM alignment and introduced various other speed-ups. These accelerated the search methods HHsearch by a factor 4 and HHblits by a factor 2 over the previous version 2.0.16. HHblits3 is ∼10× faster than PSI-BLAST and ∼20× faster than HMMER3. Jobs to perform HHsearch and HHblits searches with many query profile HMMs can be parallelized over cores and over cluster servers using OpenMP and message passing interface (MPI). The free, open-source, GPLv3-licensed software is available at <https://github.com/soedinglab/hh-suite>.

### Conclusion

The added functionalities and increased speed of HHsearch and HHblits should facilitate their use in large-scale protein structure and function prediction, e.g. in metagenomics and genomics projects.

### Similar content being viewed by others

![](https://media.springernature.com/w92h120/springer-static/cover-hires/book/978-1-4939-8736-8?as=webp)

### [A Graph-Based Approach for Detecting Sequence Homology in Highly Diverged Repeat Protein Families](https://link.springer.com/10.1007/978-1-4939-8736-8_13?fromPaywallRec=false)

Chapter
© 2019

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1186%2Fs12859-016-1198-z/MediaObjects/12859_2016_1198_Fig1_HTML.gif)

### [Fold-specific sequence scoring improves protein sequence matching](https://link.springer.com/10.1186/s12859-016-1198-z?fromPaywallRec=false)

Article
Open access
30 August 2016

![](https://media.springernature.com/w92h120/springer-static/cover-hires/book/978-981-13-1562-6?as=webp)

### [Predicting Protein Function Using Homology-Based Methods](https://link.springer.com/10.1007/978-981-13-1562-6_13?fromPaywallRec=false)

Chapter
© 2018

### Explore related subjects

Discover the latest articles, books and news in related subjects, suggested using machine learning.

* [Biological Databases](/subjects/biological-databases)
* [Genome assembly algorithms](/subjects/genome-assembly-algorithms)
* [Histone variants](/subjects/histone-variants)
* [Histone analysis](/subjects/histone-analysis)
* [Protein sequence analyses](/subjects/protein-sequence-analyses)
* [Protein Databases](/subjects/protein-databases)
* [Genomic Analysis and Sequencing Technologies](/subjects/genomic-analysis-and-sequencing-technologies)

## Introduction

A sizeable fraction of proteins in genomics and metagenomics projects remain without annotation due to the lack of an identifiable, annotated homologous protein [[1](/article/10.1186/s12859-019-3019-7#ref-CR1 "Howe AC, Jansson JK, Malfatti SA, Tringe SG, Tiedje JM, Brown CT. Tackling soil diversity with the assembly of large, complex metagenomes. Proc Natl Acad Sci USA. 2014; 111(13):4904–4909.
                  https://doi.org/10.1073/pnas.1402564111

                .")]. A high sensitivity in sequence similarity searches increases the chance of finding a homologous protein with an annotated function or a known structure from which the function or structure of the query protein can be inferred [[2](/article/10.1186/s12859-019-3019-7#ref-CR2 "Söding J, Remmert M. Protein sequence comparison and fold recognition: progress and good-practice benchmarking. Curr Opin Struct Biol. 2011; 21(3):404–11.
                  https://doi.org/10.1016/j.sbi.2011.03.005

                .")]. Therefore, to find template proteins for comparative protein structure modeling and for deep functional annotation, the most sensitive search tools such as HMMER [[3](/article/10.1186/s12859-019-3019-7#ref-CR3 "Eddy SR. A new generation of homology search tools based on probabilistic inference. Genome Inform. 2009; 23(1):205–11."), [4](/article/10.1186/s12859-019-3019-7#ref-CR4 "Eddy SR. Accelerated Profile HMM Searches. PLOS Comput Biol. 2011; 7(10):1002195.
                  https://doi.org/10.1371/journal.pcbi.1002195

                .")] and HHblits [[5](/article/10.1186/s12859-019-3019-7#ref-CR5 "Remmert M, Biegert A, Hauser A, Söding J. HHblits: lightning-fast iterative protein sequence searching by HMM-HMM alignment. Nat Methods. 2012; 9(2):173–5.
                  https://doi.org/10.1038/nmeth.1818

                .")] are often used [[6](/article/10.1186/s12859-019-3019-7#ref-CR6 "Dill KA, MacCallum JL. The protein-folding problem, 50 years on. Science. 2012; 338(6110):1042–6.
                  https://doi.org/10.1126/science.121902

                .")–[9](/article/10.1186/s12859-019-3019-7#ref-CR9 "Burstein D, Harrington LB, Strutt SC, Probst AJ, Anantharaman K, Thomas BC, Doudna JA, Banfield JF. New CRISPR-Cas systems from uncultivated microbes. Nature. 2016; 542:237.
                  https://doi.org/10.1038/nature21059

                .")]. These tools can improve homology detection by aligning not only single sequences against other sequences, but using more information in form of multiple sequence alignments (MSAs) containing many homologous sequences. From the frequencies of amino acids in each column of the MSA, they calculate a 20×length matrix of position-specific amino acid substitution scores, termed “sequence profile”.

A profile Hidden Markov Model (HMM) extends sequence profiles by augmenting the position-specific amino acid substitution scores with position-specific penalties for insertions and deletions. These can be estimated from the frequencies of insertions and deletions in the MSA. The added information improves the sensitivity of profile HMM-based methods like HHblits or HMMER3 over ones based on sequence profiles, such as PSI-BLAST [[10](/article/10.1186/s12859-019-3019-7#ref-CR10 "Altschul SF, Madden TL, Schäffer AA, Zhang J, Zhang Z, Miller W, Lipman DJ. Gapped BLAST and PSI-BLAST: a new generation of protein database search programs. Nucleic Acids Res. 1997; 25(17):3389–402.
                  https://doi.org/10.1093/nar/25.17.3389

                .")].

Only few search tools represent both the query and the target proteins as sequence profiles built from MSAs of homologous proteins [[11](/article/10.1186/s12859-019-3019-7#ref-CR11 "Rychlewski L, Jaroszewski L, Li W, Godzik A. Comparison of sequence profiles. Strategies for structural predictions using sequence information. Protein Sci. 2000; 9(2):232–41.
                  https://doi.org/10.1110/ps.9.2.232

                .")–[14](/article/10.1186/s12859-019-3019-7#ref-CR14 "Margelevičius M, Venclovas Č. Detection of distant evolutionary relationships between protein families using theory of sequence profile-profile comparison. BMC Bioinform. 2010; 11(1):89.
                  https://doi.org/10.1186/1471-2105-11-89

                .")]. In contrast, HHblits / HHsearch represent both the query and the target proteins as profile HMMs. This makes them among the most sensitive tools for sequence similarity search and remote homology detection [[5](/article/10.1186/s12859-019-3019-7#ref-CR5 "Remmert M, Biegert A, Hauser A, Söding J. HHblits: lightning-fast iterative protein sequence searching by HMM-HMM alignment. Nat Methods. 2012; 9(2):173–5.
                  https://doi.org/10.1038/nmeth.1818

                ."), [15](/article/10.1186/s12859-019-3019-7#ref-CR15 "Söding J. Protein homology detection by HMM-HMM comparison. Bioinformatics. 2005; 21(7):951–60.
                  https://doi.org/10.1093/bioinformatics/bti125

                .")].

In recent years, various sequence search tools have been developed that are up to four orders of magnitude faster than BLAST [[16](/article/10.1186/s12859-019-3019-7#ref-CR16 "Edgar RC. Search and clustering orders of magnitude faster than BLAST. Bioinformatics. 2010; 26(19):2460–1.
                  https://doi.org/10.1093/bioinformatics/btq461

                .")–[19](/article/10.1186/s12859-019-3019-7#ref-CR19 "Steinegger M, Söding J. MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nat Biotechnol. 2017; 35(11):1026–8.
                  https://doi.org/10.1038/nbt.3988

                .")]. This speed-up addresses the need to search massive amounts of environmental next-generation sequencing data against the ever-growing databases of annotated sequences. However, no homology can be found for many of these sequences even with sensitive methods, such as BLAST or MMseqs2 [[19](/article/10.1186/s12859-019-3019-7#ref-CR19 "Steinegger M, Söding J. MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nat Biotechnol. 2017; 35(11):1026–8.
                  https://doi.org/10.1038/nbt.3988

                .")].

Genomics and metagenomics projects could annotate more sequence by adding HHblits searches through the PDB, Pfam and other profile databases to their pipelines [[8](/article/10.1186/s12859-019-3019-7#ref-CR8 "Fidler DR, Murphy SE, Courtis K, Antonoudiou P, El-Tohamy R, Ient J, Levine TP. Using HHsearch to tackle proteins of unknown function: A pilot study with PH domains. Traffic. 2016; 17(11):1214–26.
                  https://doi.org/10.1111/tra.12432

                .")]. Additional computation costs would be marginal, since the version of HHblits presented in this work runs 20 times faster than HMMER, the standard tool for Pfam [[20](/article/10.1186/s12859-019-3019-7#ref-CR20 "El-Gebali S, Mistry J, Bateman A, Eddy SR, Luciani A, Potter SC, Qureshi M, Richardson LJ, Salazar GA, Smart A, et al. The Pfam protein families database in 2019. Nucleic Acids Res. 2018; 47(D1):427–32.
                  https://doi.org/10.1093/nar/gky995

                .")] and InterPro [[21](/article/10.1186/s12859-019-3019-7#ref-CR21 "Mitchell AL, Attwood TK, Babbitt PC, Blum M, Bork P, Bridge A, Brown SD, Chang H. -Y., El-Gebali S, Fraser MI, et al. Interpro in 2019: improving coverage, classification and access to protein sequence annotations. Nucleic Acids Res. 2018; 47(D1):351–60.")] annotations.

In this work, our goal was to accelerate and parallelize various HH-suite algorithms with a focus on the most time-critical tools, HHblits and HHsearch. We applied data level parallelization using Advanced Vector Extension 2 (AVX2) or Streaming SIMD Extension 2 (SSE2) instructions, thread level parallelization using OpenMP, and parallelization across computers using MPI. Most important was the ample use of parallelization through SIMD arithmetic units present in all modern Intel, AMD and IBM CPUs, with which we achieved speed-ups per CPU core of a factor 2 to 4.

## Methods

### Overview of HH-suite

The software HH-suite contains the search tools HHsearch [[15](/article/10.1186/s12859-019-3019-7#ref-CR15 "Söding J. Protein homology detection by HMM-HMM comparison. Bioinformatics. 2005; 21(7):951–60.
                  https://doi.org/10.1093/bioinformatics/bti125

                .")] and HHblits [[5](/article/10.1186/s12859-019-3019-7#ref-CR5 "Remmert M, Biegert A, Hauser A, Söding J. HHblits: lightning-fast iterative protein sequence searching by HMM-HMM alignment. Nat Methods. 2012; 9(2):173–5.
                  https://doi.org/10.1038/nmeth.1818

                .")], and various utilities to build databases of MSAs or profile HMMs, to convert MSA formats, etc.

HHsearch aligns a profile HMM against a database of target profile HMMs. The search first aligns the query HMM with each of the target HMMs using the Viterbi dynamic programming algorithm, which finds the alignment with the maximum score. The E-value for the target HMM is calculated from the Viterbi score [[5](/article/10.1186/s12859-019-3019-7#ref-CR5 "Remmert M, Biegert A, Hauser A, Söding J. HHblits: lightning-fast iterative protein sequence searching by HMM-HMM alignment. Nat Methods. 2012; 9(2):173–5.
                  https://doi.org/10.1038/nmeth.1818

                .")]. Target HMMs that reach sufficient significance to be reported are realigned using the Maximum Accuracy algorithm (MAC) [[22](/article/10.1186/s12859-019-3019-7#ref-CR22 "Biegert A, Söding J. De novo identification of highly diverged protein repeats by probabilistic consistency. Bioinforma