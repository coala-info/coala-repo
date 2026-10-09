# humann2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| humann2_humann2 | PASS |  |
| humann2_humann2_barplot | PASS |  |
| humann2_humann2_build_custom_database | PASS |  |
| humann2_humann2_genefamilies_genus_level | PASS |  |
| humann2_humann2_join_tables | PASS |  |
| humann2_humann2_reduce_table | PASS |  |
| humann2_humann2_regroup_table | PASS |  |
| humann2_humann2_rename_table | PASS |  |
| humann2_humann2_renorm_table | PASS |  |
| humann2_humann2_rna_dna_norm | PASS |  |
| humann2_humann2_split_stratified_table | PASS |  |
| humann2_humann2_split_table | PASS |  |
| humann2_humann2_strain_profiler | PASS |  |
| humann2_humann2_unpack_pathways | PASS |  |

## humann2_humann2_join_tables

### Tool Description
Join gene, pathway, or taxonomy tables

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_join_tables [-h] [-v] -i INPUT -o OUTPUT
                           [--file_name FILE_NAME] [-s]

Join gene, pathway, or taxonomy tables

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         additional output is printed
  -i INPUT, --input INPUT
                        the directory of tables
  -o OUTPUT, --output OUTPUT
                        the table to write
  --file_name FILE_NAME
                        only join tables with this string included in the file name
  -s, --search-subdirectories
                        search sub-directories of input folder for files
```

## humann2_humann2_unpack_pathways

### Tool Description
Unpack pathway abundances to show genes included

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_unpack_pathways [-h] --input-genes INPUT_GENES --input-pathways
                               INPUT_PATHWAYS [--gene-mapping GENE_MAPPING]
                               [--pathway-mapping PATHWAY_MAPPING] [-r] -o
                               OUTPUT

Unpack pathway abundances to show genes included

optional arguments:
  -h, --help            show this help message and exit
  --input-genes INPUT_GENES
                        the gene family or EC abundance file
  --input-pathways INPUT_PATHWAYS
                        the pathway abundance file
  --gene-mapping GENE_MAPPING
                        gene family to reaction mapping file
  --pathway-mapping PATHWAY_MAPPING
                        reaction to pathway mapping file
  -r, --remove-taxonomy
                        remove the taxonomy from the output file
  -o OUTPUT, --output OUTPUT
                        the table to write
```

## humann2_humann2

### Tool Description
HUMAnN2 : HMP Unified Metabolic Analysis Network 2

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2 [-h] [--version] [-v] [-r] [--bypass-prescreen]
               [--bypass-nucleotide-index] [--bypass-translated-search]
               [--bypass-nucleotide-search] -i <input.fastq> -o <output>
               [--nucleotide-database <nucleotide_database>]
               [--annotation-gene-index <8>]
               [--protein-database <protein_database>] [--evalue <1.0>]
               [--search-mode {uniref50,uniref90}] [--metaphlan <metaphlan>]
               [--metaphlan-options <metaphlan_options>]
               [--o-log <sample.log>]
               [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
               [--remove-temp-output] [--threads <1>]
               [--prescreen-threshold <0.01>] [--identity-threshold <50.0>]
               [--translated-subject-coverage-threshold <50.0>]
               [--translated-query-coverage-threshold <90.0>]
               [--bowtie2 <bowtie2>] [--usearch <usearch>]
               [--rapsearch <rapsearch>] [--diamond <diamond>]
               [--taxonomic-profile <taxonomic_profile.tsv>]
               [--id-mapping <id_mapping.tsv>]
               [--translated-alignment {usearch,rapsearch,diamond}]
               [--xipe {on,off}] [--minpath {on,off}] [--pick-frames {on,off}]
               [--gap-fill {on,off}] [--output-format {tsv,biom}]
               [--output-max-decimals <10>] [--output-basename <sample_name>]
               [--remove-stratified-output]
               [--remove-column-description-output]
               [--input-format {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom}]
               [--pathways-database <pathways_database.tsv>]
               [--pathways {metacyc,unipathway}]
               [--memory-use {minimum,maximum}]

HUMAnN2 : HMP Unified Metabolic Analysis Network 2

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -v, --verbose         additional output is printed
  -r, --resume          bypass commands if the output files exist
  --bypass-prescreen    bypass the prescreen step and run on the full ChocoPhlAn database
  --bypass-nucleotide-index
                        bypass the nucleotide index step and run on the indexed ChocoPhlAn database
  --bypass-translated-search
                        bypass the translated search step
  --bypass-nucleotide-search
                        bypass the nucleotide search steps
  -i <input.fastq>, --input <input.fastq>
                        input file of type {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom} 
                        [REQUIRED]
  -o <output>, --output <output>
                        directory to write output files
                        [REQUIRED]
  --nucleotide-database <nucleotide_database>
                        directory containing the nucleotide database
                        [DEFAULT: /usr/local/lib/python2.7/site-packages/humann2/data/chocophlan_DEMO]
  --annotation-gene-index <8>
                        the index of the gene in the sequence annotation
                        [DEFAULT: 8]
  --protein-database <protein_database>
                        directory containing the protein database
                        [DEFAULT: /usr/local/lib/python2.7/site-packages/humann2/data/uniref_DEMO]
  --evalue <1.0>        the evalue threshold to use with the translated search
                        [DEFAULT: 1.0]
  --search-mode {uniref50,uniref90}
                        search for uniref50 or uniref90 gene families
                        [DEFAULT: based on translated database selected]
  --metaphlan <metaphlan>
                        directory containing the MetaPhlAn software
                        [DEFAULT: $PATH]
  --metaphlan-options <metaphlan_options>
                        options to be provided to the MetaPhlAn software
                        [DEFAULT: "-t rel_ab"]
  --o-log <sample.log>  log file
                        [DEFAULT: temp/sample.log]
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        level of messages to display in log
                        [DEFAULT: DEBUG]
  --remove-temp-output  remove temp output files
                        [DEFAULT: temp files are not removed]
  --threads <1>         number of threads/processes
                        [DEFAULT: 1]
  --prescreen-threshold <0.01>
                        minimum percentage of reads matching a species
                        [DEFAULT: 0.01]
  --identity-threshold <50.0>
                        identity threshold for alignments
                        [DEFAULT: 50.0]
  --translated-subject-coverage-threshold <50.0>
                        subject coverage threshold for translated alignments
                        [DEFAULT: 50.0]
  --translated-query-coverage-threshold <90.0>
                        query coverage threshold for translated alignments
                        [DEFAULT: 90.0]
  --bowtie2 <bowtie2>   directory containing the bowtie2 executable
                        [DEFAULT: $PATH]
  --usearch <usearch>   directory containing the usearch executable
                        [DEFAULT: $PATH]
  --rapsearch <rapsearch>
                        directory containing the rapsearch executable
                        [DEFAULT: $PATH]
  --diamond <diamond>   directory containing the diamond executable
                        [DEFAULT: $PATH]
  --taxonomic-profile <taxonomic_profile.tsv>
                        a taxonomic profile (the output file created by metaphlan)
                        [DEFAULT: file will be created]
  --id-mapping <id_mapping.tsv>
                        id mapping file for alignments
                        [DEFAULT: alignment reference used]
  --translated-alignment {usearch,rapsearch,diamond}
                        software to use for translated alignment
                        [DEFAULT: diamond]
  --xipe {on,off}       turn on/off the xipe computation
                        [DEFAULT: off]
  --minpath {on,off}    turn on/off the minpath computation
                        [DEFAULT: on]
  --pick-frames {on,off}
                        turn on/off the pick_frames computation
                        [DEFAULT: off]
  --gap-fill {on,off}   turn on/off the gap fill computation
                        [DEFAULT: on]
  --output-format {tsv,biom}
                        the format of the output files
                        [DEFAULT: tsv]
  --output-max-decimals <10>
                        the number of decimals to output
                        [DEFAULT: 10]
  --output-basename <sample_name>
                        the basename for the output files
                        [DEFAULT: input file basename]
  --remove-stratified-output
                        remove stratification from output
                        [DEFAULT: output is stratified]
  --remove-column-description-output
                        remove the description in the output column
                        [DEFAULT: output column includes description]
  --input-format {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom}
                        the format of the input file
                        [DEFAULT: format identified by software]
  --pathways-database <pathways_database.tsv>
                        mapping file (or files, at most two in a comma-delimited list) to use for pathway computations
                        [DEFAULT: metacyc database ]
  --pathways {metacyc,unipathway}
                        the database to use for pathway computations
                        [DEFAULT: metacyc]
  --memory-use {minimum,maximum}
                        the amount of memory to use
                        [DEFAULT: minimum]
```

## humann2_humann2_rna_dna_norm

### Tool Description
HUMAnN2 utility for normalizing combined meta'omic sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_rna_dna_norm [-h] [-d INPUT_DNA] [-r INPUT_RNA]
                            [-o OUTPUT_BASENAME] [-m {laplace,witten_bell}]
                            [-l] [-b LOG_BASE]

HUMAnN2 utility for normalizing combined meta'omic sequencing data
==================================================================
Given a DNA table and a RNA table, produce smoothed RNA and DNA 
values as well as relative expression values. "Smoothing" means
substituting a small value in place of a zero or missing value.
The default method used is "Laplace" (pseudocount) scaling, where
the pseudocount is the sample-specific minimum non-zero value.
(Witten-Bell smoothing is also implemented.)

-- The DNA and RNA columns must be 1:1 and in the same order.

-- If working with stratified data, smoothing is carried out on the
stratified values and then community totals are recomputed.

optional arguments:
  -h, --help            show this help message and exit
  -d INPUT_DNA, --input_dna INPUT_DNA
                        Original DNA output table (tsv or biom format)
  -r INPUT_RNA, --input_rna INPUT_RNA
                        Original RNA output table (tsv or biom format)
  -o OUTPUT_BASENAME, --output_basename OUTPUT_BASENAME
                        Path/basename for the three output tables; DEFAULT=results
  -m {laplace,witten_bell}, --method {laplace,witten_bell}
                        Choice of smoothing method; DEFAULT=laplace
  -l, --log_transform   Report log-transformed relative expression values
  -b LOG_BASE, --log_base LOG_BASE
                        Base for log transformation (if requested); DEFAULT=2.
```

## humann2_humann2_split_stratified_table

### Tool Description
Split stratified table

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_split_stratified_table [-h] -i INPUT -o OUTPUT

Split stratified table

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the stratified input table (tsv, tsv.gzip, tsv.bzip2, or biom format)
  -o OUTPUT, --output OUTPUT
                        the output folder
```

## humann2_humann2_strain_profiler

### Tool Description
HUMAnN2 utility for making strain profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_strain_profiler [-h] [-i INPUT] [-m CRITICAL_MEAN]
                               [-n CRITICAL_COUNT] [-p PINTERVAL PINTERVAL]
                               [-s CRITICAL_SAMPLES] [-l LIMIT]

HUMAnN2 utility for making strain profiles
==========================================
Based on the principle of detecting variable 
presence and absence of gene families within a species
that is otherwise well-covered in multiple samples.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Original output table (tsv or biom format); default=[TSV/STDIN]
  -m CRITICAL_MEAN, --critical_mean CRITICAL_MEAN
                        Default mean non-zero gene abundance for inclusion; default=10.0
  -n CRITICAL_COUNT, --critical_count CRITICAL_COUNT
                        Default non-zero number of genes for inclusion; default=500
  -p PINTERVAL PINTERVAL, --pinterval PINTERVAL PINTERVAL
                        Only genes with prevalence in this interval are allowed; default=[1e-10, 1]
  -s CRITICAL_SAMPLES, --critical_samples CRITICAL_SAMPLES
                        Threshold number of samples having strain; default=2
  -l LIMIT, --limit LIMIT
                        Limit output to species matching a particular pattern, e.g. 'Streptococcus'; default=OFF
```

## humann2_humann2_genefamilies_genus_level

### Tool Description
Create a genus level gene families file

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_genefamilies_genus_level [-h] -i INPUT -o OUTPUT

Create a genus level gene families file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the gene families input table
  -o OUTPUT, --output OUTPUT
                        the output table
```

## humann2_humann2_build_custom_database

### Tool Description
Create a custom database file

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_build_custom_database [-h] -i INPUT -o OUTPUT
                                     [--id-mapping ID_MAPPING]
                                     [--taxonomic-profile TAXONOMIC_PROFILE]
                                     [--format {fasta,diamond}]
                                     [--genus-abundance-threshold GENUS_ABUNDANCE_THRESHOLD]

Create a custom database file

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the fasta input file
  -o OUTPUT, --output OUTPUT
                        the output folder
  --id-mapping ID_MAPPING
                        the file mapping fasta ids to taxonomy
  --taxonomic-profile TAXONOMIC_PROFILE
                        the file containing the taxonomic profile
  --format {fasta,diamond}
                        the final database format
  --genus-abundance-threshold GENUS_ABUNDANCE_THRESHOLD
                        the minimum abundance for a genus to be included in the database
```

## humann2_humann2_reduce_table

### Tool Description
Reduce table

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_reduce_table [-h] [-v] -i INPUT -o OUTPUT
                            [--function {max,sum,mean,min}]
                            [--sort-by {name,value,level}]

Reduce table

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         additional output is printed
  -i INPUT, --input INPUT
                        the input table
  -o OUTPUT, --output OUTPUT
                        the output table
  --function {max,sum,mean,min}
                        the function to apply
  --sort-by {name,value,level}
                        sort the output by the selection
```

## humann2_humann2_rename_table

### Tool Description
HUMAnN2 utility for renaming table features

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_rename_table [-h] [-i INPUT]
                            [-n {infogo1000,metacyc-rxn,kegg-module,ec,go,metacyc-pwy,pfam,eggnog,uniref50,kegg-pathway,kegg-orthology}]
                            [-c CUSTOM] [-s] [-o OUTPUT]

HUMAnN2 utility for renaming table features
===========================================

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Original output table (tsv or biom format); default=[TSV/STDIN]
  -n {infogo1000,metacyc-rxn,kegg-module,ec,go,metacyc-pwy,pfam,eggnog,uniref50,kegg-pathway,kegg-orthology}, --names {infogo1000,metacyc-rxn,kegg-module,ec,go,metacyc-pwy,pfam,eggnog,uniref50,kegg-pathway,kegg-orthology}
                        Table features that can be renamed with included data files
  -c CUSTOM, --custom CUSTOM
                        Custom mapping of feature IDs to full names (.tsv or .tsv.gz)
  -s, --simplify        Remove non-alphanumeric characters from names
  -o OUTPUT, --output OUTPUT
                        Path for modified output table; default=[STDOUT]
```

## humann2_humann2_barplot

### Tool Description
HUMAnN2 plotting tool

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_barplot [-h] -i <input table> [-f <feature id>] [-t <int>]
                       [-s <sorting methods> [<sorting methods> ...]]
                       [-l <feature>] [-m <feature>] [-c <colormap>]
                       [-k <colormap>] [-x] [-o <file.ext>] [-a <choice>] [-g]
                       [-r] [-z] [-w <int>] [-d <size> <size>]
                       [-y <limit> <limit>] [-e]

HUMAnN2 plotting tool

optional arguments:
  -h, --help            show this help message and exit
  -i <input table>, --input <input table>
                        HUMAnN2 table with optional metadata
  -f <feature id>, --focal-feature <feature id>
                        Feature ID of interest (give ID not full name)
  -t <int>, --top-strata <int>
                        Number of top stratifications to highlight (top = highest grand means)
  -s <sorting methods> [<sorting methods> ...], --sort <sorting methods> [<sorting methods> ...]
                        Sample sorting methods (can use more than one; will evaluate in order)
                        
                        none        : Default
                        sum         : Sum of stratified values
                        dominant    : Value of the most dominant stratification
                        similarity  : Bray-Curtis agreement of relative stratifications
                        usimilarity : Bray-Curtis agreement of raw stratifications
                        metadata    : Given metadata label
                        
  -l <feature>, --last-metadatum <feature>
                        Indicate end of metadata rows
  -m <feature>, --focal-metadatum <feature>
                        Indicate metadatum to highlight / group by
  -c <colormap>, --colormap <colormap>
                        Color space for stratifications
  -k <colormap>, --meta-colormap <colormap>
                        Color space for metadata levels
  -x, --exclude-unclassified
                        Do not include the 'unclassified' stratum
  -o <file.ext>, --output <file.ext>
                        Where to save the figure
  -a <choice>, --scaling <choice>
                        Scaling options for total bar heights (strata are always proportional to height)
                        
                        none        : Default
                        pseudolog   : Total bar heights log-scaled (strata are NOT log scaled)
                        normalize   : Bars all have height=1 (highlighting relative attribution)
                        
  -g, --as-genera       Collapse species to genera
  -r, --grid            Add y-axis grid
  -z, --remove-zeroes   Do not plot samples with zero sum for this feature
  -w <int>, --width <int>
                        Relative width of the plot vs. legend (default: 5)
  -d <size> <size>, --dimensions <size> <size>
                        Image height and width in inches (default: 8 4)
  -y <limit> <limit>, --ylims <limit> <limit>
                        Fix limits for y-axis
  -e , --legend-stretch 
                        Stretch/compress legend elements
```

## humann2_humann2_split_table

### Tool Description
Split gene table to input to HUMAnN

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann2_split_table [-h] [-v] -i INPUT -o OUTPUT
                           [--taxonomy_index TAXONOMY_INDEX]
                           [--taxonomy_level {Kingdom,Phylum,Class,Order,Family,Genus,Species}]

Split gene table to input to HUMAnN2

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         additional output is printed
  -i INPUT, --input INPUT
                        the gene table to read
  -o OUTPUT, --output OUTPUT
                        the directory for output files
  --taxonomy_index TAXONOMY_INDEX
                        the index of the gene in the taxonomy data
  --taxonomy_level {Kingdom,Phylum,Class,Order,Family,Genus,Species}
                        the level of taxonomy for the output (if input is from picrust metagenome_contributions.py)
```

## Metadata
- **Skill**: generated

## humann2_humann2_renorm_table

### Tool Description
Renormalize a HUMAnN2 table to relative abundance or other units.

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/humann2:2.8.1--py27_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3439869234: no space left on device
```
## humann2_humann2_regroup_table

### Tool Description
Regroup HUMAnN2 table features (e.g. convert UniRef50 gene families to GO terms or KO groups).

### Metadata
- **Docker Image**: quay.io/biocontainers/humann2:2.8.1--py27_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann2
- **Package**: https://anaconda.org/channels/bioconda/packages/humann2/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/humann2:2.8.1--py27_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1981155305: no space left on device
```
