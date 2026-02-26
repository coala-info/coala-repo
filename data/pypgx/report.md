# pypgx CWL Generation Report

## pypgx_call-genotypes

### Tool Description
Call genotypes for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Total Downloads**: 52.1K
- **Last updated**: 2026-01-04
- **GitHub**: https://github.com/sbslee/pypgx
- **Stars**: N/A
### Original Help Text
```text
usage: pypgx call-genotypes [-h] [--alleles PATH] [--cnv-calls PATH] genotypes

Call genotypes for target gene.

Positional arguments:
  genotypes         Output archive file with the semantic type
                    SampleTable[Genotypes].

Optional arguments:
  -h, --help        Show this help message and exit.
  --alleles PATH    Input archive file with the semantic type
                    SampleTable[Alleles].
  --cnv-calls PATH  Input archive file with the semantic type
                    SampleTable[CNVCalls].
```


## pypgx_call-phenotypes

### Tool Description
Call phenotypes for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx call-phenotypes [-h] genotypes phenotypes

Call phenotypes for target gene.

Positional arguments:
  genotypes   Input archive file with the semantic type
              SampleTable[Genotypes].
  phenotypes  Output archive file with the semantic type
              SampleTable[Phenotypes].

Optional arguments:
  -h, --help  Show this help message and exit.
```


## pypgx_combine-results

### Tool Description
Combine various results for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx combine-results [-h] [--genotypes PATH] [--phenotypes PATH]
                             [--alleles PATH] [--cnv-calls PATH]
                             results

Combine various results for target gene.

Positional arguments:
  results            Output archive file with the semantic type
                     SampleTable[Results].

Optional arguments:
  -h, --help         Show this help message and exit.
  --genotypes PATH   Input archive file with the semantic type
                     SampleTable[Genotypes].
  --phenotypes PATH  Input archive file with the semantic type
                     SampleTable[Phenotypes].
  --alleles PATH     Input archive file with the semantic type
                     SampleTable[Alleles].
  --cnv-calls PATH   Input archive file with the semantic type
                     SampleTable[CNVCalls].
```


## pypgx_compare-genotypes

### Tool Description
Calculate concordance between two genotype results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx compare-genotypes [-h] [--verbose] first second

Calculate concordance between two genotype results.

Only samples that appear in both genotype results will be used to calculate
concordance for genotype calls as well as CNV calls.

Positional arguments:
  first       First archive file with the semantic type
              SampleTable[Results].
  second      Second archive file with the semantic type
              SampleTable[Results].

Optional arguments:
  -h, --help  Show this help message and exit.
  --verbose   Whether to print the verbose version of output, including
              discordant calls.
```


## pypgx_compute-control-statistics

### Tool Description
Compute summary statistics for control gene from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx compute-control-statistics [-h] [--assembly TEXT] [--bed PATH]
                                        gene control-statistics bams
                                        [bams ...]

Compute summary statistics for control gene from BAM files.

Note that for the arguments gene and --bed, the 'chr' prefix in contig names
(e.g. 'chr1' vs. '1') will be automatically added or removed as necessary to
match the input BAM's contig names.

Positional arguments:
  gene                Control gene (recommended choices: 'EGFR', 'RYR1',
                      'VDR'). Alternatively, you can provide a custom region
                      (format: chrom:start-end).
  control-statistics  Output archive file with the semantic type
                      SampleTable[Statistics].
  bams                One or more input BAM files. Alternatively, you can
                      provide a text file (.txt, .tsv, .csv, or .list)
                      containing one BAM file per line.

Optional arguments:
  -h, --help          Show this help message and exit.
  --assembly TEXT     Reference genome assembly (default: 'GRCh37')
                      (choices: 'GRCh37', 'GRCh38').
  --bed PATH          By default, the input data is assumed to be WGS. If
                      it's targeted sequencing, you must provide a BED file
                      to indicate probed regions.

[Example] For the VDR gene from WGS data:
  $ pypgx compute-control-statistics \
  VDR \
  control-statistics.zip \
  1.bam 2.bam

[Example] For a custom region from targeted sequencing data:
  $ pypgx compute-control-statistics \
  chr1:100-200 \
  control-statistics.zip \
  bam.list \
  --bed probes.bed
```


## pypgx_compute-copy-number

### Tool Description
Compute copy number from read depth for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx compute-copy-number [-h] [--samples-without-sv TEXT [TEXT ...]]
                                 read-depth control-statistics copy-number

Compute copy number from read depth for target gene.

The command will convert read depth to copy number by performing intra-sample
normalization using summary statistics from the control gene.

During copy number analysis, if the input data is targeted sequencing, the
command will apply inter-sample normalization using summary statistics across
all samples. For best results, it is recommended to specify known samples
without SV using --samples-without-sv.

Positional arguments:
  read-depth            Input archive file with the semantic type
                        CovFrame[ReadDepth].
  control-statistics    Input archive file with the semantic type
                        SampleTable[Statistics].
  copy-number           Output archive file with the semantic type
                        CovFrame[CopyNumber].

Optional arguments:
  -h, --help            Show this help message and exit.
  --samples-without-sv TEXT [TEXT ...]
                        List of known samples with no SV.
```


## pypgx_compute-target-depth

### Tool Description
Compute read depth for target gene from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx compute-target-depth [-h] [--assembly TEXT] [--bed PATH]
                                  gene read-depth bams [bams ...]

Compute read depth for target gene from BAM files.

Positional arguments:
  gene             Target gene.
  read-depth       Output archive file with the semantic type
                   CovFrame[ReadDepth].
  bams             One or more input BAM files. Alternatively, you can
                   provide a text file (.txt, .tsv, .csv, or .list)
                   containing one BAM file per line.

Optional arguments:
  -h, --help       Show this help message and exit.
  --assembly TEXT  Reference genome assembly (default: 'GRCh37')
                   (choices: 'GRCh37', 'GRCh38').
  --bed PATH       By default, the input data is assumed to be WGS. If it
                   is targeted sequencing, you must provide a BED file to
                   indicate probed regions.

[Example] For the CYP2D6 gene from WGS data:
  $ pypgx compute-target-depth \
  CYP2D6 \
  read-depth.zip \
  1.bam 2.bam

[Example] For the CYP2D6 gene from targeted sequencing data:
  $ pypgx compute-target-depth \
  CYP2D6 \
  read-depth.zip \
  bam.list \
  --bed probes.bed
```


## pypgx_create-consolidated-vcf

### Tool Description
Create a consolidated VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx create-consolidated-vcf [-h]
                                     imported-variants phased-variants
                                     consolidated-variants

Create a consolidated VCF file.

Positional arguments:
  imported-variants     Input archive file with the semantic type
                        VcfFrame[Imported].
  phased-variants       Input archive file with the semantic type
                        VcfFrame[Phased].
  consolidated-variants
                        Output archive file with the semantic type
                        VcfFrame[Consolidated].

Optional arguments:
  -h, --help            Show this help message and exit.
```


## pypgx_create-input-vcf

### Tool Description
Call SNVs/indels from BAM files for all target genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx create-input-vcf [-h] [--assembly TEXT] [--genes TEXT [TEXT ...]]
                              [--exclude] [--dir-path PATH] [--max-depth INT]
                              vcf fasta bams [bams ...]

Call SNVs/indels from BAM files for all target genes.

To save computing resources, this method will call variants only for target
genes whose at least one star allele is defined by SNVs/indels. Therefore,
variants will not be called for target genes that have star alleles defined
only by structural variation (e.g. UGT2B17).

Positional arguments:
  vcf                   Output VCF file. It must have .vcf.gz as suffix.
  fasta                 Reference FASTA file.
  bams                  One or more input BAM files. Alternatively, you can
                        provide a text file (.txt, .tsv, .csv, or .list)
                        containing one BAM file per line.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --genes TEXT [TEXT ...]
                        List of genes to include.
  --exclude             Exclude specified genes. Ignored when --genes is not
                        used.
  --dir-path PATH       By default, intermediate files (likelihoods.bcf,
                        calls.bcf, and calls.normalized.bcf) will be stored
                        in a temporary directory, which is automatically
                        deleted after creating final VCF. If you provide a
                        directory path, intermediate files will be stored
                        there.
  --max-depth INT       At a position, read maximally this number of reads
                        per input file (default: 250). If your input data is
                        from WGS (e.g. 30X), you don't need to change this
                        option. However, if it's from targeted sequencing
                        with ultra-deep coverage (e.g. 500X), then you need
                        to increase the maximum depth.
```


## pypgx_create-regions-bed

### Tool Description
Create a BED file which contains all regions used by PyPGx.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx create-regions-bed [-h] [--assembly TEXT] [--add-chr-prefix]
                                [--merge] [--target-genes] [--sv-genes]
                                [--var-genes] [--genes TEXT [TEXT ...]]
                                [--exclude]

Create a BED file which contains all regions used by PyPGx.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --add-chr-prefix      Whether to add the 'chr' string in contig names.
  --merge               Whether to merge overlapping intervals (gene names
                        will be removed too).
  --target-genes        Whether to only return target genes, excluding
                        control genes and paralogs.
  --sv-genes            Whether to only return target genes whose at least
                        one star allele is defined by structural variation
  --var-genes           Whether to only return target genes whose at least
                        one star allele is defined by SNVs/indels.
  --genes TEXT [TEXT ...]
                        List of genes to include.
  --exclude             Exclude specified genes. Ignored when --genes is not
                        used.
```


## pypgx_estimate-phase-beagle

### Tool Description
Estimate haplotype phase of observed variants with the Beagle program.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx estimate-phase-beagle [-h] [--panel PATH] [--impute]
                                   imported-variants phased-variants

Estimate haplotype phase of observed variants with the Beagle program.

Positional arguments:
  imported-variants  Input archive file with the semantic type
                     VcfFrame[Imported]. The 'chr' prefix in contig names
                     (e.g. 'chr1' vs. '1') will be automatically added or
                     removed as necessary to match the reference VCF's contig
                     names.
  phased-variants    Output archive file with the semantic type
                     VcfFrame[Phased].

Optional arguments:
  -h, --help         Show this help message and exit.
  --panel PATH       VCF file (compressed or uncompressed) corresponding to a
                     reference haplotype panel. By default, the 1KGP panel in
                     the pypgx-bundle directory will be used.
  --impute           Perform imputation of missing genotypes.
```


## pypgx_filter-samples

### Tool Description
Filter Archive file for specified samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx filter-samples [-h] [--exclude]
                            input output samples [samples ...]

Filter Archive file for specified samples.

Positional arguments:
  input       Input archive file.
  output      Output archive file.
  samples     Specify which samples should be included for analysis
              by providing a text file (.txt, .tsv, .csv, or .list)
              containing one sample per line. Alternatively, you can
              provide a list of samples.

Optional arguments:
  -h, --help  Show this help message and exit.
  --exclude   Exclude specified samples.
```


## pypgx_import-read-depth

### Tool Description
Import read depth data for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx import-read-depth [-h] [--samples TEXT [TEXT ...]] [--exclude]
                               gene depth-of-coverage read-depth

Import read depth data for target gene.

Positional arguments:
  gene                  Target gene.
  depth-of-coverage     Input archive file with the semantic type
                        CovFrame[DepthOfCoverage].
  read-depth            Output archive file with the semantic type
                        CovFrame[ReadDepth].

Optional arguments:
  -h, --help            Show this help message and exit.
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --exclude             Exclude specified samples.
```


## pypgx_import-variants

### Tool Description
Import SNV/indel data for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx import-variants [-h] [--assembly TEXT] [--platform TEXT]
                             [--samples TEXT [TEXT ...]] [--exclude]
                             gene vcf imported-variants

Import SNV/indel data for target gene.

The command will slice the input VCF for the target gene to create an archive
file with the semantic type VcfFrame[Imported] or VcfFrame[Consolidated].

Positional arguments:
  gene                  Target gene.
  vcf                   Input VCF file must be already BGZF compressed (.gz)
                        and indexed (.tbi) to allow random access.
  imported-variants     Output archive file with the semantic type
                        VcfFrame[Imported] or VcfFrame[Consolidated].

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --platform TEXT       Genotyping platform used (default: 'WGS') (choices:
                        'WGS', 'Targeted', 'Chip', 'LongRead'). When the
                        platform is 'WGS', 'Targeted', or 'Chip', the command
                        will assess whether every genotype call in the sliced
                        VCF is haplotype phased (e.g. '0|1'). If the sliced
                        VCF is fully phased, the command will return
                        VcfFrame[Consolidated] or otherwise
                        VcfFrame[Imported]. When the platform is 'LongRead',
                        the command will return VcfFrame[Consolidated] after
                        applying the phase-extension algorithm to estimate
                        haplotype phase of any variants that could not be
                        resolved by read-backed phasing.
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you
                        can provide a list of samples.
  --exclude             Exclude specified samples.
```


## pypgx_plot-bam-copy-number

### Tool Description
Plot copy number profile from CovFrame[CopyNumber].

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx plot-bam-copy-number [-h] [--fitted] [--path PATH]
                                  [--samples TEXT [TEXT ...]] [--ymin FLOAT]
                                  [--ymax FLOAT] [--fontsize FLOAT]
                                  copy-number

Plot copy number profile from CovFrame[CopyNumber].

Positional arguments:
  copy-number           Input archive file with the semantic type
                        CovFrame[CopyNumber].

Optional arguments:
  -h, --help            Show this help message and exit.
  --fitted              Show the fitted line as well.
  --path PATH           Create plots in this directory (default: current
                        directory).
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --ymin FLOAT          Y-axis bottom (default: -0.3).
  --ymax FLOAT          Y-axis top (default: 6.3).
  --fontsize FLOAT      Text fontsize (default: 25).
```


## pypgx_plot-bam-read-depth

### Tool Description
Plot read depth profile with BAM data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx plot-bam-read-depth [-h] [--path PATH]
                                 [--samples TEXT [TEXT ...]] [--ymin FLOAT]
                                 [--ymax FLOAT] [--fontsize FLOAT]
                                 read-depth

Plot read depth profile with BAM data.

Positional arguments:
  read-depth            Input archive file with the semantic type
                        CovFrame[ReadDepth].

Optional arguments:
  -h, --help            Show this help message and exit.
  --path PATH           Create plots in this directory (default: current
                        directory).
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --ymin FLOAT          Y-axis bottom.
  --ymax FLOAT          Y-axis top.
  --fontsize FLOAT      Text fontsize (default: 25).
```


## pypgx_plot-cn-af

### Tool Description
Plot both copy number profile and allele fraction profile in one figure.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx plot-cn-af [-h] [--path PATH] [--samples TEXT [TEXT ...]]
                        [--ymin FLOAT] [--ymax FLOAT] [--fontsize FLOAT]
                        copy-number imported-variants

Plot both copy number profile and allele fraction profile in one figure.

Positional arguments:
  copy-number           Input archive file with the semantic type
                        CovFrame[CopyNumber].
  imported-variants     Input archive file with the semantic type
                        VcfFrame[Imported].

Optional arguments:
  -h, --help            Show this help message and exit.
  --path PATH           Create plots in this directory (default: current
                        directory).
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --ymin FLOAT          Y-axis bottom (default: -0.3).
  --ymax FLOAT          Y-axis top (default: 6.3).
  --fontsize FLOAT      Text fontsize (default: 25).
```


## pypgx_plot-vcf-allele-fraction

### Tool Description
Plot allele fraction profile from VcfFrame[Imported].

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx plot-vcf-allele-fraction [-h] [--path PATH]
                                      [--samples TEXT [TEXT ...]]
                                      [--fontsize FLOAT]
                                      imported-variants

Plot allele fraction profile from VcfFrame[Imported].

Positional arguments:
  imported-variants     Input archive file with the semantic type
                        VcfFrame[Imported].

Optional arguments:
  -h, --help            Show this help message and exit.
  --path PATH           Create plots in this directory (default: current
                        directory).
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --fontsize FLOAT      Text fontsize (default: 25).
```


## pypgx_plot-vcf-read-depth

### Tool Description
Plot read depth profile with VCF data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx plot-vcf-read-depth [-h] [--assembly TEXT] [--path PATH]
                                 [--samples TEXT [TEXT ...]] [--ymin FLOAT]
                                 [--ymax FLOAT]
                                 gene vcf

Plot read depth profile with VCF data.

Positional arguments:
  gene                  Target gene.
  vcf                   Input VCF file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --path PATH           Create plots in this directory (default: current
                        directory).
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you can
                        provide a list of samples.
  --ymin FLOAT          Y-axis bottom.
  --ymax FLOAT          Y-axis top.
```


## pypgx_predict-alleles

### Tool Description
Predict candidate star alleles based on observed variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx predict-alleles [-h] consolidated-variants alleles

Predict candidate star alleles based on observed variants.

Positional arguments:
  consolidated-variants
                        Input archive file with the semantic type
                        VcfFrame[Consolidated].
  alleles               Output archive file with the semantic type
                        SampleTable[Alleles].

Optional arguments:
  -h, --help            Show this help message and exit.
```


## pypgx_predict-cnv

### Tool Description
Predict CNV from copy number data for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx predict-cnv [-h] [--cnv-caller PATH] copy-number cnv-calls

Predict CNV from copy number data for target gene.

Genomic positions that are missing copy number because, for example, the
input data is targeted sequencing will be imputed with forward filling.

Positional arguments:
  copy-number        Input archive file with the semantic type
                     CovFrame[CopyNumber].
  cnv-calls          Output archive file with the semantic type
                     SampleTable[CNVCalls].

Optional arguments:
  -h, --help         Show this help message and exit.
  --cnv-caller PATH  Archive file with the semantic type Model[CNV]. By
                     default, a pre-trained CNV caller in the pypgx-bundle
                     directory will be used.
```


## pypgx_prepare-depth-of-coverage

### Tool Description
Prepare a depth of coverage file for all target genes with SV from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx prepare-depth-of-coverage [-h] [--assembly TEXT] [--bed PATH]
                                       [--genes TEXT [TEXT ...]] [--exclude]
                                       depth-of-coverage bams [bams ...]

Prepare a depth of coverage file for all target genes with SV from BAM files.

To save computing resources, this method will count read depth only for
target genes whose at least one star allele is defined by structural
variation. Therefore, read depth will not be computed for target genes that
have star alleles defined only by SNVs/indels (e.g. CYP3A5).

Positional arguments:
  depth-of-coverage     Output archive file with the semantic type
                        CovFrame[DepthOfCoverage].
  bams                  One or more input BAM files. Alternatively, you can
                        provide a text file (.txt, .tsv, .csv, or .list)
                        containing one BAM file per line.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --bed PATH            By default, the input data is assumed to be WGS. If
                        it's targeted sequencing, you must provide a BED file
                        to indicate probed regions. Note that the 'chr' prefix
                        in contig names (e.g. 'chr1' vs. '1') will be
                        automatically added or removed as necessary to match
                        the input BAM's contig names.
  --genes TEXT [TEXT ...]
                        List of genes to include.
  --exclude             Exclude specified genes. Ignored when --genes is not
                        used.

[Example] From WGS data:
  $ pypgx prepare-depth-of-coverage \
  depth-of-coverage.zip \
  1.bam 2.bam

[Example] From targeted sequencing data:
  $ pypgx prepare-depth-of-coverage \
  depth-of-coverage.zip \
  bam.list \
  --bed probes.bed
```


## pypgx_print-data

### Tool Description
Print the main data of specified archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx print-data [-h] input

Print the main data of specified archive.

Positional arguments:
  input       Input archive file.

Optional arguments:
  -h, --help  Show this help message and exit.
```


## pypgx_print-metadata

### Tool Description
Print the metadata of specified archive.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx print-metadata [-h] input

Print the metadata of specified archive.

Positional arguments:
  input       Input archive file.

Optional arguments:
  -h, --help  Show this help message and exit.
```


## pypgx_run-chip-pipeline

### Tool Description
Run genotyping pipeline for chip data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx run-chip-pipeline [-h] [--assembly TEXT] [--panel PATH]
                               [--impute] [--force]
                               [--samples TEXT [TEXT ...]] [--exclude]
                               gene output variants

Run genotyping pipeline for chip data.

Positional arguments:
  gene                  Target gene.
  output                Output directory.
  variants              Input VCF file must be already BGZF compressed (.gz)
                        and indexed (.tbi) to allow random access.
                        Statistical haplotype phasing will be skipped if
                        input VCF is already fully phased.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       
                        Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --panel PATH          VCF file corresponding to a reference haplotype panel
                        (compressed or uncompressed). By default, the 1KGP
                        panel in the pypgx-bundle directory will be used.
  --impute              Perform imputation of missing genotypes.
  --force               Overwrite output directory if it already exists.
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you
                        can provide a list of samples.
  --exclude             Exclude specified samples.

[Example] To genotype the CYP3A5 gene from chip data:
  $ pypgx run-chip-pipeline \
  CYP3A5 \
  CYP3A5-pipeline \
  variants.vcf.gz
```


## pypgx_run-long-read-pipeline

### Tool Description
Run genotyping pipeline for long-read sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx run-long-read-pipeline [-h] [--assembly TEXT] [--force]
                                    [--samples TEXT [TEXT ...]] [--exclude]
                                    gene output variants

Run genotyping pipeline for long-read sequencing data.

Positional arguments:
  gene                  Target gene.
  output                Output directory.
  variants              Input VCF file must be already BGZF compressed (.gz)
                        and indexed (.tbi) to allow random access.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --force               Overwrite output directory if it already exists.
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you
                        can provide a list of samples.
  --exclude             Exclude specified samples.

[Example] To genotype the CYP3A5 gene from long-read sequencing data:
  $ pypgx run-long-read-pipeline \
  CYP3A5 \
  CYP3A5-pipeline \
  variants.vcf.gz
```


## pypgx_run-ngs-pipeline

### Tool Description
Run genotyping pipeline for NGS data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx run-ngs-pipeline [-h] [--variants PATH]
                              [--depth-of-coverage PATH]
                              [--control-statistics PATH] [--platform TEXT]
                              [--assembly TEXT] [--panel PATH] [--force]
                              [--samples TEXT [TEXT ...]] [--exclude]
                              [--samples-without-sv TEXT [TEXT ...]]
                              [--do-not-plot-copy-number]
                              [--do-not-plot-allele-fraction]
                              [--cnv-caller PATH]
                              gene output

Run genotyping pipeline for NGS data.

During copy number analysis, if the input data is targeted sequencing, the
command will apply inter-sample normalization using summary statistics across
all samples. For best results, it is recommended to specify known samples
without SV using --samples-without-sv.

Positional arguments:
  gene                  Target gene.
  output                Output directory.

Optional arguments:
  -h, --help            Show this help message and exit.
  --variants PATH       Input VCF file must be already BGZF compressed (.gz)
                        and indexed (.tbi) to allow random access.
                        Statistical haplotype phasing will be skipped if
                        input VCF is already fully phased.
  --depth-of-coverage PATH
                        Archive file with the semantic type
                        CovFrame[DepthOfCoverage].
  --control-statistics PATH
                        Archive file with the semantic type
                        SampleTable[Statistics].
  --platform TEXT       Genotyping platform (default: 'WGS') (choices: 'WGS',
                        'Targeted')
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --panel PATH          VCF file corresponding to a reference haplotype panel
                        (compressed or uncompressed). By default, the 1KGP panel
                        in the pypgx-bundle directory will be used.
  --force               Overwrite output directory if it already exists.
  --samples TEXT [TEXT ...]
                        Specify which samples should be included for analysis
                        by providing a text file (.txt, .tsv, .csv, or .list)
                        containing one sample per line. Alternatively, you
                        can provide a list of samples.
  --exclude             Exclude specified samples.
  --samples-without-sv TEXT [TEXT ...]
                        List of known samples without SV.
  --do-not-plot-copy-number
                        Do not plot copy number profile.
  --do-not-plot-allele-fraction
                        Do not plot allele fraction profile.
  --cnv-caller PATH     Archive file with the semantic type Model[CNV]. By
                        default, a pre-trained CNV caller in the pypgx-bundle
                        directory will be used.

[Example] To genotype the CYP3A5 gene, which does not have SV, from WGS data:
  $ pypgx run-ngs-pipeline \
  CYP3A5 \
  CYP3A5-pipeline \
  --variants variants.vcf.gz

[Example] To genotype the CYP2D6 gene, which does have SV, from WGS data:
  $ pypgx run-ngs-pipeline \
  CYP2D6 \
  CYP2D6-pipeline \
  --variants variants.vcf.gz \
  --depth-of-coverage depth-of-coverage.zip \
  --control-statistics control-statistics-VDR.zip

[Example] To genotype the CYP2D6 gene from targeted sequencing data:
  $ pypgx run-ngs-pipeline \
  CYP2D6 \
  CYP2D6-pipeline \
  --variants variants.vcf.gz \
  --depth-of-coverage depth-of-coverage.zip \
  --control-statistics control-statistics-VDR.zip \
  --platform Targeted
```


## pypgx_slice-bam

### Tool Description
Slice BAM file for all genes used by PyPGx.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx slice-bam [-h] [--assembly TEXT] [--genes TEXT [TEXT ...]]
                       [--exclude]
                       input output

Slice BAM file for all genes used by PyPGx.

Positional arguments:
  input                 Input BAM file. It must be already indexed to allow
                        random access.
  output                Output BAM file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --assembly TEXT       Reference genome assembly (default: 'GRCh37')
                        (choices: 'GRCh37', 'GRCh38').
  --genes TEXT [TEXT ...]
                        List of genes to include.
  --exclude             Exclude specified genes. Ignored when --genes is not
                        used.
```


## pypgx_test-cnv-caller

### Tool Description
Test CNV caller for target gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx test-cnv-caller [-h] [--confusion-matrix PATH]
                             [--comparison-table PATH]
                             cnv-caller copy-number cnv-calls

Test CNV caller for target gene.

Positional arguments:
  cnv-caller            Input archive file with the semantic type Model[CNV].
  copy-number           Input archive file with the semantic type
                        CovFrame[CopyNumber].
  cnv-calls             Input archive file with the semantic type
                        SampleTable[CNVCalls].

Optional arguments:
  -h, --help            Show this help message and exit.
  --confusion-matrix PATH
                        Write the confusion matrix as a CSV file where rows
                        indicate actual class and columns indicate prediction
                        class.
  --comparison-table PATH
                        Write a CSV file comparing actual vs. predicted CNV
                        calls for each sample.
```


## pypgx_train-cnv-caller

### Tool Description
Train CNV caller for target gene.

This command will return a SVM-based multiclass classifier that makes CNV
calls using the one-vs-rest strategy.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/pypgx
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pypgx train-cnv-caller [-h] [--confusion-matrix PATH]
                              [--comparison-table PATH]
                              copy-number cnv-calls cnv-caller

Train CNV caller for target gene.

This command will return a SVM-based multiclass classifier that makes CNV
calls using the one-vs-rest strategy.

Positional arguments:
  copy-number           Input archive file with the semantic type
                        CovFrame[CopyNumber].
  cnv-calls             Input archive file with the semantic type
                        SampleTable[CNVCalls].
  cnv-caller            Output archive file with the semantic type Model[CNV].

Optional arguments:
  -h, --help            Show this help message and exit.
  --confusion-matrix PATH
                        Write the confusion matrix as a CSV file where rows
                        indicate actual class and columns indicate prediction
                        class.
  --comparison-table PATH
                        Write a CSV file comparing actual vs. predicted CNV
                        calls for each sample.
```

