# pyfba CWL Generation Report

## pyfba_fba

### Tool Description
Run Flux Balance Analysis and calculate reaction fluxes

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Total Downloads**: 16.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linsalrob/PyFBA
- **Stars**: N/A
### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -m MEDIA [-t TYPE] [-b BIOMASS] [-v]

Run Flux Balance Analysis and calculate reaction fluxes

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        A list of the reactions in this model, one per line
  -m MEDIA, --media MEDIA
                        media name
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -b BIOMASS, --biomass BIOMASS
                        biomass equation to use. Default is the same as --type
                        option
  -v, --verbose         verbose output
```


## pyfba_fluxes

### Tool Description
Run Flux Balance Analysis and calculate reaction fluxes

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -o OUTPUT -m MEDIA [-t TYPE] [-b BIOMASS] [-v]

Run Flux Balance Analysis and calculate reaction fluxes

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        A list of the reactions in this model, one per line
  -o OUTPUT, --output OUTPUT
                        file to save the fluxes list to
  -m MEDIA, --media MEDIA
                        media name
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -b BIOMASS, --biomass BIOMASS
                        biomass equation to use. Default is the same as --type
                        option
  -v, --verbose         verbose output
```


## pyfba_to_reactions

### Tool Description
Convert a set of functions or roles to a list of reactions

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] (-r ROLES | -a ASSIGNED_FUNCTIONS | -f FEATURES) -o OUTPUT
             [-t TYPE] [-v]

Convert a set of functions or roles to a list of reactions

optional arguments:
  -h, --help            show this help message and exit
  -r ROLES, --roles ROLES
                        A list of functional roles in this genome, one per
                        line
  -a ASSIGNED_FUNCTIONS, --assigned_functions ASSIGNED_FUNCTIONS
                        RAST assigned functions role (tab separated
                        PEG/Functional Role)
  -f FEATURES, --features FEATURES
                        PATRIC features.txt file (with 5 columns)
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_gapfill_roles

### Tool Description
Run Flux Balance Analysis on a set of gapfilled functional roles

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] (-r ROLES | -a ASSIGNED_FUNCTIONS | -f FEATURES) -o OUTPUT
             -m MEDIA [-t TYPE] [-c CLOSE] [-g GENERA] [-v]

Run Flux Balance Analysis on a set of gapfilled functional roles

optional arguments:
  -h, --help            show this help message and exit
  -r ROLES, --roles ROLES
                        A list of functional roles in this genome, one per
                        line
  -a ASSIGNED_FUNCTIONS, --assigned_functions ASSIGNED_FUNCTIONS
                        RAST assigned functions (tab separated PEG/Functional
                        Role)
  -f FEATURES, --features FEATURES
                        PATRIC features.txt file (with 5 columns)
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -m MEDIA, --media MEDIA
                        media name
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -c CLOSE, --close CLOSE
                        a file with roles from close organisms
  -g GENERA, --genera GENERA
                        a file with roles from similar genera
  -v, --verbose         verbose output
```


## pyfba_multiple_media

### Tool Description
Import a list of reactions and then iterate through our gapfilling steps to see when we get growth. You can specify multiple --positive & --negative media conditions

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -o OUTPUT -p POSITIVE [-n NEGATIVE]
             [-f FRACTION] [-c CLOSE_GENOMES] [-t TYPE] [-v]

Import a list of reactions and then iterate through our gapfilling steps to
see when we get growth. You can specify multiple --positive & --negative media
conditions

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        reactions file
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -p POSITIVE, --positive POSITIVE
                        media file(s) on which the organism can grow
  -n NEGATIVE, --negative NEGATIVE
                        media file(s) on which the organism can NOT grow
  -f FRACTION, --fraction FRACTION
                        fraction of growth conditions on which we want growth
                        for success
  -c CLOSE_GENOMES, --close_genomes CLOSE_GENOMES
                        close genomes reactions file. Multiple files are
                        allowed
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_gapfill_two_media

### Tool Description
Import a list of reactions and then iterate through our gapfilling steps to see when we get growth. You can specify a single --growth & --nogrowth media conditions

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -o OUTPUT -g GROWTH [-n NOGROWTH]
             [-c CLOSE_GENOMES] [-t TYPE] [-v]

Import a list of reactions and then iterate through our gapfilling steps to
see when we get growth. You can specify a single --growth & --nogrowth media
conditions

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        reactions file
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -g GROWTH, --growth GROWTH
                        media file on which the organism can grow
  -n NOGROWTH, --nogrowth NOGROWTH
                        media file on which the organism can NOT grow
  -c CLOSE_GENOMES, --close_genomes CLOSE_GENOMES
                        close genomes reactions file. Multiple files are
                        allowed
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_create_gaps

### Tool Description
Import a list of reactions and then iterate through testing eachreaction to see if the model can still grow

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -o OUTPUT -m MEDIA [-t TYPE] [-f FLUX_FRACTION]
             [-l LOG] [-v]

Import a list of reactions and then iterate through testing eachreaction to
see if the model can still grow

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        reactions file
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -m MEDIA, --media MEDIA
                        media name
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -f FLUX_FRACTION, --flux_fraction FLUX_FRACTION
                        Flux fraction to consider grwoth. By default we use
                        any flux but you can set it to e.g. 0.75 of the
                        initial flux
  -l LOG, --log LOG     log file to write the detailed output (optional)
  -v, --verbose         verbose output
```


## pyfba_compare_media

### Tool Description
Import a list of reactions and then compare growth on two media conditions to identify essential/non-essential media

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -r REACTIONS -o OUTPUT -p POSITIVE -n NEGATIVE [-t TYPE]
             [-v]

Import a list of reactions and then compare growth on two media conditions to
identify essential/non-essential media

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        reactions file
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -p POSITIVE, --positive POSITIVE
                        media name where we should grow
  -n NEGATIVE, --negative NEGATIVE
                        media name where we should not grow
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_reactions_to_roles

### Tool Description
Get the roles associated with a file of reactions

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] [-r REACTIONS] -o OUTPUT [-t TYPE] [-v]

Get the roles associated with a file of reactions

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        A list of the reactions you have, one per line
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_reactions_to_aliases

### Tool Description
Get the roles associated with a file of reactions

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] [-r REACTIONS] -o OUTPUT [-t TYPE] [-v]

Get the roles associated with a file of reactions

optional arguments:
  -h, --help            show this help message and exit
  -r REACTIONS, --reactions REACTIONS
                        A list of the reactions you have, one per line
  -o OUTPUT, --output OUTPUT
                        file to save new reaction list to
  -t TYPE, --type TYPE  organism type for the model (currently allowed are
                        ['gramnegative', 'grampositive', 'microbial',
                        'mycobacteria', 'plant']). Default=gramnegative
  -v, --verbose         verbose output
```


## pyfba_media

### Tool Description
List of media components for pyfba

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
ArgonneLB
MOPS_NoC_2-Deoxy-D-Ribose
MOPS_NoC_4-Hydroxy-Phenylacetate
MOPS_NoC_Acetic_Acid
MOPS_NoC_Adenosine
MOPS_NoC_Adonitol
MOPS_NoC_Alpha-D-Glucose
MOPS_NoC_Alpha-D-Lactose
MOPS_NoC_Cellobiose
MOPS_NoC_Citric_Acid
MOPS_NoC_D-Alanine
MOPS_NoC_D-Arabinose
MOPS_NoC_D-Arabitol
MOPS_NoC_D-Asparagine
MOPS_NoC_D-Aspartic_Acid
MOPS_NoC_D-Cysteine
MOPS_NoC_D-Fructose
MOPS_NoC_D-Galactose
MOPS_NoC_D-Glucosamine
MOPS_NoC_D-Glucose-6-phosphate
MOPS_NoC_D-Glucose
MOPS_NoC_D-Glutamic_Acid
MOPS_NoC_D-Mannose
MOPS_NoC_D-Ribose
MOPS_NoC_D-Serine
MOPS_NoC_D-Xylose
MOPS_NoC_Dulcitol
MOPS_NoC_Erythritol
MOPS_NoC_Glycerol
MOPS_NoC_Glycine
MOPS_NoC_Inosine
MOPS_NoC_L-Alanine
MOPS_NoC_L-Arabinose
MOPS_NoC_L-Arabitol
MOPS_NoC_L-Asparagine
MOPS_NoC_L-Aspartic_Acid
MOPS_NoC_L-Cysteic_Acid
MOPS_NoC_L-Cysteine
MOPS_NoC_L-Fucose
MOPS_NoC_L-Glutamic_Acid
MOPS_NoC_L-Glutamine
MOPS_NoC_L-Isoleucine
MOPS_NoC_L-Leucine
MOPS_NoC_L-Lysine
MOPS_NoC_L-Methionine
MOPS_NoC_L-Phenylalanine
MOPS_NoC_L-Pyro-Glutamic_Acid
MOPS_NoC_L-Rhamnose
MOPS_NoC_L-Serine
MOPS_NoC_L-Sorbose
MOPS_NoC_L-Threonine
MOPS_NoC_L-Tryptophan
MOPS_NoC_L-Valine
MOPS_NoC_L-Xylose
MOPS_NoC_Lactic_Acid
MOPS_NoC_Lactulose
MOPS_NoC_Malic_Acid
MOPS_NoC_Melibiose
MOPS_NoC_Myo-Inositol
MOPS_NoC_Negative_Control
MOPS_NoC_Oxalic_Acid
MOPS_NoC_Potassium_Sorbate
MOPS_NoC_Propionate
MOPS_NoC_Putrescine
MOPS_NoC_Pyruvate
MOPS_NoC_Quinate
MOPS_NoC_Raffinose
MOPS_NoC_Salicoside
MOPS_NoC_Succinate
MOPS_NoC_Sucrose
MOPS_NoC_Thymidine
MOPS_NoC_Trehalose
MOPS_NoC_Xylitol
MOPS_NoN_Adenine
MOPS_NoN_Adenosine
MOPS_NoN_Allantoin
MOPS_NoN_Beta-Phenylethylamine
MOPS_NoN_Biuret
MOPS_NoN_Cytidine
MOPS_NoN_Cytosine
MOPS_NoN_D-Methionine
MOPS_NoN_D-Valine
MOPS_NoN_Glycine
MOPS_NoN_Guanidine
MOPS_NoN_Histamine
MOPS_NoN_Inosine
MOPS_NoN_L-Arginine
MOPS_NoN_L-Glutathione
MOPS_NoN_L-Histidine
MOPS_NoN_L-Proline
MOPS_NoN_L-Pyro-Glutamic_Acid
MOPS_NoN_N-Acetyl-D-Glucosamine
MOPS_NoN_Negative_Control
MOPS_NoN_Thiourea
MOPS_NoN_Thymine
MOPS_NoN_Tyramine
MOPS_NoN_Uridine
```


## pyfba_media_compounds

### Tool Description
List the compounds in a media formulation

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pyfba [-h] -m MEDIA [-v]

List the compounds in a media formulation

optional arguments:
  -h, --help            show this help message and exit
  -m MEDIA, --media MEDIA
                        the name of the media
  -v, --verbose         verbose output
```


## pyfba_citations

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
- **Homepage**: https://linsalrob.github.io/PyFBA/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfba/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Thank you for citing PyFBA and the ModelSEED!
The two papers by Cuevas et al. are for PyFBA, and the Henry et al. paper describes the ModelSEED that PyFBA depend 
upon. 
    

Cuevas DA, Garza D, Sanchez SE, Rostron J, Henry CS, Vonstein V, Overbeek RA, Segall A, Rohwer F,  Dinsdale EA, Edwards RA. 2014.
Elucidating genomic gaps using phenotypic profiles. F1000Research. 3:210
doi: 10.12688/f1000research.5140.2
https://f1000research.com/articles/3-210

Cuevas, Daniel A., Janaka Edirisinghe, Chris S. Henry, Ross Overbeek, Taylor G. O’Connell, and Robert A. Edwards. 2016.
From DNA to FBA: How to Build Your Own Genome-Scale Metabolic Model.
Frontiers in Microbiology 7 (June): 907.
http://journal.frontiersin.org/article/10.3389/fmicb.2016.00907/full

Henry CS, DeJongh M, Best AA, Frybarger PM, Linsay B, Stevens RL. 2010. 
High-throughput generation, optimization and analysis of genome-scale metabolic models. 
Nat Biotechnol 28:977–982.
https://www.nature.com/articles/nbt.1672
    
Additionally, we use these resources, so please cite them:
conda-forge:

conda-forge community. (2015). 
The conda-forge Project: Community-based Software Distribution Built on the conda Package Format and Ecosystem. 
Zenodo. http://doi.org/10.5281/zenodo.4774216
```

