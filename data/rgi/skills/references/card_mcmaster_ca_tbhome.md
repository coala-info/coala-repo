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

# *Mycobacterium tuberculosis* Mutation Data

Resistance in *Mycobacterium tuberculosis* is almost exclusively SNVs. Unlike other organisms, culture and antibiotic susceptibility testing for TB is very challenging. The TB community instead developed a likelihood framework, based on statistical association of SNVs with observed phenotypic resistance across a large number of sequenced genomes, organized as mutation catalogs. It is important to note that each catalog may recycle data from earlier catalogs. These data have also been incorporated into CARD, the Antibiotic Resistance Ontology (ARO), and CARD's Resistance Gene Identifier (RGI) software. Curator Acknowledgements: Brian Alcock, Monica Warner, Karyn Mukiri, Sidrah Shaikh, Nilasha Mohan.

Collated TB Mutations

**PubMed**: mutation data hand curated from the scientific literature, evaluated as conferring resistance (R). **CRyPTIC**: mutation data acquired from the [CRyPTIC catalog](/ontology/47971), evaluated as resistant (R), susceptible (S), or undetermined (U). **ReSeqTB**: mutation data acquired from the [ReSeqTB catalog](/ontology/47970), evaluated as conferring resistance (Minimal, Moderate, High), not conferring resistance (None), or Indeterminate. **WHO**: mutation data acquired from the [WHO 2023 catalog](/ontology/47972), evaluated as resistant (R), susceptible (S), or undetermined (U).

| Gene | Mutation | Mutation type | PubMed | ReSeqTB | CRyPTIC | WHO | Mutation position |
| --- | --- | --- | --- | --- | --- | --- | --- |