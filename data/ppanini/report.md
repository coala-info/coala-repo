# ppanini CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ppanini | PASS | Ran on the package's own demo abundance table; priority table is correct (the tool crashes visibly with --basename or a #NICHE line, a tool bug). |
| ppanini_barplot | PASS | Made the characterization bar plot (PDF, PNG, SVGZ) and table from the demo ppanini input and output tables. |
| ppanini_cluster2genes | PASS | Converted a CD-HIT cluster file (made from the real demo proteins) into a 986-cluster gene map; the two-gene cluster is listed correctly. |
| ppanini_gene_caller | Not completed | needs the large UniRef90 database plus contigs and reads; not available here. |
| ppanini_infer_gene | Not completed | needs DIAMOND hits against UniRef90 with query and subject lengths; no real hits table available. |
| ppanini_join_tables | Not completed | needs a folder of real per-sample gene tables from ppanini_gene_caller; none available. |
| ppanini_press | Not completed | needs ppanini_gene_caller outputs for several samples (UniRef90 hits); no real input available. |
| ppanini_rename_contigs | PASS | Prefixed all 998 headers of the package's demo FASTA with the sample name. |
| ppanini_rocplot | Not completed | needs essential-gene lists and per-niche genome tables from the paper data; not available. |
| ppanini_scatterplot | Not completed | needs a gene-to-genome DIAMOND mapping file from the paper data; not available. |

## ppanini

### Tool Description
ppanini

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ppanini [-h] -i INPUT_TABLE [-o OUTPUT_FOLDER] [--basename BASENAME]
               [--uniref2go UNIREF2GO] [--log-level LOG_LEVEL]
               [--abundance-detection-level ABUNDANCE_DETECTION_LEVEL]
               [--tshld-abund TSHLD_ABUND] [--tshld-prev TSHLD_PREV]
               [--beta BETA] [--version]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_TABLE, --input_table INPUT_TABLE
                        REQUIRED: Gene abundance table with metadata
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Folder containing results
  --basename BASENAME   BASENAME for all the output files
  --uniref2go UNIREF2GO
                        uniref to GO term mapping file
  --log-level LOG_LEVEL
                        Choices: [DEBUG, INFO, WARNING, ERROR, CRITICAL]
  --abundance-detection-level ABUNDANCE_DETECTION_LEVEL
                        Detection level of normalized relative abundance
  --tshld-abund TSHLD_ABUND
                        [X] Percentile Cutoff for Abundance; Default=75th
  --tshld-prev TSHLD_PREV
                        Percentile cutoff for Prevalence
  --beta BETA           Beta parameter for weights on percentiles
  --version             prints the version
```


## ppanini_barplot

### Tool Description
PPANINI plotting tool: stacked bar plot of the characterization of gene families per sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_barplot [-h] [-i1 <input table>] [-i2 <input table>]
                       [--summary-table SUMMARY_TABLE]
                       [--scale {abundance,counts}] [-o <feature id>]

PPANINI plotting tool

optional arguments:
  -h, --help            show this help message and exit
  -i1 <input table>, --ppanini-input <input table>
                        Gene abundance table
  -i2 <input table>, --ppanini-output <input table>
                        PPANINI output table
  --summary-table SUMMARY_TABLE
                        Summary table
  --scale {abundance,counts}
                        Scale: abundance or counts [default: abundance]
  -o <feature id>, --output <feature id>
                        output plot)
```

## ppanini_cluster2genes

### Tool Description
Make a map table from a CD-HIT cluster output.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_cluster2genes [-h] [-i CD_HIT] -o OUTPUT [--json]

optional arguments:
  -h, --help            show this help message and exit
  -i CD_HIT, --cd-hit CD_HIT
                        CD-HIT clusters output
  -o OUTPUT, --output OUTPUT
  --json
```

## ppanini_gene_caller

### Tool Description
PPANINI gene caller.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_gene_caller [-h] -i CONTIG -f FASTQ -o OUTPUT
                           [--output-basename <sample_name>] -u UNIREF [-r]
                           [--threads <1>] [--one-contig]

PPANINI gene caller

optional arguments:
  -h, --help            show this help message and exit
  -i CONTIG, --contig CONTIG
                        contigs file (fna)
  -f FASTQ, --fastq FASTQ
                        reads file (fastq)
  -o OUTPUT, --output OUTPUT
                        Path for outputs
  --output-basename <sample_name>
                        the basename for the output files
                        [DEFAULT: input file basename]
  -u UNIREF, --uniref UNIREF
                        UniRe90 database
  -r, --resume          bypass commands if the output files exist
  --threads <1>         number of threads/processes
                        [DEFAULT: 1]
  --one-contig          If there is only one contig file for all samples, then this option should be provided
```

## ppanini_infer_gene

### Tool Description
Infer genes with a sufficient UniRef90 map from alignment hits.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_infer_gene [-h] --output OUTPUT --min-percid MIN_PERCID
                          --min-qcover MIN_QCOVER --min-scover MIN_SCOVER
                          [--all-valid-hits]
                          hits

positional arguments:
  hits

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT
  --min-percid MIN_PERCID
  --min-qcover MIN_QCOVER
  --min-scover MIN_SCOVER
  --all-valid-hits
```

## ppanini_join_tables

### Tool Description
Join gene, pathway, or taxonomy tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_join_tables [-h] [-v] -i INPUT -o OUTPUT
                           [--file_name FILE_NAME] [-s]
                           [--mapping-uniref MAPPING_UNIREF]
                           [--mapping-cluster MAPPING_CLUSTER] [-r]
                           [--scale {rpk,count}]

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
  --mapping-uniref MAPPING_UNIREF
                        Mapping file: gene to uniref90 file
  --mapping-cluster MAPPING_CLUSTER
                        Mapping file: cluster to genes file
  -r, --resume          bypass commands if the output files exist
  --scale {rpk,count}   scale the abundance table
```

## ppanini_press

### Tool Description
PPANINI Press: clusters genes to gene families.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_press [-h] -i GENE_PATH -o OUTPUT [-r] [--threads THREADS]
                     [--scale {rpk,count}] [--memory CD_HIT_MEMORY]

PPANINI Press: clusters genes to gene families including annotated genes to UniRef90 and homology-based clustered genes.

optional arguments:
  -h, --help            show this help message and exit
  -i GENE_PATH, --gene-path GENE_PATH
                        a directory path to ppanini_gene_caller outputs which includes txt, gff, and faa files for each sample.
  -o OUTPUT, --output OUTPUT
                        Path for outputs
  -r, --resume          bypass commands if the output files exist
  --threads THREADS     number of threads/processes
                        [DEFAULT: 1]
  --scale {rpk,count}   scale the abundance table
  --memory CD_HIT_MEMORY
                        memory for -M option in CD-Hit
```

## ppanini_rename_contigs

### Tool Description
Prefix every FASTA header with the sample name.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_rename_contigs [-h] [-i INPUT] [-o OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        fasta file
  -o OUTPUT, --output OUTPUT
                        fasta file
```

## ppanini_rocplot

### Tool Description
PPANINI plotting tool: ROC curves for known essential genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_rocplot [-h] [-i <input table>] [-e1 <feature id>]
                       [-e2 <feature id>] [--master-plot]
                       [--plot-metagenomics] [--plot-genomics] [--path PATH]
                       [--outfile OUTFILE] [--beta BETA] [--size SIZE]
                       [--output OUTPUT] [--niche NICHE]

PPANINI plotting tool

optional arguments:
  -h, --help            show this help message and exit
  -i <input table>, --ppanini-output <input table>
                        PPANINI output table
  -e1 <feature id>, --essential-genes1  <feature id>
                        a list of essential genes)
  -e2 <feature id>, --essential-genes2  <feature id>
                        a list of essential genes)
  --master-plot         plotting master figure of the paper
  --plot-metagenomics   plotting based of metagenomics priority score
  --plot-genomics       plotting based of genomics priority score
  --path PATH           path for inputs and/or outputs
  --outfile OUTFILE     output file
  --beta BETA           beta is a weight of contribution, B * prevelence and (1-B) * abundance
  --size SIZE           size of the plot in inches
  --output OUTPUT       a name or output file
  --niche NICHE         niche name
```

## ppanini_scatterplot

### Tool Description
PPANINI plotting tool: scatter plots of priority scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ppanini_scatterplot [-h] [-i <input table>] [-m8 <feature id>]
                           [--master-plot] [--path PATH] [--outfile OUTFILE]
                           [--size SIZE]

PPANINI plotting tool

optional arguments:
  -h, --help            show this help message and exit
  -i <input table>, --ppanini-output <input table>
                        PPANINI output table
  -m8 <feature id>, --diamond-output  <feature id>
                        a mapping file of gene-metagenom)
  --master-plot         plotting master figure of the paper
  --path PATH           path for inputs and/or outputs
  --outfile OUTFILE     output file
  --size SIZE           size of the plot in inches
```

## Metadata
- **Skill**: generated
