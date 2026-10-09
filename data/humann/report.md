# humann CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| humann_humann | PASS |  |
| humann_humann_barplot | PASS |  |
| humann_humann_build_custom_database | PASS |  |
| humann_humann_expand_cluster | Not completed | needs the HUMAnN utility mapping databases, which are not in the image and must be downloaded |
| humann_humann_genefamilies_genus_level | Failed | tool bug: the script calls dict.iteritems (Python 2 code) and crashes under Python 3 |
| humann_humann_join_tables | PASS |  |
| humann_humann_reduce_table | PASS |  |
| humann_humann_regroup_table | PASS |  |
| humann_humann_rename_table | PASS |  |
| humann_humann_renorm_table | PASS |  |
| humann_humann_split_stratified_table | PASS |  |
| humann_humann_split_table | PASS |  |
| humann_humann_unpack_pathways | PASS |  |

## humann_humann_barplot

### Tool Description
HUMAnN utility for plotting a single stratified feature

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_barplot [-h] [-i <path>] [-l <row>] -f <id> [-o <path.ext>]
                      [--top-taxa <int>] [--as-genera]
                      [--exclude-unclassified] [--remove-zeros]
                      [--sort <sorting methods> [<sorting methods> ...]]
                      [--taxa-colormap <named colormap OR colormap file>]
                      [--write-taxa-colors <path>] [-m <name>]
                      [--max-metalevels <int>]
                      [--meta-colormap <named colormap OR colormap file>]
                      [--scaling <choice>] [--ylims <limit> <limit>]
                      [--no-grid] [--dimensions <float> <float>]
                      [--units <text>] [--legend-cols <int>]
                      [--legend-rows <int>] [--legend-height <float>]
                      [--sample-order <path>] [--write-sample-order <path>]

=====================================================================================
HUMAnN utility for plotting a single stratified feature
=====================================================================================

Plots the taxon-stratified contributions of a specified function. Can optionally sort
samples to reveal ecological- or metadata-linked trends. Can perform custom scaling
to highlight stratifications even when community totals have high dynamic range.

=====================================================================================

options:
  -h, --help            show this help message and exit
  -i <path>, --input <path>
                        HUMAnN table (.tsv or .biom format) [stdin]
  -l <row>, --last-metadata <row>
                        The name (header) of the last row containing metadata, if any [none]
  -f <id>, --focal-feature <id>
                        Feature ID of interest (give ID not full name) [required]
  -o <path.ext>, --output <path.ext>
                        Where and how to save the figure [humann_barplot.png]

manipulate species contributions:
  --top-taxa <int>      Max taxon stratifications (by grand mean) to highlight [18]
  --as-genera           Collapse species to genera [off]
  --exclude-unclassified
                        Do not include the 'unclassified' taxon [off]
  --remove-zeros        Do not analyze samples with zero sum for this feature [off]
  --sort <sorting methods> [<sorting methods> ...]
                        Sample sorting methods (can use more than one; will evaluate in order)
                        
                        none         : Maintains sample order from input file [default]
                        sum          : Sort on decreasing sum of stratified values
                        dominant     : Sort on samples' greatest taxon stratification
                        braycurtis   : Sort on Bray-Curtis agreement of taxon stratifications, unweighted
                        braycurtis_w : Sort on Bray-Curtis agreement of taxon stratifications, abundance-weighted
                        metadata     : Sort on specified metadata label
                        file         : Apply sorting order read in from a file
                        
  --taxa-colormap <named colormap OR colormap file>
                        Color space for taxa [automatic]
  --write-taxa-colors <path>
                        Write taxa colors to a file for cross-plot consistency [off]

plot sample metadata:
  -m <name>, --focal-metadata <name>
                        Indicate metadata to highlight / group by [none]
  --max-metalevels <int>
                        Keep the most frequent metadata levels and collapse others [7]
  --meta-colormap <named colormap OR colormap file>
                        Color space for metadata levels [automatic]

graphical tweaks:
  --scaling <choice>    Scaling options for total bar heights (taxa are always proportional to height)
                        
                        original : Plot original units [default]
                        logstack : Community totals (stacked bar peaks) are log10-scaled
                        totalsum : Community totals (stacked bar peaks) are fixed at 1.0
                        
  --ylims <limit> <limit>
                        Fix limits for y-axis [automatic]
  --no-grid             Don't plot y-axis grid lines [on]
  --dimensions <float> <float>
                        Image width and height in inches [11 6]
  --units <text>        Name for y-axis abundance units [generic]

legend layout:
  --legend-cols <int>   Number of legend columns [3]
  --legend-rows <int>   Number of legend rows [10]
  --legend-height <float>
                        Ratio of legend to data axis height [1.0]

read or write sample order:
  --sample-order <path>
                        Read sample order from this file [none]
  --write-sample-order <path>
                        Write sample order to this file [none]
```

## humann_humann_reduce_table

### Tool Description
Reduce table

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_reduce_table [-h] [-v] -i INPUT -o OUTPUT
                           [--function {sum,min,max,mean}]
                           [--sort-by {level,name,value}]

Reduce table

options:
  -h, --help            show this help message and exit
  -v, --verbose         additional output is printed
  -i INPUT, --input INPUT
                        the input table
  -o OUTPUT, --output OUTPUT
                        the output table
  --function {sum,min,max,mean}
                        the function to apply
  --sort-by {level,name,value}
                        sort the output by the selection
```

## humann_humann_genefamilies_genus_level

### Tool Description
Create a genus level gene families file

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_genefamilies_genus_level [-h] -i INPUT -o OUTPUT

Create a genus level gene families file

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the gene families input table
  -o OUTPUT, --output OUTPUT
                        the output table
```

## humann_humann_build_custom_database

### Tool Description
Create a custom database file

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/humann/utilities.py:144: SyntaxWarning: invalid escape sequence '\*'
  if re.search("\*|[A-Za-z=.]+",data[config.sam_read_index]):
/usr/local/lib/python3.12/site-packages/humann/utilities.py:163: SyntaxWarning: invalid escape sequence '\-'
  if re.search("^[0-9E\-.]+$",data[config.gene_table_value_index]):
usage: humann_build_custom_database [-h] -i INPUT -o OUTPUT
                                    [--id-mapping ID_MAPPING]
                                    [--taxonomic-profile TAXONOMIC_PROFILE]
                                    [--format {fasta,diamond}]
                                    [--genus-abundance-threshold GENUS_ABUNDANCE_THRESHOLD]

Create a custom database file

options:
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

## humann_humann_expand_cluster

### Tool Description
HUMAnN utility for expanding clustered table features

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_expand_cluster [-h] -i INPUT -g GENE -o OUTPUT [-v]

HUMAnN utility for expanding clustered table features
=============================================
Given a table of UniRef90 values and a specific UniRef90,
create a table subset that includes all of the UniRef90s
that cluster with the selected UniRef90 in a UniRef50 set.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        UniRef90 gene families table (tsv format)
  -g GENE, --gene GENE  Gene family (UniRef90) of interest
  -o OUTPUT, --output OUTPUT
                        Path for modified output table (tsv format)
  -v, --verbose         Write status information
```

## humann_humann_regroup_table

### Tool Description
HUMAnN utility for regrouping table features

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_regroup_table [-h] [-i INPUT] [-g {uniref90_rxn,uniref50_rxn}]
                            [-c CUSTOM] [-r] [-f {sum,mean}] [-e PRECISION]
                            [-u {Y,N}] [-p {Y,N}] [-o OUTPUT]

HUMAnN utility for regrouping table features
=============================================
Given a table of feature values and a mapping
of groups to component features, produce a 
new table with group values in place of 
feature values.

    
For additional group mapping files, run the following command:
$ humann_databases --download utility_mapping full $DIR
Replacing, $DIR with the directory to download and install the databases.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Original output table (tsv or biom format); default=[TSV/STDIN]
  -g {uniref90_rxn,uniref50_rxn}, --groups {uniref90_rxn,uniref50_rxn}
                        Built-in grouping options
  -c CUSTOM, --custom CUSTOM
                        Custom groups file (.tsv or .tsv.gz format)
  -r, --reversed        Custom groups file is reversed: mapping from features to groups
  -f {sum,mean}, --function {sum,mean}
                        How to combine grouped features; default=sum
  -e PRECISION, --precision PRECISION
                        Decimal places to round to after applying function; default=Don't round
  -u {Y,N}, --ungrouped {Y,N}
                        Include an 'UNGROUPED' group to capture features that did not belong to other groups? default=Y
  -p {Y,N}, --protected {Y,N}
                        Carry through protected features, such as 'UNMAPPED'? default=Y
  -o OUTPUT, --output OUTPUT
                        Path for modified output table; default=STDOUT
```

## humann_humann_join_tables

### Tool Description
Join gene, pathway, or taxonomy tables

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_join_tables [-h] [-v] -i INPUT -o OUTPUT [--file_name FILE_NAME]
                          [-s]

Join gene, pathway, or taxonomy tables

options:
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

## humann_humann_unpack_pathways

### Tool Description
Unpack pathway abundances to show genes included

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_unpack_pathways [-h] --input-genes INPUT_GENES --input-pathways
                              INPUT_PATHWAYS [--gene-mapping GENE_MAPPING]
                              [--pathway-mapping PATHWAY_MAPPING] [-r] -o
                              OUTPUT

Unpack pathway abundances to show genes included

options:
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

## humann_humann_split_table

### Tool Description
Split gene table to input to HUMAnN

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_split_table [-h] [-v] -i INPUT -o OUTPUT
                          [--taxonomy_index TAXONOMY_INDEX]
                          [--taxonomy_level {Kingdom,Phylum,Class,Order,Family,Genus,Species}]

Split gene table to input to HUMAnN

options:
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

## humann_humann_split_stratified_table

### Tool Description
Split stratified table

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_split_stratified_table [-h] -i INPUT -o OUTPUT

Split stratified table

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        the stratified input table (tsv, tsv.gzip, tsv.bzip2, or biom format)
  -o OUTPUT, --output OUTPUT
                        the output folder
```

## humann_humann

### Tool Description
HUMAnN : HMP Unified Metabolic Analysis Network 3

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/humann/utilities.py:144: SyntaxWarning: invalid escape sequence '\*'
  if re.search("\*|[A-Za-z=.]+",data[config.sam_read_index]):
/usr/local/lib/python3.12/site-packages/humann/utilities.py:163: SyntaxWarning: invalid escape sequence '\-'
  if re.search("^[0-9E\-.]+$",data[config.gene_table_value_index]):
/usr/local/lib/python3.12/site-packages/humann/search/prescreen.py:246: SyntaxWarning: invalid escape sequence '\.'
  if ( re.search(species.lower()+"\.", species_file.lower()) or re.search(species.lower()+"_group\.", species_file.lower()) ) and not new_database_file in species_file_list:
/usr/local/lib/python3.12/site-packages/humann/search/prescreen.py:246: SyntaxWarning: invalid escape sequence '\.'
  if ( re.search(species.lower()+"\.", species_file.lower()) or re.search(species.lower()+"_group\.", species_file.lower()) ) and not new_database_file in species_file_list:
/usr/local/lib/python3.12/site-packages/humann/search/nucleotide.py:163: SyntaxWarning: invalid escape sequence '\d'
  match_numbers=re.compile("\d+")
/usr/local/lib/python3.12/site-packages/humann/search/nucleotide.py:164: SyntaxWarning: invalid escape sequence '\D'
  match_non_numbers=re.compile("\D+")
usage: humann [-h] -i <input.fastq> -o <output> [--threads <1>] [--version]
              [-r] [--bypass-nucleotide-index] [--bypass-nucleotide-search]
              [--bypass-prescreen] [--bypass-translated-search]
              [--taxonomic-profile <taxonomic_profile.tsv>]
              [--memory-use {minimum,maximum}]
              [--input-format {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom}]
              [--search-mode {uniref50,uniref90}] [-v]
              [--metaphlan <metaphlan>]
              [--metaphlan-options <metaphlan_options>]
              [--prescreen-threshold <0.01>] [--bowtie2 <bowtie2>]
              [--bowtie-options <bowtie_options>]
              [--nucleotide-database <nucleotide_database>]
              [--nucleotide-identity-threshold <0.0>]
              [--nucleotide-query-coverage-threshold <90.0>]
              [--nucleotide-subject-coverage-threshold <50.0>]
              [--diamond <diamond>] [--diamond-options <diamond_options>]
              [--evalue <1.0>] [--protein-database <protein_database>]
              [--rapsearch <rapsearch>]
              [--translated-alignment {usearch,rapsearch,diamond}]
              [--translated-identity-threshold <Automatically: 50.0 or 80.0, Custom: 0.0-100.0>]
              [--translated-query-coverage-threshold <90.0>]
              [--translated-subject-coverage-threshold <50.0>]
              [--usearch <usearch>] [--gap-fill {on,off}] [--minpath {on,off}]
              [--pathways {metacyc,unipathway}]
              [--pathways-database <pathways_database.tsv>] [--xipe {on,off}]
              [--annotation-gene-index <3>] [--id-mapping <id_mapping.tsv>]
              [--remove-temp-output]
              [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
              [--o-log <sample.log>] [--output-basename <sample_name>]
              [--output-format {tsv,biom}] [--output-max-decimals <10>]
              [--remove-column-description-output]
              [--remove-stratified-output]

HUMAnN : HMP Unified Metabolic Analysis Network 3

options:
  -h, --help            show this help message and exit

[0] Common settings:
  -i <input.fastq>, --input <input.fastq>
                        input file of type {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom} 
                        [REQUIRED]
  -o <output>, --output <output>
                        directory to write output files
                        [REQUIRED]
  --threads <1>         number of threads/processes
                        [DEFAULT: 1]
  --version             show program's version number and exit

[1] Workflow refinement:
  -r, --resume          bypass commands if the output files exist
  --bypass-nucleotide-index
                        bypass the nucleotide index step and run on the indexed ChocoPhlAn database
  --bypass-nucleotide-search
                        bypass the nucleotide search steps
  --bypass-prescreen    bypass the prescreen step and run on the full ChocoPhlAn database
  --bypass-translated-search
                        bypass the translated search step
  --taxonomic-profile <taxonomic_profile.tsv>
                        a taxonomic profile (the output file created by metaphlan)
                        [DEFAULT: file will be created]
  --memory-use {minimum,maximum}
                        the amount of memory to use
                        [DEFAULT: minimum]
  --input-format {fastq,fastq.gz,fasta,fasta.gz,sam,bam,blastm8,genetable,biom}
                        the format of the input file
                        [DEFAULT: format identified by software]
  --search-mode {uniref50,uniref90}
                        search for uniref50 or uniref90 gene families
                        [DEFAULT: based on translated database selected]
  -v, --verbose         additional output is printed

[2] Configure tier 1: prescreen:
  --metaphlan <metaphlan>
                        directory containing the MetaPhlAn software
                        [DEFAULT: $PATH]
  --metaphlan-options <metaphlan_options>
                        options to be provided to the MetaPhlAn software
                        [DEFAULT: "-t rel_ab"]
  --prescreen-threshold <0.01>
                        minimum percentage of reads matching a species
                        [DEFAULT: 0.01]

[3] Configure tier 2: nucleotide search:
  --bowtie2 <bowtie2>   directory containing the bowtie2 executable
                        [DEFAULT: $PATH]
  --bowtie-options <bowtie_options>
                        options to be provided to the bowtie software
                        [DEFAULT: "--very-sensitive"]
  --nucleotide-database <nucleotide_database>
                        directory containing the nucleotide database
                        [DEFAULT: /usr/local/lib/python3.12/site-packages/humann/data/chocophlan_DEMO]
  --nucleotide-identity-threshold <0.0>
                        identity threshold for nuclotide alignments
                        [DEFAULT: 0.0]
  --nucleotide-query-coverage-threshold <90.0>
                        query coverage threshold for nucleotide alignments
                        [DEFAULT: 90.0]
  --nucleotide-subject-coverage-threshold <50.0>
                        subject coverage threshold for nucleotide alignments
                        [DEFAULT: 50.0]

[3] Configure tier 2: translated search:
  --diamond <diamond>   directory containing the diamond executable
                        [DEFAULT: $PATH]
  --diamond-options <diamond_options>
                        options to be provided to the diamond software
                        [DEFAULT: "--top 1 --outfmt 6"]
  --evalue <1.0>        the evalue threshold to use with the translated search
                        [DEFAULT: 1.0]
  --protein-database <protein_database>
                        directory containing the protein database
                        [DEFAULT: /usr/local/lib/python3.12/site-packages/humann/data/uniref_DEMO]
  --rapsearch <rapsearch>
                        directory containing the rapsearch executable
                        [DEFAULT: $PATH]
  --translated-alignment {usearch,rapsearch,diamond}
                        software to use for translated alignment
                        [DEFAULT: diamond]
  --translated-identity-threshold <Automatically: 50.0 or 80.0, Custom: 0.0-100.0>
                        identity threshold for translated alignments
                        [DEFAULT: Tuned automatically (based on uniref mode) unless a custom value is specified]
  --translated-query-coverage-threshold <90.0>
                        query coverage threshold for translated alignments
                        [DEFAULT: 90.0]
  --translated-subject-coverage-threshold <50.0>
                        subject coverage threshold for translated alignments
                        [DEFAULT: 50.0]
  --usearch <usearch>   directory containing the usearch executable
                        [DEFAULT: $PATH]

[5] Gene and pathway quantification:
  --gap-fill {on,off}   turn on/off the gap fill computation
                        [DEFAULT: on]
  --minpath {on,off}    turn on/off the minpath computation
                        [DEFAULT: on]
  --pathways {metacyc,unipathway}
                        the database to use for pathway computations
                        [DEFAULT: metacyc]
  --pathways-database <pathways_database.tsv>
                        mapping file (or files, at most two in a comma-delimited list) to use for pathway computations
                        [DEFAULT: metacyc database ]
  --xipe {on,off}       turn on/off the xipe computation
                        [DEFAULT: off]
  --annotation-gene-index <3>
                        the index of the gene in the sequence annotation
                        [DEFAULT: 3]
  --id-mapping <id_mapping.tsv>
                        id mapping file for alignments
                        [DEFAULT: alignment reference used]

[6] More output configuration:
  --remove-temp-output  remove temp output files
                        [DEFAULT: temp files are not removed]
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        level of messages to display in log
                        [DEFAULT: DEBUG]
  --o-log <sample.log>  log file
                        [DEFAULT: temp/sample.log]
  --output-basename <sample_name>
                        the basename for the output files
                        [DEFAULT: input file basename]
  --output-format {tsv,biom}
                        the format of the output files
                        [DEFAULT: tsv]
  --output-max-decimals <10>
                        the number of decimals to output
                        [DEFAULT: 10]
  --remove-column-description-output
                        remove the description in the output column
                        [DEFAULT: output column includes description]
  --remove-stratified-output
                        remove stratification from output
                        [DEFAULT: output is stratified]
```

## humann_humann_rename_table

### Tool Description
HUMAnN utility for renaming table features

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS

### Original Help Text
```text
usage: humann_rename_table [-h] [-i INPUT]
                           [-n {kegg-orthology,kegg-pathway,kegg-module,ec,metacyc-rxn,metacyc-pwy,pfam,eggnog,go,infogo1000,uniref50}]
                           [-c CUSTOM] [-s] [-o OUTPUT]

HUMAnN utility for renaming table features
===========================================

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Original output table (tsv or biom format); default=[TSV/STDIN]
  -n {kegg-orthology,kegg-pathway,kegg-module,ec,metacyc-rxn,metacyc-pwy,pfam,eggnog,go,infogo1000,uniref50}, --names {kegg-orthology,kegg-pathway,kegg-module,ec,metacyc-rxn,metacyc-pwy,pfam,eggnog,go,infogo1000,uniref50}
                        Table features that can be renamed with included data files
  -c CUSTOM, --custom CUSTOM
                        Custom mapping of feature IDs to full names (.tsv or .tsv.gz)
  -s, --simplify        Remove non-alphanumeric characters from names
  -o OUTPUT, --output OUTPUT
                        Path for modified output table; default=[STDOUT]
```

## Metadata
- **Skill**: generated

## humann_humann_renorm_table

### Tool Description
Renormalize a HUMAnN table to relative abundance or copies per million (CPM) units.

### Metadata
- **Docker Image**: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/humann
- **Package**: https://anaconda.org/channels/bioconda/packages/humann/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/humann:3.9--py312hdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1502521354: no space left on device
```
