# souporcell CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| souporcell_consensus.py | PASS | New CWL (output folder created by the wrapper); ambient RNA estimate 27.7% and genotypes for 66 variants |
| souporcell_renamer.py | PASS | New CWL; made a barcode-tagged fastq of 134898 reads from the real hadge chr21 single-cell BAM slice |
| souporcell_retag.py | PASS | New CWL; restored CB and UB tags on 143276 remapped reads (checked in the BAM) |
| souporcell_shared_samples.py | Not completed | needs two full souporcell run folders with shared samples; no such pair could be made here |
| souporcell_souporcell | PASS | New CWL; 500 cells x 66 chr21 variants (bcftools calls, vartrix matrices) gave 2 clusters that match the reference souporcell donor calls for 454 of 455 cells |
| souporcell_souporcell_pipeline.py | Failed | image problem: freebayes in the image stops with a libvcflib undefined symbol error, so the pipeline fails after remapping (re-checked) |
| souporcell_troublet | PASS | New CWL; doublet calls for the 500 cells (439 singlet, 8 doublet, 53 unassigned) |

## souporcell_renamer.py

### Tool Description
make fastq from possorted_genome_bam.bam from cellranger

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
usage: renamer.py [-h] -f BAM -b BARCODES -o OUT [-c CHROM] [-s START]
                  [-e END] [--no_umi NO_UMI] [--umi_tag UMI_TAG]
                  [--cell_tag CELL_TAG]

make fastq from possorted_genome_bam.bam from cellranger

optional arguments:
  -h, --help            show this help message and exit
  -f BAM, --bam BAM     cellranger bam
  -b BARCODES, --barcodes BARCODES
                        cellranger barcodes.tsv
  -o OUT, --out OUT     output fastq name
  -c CHROM, --chrom CHROM
                        chrom
  -s START, --start START
                        start
  -e END, --end END     end
  --no_umi NO_UMI       set to True if your bam has no umi tag
  --umi_tag UMI_TAG     set if umi tag is not UB
  --cell_tag CELL_TAG   set if cell barcode tag is not CB
```

## souporcell_retag.py

### Tool Description
Retag reads with their cell barcodes and UMIs

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
usage: retag.py [-h] -s SAM -o OUT [--no_umi NO_UMI] [--umi_tag UMI_TAG]
                [--cell_tag CELL_TAG]

Retag reads with their cell barcodes and UMIs

optional arguments:
  -h, --help           show this help message and exit
  -s SAM, --sam SAM    sam file
  -o OUT, --out OUT    output (will be a bam)
  --no_umi NO_UMI      set True if your bam has no umi tag
  --umi_tag UMI_TAG    set if umi tag in output bam should not be UB
  --cell_tag CELL_TAG  set if cell barcode tag should not be CB
```

## souporcell_consensus.py

### Tool Description
consensus genotype calling and ambient RNA estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
usage: consensus.py [-h] -c CLUSTERS -a ALT_MATRIX -r REF_MATRIX [-p PLOIDY]
                    --soup_out SOUP_OUT --vcf_out VCF_OUT --output_dir
                    OUTPUT_DIR -v VCF

consensus genotype calling and ambient RNA estimation

optional arguments:
  -h, --help            show this help message and exit
  -c CLUSTERS, --clusters CLUSTERS
                        tsv cluster file from the troublet output
  -a ALT_MATRIX, --alt_matrix ALT_MATRIX
                        alt matrix file
  -r REF_MATRIX, --ref_matrix REF_MATRIX
                        ref matrix file
  -p PLOIDY, --ploidy PLOIDY
                        ploidy, must be 1 or 2, defaults to 2
  --soup_out SOUP_OUT   soup output
  --vcf_out VCF_OUT     vcf output
  --output_dir OUTPUT_DIR
                        output directory
  -v VCF, --vcf VCF     vcf file from which alt and ref matrix were created
```

## souporcell_shared_samples.py

### Tool Description
determine which clusters are the shared clusters between two souporcell runs with shared samples

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shared_samples.py [-h] -1 EXPERIMENT1 -2 EXPERIMENT2 -n SHARED

determine which clusters are the shared clusters between two souporcell runs
with shared samples

optional arguments:
  -h, --help            show this help message and exit
  -1 EXPERIMENT1, --experiment1 EXPERIMENT1
                        souporcell directory for experiment 1
  -2 EXPERIMENT2, --experiment2 EXPERIMENT2
                        souporcell directory for experiment 2
  -n SHARED, --shared SHARED
                        how many samples should these experiments share?
```

## souporcell_souporcell

### Tool Description
Cluster scRNAseq cells by genotype from vartrix ref and alt matrices

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
souporcell 2.4
Haynes Heaton <whheaton@gmail.com>
clustering scRNAseq cells by genotype

USAGE:
    souporcell [OPTIONS] --alt_matrix <alt_matrix> --barcodes <barcodes> --num_clusters <num_clusters> --ref_matrix <ref_matrix>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -a, --alt_matrix <alt_matrix>                                           alt matrix from vartrix
    -b, --barcodes <barcodes>                                               cell barcodes
        --initialization_strategy <initialization_strategy>
            cluster initialization strategy, defaults to kmeans++, valid values are kmeans++, random_uniform,
            middle_variance, random_cell_assignment
        --known_cell_assignments <known_cell_assignments>
            tsv with barcodes and their known assignments

    -g, --known_genotypes <known_genotypes>
            population vcf/bcf of known genotypes if available.

        --known_genotypes_sample_names <known_genotypes_sample_names>...
            sample names, must be samples from the known_genotypes vcf

        --min_alt <min_alt>
            minimum number of cells containing the alt allele for the variant to be used for clustering

        --min_alt_umis <min_alt_umis>                                       min alt umis to use locus for clustering
        --min_ref <min_ref>
            minimum number of cells containing the ref allele for the variant to be used for clustering

        --min_ref_umis <min_ref_umis>                                       min ref umis to use locus for clustering
    -k, --num_clusters <num_clusters>                                       number of clusters
    -r, --ref_matrix <ref_matrix>                                           ref matrix from vartrix
    -r, --restarts <restarts>                                               number of random seedings
        --seed <seed>                                                       optional random seed
    -t, --threads <threads>                                                 number of threads to use
```

## souporcell_troublet

### Tool Description
Intergenotypic doublet detection given cluster assignments and cell allele counts

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS

### Original Help Text
```text
troublet 2.4
Haynes Heaton <whheaton@gmail.com>
Intergenotypic doublet detection given cluster assignments and cell allele counts

USAGE:
    troublet [OPTIONS] --alts <alts> --clusters <clusters>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -a, --alts <alts>                              alt allele counts per cell in sparse matrix format out of vartrix
    -c, --clusters <clusters>                      cluster file output from schism
    -b, --debug <debug>...                         print debug info for index of cells listed
    -d, --doublet_prior <doublet_prior>            prior on doublets. Defaults to 0.5
        --doublet_threshold <doublet_threshold>    doublet posterior threshold, defaults to 0.90
    -r, --refs <refs>                              ref allele counts per cell in sparse matrix format out of vartrix
        --singlet_threshold <singlet_threshold>    singlet posterior threshold, defaults to 0.90
```

## Metadata
- **Skill**: generated

## souporcell_souporcell_pipeline.py

### Tool Description
A pipeline for clustering mixed-genotype scRNA-seq data by individual.

### Metadata
- **Docker Image**: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
- **Homepage**: https://github.com/wheaton5/souporcell
- **Package**: https://anaconda.org/channels/bioconda/packages/souporcell/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/souporcell:2.5--hc1c3326_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

