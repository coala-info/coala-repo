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

# CARD-R Resistomes, Variants, & Prevalence

Antimicrobial resistance (AMR) molecular Resistomes, Variants, & Prevalence data were generated using the [Resistance Gene Identifier (RGI)](https://card.mcmaster.ca/analyze/rgi), a tool for putative AMR gene detection from submitted sequence data using the AMR detection models available in CARD. To generate Resistomes, Variants, & Prevalence data, RGI was used to analyze molecular sequence data available in [NCBI Genomes](https://www.ncbi.nlm.nih.gov/genome/) for 414 pathogens of interest, plus genomic islands available in Islandviewer. For each of these pathogens, complete chromosome sequences, predicted genomic islands, complete plasmid sequences, and whole genome shotgun (WGS) assemblies were analyzed individually by RGI. RGI results were then aggregated to calculate percent occurrence. For example, if 50 WGS assemblies were analyzed and blaNDM-1 was predicted by RGI in 40, the calculated prevalence would be 80%. Results are further categorized using the Antibiotic Resistance Ontology (ARO), e.g. "beta-lactam resistance protein", "antibiotic inactivation enzyme", etc.

Resistomes, Variants, & Prevalence data is available under both the Perfect and Strict paradigms of RGI, the former tracking perfect matches to the curated reference sequences and mutations in the CARD, while the latter detects previously unknown variants of known AMR genes, including secondary screen for key mutations, using detection models with curated similarity cut-offs to ensure the detected variant is likely a functional AMR gene. These analysis currently exclude CARD's rRNA mutation models. For more information, see the [Resistance Gene Identifier](https://card.mcmaster.ca/analyze/rgi).

The reported results are entirely dependant upon the curated AMR detection models in CARD and the sequence data available at NCBI and Islandviewer. Reported frequencies have not been corrected for unmeasured clonality or sampling bias of genomic data available at NCBI. These data will change over time as CARD curation, RGI software, and NCBI data evolve.

Additional data have been provided by the [Canadian Genomics R&D Initiative on AMR One Health](https://grdi.canada.ca/en/projects/antimicrobial-resistance-2-amr2-project), via [NCBI BioProject PRJNA1076250](https://www.ncbi.nlm.nih.gov/bioproject/1076250).

CARD Resistomes, Variants, & Prevalence 4.0.1 is based on sequence data acquired from NCBI on May 2, 2023 and [Islandviewer 4](http://www.pathogenomics.sfu.ca/islandviewer/), analyzed using RGI 6.0.2 (DIAMOND homolog detection) and CARD 3.2.7.

Usage:
(1) CARD Resistomes, Variants, & Prevalence can be [downloaded](https://card.mcmaster.ca/download) for bulk analyses, including assessment of thousands of individual sequenced isolates.
(2) The CARD website uses these data to summarize the molecular epidemiology of individual resistance genes, e.g. [NDM-1](/ontology/36728).
(3) The Resistance Gene Identifier can use these sequences variants as [a broader reference set for analysis of metagenomics data using read-mapping](https://github.com/arpcard/rgi/blob/master/docs/rgi_bwt.rst). (4) The Resistance Gene Identifier can [use k-mers derived from these data for pathogen-of-origin prediction](https://github.com/arpcard/rgi/blob/master/docs/rgi_kmer.rst) for antimicrobial resistance gene sequences.

Sampling

The number of completely sequenced genomes, completely sequenced plasmids, whole-genome shotgun assemblies, or genomic islands analyzed for each pathogen. All sequence data acquired from [NCBI Genomes](https://www.ncbi.nlm.nih.gov/genome/) and Islandviewer.

| Species | NCBI Chromosome | NCBI Plasmid | NCBI WGS | NCBI GI | GRDI-AMR2 |
| --- | --- | --- | --- | --- | --- |

Summary Infographics

| ![mobility](/prevalence_mobility.jpg)  AMR Gene Mobility: Big circles are pathogens, little circles within are genes. Size of little circles reflects prevalence in WGS data. Genes exclusively on chromosomes in white, others increasingly blue based on association with plasmids. Does not include efflux. |
| --- |
| ![mobility](/prevalence_drugclass.jpg)  Drug Classes Impacted: Big circles are pathogens, little circles within are ARO Drug Classes. Size of little circles reflects prevalence in WGS data. Colours reflect Drug Class combinations. Does not include efflux. |

AMR Gene Prevalence

Prevalence of AMR genes and variants organized by CARD detection model. Values reflect percentage of completely sequenced genomes, completely sequenced plasmids, whole-genome shotgun assemblies, or genomic islands that have at least one hit to the AMR detection model. The search box can be used to filter results by gene family names (e.g. TEM-), pathogens (e.g. Pseudomonas), or the ARO categories used in the Phenotype table above (e.g. macrolide). Multiple search terms will search for entries containing all given terms. For more complex queries, please [Download](https://card.mcmaster.ca/download) the full data set.

| Gene | Species | Criteria | NCBI Chromosome | NCBI Plasmid | NCBI WGS | NCBI GI | GRDI-AMR2 | Category | Drug Classes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

[ ]