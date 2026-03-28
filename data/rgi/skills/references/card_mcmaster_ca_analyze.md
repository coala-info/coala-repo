[## CARD](https://card.mcmaster.ca/home)

[Use or Download Copyright & Disclaimer](/about)

[Help Us Curate](https://github.com/arpcard/amr_curation)

#AMRCuration #WorkTogether

Toggle Navigation

| |  |  |  |  | | --- | --- | --- | --- | | * [Browse](https://card.mcmaster.ca/browse) | * [Analyze](https://card.mcmaster.ca/analyze) | * [Download](https://card.mcmaster.ca/download) | * [About](https://card.mcmaster.ca/about) | |

| |  | |

×

#### A Note on Ongoing Revisions of the Antibiotic Resistance Ontology

The Comprehensive Antibiotic Resistance Database gratefully acknowledges recent funding from the Genome Canada & Canadian Institutes of Health Research's Bioinformatics & Computational Biology program, allowing integration of the Antibiotic Resistance Ontology (ARO) with the Genomic Epidemiology Ontology, IRIDA platform, and OBO Foundry (see [Genome Canada press release](https://www.genomecanada.ca/en/news-and-events/news-releases/government-canada-invests-new-genomics-big-data-research-projects)). As such, the next two years will be a time of active development for the ARO. Expect significant changes in the ARO between monthly releases as well as occasional incomplete revisions, which may affect downstream analyses.

#### February 2017 Changes

* Use of the part\_of relationship now follows canonical usage and is restricted to association of sub-units with their large multi-unit protein complexes
* Extensive revisions to the antimicrobial efflux branch of the ARO
* Extensive revisions to the rRNA mutations branch of the ARO
* New use of the participates\_in and has\_part relationships in place of formerly incorrect usage of the part\_of relationship for association of resistance determinants with their mechanism of action.

#### April 2017 Changes

* Extensive addition of confers\_resistance\_to\_drug relationships for efflux complexes
* Drug and mechanism category updates for the Resistance Gene Identifier

#### May 2017 Changes

* Addition of bitscores to detection models, curation of chloramphenicol exporter proteins, ontology changes, JSON file format changes

#### August 2017 Changes

* Removal of redundant intermediate terms relating resistance determinant to drug class, with improved overall classification by Drug Class and Resistance Mechanism

#### January 2018 Changes

* Parallel classification system added to the ARO for organization of RGI results: Drug Class, Resistance Mechanism, AMR Gene Family
* ARO now available in GitHub, <https://github.com/arpcard>

#### April 2018 Changes

* Addition of extensive ontological terms describing phenotypic testing for antimicrobial resistance

Close

×

#### Message

...

Close

×
![](/ajax_loader_blue_128.gif)

![](/ajax_loader_blue_128.gif)

# Analyze

#### [BLAST](https://card.mcmaster.ca/analyze/blast)

Perform standard BLAST searches against the CARD reference sequences. Results are annotated with extra information from CARD. Sequence data must be in FASTA format.

CARD reference sequences are also [available for download](/download/) for custom analyses.

#### [RGI *main*](https://card.mcmaster.ca/analyze/rgi)

Use the online Resistance Gene Identifier to predict resistome(s) from **protein, genome, or genome assembly data** based on homology and SNP models. Sequence data must be in FASTA format.

Full documentation and an alternate command line version of RGI *main* are available at <https://github.com/arpcard/rgi>.

#### [RGI *bwt*](https://github.com/arpcard/rgi/blob/master/docs/rgi_bwt.rst)

Use the command line version of the Resistance Gene Identifier to predict resistome(s) from **short sequencing reads** based on reference sequences in CARD and read mapping algorithms (default: [KMA](https://bitbucket.org/genomicepidemiology/kma/src/master/)). Sequence data must be in FASTQ format.

Full documentation and the command line version of RGI *bwt* are available at [https://github.com/arpcard/rgi](https://github.com/arpcard/rgi/blob/master/docs/rgi_bwt.rst).

Chan Zuckerberg ID (CZ ID) has implemented a [web-based platform](https://czid.org) for RGI analysis of metagenomic sequencing reads. See [Lu *et al*. 2025. *Genome Medicine*, **17**, 46](https://pubmed.ncbi.nlm.nih.gov/40329334/) for a detailed description.

#### [RGI *kmer*](https://github.com/arpcard/rgi/blob/master/docs/rgi_kmer.rst)

Use the command line version of the Resistance Gene Identifier to predict pathogen-of-origin or plasmid-association for **short sequencing reads** or **complete alleles** encoding resistance genes based on reference sequences in CARD.

Full documentation and the command line version of RGI *kmer\_query* are available at [https://github.com/arpcard/rgi](https://github.com/arpcard/rgi/blob/master/docs/rgi_kmer.rst).

See [Wlodarski *et al*. 2025. *bioRxiv*, 2025.09.15.676352](https://www.biorxiv.org/content/10.1101/2025.09.15.676352v1) for a detailed description.