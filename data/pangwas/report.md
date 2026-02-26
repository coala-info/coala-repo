# pangwas CWL Generation Report

## pangwas_annotate

### Tool Description
Annotate genomic assemblies with bakta.

Takes as input a FASTA file of genomic assemblies. Outputs a GFF file
of annotations, among many other formats from bakta.

All additional arguments with be passed to the `bakta` CLI.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Total Downloads**: 74
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/phac-nml/pangwas
- **Stars**: N/A
### Original Help Text
```text
usage: pangwas annotate [-h] --fasta FASTA --db DB [--outdir OUTDIR]
                        [--prefix PREFIX] [--tmp TMP] [--sample SAMPLE]
                        [--threads THREADS]

Annotate genomic assemblies with bakta.

Takes as input a FASTA file of genomic assemblies. Outputs a GFF file
of annotations, among many other formats from bakta.

All additional arguments with be passed to the `bakta` CLI.

Examples:
> pangwas annotate --fasta sample1.fasta --db database/bakta
> pangwas annotate --fasta sample1.fasta --db database/bakta --sample sample1 --threads 2 --genus Streptococcus

options:
  -h, --help         show this help message and exit

required arguments:
  --fasta FASTA      Input FASTA sequences.
  --db DB            bakta database directory.

optional output arguments:
  --outdir OUTDIR    Output directory. (default: .)
  --prefix PREFIX    Output file prefix. If not provided, will be parsed from the fasta file name.
  --tmp TMP          Temporary directory.

optional arguments:
  --sample SAMPLE    Sample identifier. If not provided, will be parsed from the fasta file name.
  --threads THREADS  CPU threads for bakta. (default: 1)
```


## pangwas_extract

### Tool Description
Extract sequences and annotations from GFF files.

Takes as input a GFF annotations file. If sequences are not included, a FASTA
of genomic contigs must also be provided. Both annotated and unannotated regions 
will be extracted. Outputs a TSV table of extracted sequence regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas extract [-h] --gff GFF [--outdir OUTDIR] [--prefix PREFIX]
                       [--fasta FASTA] [--max-len MAX_LEN] [--min-len MIN_LEN]
                       [--sample SAMPLE] [--regex REGEX]

Extract sequences and annotations from GFF files.

Takes as input a GFF annotations file. If sequences are not included, a FASTA
of genomic contigs must also be provided. Both annotated and unannotated regions 
will be extracted. Outputs a TSV table of extracted sequence regions.

Examples:
> pangwas extract --gff sample1.gff3
> pangwas extract --gff sample1.gff3 --fasta sample1.fasta --min-len 10

options:
  -h, --help         show this help message and exit

required arguments:
  --gff GFF          Input GFF annotations.

optional output arguments:
  --outdir OUTDIR    Output directory. (default: .)
  --prefix PREFIX    Output file prefix. If not provided, will be parsed from the gff file name.

optional arguments:
  --fasta FASTA      Input FASTA sequences, if not provided at the end of the GFF.
  --max-len MAX_LEN  Maximum length of sequences to extract (default: 100000).
  --min-len MIN_LEN  Minimum length of sequences to extract (default: 20).
  --sample SAMPLE    Sample identifier to use. If not provided, is parsed from the gff file name.
  --regex REGEX      Only extract gff lines that match this regular expression.
```


## pangwas_collect

### Tool Description
Collect extracted sequences from multiple samples into one file.

Takes as input multiple TSV files from extract, which can be supplied 
as either space separate paths, or a text file containing paths. 
Duplicate sequence IDs will be identified and given the suffix '.#'.
Outputs concatenated FASTA and TSV files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas collect [-h] (--tsv TSV [TSV ...] | --tsv-paths TSV_PATHS)
                       [--outdir OUTDIR] [--prefix PREFIX]

Collect extracted sequences from multiple samples into one file.

Takes as input multiple TSV files from extract, which can be supplied 
as either space separate paths, or a text file containing paths. 
Duplicate sequence IDs will be identified and given the suffix '.#'.
Outputs concatenated FASTA and TSV files.

Examples:
> pangwas collect --tsv sample1.tsv sample2.tsv sample3.tsv sample4.tsv
> pangwas collect --tsv-paths tsv_paths.txt

options:
  -h, --help            show this help message and exit

required arguments (mutually-exclusive):
  --tsv TSV [TSV ...]   TSV files from the extract subcommand.
  --tsv-paths TSV_PATHS
                        TXT file containing paths to TSV files.

optional output arguments:
  --outdir OUTDIR       Output directory. (default: .)
  --prefix PREFIX       Prefix for output files.
```


## pangwas_cluster

### Tool Description
Cluster nucleotide sequences with mmseqs.

Takes as input a FASTA file of sequences for clustering. Calls MMSeqs2 
to cluster sequences and identify a representative sequence. Outputs a
TSV table of sequence clusters and a FASTA of representative sequences.

Any additional arguments will be passed to `mmseqs cluster`. If no additional
arguments are used, the following default args will apply:
  -k 13 --min-seq-id 0.90 -c 0.90 --cluster-mode 2 --max-seqs 300

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas cluster [-h] -f FASTA [--outdir OUTDIR] [--prefix PREFIX]
                       [--tmp TMP] [--memory MEMORY] [--no-clean]
                       [--threads THREADS]

Cluster nucleotide sequences with mmseqs.

Takes as input a FASTA file of sequences for clustering. Calls MMSeqs2 
to cluster sequences and identify a representative sequence. Outputs a
TSV table of sequence clusters and a FASTA of representative sequences.

Any additional arguments will be passed to `mmseqs cluster`. If no additional
arguments are used, the following default args will apply:
  -k 13 --min-seq-id 0.90 -c 0.90 --cluster-mode 2 --max-seqs 300

Examples:
> pangwas cluster --fasta collect.fasta
> pangwas cluster --fasta collect.fasta --threads 2 -k 13 --min-seq-id 0.90 -c 0.90

options:
  -h, --help            show this help message and exit

required arguments:
  -f FASTA, --fasta FASTA
                        FASTA file of input sequences to cluster.

optional output arguments:
  --outdir OUTDIR       Output directory. (default: .)
  --prefix PREFIX       Prefix for output files.
  --tmp TMP             Tmp directory (default: tmp).

optional arguments:
  --memory MEMORY       Memory limit for mmseqs split. (default: 1G)
  --no-clean            Don't clean up intermediate files.
  --threads THREADS     CPU threads for mmseqs. (default: 1)
```


## pangwas_defrag

### Tool Description
Defrag clusters by associating fragments with their parent cluster.

Takes as input the TSV clusters and FASTA representatives from cluster.
Outputs a new cluster table and representative sequences fasta.

The defrag algorithm is adapted from PPanGGOLiN (v2.2.0) which is  
distributed under the CeCILL FREE SOFTWARE LICENSE AGREEMENT LABGeM.
- Please cite: Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
                PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
- PPanGGOLiN license: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/LICENSE.txt
- Defrag algorithm source: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/ppanggolin/cluster/cluster.py#L317

Any additional arguments will be passed to `mmseqs search`. If no additional
arguments are used, the following default args will apply:
  -k 13 --min-seq-id 0.90 -c 0.90 --cov-mode 1

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas defrag [-h] --clusters CLUSTERS --representative REPRESENTATIVE
                      [--outdir OUTDIR] [--prefix PREFIX] [--tmp TMP]
                      [--memory MEMORY] [--no-clean] [--threads THREADS]

Defrag clusters by associating fragments with their parent cluster.

Takes as input the TSV clusters and FASTA representatives from cluster.
Outputs a new cluster table and representative sequences fasta.

The defrag algorithm is adapted from PPanGGOLiN (v2.2.0) which is  
distributed under the CeCILL FREE SOFTWARE LICENSE AGREEMENT LABGeM.
- Please cite: Gautreau G et al. (2020) PPanGGOLiN: Depicting microbial diversity via a partitioned pangenome graph.
                PLOS Computational Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732
- PPanGGOLiN license: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/LICENSE.txt
- Defrag algorithm source: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/ppanggolin/cluster/cluster.py#L317

Any additional arguments will be passed to `mmseqs search`. If no additional
arguments are used, the following default args will apply:
  -k 13 --min-seq-id 0.90 -c 0.90 --cov-mode 1

Examples:
> pangwas defrag --clusters clusters.tsv --representative representative.fasta --prefix defrag
> pangwas defrag --clusters clusters.tsv --representative representative.fasta --prefix defrag --threads 2 -k 13 --min-seq-id 0.90 -c 0.90

options:
  -h, --help            show this help message and exit

required arguments:
  --clusters CLUSTERS   TSV file of clusters from mmseqs.
  --representative REPRESENTATIVE
                        FASTA file of cluster representative sequences.

optional output arguments:
  --outdir OUTDIR       Output directory. (default: .)
  --prefix PREFIX       Prefix for output files.
  --tmp TMP             Tmp directory (default: tmp).

optional arguments:
  --memory MEMORY       Memory limit for mmseqs split. (default: 2G)
  --no-clean            Don't clean up intermediate files.
  --threads THREADS     CPU threads for mmseqs. (default: 1)
```


## pangwas_summarize

### Tool Description
Summarize clusters according to their annotations.

Takes as input the TSV table from collect, and the clusters table from 
either cluster or defrag. Outputs a TSV table of summarized clusters 
with their annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas summarize [-h] --clusters CLUSTERS --regions REGIONS
                         [--max-product-len MAX_PRODUCT_LEN]
                         [--min-samples MIN_SAMPLES] [--outdir OUTDIR]
                         [--prefix PREFIX] [--threshold THRESHOLD]

Summarize clusters according to their annotations.

Takes as input the TSV table from collect, and the clusters table from 
either cluster or defrag. Outputs a TSV table of summarized clusters 
with their annotations.

Examples:
> pangwas summarize --clusters defrag.clusters.tsv --regions regions.tsv

options:
  -h, --help            show this help message and exit

required arguments:
  --clusters CLUSTERS   TSV file of clusters from cluster or defrag.
  --regions REGIONS     TSV file of sequence regions from collect.

optional arguments:
  --max-product-len MAX_PRODUCT_LEN
                        Truncate the product description to this length if used as an identifie. (default: 50)
  --min-samples MIN_SAMPLES
                        Cluster must be observed in at least this many samples to be summarized.
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.
  --threshold THRESHOLD
                        Required this proportion of samples to have annotations in agreement. (default: 0.5)
```


## pangwas_align

### Tool Description
Align clusters using mafft and create a pangenome alignment.

Takes as input the clusters from summarize and the sequence regions
from collect. Outputs multiple sequence alignments per cluster 
as well as a pangenome alignment of concatenated clusters.

Any additional arguments will be passed to `mafft`. If no additional
arguments are used, the following default args will apply:
  --adjustdirection --localpair --maxiterate 1000 --addfragments

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas align [-h] --clusters CLUSTERS --regions REGIONS
                     [--outdir OUTDIR] [--prefix PREFIX] [--threads THREADS]
                     [--exclude-singletons]

Align clusters using mafft and create a pangenome alignment.

Takes as input the clusters from summarize and the sequence regions
from collect. Outputs multiple sequence alignments per cluster 
as well as a pangenome alignment of concatenated clusters.

Any additional arguments will be passed to `mafft`. If no additional
arguments are used, the following default args will apply:
  --adjustdirection --localpair --maxiterate 1000 --addfragments

Examples:
> pangwas align --clusters clusters.tsv --regions regions.tsv
> pangwas align --clusters clusters.tsv --regions regions.tsv --threads 2 --exclude-singletons --localpair --maxiterate 100

options:
  -h, --help            show this help message and exit

required arguments:
  --clusters CLUSTERS   TSV of clusters from summarize.
  --regions REGIONS     TSV of sequence regions from collect.

optional output arguments:
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.

optional arguments:
  --threads THREADS     CPU threads for running mafft in parallel. (default: 1)
  --exclude-singletons  Exclude clusters found in only 1 sample.
```


## pangwas_structural

### Tool Description
Extract structural variants from cluster alignments.

Takes as input the summarized clusters and their individual alignments.
Outputs an Rtab file of structural variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas structural [-h] --clusters CLUSTERS --alignments ALIGNMENTS
                          [--outdir OUTDIR] [--prefix PREFIX]
                          [--min-len MIN_LEN] [--min-indel-len MIN_INDEL_LEN]

Extract structural variants from cluster alignments.

Takes as input the summarized clusters and their individual alignments.
Outputs an Rtab file of structural variants.

Examples:
> pangwas structural --clusters clusters.tsv --alignments alignments
> pangwas structural --clusters clusters.tsv --alignments alignments --min-len 100 --min-indel-len 10

options:
  -h, --help            show this help message and exit

required arguments:
  --clusters CLUSTERS   TSV of clusters from summarize.
  --alignments ALIGNMENTS
                        Directory of cluster alignments (not consensus alignments!).

optional output arguments:
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.

optional arguments:
  --min-len MIN_LEN     Minimum variant length. (default: 10)
  --min-indel-len MIN_INDEL_LEN
                        Minimum indel length. (default: 3)
```


## pangwas_snps

### Tool Description
Extract SNPs from a pangenome alignment.

Takes as input the pangenome alignment fasta, bed, and consensus file from align.
Outputs an Rtab file of SNPs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas snps [-h] --alignment ALIGNMENT --bed BED --consensus CONSENSUS
                    [--structural STRUCTURAL] [--outdir OUTDIR]
                    [--prefix PREFIX] [--core CORE]
                    [--indel-window INDEL_WINDOW] [--snp-window SNP_WINDOW]

Extract SNPs from a pangenome alignment.

Takes as input the pangenome alignment fasta, bed, and consensus file from align.
Outputs an Rtab file of SNPs.

Examples:
> pangwas snps --alignment pangenome.aln --bed pangenome.bed --consensus pangenome.consensus.fasta
> pangwas snps --alignment pangenome.aln --bed pangenome.bed --consensus pangenome.consensus.fasta --structural structural.Rtab --core 0.90 --indel-window 3 --snp-window 10

options:
  -h, --help            show this help message and exit

required arguments:
  --alignment ALIGNMENT
                        Fasta sequences alignment.
  --bed BED             Bed file of coordinates.
  --consensus CONSENSUS
                        Fasta consensus/representative sequence.

optional but recommended arguments:
  --structural STRUCTURAL
                        Rtab from the structural subcommand, used to avoid treating terminal ends as indels.

optional output arguments:
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.

optional arguments:
  --core CORE           Core threshold for calling core SNPs. (default: 0.95)
  --indel-window INDEL_WINDOW
                        Exclude SNPs that are within this proximity to indels. (default: 0)
  --snp-window SNP_WINDOW
                        Exclude SNPs that are within this proximity to another SNP. (default: 0)
```


## pangwas_presence_absence

### Tool Description
Extract presence absence of clusters.

Takes as input a TSV of summarized clusters from summarize.
Outputs an Rtab file of cluster presence/absence.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas presence_absence [-h] --clusters CLUSTERS [--outdir OUTDIR]
                                [--prefix PREFIX]

Extract presence absence of clusters.

Takes as input a TSV of summarized clusters from summarize.
Outputs an Rtab file of cluster presence/absence.

Examples:
> pangwas presence_absence --clusters clusters.tsv

options:
  -h, --help           show this help message and exit

required arguments:
  --clusters CLUSTERS  TSV of clusters from summarize.

optional output arguments:
  --outdir OUTDIR      Output directory. (default: . )
  --prefix PREFIX      Prefix for output files.
```


## pangwas_tree

### Tool Description
Estimate a maximum-likelihood tree with IQ-TREE.

Takes as input a multiple sequence alignment in FASTA format. If a SNP
alignment is provided, an optional text file of constant sites can be 
included for correction. Outputs a maximum-likelihood tree, as well as 
additional rooted trees if an outgroup is specified in the iqtree args.

Any additional arguments will be passed to `iqtree`. If no additional
arguments are used, the following default args will apply:
-safe -m MFP

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas tree [-h] --alignment ALIGNMENT
                    [--constant-sites CONSTANT_SITES] [--outdir OUTDIR]
                    [--prefix PREFIX] [--threads THREADS]

Estimate a maximum-likelihood tree with IQ-TREE.

Takes as input a multiple sequence alignment in FASTA format. If a SNP
alignment is provided, an optional text file of constant sites can be 
included for correction. Outputs a maximum-likelihood tree, as well as 
additional rooted trees if an outgroup is specified in the iqtree args.

Any additional arguments will be passed to `iqtree`. If no additional
arguments are used, the following default args will apply:
-safe -m MFP

Examples:
> pangwas tree --alignment snps.core.fasta --constant-sites snps.constant_sites.txt
> pangwas tree --alignment pangenome.aln --threads 4 -o sample1 --ufboot 1000

options:
  -h, --help            show this help message and exit

required arguments:
  --alignment ALIGNMENT
                        Multiple sequence alignment.

optional arguments:
  --constant-sites CONSTANT_SITES
                        Text file containing constant sites correction for SNP alignment.
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.
  --threads THREADS     CPU threads for IQTREE. (default: 1)
```


## pangwas_gwas

### Tool Description
Run genome-wide association study (GWAS) tests with pyseer.

Takes as input the TSV file of summarized clusters from summarize, an Rtab file of variants,
a TSV/CSV table of phenotypes, and a column name representing the trait of interest.
Outputs tables of locus effects, and optionally lineage effects (bugwas) if specified.

Any additional arguments will be passed to `pyseer`. If no additional
arguments are used, the following default args will apply:
--lmm

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas gwas [-h] --variants VARIANTS --table TABLE --column COLUMN
                    [--lineage-column LINEAGE_COLUMN] [--no-midpoint]
                    [--tree TREE] [--continuous] [--exclude-missing]
                    [--clusters CLUSTERS] [--outdir OUTDIR] [--prefix PREFIX]
                    [--threads THREADS]

Run genome-wide association study (GWAS) tests with pyseer.

Takes as input the TSV file of summarized clusters from summarize, an Rtab file of variants,
a TSV/CSV table of phenotypes, and a column name representing the trait of interest.
Outputs tables of locus effects, and optionally lineage effects (bugwas) if specified.

Any additional arguments will be passed to `pyseer`. If no additional
arguments are used, the following default args will apply:
--lmm

Examples:
> pangwas gwas --variants combine.Rtab --table samplesheet.csv --column lineage --no-distances
> pangwas gwas --variants combine.Rtab --table samplesheet.csv --column resistant --lmm --tree tree.rooted.nwk --clusters clusters.tsv --lineage-column lineage '

options:
  -h, --help            show this help message and exit

required arguments:
  --variants VARIANTS   Rtab file of variants.
  --table TABLE         TSV or CSV table of phenotypes (variables).
  --column COLUMN       Column name of trait (variable) in table.

optional arguments (bugwas):
  --lineage-column LINEAGE_COLUMN
                        Column name of lineages in table. Enables bugwas lineage effects.

optional arguments (lmm):
  --no-midpoint         Disable midpoint rooting of the tree for the kinship matrix.
  --tree TREE           Newick phylogenetic tree. Not required if pyseer args includes --no-distances.

optional arguments (data):
  --continuous          Treat the column trait as a continuous variable.
  --exclude-missing     Exclude samples missing phenotype data.

optional arguments:
  --clusters CLUSTERS   TSV of clusters from summarize.
  --outdir OUTDIR       Output directory. (default: . )
  --prefix PREFIX       Prefix for output files.
  --threads THREADS     CPU threads for pyseer. (default: 1)
```


## pangwas_manhattan

### Tool Description
Plot the distribution of variant p-values across the genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas manhattan [-h] --bed BED --gwas GWAS
                         [--clusters CLUSTERS [CLUSTERS ...]]
                         [--syntenies SYNTENIES [SYNTENIES ...]]
                         [--variant-types VARIANT_TYPES [VARIANT_TYPES ...]]
                         [--font-size FONT_SIZE] [--font-family FONT_FAMILY]
                         [--height HEIGHT] [--margin MARGIN]
                         [--max-blocks MAX_BLOCKS] [--outdir OUTDIR]
                         [--png-scale PNG_SCALE] [--prefix PREFIX]
                         [--prop-x-axis] [--width WIDTH] [--ymax YMAX]

Plot the distribution of variant p-values across the genome.

Takes as input a table of locus effects from the subcommand and a bed
file such as the one producted by the align subcommand. Outputs a 
manhattan plot in SVG and PNG format.

Examples:
> pangwas manhattan --gwas locus_effects.tsv --bed pangenome.bed
> pangwas manhattan --gwas locus_effects.tsv --bed pangenome.bed --syntenies chromosome --clusters pbpX --variant-types snp presence_absence

options:
  -h, --help            show this help message and exit

required arguments:
  --bed BED             BED file with region coordinates and names.
  --gwas GWAS           TSV table of variants from gwas subcommand.

optional filter arguments:
  --clusters CLUSTERS [CLUSTERS ...]
                        Only plot these clusters. (default: all)
  --syntenies SYNTENIES [SYNTENIES ...]
                        Only plot these synteny blocks. (default: all)
  --variant-types VARIANT_TYPES [VARIANT_TYPES ...]
                        Only plot these variant types. (default: all)

optional arguments:
  --font-size FONT_SIZE
                        Font size of the tree labels. (default: 16)
  --font-family FONT_FAMILY
                        Font family of the tree labels. (default: Roboto)
  --height HEIGHT       Plot height in pixels.
  --margin MARGIN       Margin sizes in pixels. (default: 20)
  --max-blocks MAX_BLOCKS
                        Maximum number of blocks to draw before switching to pangenome coordinates. (default: 20)
  --outdir OUTDIR       Output directory. (default: . )
  --png-scale PNG_SCALE
                        Scaling factor of the PNG file. (default: 2.0)
  --prefix PREFIX       Prefix for output files.
  --prop-x-axis         Make x-axis proporional to genomic length.
  --width WIDTH         Plot width in pixels.
  --ymax YMAX           A -log10 value to use as the y axis max, to synchronize multiple plots.
```


## pangwas_heatmap

### Tool Description
Plot a heatmap of variants alongside a tree.

Takes as input a table of variants and/or a newick tree. The table can be either
an Rtab file, or the locus effects TSV output from the gwas subcommand.
If both a tree and a table are provided, the tree will determine the sample order 
and arrangement. If just a table is provided, sample order will follow the 
order of the sample columns. A TXT of focal sample IDs can also be supplied
with one sample ID per line. Outputs a plot in SVG and PNG format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas heatmap [-h] [--gwas GWAS | --rtab RTAB] [--tree TREE]
                       [--tree-format TREE_FORMAT] [--tree-width TREE_WIDTH]
                       [--root-branch ROOT_BRANCH] [--focal FOCAL]
                       [--font-size FONT_SIZE] [--font-family FONT_FAMILY]
                       [--heatmap-scale HEATMAP_SCALE] [--margin MARGIN]
                       [--min-score MIN_SCORE] [--outdir OUTDIR]
                       [--png-scale PNG_SCALE] [--prefix PREFIX]
                       [--tip-pad TIP_PAD]

Plot a heatmap of variants alongside a tree.

Takes as input a table of variants and/or a newick tree. The table can be either
an Rtab file, or the locus effects TSV output from the gwas subcommand.
If both a tree and a table are provided, the tree will determine the sample order 
and arrangement. If just a table is provided, sample order will follow the 
order of the sample columns. A TXT of focal sample IDs can also be supplied
with one sample ID per line. Outputs a plot in SVG and PNG format.

Examples:
> pangwas heatmap --tree tree.rooted.nwk
> pangwas heatmap --rtab combine.Rtab
> pangwas heatmap --gwas resistant.locus_effects.significant.tsv
> pangwas heatmap --tree tree.rooted.nwk --rtab combine.Rtab --focal focal.txt
> pangwas heatmap --tree tree.rooted.nwk --gwas resistant.locus_effects.significant.tsv
> pangwas heatmap --tree tree.rooted.nwk --tree-width 500 --png-scale 2.0

options:
  -h, --help            show this help message and exit

optional variant arguments (mutually-exclusive):
  --gwas GWAS           TSV table of variants from gwas subcommand.
  --rtab RTAB           Rtab table of variants.

optional tree arguments:
  --tree TREE           Tree file.
  --tree-format TREE_FORMAT
                        Tree format. (default: newick)
  --tree-width TREE_WIDTH
                        Width of the tree in pixels. (default: 200)
  --root-branch ROOT_BRANCH
                        Root branch length in pixels. (default: 10)

optional arguments:
  --focal FOCAL         TXT file of focal samples.
  --font-size FONT_SIZE
                        Font size of the tree labels. (default: 16)
  --font-family FONT_FAMILY
                        Font family of the tree labels. (default: Roboto)
  --heatmap-scale HEATMAP_SCALE
                        Scaling factor of heatmap boxes relative to the text. (default: 1.5)
  --margin MARGIN       Margin sizes in pixels. (default: 20)
  --min-score MIN_SCORE
                        Filter GWAS variants by a minimum score (range: -1.0 to 1.0).
  --outdir OUTDIR       Output directory. (default: . )
  --png-scale PNG_SCALE
                        Scaling factor of the PNG file. (default: 2.0)
  --prefix PREFIX       Prefix for output files.
  --tip-pad TIP_PAD     Tip padding. (default: 10)
```


## pangwas_root_tree

### Tool Description
Root tree on outgroup taxa.

Takes as input a path to a phylogenetic tree and outgroup taxa. This is
a utility script that is meant to fix IQ-TREE's creation of a multifurcated
root node. It will position the root node along the midpoint of the branch
between the outgroup taxa and all other samples. If no outgroup is selected,
the tree will be rooted using the first taxa. Outputs a new tree in the specified
tree format.

Note: This functionality is already included in the tree subcommand.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas root_tree [-h] [--tree TREE] [--outdir OUTDIR]
                         [--outgroup OUTGROUP] [--prefix PREFIX]
                         [--tree-format TREE_FORMAT]

Root tree on outgroup taxa.

Takes as input a path to a phylogenetic tree and outgroup taxa. This is
a utility script that is meant to fix IQ-TREE's creation of a multifurcated
root node. It will position the root node along the midpoint of the branch
between the outgroup taxa and all other samples. If no outgroup is selected,
the tree will be rooted using the first taxa. Outputs a new tree in the specified
tree format.

Note: This functionality is already included in the tree subcommand.

Examples:
> pangwas root_tree --tree tree.treefile
> pangwas root_tree --tree tree.treefile --outgroup sample1
> pangwas root_tree --tree tree.treefile --outgroup sample1,sample4
> pangwas root_tree --tree tree.nex --outgroup sample1 --tree-format nexus

options:
  -h, --help            show this help message and exit

required arguments:
  --tree TREE           Path to phylogenetic tree.

optional arguments:
  --outdir OUTDIR       Output directory. (default: . )
  --outgroup OUTGROUP   Outgroup taxa as CSV string. If not specified, roots on first taxon.
  --prefix PREFIX       Prefix for output files.
  --tree-format TREE_FORMAT
                        Tree format. (default: newick)
```


## pangwas_binarize

### Tool Description
Convert a categorical column to multiple binary (0/1) columns.

Takes as input a table (TSV or CSV) and the name of a column to binarize.
Outputs a new table with separate columns for each categorical value.

Any additional arguments will be passed to `pyseer`.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas binarize [-h] --table TABLE --column COLUMN
                        [--column-prefix COLUMN_PREFIX] [--outdir OUTDIR]
                        [--output-delim OUTPUT_DELIM] [--prefix PREFIX]
                        [--transpose]

Convert a categorical column to multiple binary (0/1) columns.

Takes as input a table (TSV or CSV) and the name of a column to binarize.
Outputs a new table with separate columns for each categorical value.

Any additional arguments will be passed to `pyseer`.

Examples:
  pangwas binarize --table samplesheet.csv --column lineage --output lineage.binarize.csv
  pangwas binarize --table samplesheet.tsv --column outcome --output outcome.binarize.tsv

options:
  -h, --help            show this help message and exit

required arguments:
  --table TABLE         TSV or CSV table.
  --column COLUMN       Column name to binarize.

optional arguments:
  --column-prefix COLUMN_PREFIX
                        Prefix to add to column names.
  --outdir OUTDIR       Output directory. (default: . )
  --output-delim OUTPUT_DELIM
                        Output delimiter. (default: 	 )
  --prefix PREFIX       Prefix for output files
  --transpose           Tranpose output table.
```


## pangwas_table_to_rtab

### Tool Description
Convert a TSV/CSV table to an Rtab file based on regex filters.

Takes as input a TSV/CSV table to convert, and a TSV/CSV of regex filters.
The filter table should have the header: column, regex, name. Where column
is the 'column' to search, 'regex' is the regular expression pattern, and
'name' is how the output variant should be named in the Rtab.

An example `filter.tsv` might look like this:

column    regex         name
assembly  .*sample2.*   sample2
lineage   .*2.*         lineage_2

Where the goal is to filter the assembly and lineage columns for particular values.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas table_to_rtab [-h] --table TABLE --filter FILTER
                             [--outdir OUTDIR] [--prefix PREFIX]

Convert a TSV/CSV table to an Rtab file based on regex filters.

Takes as input a TSV/CSV table to convert, and a TSV/CSV of regex filters.
The filter table should have the header: column, regex, name. Where column
is the 'column' to search, 'regex' is the regular expression pattern, and
'name' is how the output variant should be named in the Rtab.

An example `filter.tsv` might look like this:

column    regex         name
assembly  .*sample2.*   sample2
lineage   .*2.*         lineage_2

Where the goal is to filter the assembly and lineage columns for particular values.

Examples:
> pangwas table_to_rtab --table samplesheet.csv --filter filter.tsv

options:
  -h, --help       show this help message and exit

required arguments:
  --table TABLE    TSV or CSV table.
  --filter FILTER  TSV or CSV filter table.

optional arguments:
  --outdir OUTDIR  Output directory. (default: . )
  --prefix PREFIX  Prefix for output files.
```


## pangwas_vcf_to_rtab

### Tool Description
Convert a VCF file to an Rtab file.

Takes as input a VCF file to convert to a SNPs Rtab file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/phac-nml/pangwas
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pangwas vcf_to_rtab [-h] --vcf VCF [--bed BED] [--outdir OUTDIR]
                           [--prefix PREFIX]

Convert a VCF file to an Rtab file.

Takes as input a VCF file to convert to a SNPs Rtab file.

Examples:
> pangwas vcf_to_rtab --vcf snps.vcf

options:
  -h, --help       show this help message and exit

required arguments:
  --vcf VCF        VCF file.

optional arguments:
  --bed BED        BED file with names by coordinates.
  --outdir OUTDIR  Output directory. (default: . )
  --prefix PREFIX  Prefix for output files.
```

