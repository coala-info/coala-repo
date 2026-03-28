[Skip to main content](#main)

Advertisement

[![Advertisement](//pubads.g.doubleclick.net/gampad/ad?iu=/270604982/springerlink/13059/article&sz=728x90&pos=top&articleid=s13059-022-02815-7)](//pubads.g.doubleclick.net/gampad/jump?iu=/270604982/springerlink/13059/article&sz=728x90&pos=top&articleid=s13059-022-02815-7)

BMC journals have moved to Springer Nature Link. [Learn more about website changes.](https://support.springernature.com/en/support/solutions/articles/6000281876-springer-nature-brand-websites-are-moving-to-springer-nature-link)

[![Springer Nature Link](/oscar-static/images/darwin/header/img/logo-springer-nature-link-05805fde18.svg)](https://link.springer.com)

[Log in](https://idp.springer.com/auth/personal/springernature?redirect_uri=https://link.springer.com/article/10.1186/s13059-022-02815-7)

[Menu](#eds-c-header-nav)

[Find a journal](https://link.springer.com/journals/)
[Publish with us](https://www.springernature.com/gp/authors)
[Track your research](https://link.springernature.com/home/)

[Search](#eds-c-header-popup-search)

[Saved research](/saved-research)

[Cart](https://order.springer.com/public/cart)

1. [Home](/)
2. [Genome Biology](/journal/13059)
3. Article

# MoDLE: high-performance stochastic modeling of DNA loop extrusion interactions

* Software
* [Open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research)
* Published: 30 November 2022

* Volume 23, article number 247, (2022)
* [Cite this article](#citeas)

You have full access to this [open access](https://www.springernature.com/gp/open-science/about/the-fundamentals-of-open-access-and-open-research) article

[Download PDF](/content/pdf/10.1186/s13059-022-02815-7.pdf)

[Save article](/article/10.1186/s13059-022-02815-7/save-research?_csrf=snf7Kpseg7gKScMX_sq7YE1ZPjv3kopk)

[View saved research](/saved-research)

[![](https://media.springernature.com/w72/springer-static/cover-hires/journal/13059?as=webp)
Genome Biology](/journal/13059)
[Aims and scope](/journal/13059/aims-and-scope)
[Submit manuscript](https://submission.springernature.com/new-submission/13059/3)

MoDLE: high-performance stochastic modeling of DNA loop extrusion interactions

[Download PDF](/content/pdf/10.1186/s13059-022-02815-7.pdf)

* [Roberto Rossini](#auth-Roberto-Rossini-Aff1)[1](#Aff1),
* [Vipin Kumar](#auth-Vipin-Kumar-Aff2)[2](#Aff2),
* [Anthony Mathelier](#auth-Anthony-Mathelier-Aff2)[2](#Aff2),
* [Torbjørn Rognes](#auth-Torbj_rn-Rognes-Aff3-Aff4)[3](#Aff3),[4](#Aff4) &
* …
* [Jonas Paulsen](#auth-Jonas-Paulsen-Aff1-Aff3)
  [ORCID: orcid.org/0000-0002-7918-5495](https://orcid.org/0000-0002-7918-5495)[1](#Aff1),[3](#Aff3)

Show authors

* 5504 Accesses
* 18 Citations
* 6
  Altmetric
* [Explore all metrics](/article/10.1186/s13059-022-02815-7/metrics)

## Abstract

DNA loop extrusion emerges as a key process establishing genome structure and function. We introduce MoDLE, a computational tool for fast, stochastic modeling of molecular contacts from DNA loop extrusion capable of simulating realistic contact patterns genome wide in a few minutes. MoDLE accurately simulates contact maps in concordance with existing molecular dynamics approaches and with Micro-C data and does so orders of magnitude faster than existing approaches. MoDLE runs efficiently on machines ranging from laptops to high performance computing clusters and opens up for exploratory and predictive modeling of 3D genome structure in a wide range of settings.

### Similar content being viewed by others

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1038%2Fs41592-022-01527-x/MediaObjects/41592_2022_1527_Fig1_HTML.png)

### [Integrative genome modeling platform reveals essentiality of rare contact events in 3D genome organizations](https://link.springer.com/10.1038/s41592-022-01527-x?fromPaywallRec=false)

Article
Open access
11 July 2022

![](https://media.springernature.com/w215h120/springer-static/image/art%3A10.1007%2Fs11047-018-9693-y/MediaObjects/11047_2018_9693_Fig1_HTML.png)

### [Automated analysis of tethered DNA nanostructures using constraint solving](https://link.springer.com/10.1007/s11047-018-9693-y?fromPaywallRec=false)

Article
25 June 2018

![](https://media.springernature.com/w92h120/springer-static/cover-hires/book/978-1-0716-2221-6?as=webp)

### [Atomistic Molecular Dynamics Simulations of DNA in Complex 3D Arrangements for Comparison with Lower Resolution Structural Experiments](https://link.springer.com/10.1007/978-1-0716-2221-6_8?fromPaywallRec=false)

Chapter
© 2022

### Explore related subjects

Discover the latest articles, books and news in related subjects, suggested using machine learning.

* [Chromosome conformation capture-based methods](/subjects/chromosome-conformation-capture-based-methods)
* [DNA Nanomachines](/subjects/dna-nanomachines)
* [Genetic Interaction](/subjects/genetic-interaction)
* [Genome informatics](/subjects/genome-informatics)
* [Molecular Modelling](/subjects/molecular-modelling)
* [Molecular Dynamics](/subjects/molecular-dynamics)
* [Protein Structure Prediction and Function Analysis](/subjects/protein-structure-prediction-and-function-analysis)

## Background

DNA loop-extrusion, in which DNA is progressively reeled into transient loops, emerges as a key process in genome structure and function. The growing list of cellular processes where loop-extrusion plays a critical role now includes transcriptional regulation [[1](/article/10.1186/s13059-022-02815-7#ref-CR1 "Braccioli L, de Wit E. CTCF: a Swiss-army knife for genome organization and transcription regulation. Essays Biochem. 2019;63:157–65."), [2](/article/10.1186/s13059-022-02815-7#ref-CR2 "Razin SV, Gavrilov AA, Vassetzky YS, Ulianov SV. Topologically-associating domains: gene warehouses adapted to serve transcriptional regulation. Transcription. 2016;7:84–90.")], DNA repair [[3](/article/10.1186/s13059-022-02815-7#ref-CR3 "Arnould C, Rocher V, Finoux A-L, Clouaire T, Li K, Zhou F, et al. Loop extrusion as a mechanism for formation of DNA damage repair foci. Nature. 2021;590:660–5.")], VDJ-recombination [[4](/article/10.1186/s13059-022-02815-7#ref-CR4 "Peters J-M. How DNA loop extrusion mediated by cohesin enables V(D)J recombination. Curr Opin Cell Biol. 2021;70:75–83.")], and cell division [[5](/article/10.1186/s13059-022-02815-7#ref-CR5 "Goloborodko A, Marko JF, Mirny LA. Chromosome compaction by active loop extrusion. Biophys J. 2016;110:2162–8.")]. Recent single-molecule imaging experiments have provided direct observations of loop extrusion in vitro [[6](/article/10.1186/s13059-022-02815-7#ref-CR6 "Ganji M, Shaltiel IA, Bisht S, Kim E, Kalichava A, Haering CH, et al. Real-time imaging of DNA loop extrusion by condensin. Science. 2018;360:102–5."), [7](/article/10.1186/s13059-022-02815-7#ref-CR7 "Golfier S, Quail T, Kimura H, Brugués J. Cohesin and condensin extrude DNA loops in a cell cycle-dependent manner. Elife. 2020:9.
                  https://doi.org/10.7554/eLife.53885

                .")].

High-throughput chromosome conformation capture sequencing, including Hi-C [[8](/article/10.1186/s13059-022-02815-7#ref-CR8 "Lieberman-Aiden E, van Berkum NL, Williams L, Imakaev M, Ragoczy T, Telling A, et al. Comprehensive mapping of long-range interactions reveals folding principles of the human genome. Science. 2009;326:289–93.")] and Micro-C [[9](/article/10.1186/s13059-022-02815-7#ref-CR9 "Hsieh T-HS, Weiner A, Lajoie B, Dekker J, Friedman N, Rando OJ. Mapping nucleosome resolution chromosome folding in yeast by Micro-C. Cell. 2015;162:108–19."), [10](/article/10.1186/s13059-022-02815-7#ref-CR10 "Krietenstein N, Abraham S, Venev SV, Abdennur N, Gibcus J, Hsieh T-HS, et al. Ultrastructural details of mammalian chromosome architecture. Mol Cell. 2020;78:554–65.e7.")], has advanced our abilities to map three-dimensional (3D) genome organization through quantification of spatially proximal genome regions. The resulting data is usually rendered as a matrix of intrachromosomal and interchromosomal contact frequencies. These data increasingly deepen our understanding of 3D genome organization and show DNA loop extrusion as a key process shaping genome structure [[11](#ref-CR11 "Sanborn AL, Rao SSP, Huang S-C, Durand NC, Huntley MH, Jewett AI, et al. Chromatin extrusion explains key features of loop and domain formation in wild-type and engineered genomes. Proc Natl Acad Sci U S A. 2015;112:E6456–65."),[12](#ref-CR12 "Fudenberg G, Imakaev M, Lu C, Goloborodko A, Abdennur N, Mirny LA. Formation of chromosomal domains by loop extrusion. Cell Rep. 2016;15:2038–49."),[13](/article/10.1186/s13059-022-02815-7#ref-CR13 "Brandão HB, Ren Z, Karaboja X, Mirny LA, Wang X. DNA-loop-extruding SMC complexes can traverse one another in vivo. Nat Struct Mol Biol. 2021;28:642–51.")]. In fact, topologically associating domains (TADs), which show up as sub-megabase-sized domains covering most of higher eukaryote genomes, are formed by loop extrusion [[12](/article/10.1186/s13059-022-02815-7#ref-CR12 "Fudenberg G, Imakaev M, Lu C, Goloborodko A, Abdennur N, Mirny LA. Formation of chromosomal domains by loop extrusion. Cell Rep. 2016;15:2038–49.")]. TADs are relevant units of gene expression regulation and are associated with disease when disrupted [[14](/article/10.1186/s13059-022-02815-7#ref-CR14 "Lupiáñez DG, Spielmann M, Mundlos S. Breaking TADs: How alterations of chromatin domains result in disease. Trends Genet. 2016;32:225–37.")].

DNA loop extrusion is carried out by ring-shaped proteins (including cohesin and condensin) belonging to the structural maintenance of chromosomes (SMC) family. These proteins are often referred to as loop extrusion factors (LEFs) [[15](/article/10.1186/s13059-022-02815-7#ref-CR15 "Alipour E, Marko JF. Self-organization of domain structures by DNA-loop-extruding enzymes. Nucleic Acids Res. 2012;40:11202–12.")]. The exact mechanism of how loop extrusion takes place in interphase is not fully understood. There is, however, convincing evidence that SMCs bind DNA to perform ATP-dependent loop extrusion in a symmetric or asymmetric fashion. Recent evidence suggests that cohesin can extrude DNA with a “swing-and-clamp” mechanism [[16](/article/10.1186/s13059-022-02815-7#ref-CR16 "Bauer BW, Davidson IF, Canena D, Wutz G, Tang W, Litos G, et al. Cohesin mediates DNA loop extrusion by a “swing and clamp” mechanism. Cell. 2021;184:5448–64.e22.")] and in a nontopological configuration where DNA is not encircled by the cohesin ring [[17](/article/10.1186/s13059-022-02815-7#ref-CR17 "Golov AK, Golova AV, Gavrilov AA, Razin SV. Sensitivity of cohesin-chromatin association to high-salt treatment corroborates non-topological mode of loop extrusion. Epigenetics Chromatin. 2021;14:36."), [18](/article/10.1186/s13059-022-02815-7#ref-CR18 "Pradhan B, Barth R, Kim E, Davidson IF, Bauer B, van Laar T, et al. SMC complexes can traverse physical roadblocks bigger than their ring size [Internet]. bioRxiv. 2021:2021.07.15.452501 Available from:
                  https://www.biorxiv.org/content/10.1101/2021.07.15.452501v1.abstract

                . [Cited 2022 Apr 11].")]. A loop starts extruding when a LEF binds to a genomic region and continues processively until it is stalled by a DNA-bound CCCTC binding factor (CTCF) oriented with its N-terminus pointing towards the extruding cohesin complex. A pair of CTCFs arranged in a convergent orientation can thus stall loop growth on both sides creating semi-stable loops visible in Hi-C as a characteristic "dot" at TAD corners [[19](/article/10.1186/s13059-022-02815-7#ref-CR19 "Rao SSP, Huntley MH, Durand NC, Stamenova EK, Bochkov ID, Robinson JT, et al. A 3D map of the human genome at kilobase resolution reveals principles of chromatin looping. Cell. 2014;159:1665–80.")]. Similarly, when extruding loops are stalled only on one side, a “stripe” can be observed along one or both TAD borders [[20](/article/10.1186/s13059-022-02815-7#ref-CR20 "Vian L, Pękowska A, Rao SSP, Kieffer-Kwon K-R, Jung S, Baranello L, et al. The energetics and physiological impact of cohesin extrusion. Cell. 2018;173:1165–78.e20.")]. The protein WAPL transiently releases cohesin from chromatin, terminating the loop extrusion process [[21](/article/10.1186/s13059-022-02815-7#ref-CR21 "Tedeschi A, Wutz G, Huet S, Jaritz M, Wuensche A, Schirghuber E, et al. Wapl is an essential regulator of chromatin structure and chromosome segregation. Nature. 2013;501:564–8."), [22](/article/10.1186/s13059-022-02815-7#ref-CR22 "Haarhuis JHI, van der Weide RH, Blomen VA, Yáñez-Cuna JO, Amendola M, van Ruiten MS, et al. The cohesin release factor WAPL restricts chromatin loop extension. Cell. 2017;169:693–707.e14.")]. The resulting loop-extrusion patterns have been found in a range of Hi-C datasets so far, emphasizing the evolutionary conserved role of loop extrusion in shaping 3D genome organization [[19](/article/10.1186/s13059-022-02815-7#ref-CR19 "Rao SSP, Huntley MH, Durand NC, Stamenova EK, Bochkov ID, Robinson JT, et al. A 3D map of the human genome at kilobase resolution reveals principles of chromatin looping. Cell. 2014;159:1665–80."), [23](/article/10.1186/s13059-022-02815-7#ref-CR23 "Nakamura R, Motai Y, Kumagai M, Wike CL, Nishiyama H, Nakatani Y, et al. CTCF looping is established during gastrulation in medaka embryos. Genome Res. 2021;31:968–80.")].

Disrupting any of the key proteins involved in DNA loop extrusion has a dramatic effect on genome 3D structure. WAPL depletion causes an increase in loop stability, with an accumulation of axial elements and weakening of compartments [[21](/article/10.1186/s13059-022-02815-7#ref-CR21 "Tedeschi A, Wutz G, Huet S, Jaritz M, Wuensche A, Schirghuber E, et al. Wapl is an essential regulator of chromatin structure and chromosome segregation. Nature. 2013;501:564–8."), [24](/article/10.1186/s13059-022-02815-7#ref-CR24 "Wutz G, Várnai C, Nagasaka K, Cisneros DA, Stocsits RR, Tang W, et al. Topologically associating domains and chromatin loops depend on cohesin and are regulated by CTCF, WAPL, and PDS5 proteins. EMBO J. 2017;36:3573–99.")]. Depletion of cohesin causes a large fraction of TADs and loops to disappear [[24](#ref-CR24 "Wutz G, Várnai C, Nagasaka K, Cisneros DA, Stocsits RR, Tang W, et al. Topologically associating domains and chromatin loops depend on cohesin and are regulated by CTCF, WAPL, and PDS5 proteins. EMBO J. 2017;36:3573–99."),[25](#ref-CR25 "Rao SSP, Huang S-C, Glenn St Hilaire B, Engreitz JM, Perez EM, Kieffer-Kwon K-R, et al. Cohesin loss eliminates all loop domains. Cell. 2017;171:305–20.e24."),[26](/article/10.1186/s13059-022-02815-7#ref-CR26 "Liu NQ, Magnitov M, Schijns M, van Schaik T, van der Weide RH, Teunissen H, et al. Rapid depletion of CTCF and cohesin proteins reveals dynamic features of chromosome architecture [Internet]. bioRxiv. 2021:2021.08.27.457977 Available from:
                  https://www.biorxiv.org/conte