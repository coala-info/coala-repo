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

# FungAMR Mutation Data

From Bédard *et al.* 2025. FungAMR: a comprehensive database for investigating fungal mutations associated with antimicrobial resistance. *Nature Microbiology* [DOI 10.1038/s41564-025-02084-7](https://doi.org/10.1038/s41564-025-02084-7):

*Antimicrobial resistance (AMR) is a global threat, especially in fungal pathogens. To optimize the use of available antifungals, we need rapid detection and monitoring tools that rely on high-quality AMR mutation data. Here we present FungAMR, a resource based on manual curation of 501 published studies on AMR mutations in clinically and agriculturally relevant fungal pathogens resulting in 35,792 entries covering 208 drugs, 246 genes and 95 fungal species. Each entry includes gene, mutation site and drug susceptibility data, with confidence scores indicating the strength of the supporting evidence. Data analysis revealed convergent mechanisms of resistance, indicating some potentially universal resistance mutations and mutations that lead to cross-resistance within and across antifungal classes. We also developed a computational tool, ChroQueTas, that leverages FungAMR to screen fungal genomes for AMR mutations. FungAMR is available as a web-searchable interface within the Comprehensive Antibiotic Resistance Database. These evolving resources promise to facilitate research on antifungal resistance.*

Supplementary Table 1 data reproduced from https://github.com/Landrylab/FungAMR

The FungAMR compendium contains 35,792 carefully curated entries across 208 drugs (including 118 antifungals) for 95 fungal species and includes amino acid substitutions as well as other genomic changes such as copy-number variations (CNVs). Every mutation is classified with the degree of evidence that supports its role in AMR. Additional metadata, including sources for the original data, are available in the [GitHub spreadsheet](https://github.com/Landrylab/FungAMR).

**If you use these data, please cite**: Bédard *et al.* 2025. FungAMR: a comprehensive database for investigating fungal mutations associated with antimicrobial resistance. *Nature Microbiology* [DOI 10.1038/s41564-025-02084-7](https://doi.org/10.1038/s41564-025-02084-7).

**FungAMR is kept up to date**: If you have any new mutations that absent in the database, we'd love to hear from you! You can contact fungamr.db@gmail.com with a completed curation sheet (Supplementary Table 3 or [FungAMR Curation Spreadsheet](https://github.com/Landrylab/FungAMR/blob/main/curation_sheet_FungAMR.xlsx).

**Confidence score**: a positive confidence score denotes mutations reported to confer resistance, while a negative confidence score relates to mutations reported in susceptible strains. A low positive confidence score indicates that the evidence for the contribution of the mutation to resistance is strong, with 1 being the strongest and 8 being the weakest. Similarly for negative scores, the evidence of susceptibility is stronger for -1 than -8. Full details are available at [GitHub](https://github.com/Landrylab/FungAMR). **Ortholog group**: name of a protein orthologous or homologous to the listed protein (for data standardization). **Resistance & Sensitivity evidence**: the lowest positive (resistance) or lowest negative (sensitivity) confidence score assigned to the mutation in the FungAMR database. **Orthologous mutations & residues**: curated group numbers assigned to orthologous positions in different species based on multiple sequence alignments. Orthologous mutations share the same alternate amino acid, whereas orthologous residues can have any amino acid at the position.

| Reference | Gene or Protein name | Species | Drug | Mutation | Confidence score | Ortholog group | Resistance evidence | Sensitivity evidence | Orthologous mutation group | Orthologous residues group |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |