# cnvkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cnvkit_access | PASS |  |
| cnvkit_antitarget | PASS |  |
| cnvkit_autobin | PASS |  |
| cnvkit_bintest | PASS |  |
| cnvkit_breaks | PASS |  |
| cnvkit_call | PASS |  |
| cnvkit_coverage | PASS |  |
| cnvkit_diagram | PASS |  |
| cnvkit_export_bed | PASS |  |
| cnvkit_export_cdt | PASS |  |
| cnvkit_export_gistic | PASS |  |
| cnvkit_export_jtv | PASS |  |
| cnvkit_export_nexus-basic | PASS |  |
| cnvkit_export_nexus-ogt | PASS |  |
| cnvkit_export_seg | PASS |  |
| cnvkit_export_theta | PASS |  |
| cnvkit_export_vcf | PASS |  |
| cnvkit_fix | PASS |  |
| cnvkit_genemetrics | PASS |  |
| cnvkit_heatmap | PASS |  |
| cnvkit_import-picard | PASS |  |
| cnvkit_import-rna | Failed | Image problem: import-rna crashes with AttributeError because the image's pandas no longer has DataFrame.iteritems. |
| cnvkit_import-seg | PASS |  |
| cnvkit_import-theta | PASS |  |
| cnvkit_metrics | PASS |  |
| cnvkit_reference | PASS |  |
| cnvkit_scatter | PASS |  |
| cnvkit_segment | PASS |  |
| cnvkit_segmetrics | PASS |  |
| cnvkit_sex | PASS |  |
| cnvkit_target | PASS |  |

## cnvkit_access

### Tool Description
List the locations of accessible sequence regions in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py access [-h] [-s MIN_GAP_SIZE] [-x EXCLUDE] [-o FILENAME]
                        fa_fname

positional arguments:
  fa_fname              Genome FASTA file name

options:
  -h, --help            show this help message and exit
  -s MIN_GAP_SIZE, --min-gap-size MIN_GAP_SIZE
                        Minimum gap size between accessible sequence regions.
                        Regions separated by less than this distance will be
                        joined together. [Default: 5000]
  -x EXCLUDE, --exclude EXCLUDE
                        Additional regions to exclude, in BED format. Can be
                        used multiple times.
  -o FILENAME, --output FILENAME
                        Output file name
```

## cnvkit_antitarget

### Tool Description
Derive off-target ("antitarget") bins from target regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py antitarget [-h] [-g FILENAME] [-a AVG_SIZE] [-m MIN_SIZE]
                            [-o FILENAME]
                            targets

positional arguments:
  targets               BED or interval file listing the targeted regions.

options:
  -h, --help            show this help message and exit
  -g FILENAME, --access FILENAME
                        Regions of accessible sequence on chromosomes (.bed),
                        as output by genome2access.py.
  -a AVG_SIZE, --avg-size AVG_SIZE
                        Average size of antitarget bins (results are
                        approximate). [Default: 150000]
  -m MIN_SIZE, --min-size MIN_SIZE
                        Minimum size of antitarget bins (smaller regions are
                        dropped). [Default: 1/16 avg size, calculated]
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_autobin

### Tool Description
Quickly calculate reasonable bin sizes from BAM read counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py autobin [-h] [-f FILENAME] [-m {hybrid,amplicon,wgs}]
                         [-g FILENAME] [-t TARGETS] [-b BP_PER_BIN]
                         [--target-max-size BASES] [--target-min-size BASES]
                         [--antitarget-max-size BASES]
                         [--antitarget-min-size BASES] [--annotate FILENAME]
                         [--short-names] [--target-output-bed FILENAME]
                         [--antitarget-output-bed FILENAME]
                         bams [bams ...]

positional arguments:
  bams                  Sample BAM file(s) to test for target coverage

options:
  -h, --help            show this help message and exit
  -f FILENAME, --fasta FILENAME
                        Reference genome, FASTA format (e.g. UCSC hg19.fa)
  -m {hybrid,amplicon,wgs}, --method {hybrid,amplicon,wgs}
                        Sequencing protocol: hybridization capture ('hybrid'),
                        targeted amplicon sequencing ('amplicon'), or whole
                        genome sequencing ('wgs'). Determines whether and how
                        to use antitarget bins. [Default: hybrid]
  -g FILENAME, --access FILENAME
                        Sequencing-accessible genomic regions, or exons to use
                        as possible targets (e.g. output of refFlat2bed.py)
  -t TARGETS, --targets TARGETS
                        Potentially targeted genomic regions, e.g. all
                        possible exons for the reference genome. Format: BED,
                        interval list, etc.
  -b BP_PER_BIN, --bp-per-bin BP_PER_BIN
                        Desired average number of sequencing read bases mapped
                        to each bin. [Default: 100000.0]
  --target-max-size BASES
                        Maximum size of target bins. [Default: 20000]
  --target-min-size BASES
                        Minimum size of target bins. [Default: 20]
  --antitarget-max-size BASES
                        Maximum size of antitarget bins. [Default: 500000]
  --antitarget-min-size BASES
                        Minimum size of antitarget bins. [Default: 500]
  --annotate FILENAME   Use gene models from this file to assign names to the
                        target regions. Format: UCSC refFlat.txt or
                        ensFlat.txt file (preferred), or BED, interval list,
                        GFF, or similar.
  --short-names         Reduce multi-accession bait labels to be short and
                        consistent.
  --target-output-bed FILENAME
                        Filename for target BED output. If not specified,
                        constructed from the input file basename.
  --antitarget-output-bed FILENAME
                        Filename for antitarget BED output. If not specified,
                        constructed from the input file basename.
```

## cnvkit_bintest

### Tool Description
Test for single-bin copy number alterations.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py bintest [-h] [-s FILENAME] [-a ALPHA] [-t] [-o OUTPUT]
                         cnarray

positional arguments:
  cnarray               Bin-level log2 ratios (.cnr file), as produced by
                        'fix'.

options:
  -h, --help            show this help message and exit
  -s FILENAME, --segment FILENAME
                        Segmentation calls (.cns), the output of the 'segment'
                        command).
  -a ALPHA, --alpha ALPHA
                        Significance threhold. [Default: 0.005]
  -t, --target          Test target bins only; ignore off-target bins.
  -o OUTPUT, --output OUTPUT
                        Output filename.
```

## cnvkit_breaks

### Tool Description
List the targeted genes in which a copy number breakpoint occurs.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py breaks [-h] [-m MIN_PROBES] [-o FILENAME] filename segment

positional arguments:
  filename              Processed sample coverage data file (*.cnr), the
                        output of the 'fix' sub-command.
  segment               Segmentation calls (.cns), the output of the 'segment'
                        command).

options:
  -h, --help            show this help message and exit
  -m MIN_PROBES, --min-probes MIN_PROBES
                        Minimum number of within-gene probes on both sides of
                        a breakpoint to report it. [Default: 1]
  -o FILENAME, --output FILENAME
                        Output table file name.
```

## cnvkit_call

### Tool Description
Call copy number variants from segmented log2 ratios.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py call [-h] [--center [{mean,median,mode,biweight}]]
                      [--center-at CENTER_AT] [--filter {ampdel,cn,ci,sem}]
                      [-m {threshold,clonal,none}] [-t THRESHOLDS]
                      [--ploidy PLOIDY] [--purity PURITY]
                      [--drop-low-coverage]
                      [-x {m,y,male,Male,f,x,female,Female}] [-y]
                      [-o FILENAME] [-v FILENAME] [-i SAMPLE_ID]
                      [-n NORMAL_ID] [--min-variant-depth MIN_VARIANT_DEPTH]
                      [-z [ALT_FREQ]]
                      [--diploid-parx-genome DIPLOID_PARX_GENOME]
                      filename

positional arguments:
  filename              Copy ratios (.cnr or .cns).

options:
  -h, --help            show this help message and exit
  --center [{mean,median,mode,biweight}]
                        Re-center the log2 ratio values using this estimator
                        of the center or average value. ('median' if no
                        argument given.)
  --center-at CENTER_AT
                        Subtract a constant number from all log2 ratios. For
                        "manual" re-centering, in case the --center option
                        gives unsatisfactory results.)
  --filter {ampdel,cn,ci,sem}
                        Merge segments flagged by the specified filter(s) with
                        the adjacent segment(s).
  -m {threshold,clonal,none}, --method {threshold,clonal,none}
                        Calling method. [Default: threshold]
  -t THRESHOLDS, --thresholds THRESHOLDS
                        Hard thresholds for calling each integer copy number,
                        separated by commas. Use the '=' sign on the command
                        line, e.g.: -t=-1,0,1 [Default: -1.1,-0.25,0.2,0.7]
  --ploidy PLOIDY       Ploidy of the sample cells. [Default: 2]
  --purity PURITY       Estimated tumor cell fraction, a.k.a. purity or
                        cellularity.
  --drop-low-coverage   Drop very-low-coverage bins before segmentation to
                        avoid false-positive deletions in poor-quality tumor
                        samples.
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the sample's chromosomal sex as male or
                        female. (Otherwise guessed from X and Y coverage).
  -y, --male-reference, --haploid-x-reference
                        Was a male reference used? If so, expect half ploidy
                        on chrX and chrY; otherwise, only chrY has half
                        ploidy. In CNVkit, if a male reference was used, the
                        "neutral" copy number (ploidy) of chrX is 1; chrY is
                        haploid for either reference sex.
  -o FILENAME, --output FILENAME
                        Output table file name (CNR-like table of segments,
                        .cns).
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

To additionally process SNP b-allele frequencies for allelic copy number:
  -v FILENAME, --vcf FILENAME
                        VCF file name containing variants for calculation of
                        b-allele frequencies.
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Name of the sample in the VCF (-v/--vcf) to use for
                        b-allele frequency extraction.
  -n NORMAL_ID, --normal-id NORMAL_ID
                        Corresponding normal sample ID in the input VCF
                        (-v/--vcf). This sample is used to select only
                        germline SNVs to calculate b-allele frequencies.
  --min-variant-depth MIN_VARIANT_DEPTH
                        Minimum read depth for a SNV to be used in the
                        b-allele frequency calculation. [Default: 20]
  -z [ALT_FREQ], --zygosity-freq [ALT_FREQ]
                        Ignore VCF's genotypes (GT field) and instead infer
                        zygosity from allele frequencies. [Default if used
                        without a number: 0.25]
```

## cnvkit_coverage

### Tool Description
Calculate coverage in the given regions from BAM read depths.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py coverage [-h] [-f FILENAME] [-c] [-q MIN_MAPQ] [-o FILENAME]
                          [-p [PROCESSES]]
                          bam_file interval

positional arguments:
  bam_file              Mapped sequence reads (.bam)
  interval              Intervals (.bed or .list)

options:
  -h, --help            show this help message and exit
  -f FILENAME, --fasta FILENAME
                        Reference genome, FASTA format (e.g. UCSC hg19.fa)
  -c, --count           Get read depths by counting read midpoints within each
                        bin. (An alternative algorithm).
  -q MIN_MAPQ, --min-mapq MIN_MAPQ
                        Minimum mapping quality score (phred scale 0-60) to
                        count a read for coverage depth. [Default: 0]
  -o FILENAME, --output FILENAME
                        Output file name.
  -p [PROCESSES], --processes [PROCESSES]
                        Number of subprocesses to calculate coverage in
                        parallel. Without an argument, use the maximum number
                        of available CPUs. [Default: use 1 process]
```

## cnvkit_diagram

### Tool Description
Draw copy number (log2 coverages, segments) on chromosomes as a diagram. If both the raw probes and segments are given, show them side-by-side on each chromosome (segments on the left side, probes on the right side).

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py diagram [-h] [-s SEGMENT] [-c CHROMOSOME] [-t THRESHOLD]
                         [-m MIN_PROBES] [-y]
                         [-x {m,y,male,Male,f,x,female,Female}]
                         [--no-shift-xy] [-o FILENAME] [--title TITLE]
                         [--no-gene-labels]
                         [--diploid-parx-genome DIPLOID_PARX_GENOME]
                         [filename]

positional arguments:
  filename              Processed coverage data file (*.cnr), the output of
                        the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -s SEGMENT, --segment SEGMENT
                        Segmentation calls (.cns), the output of the 'segment'
                        command.
  -c CHROMOSOME, --chromosome CHROMOSOME
                        Chromosome to display, e.g. 'chr1' (no chromosomal
                        range allowed)
  -t THRESHOLD, --threshold THRESHOLD
                        Copy number change threshold to label genes. [Default:
                        0.5]
  -m MIN_PROBES, --min-probes MIN_PROBES
                        Minimum number of covered probes to label a gene.
                        [Default: 3]
  -y, --male-reference, --haploid-x-reference
                        Assume inputs were normalized to a male reference
                        (i.e. female samples will have +1 log-CNR of chrX;
                        otherwise male samples would have -1 chrX).
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the sample's chromosomal sex as male or
                        female. (Otherwise guessed from X and Y coverage).
  --no-shift-xy         Don't adjust the X and Y chromosomes according to
                        sample sex.
  -o FILENAME, --output FILENAME
                        Output PDF file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

Plot aesthetics:
  --title TITLE         Plot title. [Default: sample ID, from filename or -i]
  --no-gene-labels      Disable gene_name labels on plot (useful when a lot of
                        CNV were called).
```

## cnvkit_export_bed

### Tool Description
Convert segments to BED format. Input is a segmentation file (.cns) where, preferably, log2 ratios have already been adjusted to integer absolute values using the 'call' command.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export bed [-h] [-i LABEL] [--label-genes] [--ploidy PLOIDY]
                            [-x {m,y,male,Male,f,x,female,Female}]
                            [--show {ploidy,variant,all}] [-y] [-o FILENAME]
                            [--diploid-parx-genome DIPLOID_PARX_GENOME]
                            segments [segments ...]

positional arguments:
  segments              Segmented copy ratio data files (*.cns), the output of
                        the 'segment' or 'call' sub-commands.

options:
  -h, --help            show this help message and exit
  -i LABEL, --sample-id LABEL
                        Identifier to write in the 4th column of the BED file.
                        [Default: use the sample ID, taken from the file name]
  --label-genes         Show gene names in the 4th column of the BED file.
                        (This is a bad idea if >1 input files are given.)
  --ploidy PLOIDY       Ploidy of the sample cells. [Default: 2]
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the sample's chromosomal sex as male or
                        female. (Otherwise guessed from X and Y coverage).
  --show {ploidy,variant,all}
                        Which segmented regions to show: 'all' = all segment
                        regions; 'variant' = CNA regions with non-neutral copy
                        number; 'ploidy' = CNA regions with non-default
                        ploidy. [Default: ploidy]
  -y, --male-reference, --haploid-x-reference
                        Was a male reference used? If so, expect half ploidy
                        on chrX and chrY; otherwise, only chrY has half
                        ploidy. In CNVkit, if a male reference was used, the
                        "neutral" copy number (ploidy) of chrX is 1; chrY is
                        haploid for either reference sex.
  -o FILENAME, --output FILENAME
                        Output file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'
```

## cnvkit_export_cdt

### Tool Description
Convert log2 ratios to CDT format. Compatible with Java TreeView.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export cdt [-h] [-o FILENAME] filenames [filenames ...]

positional arguments:
  filenames             Log2 copy ratio data file(s) (*.cnr), the output of
                        the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_gistic

### Tool Description
Convert log2 copy ratio data (.cnr) to GISTIC markers format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export gistic [-h] [-o FILENAME] filenames [filenames ...]

positional arguments:
  filenames             Log2 copy ratio data file(s) (*.cnr), the output of
                        the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_jtv

### Tool Description
Convert log2 ratios to Java TreeView's native format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export jtv [-h] [-o FILENAME] filenames [filenames ...]

positional arguments:
  filenames             Log2 copy ratio data file(s) (*.cnr), the output of
                        the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_nexus-basic

### Tool Description
Convert bin-level log2 ratios to Nexus Copy Number "basic" format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export nexus-basic [-h] [-o FILENAME] filename

positional arguments:
  filename              Log2 copy ratio data file (*.cnr), the output of the
                        'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_nexus-ogt

### Tool Description
Convert log2 ratios and b-allele freqs to Nexus "Custom-OGT" format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export nexus-ogt [-h] [-i SAMPLE_ID] [-n NORMAL_ID]
                                  [-m MIN_VARIANT_DEPTH] [-z [ALT_FREQ]]
                                  [-w MIN_WEIGHT] [-o FILENAME]
                                  filename vcf

positional arguments:
  filename              Log2 copy ratio data file (*.cnr), the output of the
                        'fix' sub-command.
  vcf                   VCF of SNVs for the same sample, to calculate b-allele
                        frequencies.

options:
  -h, --help            show this help message and exit
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Specify the name of the sample in the VCF to use to
                        extract b-allele frequencies.
  -n NORMAL_ID, --normal-id NORMAL_ID
                        Corresponding normal sample ID in the input VCF.
  -m MIN_VARIANT_DEPTH, --min-variant-depth MIN_VARIANT_DEPTH
                        Minimum read depth for a SNV to be included in the
                        b-allele frequency calculation. [Default: 20]
  -z [ALT_FREQ], --zygosity-freq [ALT_FREQ]
                        Ignore VCF's genotypes (GT field) and instead infer
                        zygosity from allele frequencies. [Default if used
                        without a number: 0.25]
  -w MIN_WEIGHT, --min-weight MIN_WEIGHT
                        Minimum weight (between 0 and 1) for a bin to be
                        included in the output. [Default: 0.0]
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_seg

### Tool Description
Convert segments to SEG format. Compatible with IGV and GenePattern.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export seg [-h] [--enumerate-chroms] [-o FILENAME]
                            filenames [filenames ...]

positional arguments:
  filenames             Segmented copy ratio data file(s) (*.cns), the output
                        of the 'segment' sub-command.

options:
  -h, --help            show this help message and exit
  --enumerate-chroms    Replace chromosome names with sequential integer IDs.
  -o FILENAME, --output FILENAME
                        Output file name.
```

## cnvkit_export_theta

### Tool Description
Convert segments to THetA2 input file format (*.input).

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export theta [-h] [-r REFERENCE] [-o FILENAME] [-v VCF]
                              [-i SAMPLE_ID] [-n NORMAL_ID]
                              [-m MIN_VARIANT_DEPTH] [-z [ALT_FREQ]]
                              tumor_segment

positional arguments:
  tumor_segment         Tumor-sample segmentation file from CNVkit (.cns).

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Reference copy number profile (.cnn), or normal-sample
                        bin-level log2 copy ratios (.cnr). Use if the
                        tumor_segment input file does not contain a "weight"
                        column.
  -o FILENAME, --output FILENAME
                        Output file name.

To also output tables of SNP b-allele frequencies for THetA2:
  -v VCF, --vcf VCF     VCF file containing SNVs observed in both the tumor
                        and normal samples. Tumor sample ID should match the
                        `tumor_segment` filename or be specified with
                        -i/--sample-id.
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Specify the name of the tumor sample in the VCF (given
                        with -v/--vcf). [Default: taken the tumor_segment file
                        name]
  -n NORMAL_ID, --normal-id NORMAL_ID
                        Corresponding normal sample ID in the input VCF.
  -m MIN_VARIANT_DEPTH, --min-variant-depth MIN_VARIANT_DEPTH
                        Minimum read depth for a SNP in the VCF to be counted.
                        [Default: 20]
  -z [ALT_FREQ], --zygosity-freq [ALT_FREQ]
                        Ignore VCF's genotypes (GT field) and instead infer
                        zygosity from allele frequencies. [Default if used
                        without a number: 0.25]
```

## cnvkit_export_vcf

### Tool Description
Convert segments to VCF format. Input is a segmentation file (.cns) where, preferably, log2 ratios have already been adjusted to integer absolute values using the 'call' command.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py export vcf [-h] [--cnr CNR] [-i LABEL] [--ploidy PLOIDY]
                            [-x {m,y,male,Male,f,x,female,Female}] [-y]
                            [-o FILENAME]
                            [--diploid-parx-genome DIPLOID_PARX_GENOME]
                            segments

positional arguments:
  segments              Segmented copy ratio data file (*.cns), the output of
                        the 'segment' or 'call' sub-commands.

options:
  -h, --help            show this help message and exit
  --cnr CNR             Bin-level copy ratios (*.cnr). Used to indicate fuzzy
                        boundaries for segments in the output VCF via the
                        CIPOS and CIEND tags.
  -i LABEL, --sample-id LABEL
                        Sample name to write in the genotype field of the
                        output VCF file. [Default: use the sample ID, taken
                        from the file name]
  --ploidy PLOIDY       Ploidy of the sample cells. [Default: 2]
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the sample's chromosomal sex as male or
                        female. (Otherwise guessed from X and Y coverage).
  -y, --male-reference, --haploid-x-reference
                        Was a male reference used? If so, expect half ploidy
                        on chrX and chrY; otherwise, only chrY has half
                        ploidy. In CNVkit, if a male reference was used, the
                        "neutral" copy number (ploidy) of chrX is 1; chrY is
                        haploid for either reference sex.
  -o FILENAME, --output FILENAME
                        Output file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'
```

## cnvkit_fix

### Tool Description
Combine target and antitarget coverages and correct for biases. Adjust raw coverage data according to the given reference, correct potential biases and re-center.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py fix [-h] [-c] [-i SAMPLE_ID] [--no-gc] [--no-edge]
                     [--no-rmask] [-o FILENAME]
                     [--diploid-parx-genome DIPLOID_PARX_GENOME]
                     [--smoothing-window-fraction SMOOTHING_WINDOW_FRACTION]
                     target antitarget reference

positional arguments:
  target                Target coverage file (.targetcoverage.cnn).
  antitarget            Antitarget coverage file (.antitargetcoverage.cnn).
  reference             Reference coverage (.cnn).

options:
  -h, --help            show this help message and exit
  -c, --cluster         Compare and use cluster-specific values present in the
                        reference profile. (Requires that the reference
                        profile was built with the --cluster option.)
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Sample ID for target/antitarget files. Otherwise
                        inferred from file names.
  --no-gc               Skip GC correction.
  --no-edge             Skip edge-effect correction.
  --no-rmask            Skip RepeatMasker correction.
  -o FILENAME, --output FILENAME
                        Output file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'
  --smoothing-window-fraction SMOOTHING_WINDOW_FRACTION
                        If specified, sets the smoothing window fraction for
                        rolling median bias smoothing based on traits.
                        Otherwise, defaults to 1/sqrt(len(data)).
```

## cnvkit_genemetrics

### Tool Description
Identify targeted genes with copy number gain or loss.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py genemetrics [-h] [-s SEGMENT] [-t THRESHOLD] [-m MIN_PROBES]
                             [--drop-low-coverage] [-y]
                             [-x {m,y,male,Male,f,x,female,Female}]
                             [-o FILENAME]
                             [--diploid-parx-genome DIPLOID_PARX_GENOME]
                             [--mean] [--median] [--mode] [--ttest] [--stdev]
                             [--sem] [--mad] [--mse] [--iqr] [--bivar] [--ci]
                             [--pi] [-a ALPHA] [-b BOOTSTRAP]
                             filename

positional arguments:
  filename              Processed sample coverage data file (*.cnr), the
                        output of the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -s SEGMENT, --segment SEGMENT
                        Segmentation calls (.cns), the output of the 'segment'
                        command).
  -t THRESHOLD, --threshold THRESHOLD
                        Copy number change threshold to report a gene
                        gain/loss. [Default: 0.2]
  -m MIN_PROBES, --min-probes MIN_PROBES
                        Minimum number of covered probes to report a
                        gain/loss. [Default: 3]
  --drop-low-coverage   Drop very-low-coverage bins before segmentation to
                        avoid false-positive deletions in poor-quality tumor
                        samples.
  -y, --male-reference, --haploid-x-reference
                        Assume inputs were normalized to a male reference
                        (i.e. female samples will have +1 log-coverage of
                        chrX; otherwise male samples would have -1 chrX).
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the sample's chromosomal sex as male or
                        female. (Otherwise guessed from X and Y coverage).
  -o FILENAME, --output FILENAME
                        Output table file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

Statistics available:
  --mean                Mean log2-ratio (unweighted).
  --median              Median.
  --mode                Mode (i.e. peak density of log2 ratios).
  --ttest               One-sample t-test of bin log2 ratios versus 0.0.
  --stdev               Standard deviation.
  --sem                 Standard error of the mean.
  --mad                 Median absolute deviation (standardized).
  --mse                 Mean squared error.
  --iqr                 Inter-quartile range.
  --bivar               Tukey's biweight midvariance.
  --ci                  Confidence interval (by bootstrap).
  --pi                  Prediction interval.
  -a ALPHA, --alpha ALPHA
                        Level to estimate confidence and prediction intervals;
                        use with --ci and --pi. [Default: 0.05]
  -b BOOTSTRAP, --bootstrap BOOTSTRAP
                        Number of bootstrap iterations to estimate confidence
                        interval; use with --ci. [Default: 100]
```

## cnvkit_heatmap

### Tool Description
Plot copy number for multiple samples as a heatmap.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py heatmap [-h] [-c CHROMOSOME] [-y]
                         [-x {m,y,male,Male,f,x,female,Female}]
                         [--no-shift-xy] [-o FILENAME] [-b] [-d] [-v]
                         [--delimit-samples] [-t TITLE]
                         [--diploid-parx-genome DIPLOID_PARX_GENOME]
                         filenames [filenames ...]

positional arguments:
  filenames             Sample coverages as raw probes (.cnr) or segments
                        (.cns).

options:
  -h, --help            show this help message and exit
  -c CHROMOSOME, --chromosome CHROMOSOME
                        Chromosome (e.g. 'chr1') or chromosomal range (e.g.
                        'chr1:2333000-2444000') to display. If a range is
                        given, all targeted genes in this range will be shown,
                        unless '--gene'/'-g' is already given.
  -y, --male-reference, --haploid-x-reference
                        Assume inputs were normalized to a male reference
                        (i.e. female samples will have +1 log-CNR of chrX;
                        otherwise male samples would have -1 chrX).
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the chromosomal sex of all given samples as
                        male or female. [Default: guess each sample from
                        coverage of X and Y chromosomes].
  --no-shift-xy         Don't adjust the X and Y chromosomes according to
                        sample sex.
  -o FILENAME, --output FILENAME
                        Output PDF file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

Plot aesthetics:
  -b, --by-bin          Plot data x-coordinates by bin indices instead of
                        genomic coordinates. All bins will be shown with equal
                        width, no blank regions will be shown, and x-axis
                        values indicate bin number (within chromosome) instead
                        of genomic position.
  -d, --desaturate      Tweak color saturation to focus on significant
                        changes.
  -v, --vertical        Plot heatmap with samples as X-axis (instead of
                        Y-axis).
  --delimit-samples     Add an horizontal delimitation line between each
                        sample.
  -t TITLE, --title TITLE
                        Plot title. [Default: Range if provided, otherwise
                        none]
```

## cnvkit_import-picard

### Tool Description
Convert Picard CalculateHsMetrics tabular output to CNVkit .cnn files. The input file is generated by the PER_TARGET_COVERAGE option in the CalculateHsMetrics script in Picard tools. If 'antitarget' is in the input filename, the generated output filename will have the suffix '.antitargetcoverage.cnn', otherwise '.targetcoverage.cnn'.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py import-picard [-h] [-d DIRECTORY] targets [targets ...]

positional arguments:
  targets               Sample coverage .csv files (target and antitarget).

options:
  -h, --help            show this help message and exit
  -d DIRECTORY, --output-dir DIRECTORY
                        Output directory name.
```

## cnvkit_import-rna

### Tool Description
Convert a cohort of per-gene log2 ratios to CNVkit .cnr format.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py import-rna [-h] [-f NAME] -g FILE [-c FILE]
                            [--max-log2 FLOAT] [-n NORMAL [NORMAL ...]]
                            [-d PATH] [-o FILE] [--no-gc] [--no-txlen]
                            FILES [FILES ...]

positional arguments:
  FILES                 Tabular files with Ensembl gene ID and number of reads
                        mapped to each gene, from RSEM or another transcript
                        quantifier.

options:
  -h, --help            show this help message and exit
  -f NAME, --format NAME
                        Input format name: 'rsem' for RSEM gene-level read
                        counts (*_rsem.genes.results), or 'counts' for generic
                        2-column gene IDs and their read counts (e.g. TCGA
                        level 2 RNA expression).
  -g FILE, --gene-resource FILE
                        Location of gene info table from Ensembl BioMart.
  -c FILE, --correlations FILE
                        Correlation of each gene's copy number with
                        expression. Output of cnv_expression_correlate.py.
  --max-log2 FLOAT      Maximum log2 ratio in output. Observed values above
                        this limit will be replaced with this value. [Default:
                        3.0]
  -n NORMAL [NORMAL ...], --normal NORMAL [NORMAL ...]
                        Normal samples (same format as `gene_counts`) to be
                        used as a control to when normalizing and re-centering
                        gene read depth ratios. All filenames following this
                        option will be used.
  -d PATH, --output-dir PATH
                        Directory to write a CNVkit .cnr file for each input
                        sample. [Default: .]
  -o FILE, --output FILE
                        Output file name (summary table).

To disable specific automatic bias corrections:
  --no-gc               Skip GC correction.
  --no-txlen            Skip transcript length correction.
```

## cnvkit_import-seg

### Tool Description
Convert a SEG file to CNVkit .cns files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py import-seg [-h] [-c CHROMOSOMES] [-p PREFIX] [--from-log10]
                            [-d DIRECTORY]
                            segfile

positional arguments:
  segfile               Input file in SEG format. May contain multiple
                        samples.

options:
  -h, --help            show this help message and exit
  -c CHROMOSOMES, --chromosomes CHROMOSOMES
                        Mapping of chromosome indexes to names. Syntax:
                        "from1:to1,from2:to2". Or use "human" for the preset:
                        "23:X,24:Y,25:M".
  -p PREFIX, --prefix PREFIX
                        Prefix to add to chromosome names (e.g 'chr' to rename
                        '8' in the SEG file to 'chr8' in the output).
  --from-log10          Convert base-10 logarithm values in the input to
                        base-2 logs.
  -d DIRECTORY, --output-dir DIRECTORY
                        Output directory name.
```

## cnvkit_import-theta

### Tool Description
Convert THetA output to a BED-like, CNVkit-like tabular format. Equivalently, use the THetA results file to convert CNVkit .cns segments to integer copy number calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py import-theta [-h] [--ploidy PLOIDY] [-d DIRECTORY]
                              tumor_cns theta_results

positional arguments:
  tumor_cns
  theta_results

options:
  -h, --help            show this help message and exit
  --ploidy PLOIDY       Ploidy of normal cells. [Default: 2]
  -d DIRECTORY, --output-dir DIRECTORY
                        Output directory name.
```

## cnvkit_metrics

### Tool Description
Compute coverage deviations and other metrics for self-evaluation.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py metrics [-h] [-s SEGMENTS [SEGMENTS ...]]
                         [--drop-low-coverage] [-o FILENAME]
                         cnarrays [cnarrays ...]

positional arguments:
  cnarrays              One or more bin-level coverage data files (*.cnn,
                        *.cnr).

options:
  -h, --help            show this help message and exit
  -s SEGMENTS [SEGMENTS ...], --segments SEGMENTS [SEGMENTS ...]
                        One or more segmentation data files (*.cns, output of
                        the 'segment' command). If more than one file is
                        given, the number must match the coverage data files,
                        in which case the input files will be paired together
                        in the given order. Otherwise, the same segments will
                        be used for all coverage files.
  --drop-low-coverage   Drop very-low-coverage bins before calculations to
                        reduce negative "fat tail" of bin log2 values in poor-
                        quality tumor samples.
  -o FILENAME, --output FILENAME
                        Output table file name.
```

## cnvkit_reference

### Tool Description
Compile a coverage reference from the given files (normal samples).

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py reference [-h] [-f FASTA] [-o FILENAME] [-c]
                           [--min-cluster-size NUM]
                           [-x {m,y,male,Male,f,x,female,Female}] [-y]
                           [--diploid-parx-genome DIPLOID_PARX_GENOME]
                           [-t TARGETS] [-a ANTITARGETS] [--no-gc] [--no-edge]
                           [--no-rmask]
                           [references ...]

positional arguments:
  references            Normal-sample target or antitarget .cnn files, or the
                        directory that contains them.

options:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Reference genome, FASTA format (e.g. UCSC hg19.fa)
  -o FILENAME, --output FILENAME
                        Output file name.
  -c, --cluster         Calculate and store summary stats for clustered
                        subsets of the normal samples with similar coverage
                        profiles.
  --min-cluster-size NUM
                        Minimum cluster size to keep in reference profiles.
                        [Default: 4]
  -x {m,y,male,Male,f,x,female,Female}, --sample-sex {m,y,male,Male,f,x,female,Female}, -g {m,y,male,Male,f,x,female,Female}, --gender {m,y,male,Male,f,x,female,Female}
                        Specify the chromosomal sex of all given samples as
                        male or female. (Default: guess each sample from
                        coverage of X and Y chromosomes).
  -y, --male-reference, --haploid-x-reference
                        Create a male reference: shift female samples' chrX
                        log-coverage by -1, so the reference chrX average is
                        -1. Otherwise, shift male samples' chrX by +1, so the
                        reference chrX average is 0.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

To construct a generic, "flat" copy number reference with neutral expected coverage:
  -t TARGETS, --targets TARGETS
                        Target intervals (.bed or .list)
  -a ANTITARGETS, --antitargets ANTITARGETS
                        Antitarget intervals (.bed or .list)

To disable specific automatic bias corrections:
  --no-gc               Skip GC correction.
  --no-edge             Skip edge-effect correction.
  --no-rmask            Skip RepeatMasker correction.
```

## cnvkit_scatter

### Tool Description
Plot probe log2 coverages and segmentation calls together.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py scatter [-h] [-s FILENAME] [-c RANGE] [-g GENE]
                         [-l RANGE_LIST] [-w WIDTH] [-o FILENAME]
                         [-a CHARACTER] [--by-bin]
                         [--segment-color SEGMENT_COLOR] [--title TITLE] [-t]
                         [--y-max Y_MAX] [--y-min Y_MIN]
                         [--fig-size WIDTH HEIGHT] [-v FILENAME]
                         [-i SAMPLE_ID] [-n NORMAL_ID] [-m MIN_VARIANT_DEPTH]
                         [-z [ALT_FREQ]]
                         [filename]

positional arguments:
  filename              Processed bin-level copy ratios (*.cnr), the output of
                        the 'fix' sub-command.

options:
  -h, --help            show this help message and exit
  -s FILENAME, --segment FILENAME
                        Segmentation calls (.cns), the output of the 'segment'
                        command.
  -c RANGE, --chromosome RANGE
                        Chromosome or chromosomal range, e.g. 'chr1' or
                        'chr1:2333000-2444000', to display. If a range is
                        given, all targeted genes in this range will be shown,
                        unless -g/--gene is also given.
  -g GENE, --gene GENE  Name of gene or genes (comma-separated) to display.
  -l RANGE_LIST, --range-list RANGE_LIST
                        File listing the chromosomal ranges to display, as
                        BED, interval list or 'chr:start-end' text. Creates
                        focal plots similar to -c/--chromosome for each listed
                        region, combined into a multi-page PDF. The output
                        filename must also be specified (-o/--output).
  -w WIDTH, --width WIDTH
                        Width of margin to show around the selected gene(s)
                        (-g/--gene) or small chromosomal region
                        (-c/--chromosome). [Default: 1000000]
  -o FILENAME, --output FILENAME
                        Output PDF file name.

Plot aesthetics:
  -a CHARACTER, --antitarget-marker CHARACTER
                        Plot antitargets using this symbol when plotting in a
                        selected chromosomal region (-g/--gene or
                        -c/--chromosome). [Default: same as targets]
  --by-bin              Plot data x-coordinates by bin indices instead of
                        genomic coordinates. All bins will be shown with equal
                        width, no blank regions will be shown, and x-axis
                        values indicate bin number (within chromosome) instead
                        of genomic position.
  --segment-color SEGMENT_COLOR
                        Plot segment lines in this color. Value can be any
                        string accepted by matplotlib, e.g. 'red' or
                        '#CC0000'.
  --title TITLE         Plot title. [Default: sample ID, from filename or -i]
  -t, --trend           Draw a smoothed local trendline on the scatter plot.
  --y-max Y_MAX         y-axis upper limit.
  --y-min Y_MIN         y-axis lower limit.
  --fig-size WIDTH HEIGHT
                        Width and height of the plot in inches. [Default: Pre-
                        defined in Matplotlib 'rcParams' variable (most of the
                        time: '6.4 4.8')]

To plot SNP b-allele frequencies:
  -v FILENAME, --vcf FILENAME
                        VCF file name containing variants to plot for SNV
                        b-allele frequencies.
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Name of the sample in the VCF to use for b-allele
                        frequency extraction and as the default plot title.
  -n NORMAL_ID, --normal-id NORMAL_ID
                        Corresponding normal sample ID in the input VCF. This
                        sample is used to select only germline SNVs to plot.
  -m MIN_VARIANT_DEPTH, --min-variant-depth MIN_VARIANT_DEPTH
                        Minimum read depth for a SNV to be used in the
                        b-allele frequency calculation. [Default: 20]
  -z [ALT_FREQ], --zygosity-freq [ALT_FREQ]
                        Ignore VCF's genotypes (GT field) and instead infer
                        zygosity from allele frequencies. [Default if used
                        without a number: 0.25]
```

## cnvkit_segment

### Tool Description
Infer copy number segments from the given coverage table.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py segment [-h] [-o FILENAME] [-d DATAFRAME]
                         [-m {cbs,flasso,haar,none,hmm,hmm-tumor,hmm-germline}]
                         [-t THRESHOLD] [--drop-low-coverage]
                         [--drop-outliers FACTOR] [--rscript-path PATH]
                         [-p [PROCESSES]] [--smooth-cbs]
                         [--diploid-parx-genome DIPLOID_PARX_GENOME]
                         [-v FILENAME] [-i SAMPLE_ID] [-n NORMAL_ID]
                         [--min-variant-depth MIN_VARIANT_DEPTH]
                         [-z [ALT_FREQ]]
                         filename

positional arguments:
  filename              Bin-level log2 ratios (.cnr file), as produced by
                        'fix'.

options:
  -h, --help            show this help message and exit
  -o FILENAME, --output FILENAME
                        Output table file name (CNR-like table of segments,
                        .cns).
  -d DATAFRAME, --dataframe DATAFRAME
                        File name to save the raw R dataframe emitted by CBS
                        or Fused Lasso. (Useful for debugging.)
  -m {cbs,flasso,haar,none,hmm,hmm-tumor,hmm-germline}, --method {cbs,flasso,haar,none,hmm,hmm-tumor,hmm-germline}
                        Segmentation method (see docs), or 'none' for
                        chromosome arm-level averages as segments. [Default:
                        cbs]
  -t THRESHOLD, --threshold THRESHOLD
                        Significance threshold (p-value or FDR, depending on
                        method) to accept breakpoints during segmentation. For
                        HMM methods, this is the smoothing window size.
  --drop-low-coverage   Drop very-low-coverage bins before segmentation to
                        avoid false-positive deletions in poor-quality tumor
                        samples.
  --drop-outliers FACTOR
                        Drop outlier bins more than this many multiples of the
                        95th quantile away from the average within a rolling
                        window. Set to 0 for no outlier filtering. [Default:
                        10]
  --rscript-path PATH   Path to the Rscript executable to use for running R
                        code. Use this option to specify a non-default R
                        installation. [Default: Rscript]
  -p [PROCESSES], --processes [PROCESSES]
                        Number of subprocesses to segment in parallel. Give 0
                        or a negative value to use the maximum number of
                        available CPUs. [Default: use 1 process]
  --smooth-cbs          Perform an additional smoothing before CBS
                        segmentation, which in some cases may increase the
                        sensitivity. Used only for CBS method.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'

To additionally segment SNP b-allele frequencies:
  -v FILENAME, --vcf FILENAME
                        VCF file name containing variants for segmentation by
                        allele frequencies.
  -i SAMPLE_ID, --sample-id SAMPLE_ID
                        Specify the name of the sample in the VCF (-v/--vcf)
                        to use for b-allele frequency extraction and as the
                        default plot title.
  -n NORMAL_ID, --normal-id NORMAL_ID
                        Corresponding normal sample ID in the input VCF
                        (-v/--vcf). This sample is used to select only
                        germline SNVs to plot b-allele frequencies.
  --min-variant-depth MIN_VARIANT_DEPTH
                        Minimum read depth for a SNV to be displayed in the
                        b-allele frequency plot. [Default: 20]
  -z [ALT_FREQ], --zygosity-freq [ALT_FREQ]
                        Ignore VCF's genotypes (GT field) and instead infer
                        zygosity from allele frequencies. [Default if used
                        without a number: 0.25]
```

## cnvkit_segmetrics

### Tool Description
Compute segment-level metrics from bin-level log2 ratios.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py segmetrics [-h] -s SEGMENTS [--drop-low-coverage]
                            [-o FILENAME] [--mean] [--median] [--mode]
                            [--t-test] [--stdev] [--sem] [--mad] [--mse]
                            [--iqr] [--bivar] [--ci] [--pi] [-a ALPHA]
                            [-b BOOTSTRAP] [--smooth-bootstrap]
                            cnarray

positional arguments:
  cnarray               Bin-level copy ratio data file (*.cnn, *.cnr).

options:
  -h, --help            show this help message and exit
  -s SEGMENTS, --segments SEGMENTS
                        Segmentation data file (*.cns, output of the 'segment'
                        command).
  --drop-low-coverage   Drop very-low-coverage bins before calculations to
                        avoid negative bias in poor-quality tumor samples.
  -o FILENAME, --output FILENAME
                        Output table file name.

Statistics available:
  --mean                Mean log2 ratio (unweighted).
  --median              Median.
  --mode                Mode (i.e. peak density of bin log2 ratios).
  --t-test              One-sample t-test of bin log2 ratios versus 0.0.
  --stdev               Standard deviation.
  --sem                 Standard error of the mean.
  --mad                 Median absolute deviation (standardized).
  --mse                 Mean squared error.
  --iqr                 Inter-quartile range.
  --bivar               Tukey's biweight midvariance.
  --ci                  Confidence interval (by bootstrap).
  --pi                  Prediction interval.
  -a ALPHA, --alpha ALPHA
                        Level to estimate confidence and prediction intervals;
                        use with --ci and --pi. [Default: 0.05]
  -b BOOTSTRAP, --bootstrap BOOTSTRAP
                        Number of bootstrap iterations to estimate confidence
                        interval; use with --ci. [Default: 100]
  --smooth-bootstrap    Apply Gaussian noise to bootstrap samples, a.k.a.
                        smoothed bootstrap, to estimate confidence interval;
                        use with --ci.
```

## cnvkit_sex

### Tool Description
Guess samples' sex from the relative coverage of chromosomes X and Y.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py sex [-h] [-y] [-o FILENAME]
                     [--diploid-parx-genome DIPLOID_PARX_GENOME]
                     filenames [filenames ...]

positional arguments:
  filenames             Copy number or copy ratio files (*.cnn, *.cnr).

options:
  -h, --help            show this help message and exit
  -y, --male-reference, --haploid-x-reference
                        Assume inputs were normalized to a male reference
                        (i.e. female samples will have +1 log-coverage of
                        chrX; otherwise male samples would have -1 chrX).
  -o FILENAME, --output FILENAME
                        Output table file name.
  --diploid-parx-genome DIPLOID_PARX_GENOME
                        Considers the given human genome's PAR of chromosome X
                        as autosomal. Example: 'grch38'
```

## cnvkit_target

### Tool Description
Transform bait intervals into targets more suitable for CNVkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
- **Homepage**: https://github.com/etal/cnvkit
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvkit/overview
- **Total Downloads**: 250.2K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/etal/cnvkit
- **Stars**: N/A
### Original Help Text
```text
usage: cnvkit.py target [-h] [--annotate ANNOTATE] [--short-names] [--split]
                        [-a AVG_SIZE] [-o FILENAME]
                        interval

positional arguments:
  interval              BED or interval file listing the targeted regions.

options:
  -h, --help            show this help message and exit
  --annotate ANNOTATE   Use gene models from this file to assign names to the
                        target regions. Format: UCSC refFlat.txt or
                        ensFlat.txt file (preferred), or BED, interval list,
                        GFF, or similar.
  --short-names         Reduce multi-accession bait labels to be short and
                        consistent.
  --split               Split large tiled intervals into smaller, consecutive
                        targets.
  -a AVG_SIZE, --avg-size AVG_SIZE
                        Average size of split target bins (results are
                        approximate). [Default: 266.6666666666667]
  -o FILENAME, --output FILENAME
                        Output file name.
```

