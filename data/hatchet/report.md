# hatchet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hatchet_cluster_bins | PASS |  |
| hatchet_cluster_bins_gmm | PASS |  |
| hatchet_combine_counts | PASS |  |
| hatchet_combine_counts_fw | PASS |  |
| hatchet_compute_cn | Not completed | needs the Gurobi solver library and licence (libgurobi90.so is missing in the image) |
| hatchet_count_alleles | Not completed | no usable test data: needs matched normal and tumor BAMs aligned to a full human reference; the tool crashes on a one-chromosome genome |
| hatchet_count_reads | Not completed | no usable test data: needs matched normal and tumor BAMs aligned to a full human reference; the tool crashes on a one-chromosome genome |
| hatchet_count_reads_fw | Not completed | no usable test data: needs matched normal and tumor BAMs aligned to a full human reference; the tool crashes on a one-chromosome genome |
| hatchet_genotype_snps | Not completed | no usable test data: needs matched normal and tumor BAMs aligned to a full human reference; the tool crashes on a one-chromosome genome |
| hatchet_phase_snps | Not completed | needs shapeit, picard and a large reference panel |
| hatchet_plot_bins | PASS |  |
| hatchet_plot_bins_1d2d | PASS |  |
| hatchet_plot_cn | PASS |  |
| hatchet_plot_cn_1d2d | PASS |  |

## hatchet_count_reads

### Tool Description
Count the mapped reads in variable-length bins for a normal and one or more tumor BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:13:59]# Parsing and checking input arguments
usage: hatchet count-reads [-h] -N NORMAL -T TUMOR [TUMOR ...] -b BAFFILE -V
                           REFVERSION -O OUTDIR [-S SAMPLES [SAMPLES ...]]
                           [-st SAMTOOLS] [-md MOSDEPTH] [-tx TABIX]
                           [-j PROCESSES] [-q READQUALITY] [-i]
                           [--chromosomes [CHROMOSOMES ...]]

Count the mapped sequencing reads in bins of fixed and given length, uniformly
for a BAM file of a normal sample and one or more BAM files of tumor samples.
This program supports both data from whole-genome sequencing (WGS) and whole-
exome sequencing (WES), but the a BED file with targeted regions is required
when considering WES.

options:
  -h, --help            show this help message and exit
  -N NORMAL, --normal NORMAL
                        BAM file corresponding to matched normal sample
  -T TUMOR [TUMOR ...], --tumor TUMOR [TUMOR ...]
                        BAM files corresponding to samples from the same tumor
  -b BAFFILE, --baffile BAFFILE
                        1bed file containing SNP information from tumor
                        samples (i.e., baf/bulk.1bed)
  -V REFVERSION, --refversion REFVERSION
                        Version of reference genome used in BAM files
  -O OUTDIR, --outdir OUTDIR
                        Directory for output files
  -S SAMPLES [SAMPLES ...], --samples SAMPLES [SAMPLES ...]
                        Sample names for each BAM, given in the same order
                        where the normal name is first (default: inferred from
                        file names)
  -st SAMTOOLS, --samtools SAMTOOLS
                        Path to samtools executable
  -md MOSDEPTH, --mosdepth MOSDEPTH
                        Path to mosdepth executable
  -tx TABIX, --tabix TABIX
                        Path to tabix executable
  -j PROCESSES, --processes PROCESSES
                        Number of available parallel processes (default: 2)
  -q READQUALITY, --readquality READQUALITY
                        Minimum mapping quality for an aligned read to be
                        considered (default: 11)
  -i, --intermediates   Produce intermediate counts files only and do not
                        proceed to forming arrays (default: False)
  --chromosomes [CHROMOSOMES ...]
                        One or more chromosomes to process (default: blank to
                        process all chromosomes)
```

## hatchet_count_reads_fw

### Tool Description
Count the mapped reads in fixed-length bins for a normal and one or more tumor BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:03]# Parsing and checking input arguments
usage: hatchet count-reads [-h] -N NORMAL -T TUMORS [TUMORS ...] -b SIZE
                           [-S SAMPLES [SAMPLES ...]] [-st SAMTOOLS]
                           [-r REGIONS] [-g REFERENCE] [-j PROCESSES]
                           [-q READQUALITY] [-O OUTPUTNORMAL]
                           [-o OUTPUTTUMORS] [-t OUTPUTTOTAL] [-v]
                           [--chromosomes [CHROMOSOMES ...]] [-V]

Count the mapped sequencing reads in bins of fixed and given length, uniformly
for a BAM file of a normal sample and one or more BAM files of tumor samples.
This program supports both data from whole-genome sequencing (WGS) and whole-
exome sequencing (WES), but the a BED file with targeted regions is required
when considering WES.

options:
  -h, --help            show this help message and exit
  -N NORMAL, --normal NORMAL
                        BAM file corresponding to matched normal sample
  -T TUMORS [TUMORS ...], --tumors TUMORS [TUMORS ...]
                        BAM files corresponding to samples from the same tumor
  -b SIZE, --size SIZE  Size of the bins, specified as a full number or using
                        the notations either "kb" or "Mb"
  -S SAMPLES [SAMPLES ...], --samples SAMPLES [SAMPLES ...]
                        Sample names for each BAM, given in the same order
                        where the normal name is first (default: inferred from
                        file names)
  -st SAMTOOLS, --samtools SAMTOOLS
                        Path to the directory to "samtools" executable,
                        required in default mode (default: samtools is
                        directly called as it is in user $PATH)
  -r REGIONS, --regions REGIONS
                        BED file containing the a list of genomic regions to
                        consider in the format "CHR START END", REQUIRED for
                        WES data (default: none, consider entire genome)
  -g REFERENCE, --reference REFERENCE
                        Reference genome, note that reference must be indexed
                        and the dictionary must exist in the same directory
                        with the same name and .dict extension
  -j PROCESSES, --processes PROCESSES
                        Number of available parallel processes (default: 2)
  -q READQUALITY, --readquality READQUALITY
                        Minimum mapping quality for an aligned read to be
                        considered (default: 11)
  -O OUTPUTNORMAL, --outputnormal OUTPUTNORMAL
                        Filename of output for allele counts in the normal
                        sample (default: standard output)
  -o OUTPUTTUMORS, --outputtumors OUTPUTTUMORS
                        Output filename for allele counts in tumor samples
                        (default: standard output)
  -t OUTPUTTOTAL, --outputtotal OUTPUTTOTAL
                        Output filename for total read counts in all tumor
                        samples (default: "total_read.counts")
  -v, --verbose         Use verbose log messages
  --chromosomes [CHROMOSOMES ...]
                        One or more chromosomes to process (default: blank to
                        process all chromosomes)
  -V, --version         show program's version number and exit
```

## hatchet_genotype_snps

### Tool Description
Genotype and call SNPs in a matched-normal sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:11]('# Parsing the input arguments, checking the consistency of given files, and extracting required ', 'information\n')usage: hatchet genotype-snps [-h] -N NORMAL -r REFERENCE [-st SAMTOOLS]
                             [-bt BCFTOOLS] [-R SNPS] [-j PROCESSES]
                             [-q READQUALITY] [-Q BASEQUALITY] [-c MINCOV]
                             [-C MAXCOV] [-E] [-o OUTPUTSNPS]
                             [--chromosomes [CHROMOSOMES ...]] [-v] [-V]

Genotype and call SNPs in a matched-normal sample.

options:
  -h, --help            show this help message and exit
  -N NORMAL, --normal NORMAL
                        BAM file corresponding to matched normal sample
  -r REFERENCE, --reference REFERENCE
                        Human reference genome of BAMs
  -st SAMTOOLS, --samtools SAMTOOLS
                        Path to the directory to "samtools" executable,
                        required in default mode (default: samtools is
                        directly called as it is in user $PATH)
  -bt BCFTOOLS, --bcftools BCFTOOLS
                        Path to the directory of "bcftools" executable,
                        required in default mode (default: bcftools is
                        directly called as it is in user $PATH)
  -R SNPS, --snps SNPS  List of SNPs to consider in the normal sample
                        (default: heterozygous SNPs are inferred from the
                        normal sample)
  -j PROCESSES, --processes PROCESSES
                        Number of available parallel processes (default: 2)
  -q READQUALITY, --readquality READQUALITY
                        Minimum mapping quality for an aligned read to be
                        considered (default: 0)
  -Q BASEQUALITY, --basequality BASEQUALITY
                        Minimum base quality for a base to be considered
                        (default: 11)
  -c MINCOV, --mincov MINCOV
                        Minimum coverage for SNPs to be considered (default:
                        0)
  -C MAXCOV, --maxcov MAXCOV
                        Maximum coverage for SNPs to be considered (default:
                        1000, suggested: twice the values of expected average
                        coverage to avoid aligning artefacts)
  -E, --newbaq          Recompute alignment of reads on the fly during SNP
                        calling (default: false)
  -o OUTPUTSNPS, --outputsnps OUTPUTSNPS
                        Output folder for SNPs separated by chromosome
                        (default: ./)
  --chromosomes [CHROMOSOMES ...]
                        One or more chromosomes to process (default: blank to
                        process all chromosomes)
  -v, --verbose         Use verbose log messages
  -V, --version         show program's version number and exit
```

## hatchet_count_alleles

### Tool Description
Count the A/B alleles from a matched-normal BAM file and tumor BAM files in specified SNP positions.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:15]# Parsing the input arguments, checking the consistency of given files, and extracting required information
usage: hatchet count-alleles [-h] -N NORMAL -T TUMORS [TUMORS ...] -r
                             REFERENCE -L SNPS [SNPS ...]
                             [-S SAMPLES [SAMPLES ...]] [-st SAMTOOLS]
                             [-bt BCFTOOLS] [-j PROCESSES] [-q READQUALITY]
                             [-Q BASEQUALITY] [-U SNPQUALITY] [-g GAMMA]
                             [-b MAXSHIFT] [-c MINCOV] [-C MAXCOV] [-E]
                             [-O OUTPUTNORMAL] [-o OUTPUTTUMORS]
                             [-l OUTPUTSNPS] [--chromosomes [CHROMOSOMES ...]]
                             [-v] [-V]

Count the A/B alleles from a matched-normal BAM file and multiple tumor BAM
files in specified SNP positions or estimated heterozygous SNPs in the normal
genome. This tool can be applied both to whole-genome sequencing (WGS) data or
whole-exome sequencing (WES) data, but coding regions must be specified as a
BED file in the case of WES.

options:
  -h, --help            show this help message and exit
  -N NORMAL, --normal NORMAL
                        BAM file corresponding to matched normal sample
  -T TUMORS [TUMORS ...], --tumors TUMORS [TUMORS ...]
                        BAM files corresponding to samples from the same tumor
  -r REFERENCE, --reference REFERENCE
                        Human reference genome of BAMs
  -L SNPS [SNPS ...], --snps SNPS [SNPS ...]
                        List of SNPs to consider in the normal sample
  -S SAMPLES [SAMPLES ...], --samples SAMPLES [SAMPLES ...]
                        Sample names for each BAM (given in the same order
                        where the normal name is first)
  -st SAMTOOLS, --samtools SAMTOOLS
                        Path to the directory to "samtools" executable,
                        required in default mode (default: samtools is
                        directly called as it is in user $PATH)
  -bt BCFTOOLS, --bcftools BCFTOOLS
                        Path to the directory of "bcftools" executable,
                        required in default mode (default: bcftools is
                        directly called as it is in user $PATH)
  -j PROCESSES, --processes PROCESSES
                        Number of available parallel processes (default: 2)
  -q READQUALITY, --readquality READQUALITY
                        Minimum mapping quality for an aligned read to be
                        considered (default: 0)
  -Q BASEQUALITY, --basequality BASEQUALITY
                        Minimum base quality for a base to be considered
                        (default: 11)
  -U SNPQUALITY, --snpquality SNPQUALITY
                        Minimum SNP-variant quality, QUAL, for a variant to be
                        considered (default: 11)
  -g GAMMA, --gamma GAMMA
                        Level of confidence to determine heterozigosity of
                        SNPs (default: 0.05)
  -b MAXSHIFT, --maxshift MAXSHIFT
                        Maximum allowed absolute difference of BAF from 0.5
                        for selected heterozygous SNPs in the normal sample
                        (default: 0.5)
  -c MINCOV, --mincov MINCOV
                        Minimum coverage for SNPs to be considered (default:
                        0)
  -C MAXCOV, --maxcov MAXCOV
                        Maximum coverage for SNPs to be considered (default:
                        1000, suggested: twice the values of expected average
                        coverage to avoid aligning artefacts)
  -E, --newbaq          Recompute alignment of reads on the fly during SNP
                        calling (default: false)
  -O OUTPUTNORMAL, --outputnormal OUTPUTNORMAL
                        Filename of output for allele counts in the normal
                        sample (default: standard output)
  -o OUTPUTTUMORS, --outputtumors OUTPUTTUMORS
                        Output filename for allele counts in tumor samples
                        (default: standard output)
  -l OUTPUTSNPS, --outputsnps OUTPUTSNPS
                        Output directory for lists of selected SNPs (default:
                        ./)
  --chromosomes [CHROMOSOMES ...]
                        One or more chromosomes to process (default: blank to
                        process all chromosomes)
  -v, --verbose         Use verbose log messages
  -V, --version         show program's version number and exit
```

## hatchet_combine_counts

### Tool Description
Perform adaptive binning, compute RDR and BAF for each bin, and produce a BB file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:19]# Parsing and checking input arguments
usage: hatchet [-h] -A ARRAY -t TOTALCOUNTS -b BAFFILE -r REFERENCEFASTA -o
               OUTFILE [--msr MSR] [--mtr MTR] [-j PROCESSES] [-p PHASE]
               [-s MAX_BLOCKSIZE] [-m MAX_SPB] [-a ALPHA] [--ss_em] [-z] -V
               REFVERSION

Perform adaptive binning, compute RDR and BAF for each bin, and produce a BB
file.

options:
  -h, --help            show this help message and exit
  -A ARRAY, --array ARRAY
                        Directory containing array files (output from
                        "count_reads" command)
  -t TOTALCOUNTS, --totalcounts TOTALCOUNTS
                        Total read counts in the format "SAMPLE COUNT" used to
                        normalize by the different number of reads extracted
                        from each sample
  -b BAFFILE, --baffile BAFFILE
                        1bed file containing SNP information from tumor
                        samples (i.e., baf/bulk.1bed)
  -r REFERENCEFASTA, --referencefasta REFERENCEFASTA
                        path to the reference genome fasta file
  -o OUTFILE, --outfile OUTFILE
                        Filename for output
  --msr MSR             Minimum SNP reads per bin (default 5000)
  --mtr MTR             Minimum total reads per bin (default 5000)
  -j PROCESSES, --processes PROCESSES
                        Number of parallel processes to use (default 1)
  -p PHASE, --phase PHASE
                        VCF file containing phasing for heterozygous germline
                        SNPs
  -s MAX_BLOCKSIZE, --max_blocksize MAX_BLOCKSIZE
                        Maximum size of phasing block (default 25000)
  -m MAX_SPB, --max_spb MAX_SPB
                        Maximum number of SNPs per phasing block (default 10)
  -a ALPHA, --alpha ALPHA
                        Significance level for phase blocking adjacent SNPs.
                        Higher means less trust in phasing. (default 0.1)
  --ss_em               Use single-sample EM BAF inference (instead of multi-
                        sample)
  -z, --not_compressed  Non-compressed intermediate files
  -V REFVERSION, --refversion REFVERSION
                        Version of reference genome used in BAM files
```

## hatchet_combine_counts_fw

### Tool Description
Combine tumor bin counts, normal bin counts and tumor allele counts into read-depth ratio and BAF of each bin (BB file).

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:07]# Parsing and checking input arguments
usage: hatchet combine-counts [-h] -c NORMALBINS -C TUMORBINS -B TUMORBAFS
                              [-p PHASE] [-d DIPLOIDBAF] [-l BLOCKLENGTH]
                              [-t TOTALCOUNTS] [-g GAMMA] [-e SEED] [-v] [-r]
                              [-V]

Combine tumor bin counts, normal bin counts, and tumor allele counts to obtain the read-depth ratio and the mean B-allel frequency (BAF) of each bin. Optionally, the normal allele counts can be provided to add the BAF of each bin scaled by the normal BAF. The output is written on stdout.

options:
  -h, --help            show this help message and exit
  -c NORMALBINS, --normalbins NORMALBINS
                        Normal bin counts in the format "SAMPLE	CHR	START	END	COUNT"
  -C TUMORBINS, --tumorbins TUMORBINS
                        Tumor bin counts in the format "SAMPLE	CHR	START	END	COUNT"
  -B TUMORBAFS, --tumorbafs TUMORBAFS
                        Tumor allele counts in the format "SAMPLE	CHR	POS	REF-COUNT	ALT-COUNT"
  -p PHASE, --phase PHASE
                        Phasing of heterozygous germline SNPs in the format "CHR	POS	<string containing 0|1 or 1|0>"
  -d DIPLOIDBAF, --diploidbaf DIPLOIDBAF
                        Maximum diploid-BAF shift used to select the bins whose BAF should be normalized by the normal when normalbafs is given (default: 0.1)
  -l BLOCKLENGTH, --blocklength BLOCKLENGTH
                        Size of the haplotype blocks, specified as a full number or using the notations either "kb" or "Mb"  (default: 50kb)
  -t TOTALCOUNTS, --totalcounts TOTALCOUNTS
                        Total read counts in the format "SAMPLE	COUNT" used to normalize by the different number of reads extracted from each sample (default: none)
  -g GAMMA, --gamma GAMMA
                        Confidence level used to determine if a bin is copy neutral with BAF of 0.5 in the BINOMIAL_TEST mode (default: 0.05)
  -e SEED, --seed SEED  Random seed used for the normal distributions used in the clouds (default: 0)
  -v, --verbose         Use verbose log messages
  -r, --disablebar      Disable progress bar
  -V, --version         show program's version number and exit
```

## hatchet_cluster_bins

### Tool Description
Cluster the bins of a BB file with a hidden Markov model into segments and a BBC file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:22]# Parsing and checking input arguments
usage: hatchet cluster-bins [-h] [-o OUTSEGMENTS] [-O OUTBINS] [-d DIPLOIDBAF]
                            [--minK MINK] [--maxK MAXK] [--exactK EXACTK]
                            [-t TRANSMAT] [--tau TAU] [-c COVAR] [-x DECODING]
                            [-s SELECTION] [-R RESTARTS]
                            [-S SUBSET [SUBSET ...]] [--allow_gaps] [-V]
                            BBFILE

Combine tumor bin counts, normal bin counts, and tumor allele counts to obtain the read-depth ratio and the mean B-allel frequency (BAF) of each bin. Optionally, the normal allele counts can be provided to add the BAF of each bin scaled by the normal BAF. The output is written on stdout.

positional arguments:
  BBFILE                A BB file containing a line for each bin in each sample and the corresponding values of read-depth ratio and B-allele frequency (BAF)

options:
  -h, --help            show this help message and exit
  -o OUTSEGMENTS, --outsegments OUTSEGMENTS
                        Output filename for the segments computed by clustering bins (default: stdout)
  -O OUTBINS, --outbins OUTBINS
                        Output filename for a BB file adding the clusters (default: stdout)
  -d DIPLOIDBAF, --diploidbaf DIPLOIDBAF
                        Maximum diploid-BAF shift used to determine the largest copy-neutral cluster and to rescale all the cluster inside this threshold accordingly (default: 0.1)
  --minK MINK           Minimum number of clusters to infer (default = 5)
  --maxK MAXK           Maximum number of clusters to infer (default = 30)
  --exactK EXACTK       Skip model selection and infer exactly this many clusters (default: None)
  -t TRANSMAT, --transmat TRANSMAT
                        Form of transition matrix to infer: fixed, diag (1-parameter), or full (default: diag)
  --tau TAU             Off-diagonal value for initializing transition matrix (default: 1e-06)
  -c COVAR, --covar COVAR
                        Form of covariance matrix: spherical, diag, full, or tied (default: diag)
  -x DECODING, --decoding DECODING
                        Decoding algorithm to use: map or viterbi (default: map)
  -s SELECTION, --selection SELECTION
                        Number of HMM states selection criterion: bic or silhouette (default: bic)
  -R RESTARTS, --restarts RESTARTS
                        Number of restarts performed by the clustering to choose the best (default: 10)
  -S SUBSET [SUBSET ...], --subset SUBSET [SUBSET ...]
                        List of sample names to use as a subset of those included in binning(default: none, run on all samples)
  --allow_gaps          Set this flag to allow gaps in chromosomes (each contiguous region is considered a separate "arm").
  -V, --version         show program's version number and exit
```

## hatchet_cluster_bins_gmm

### Tool Description
Cluster the bins of a BB file with a Dirichlet-process Gaussian mixture model into segments and a BBC file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:37]# Parsing and checking input arguments
usage: hatchet cluster-bins [-h] [-o OUTSEGMENTS] [-O OUTBINS] [-d DIPLOIDBAF]
                            [-tR TOLERANCERDR] [-tB TOLERANCEBAF]
                            [-u BOOTCLUSTERING] [-dR RATIODEVIATION]
                            [-dB BAFDEVIATION] [-e SEED] [-K INITCLUSTERS]
                            [-c CONCENTRATION] [-R RESTARTS] [-v]
                            [--disablebar] [-V]
                            BBFILE

Combine tumor bin counts, normal bin counts, and tumor allele counts to obtain the read-depth ratio and the mean B-allel frequency (BAF) of each bin. Optionally, the normal allele counts can be provided to add the BAF of each bin scaled by the normal BAF. The output is written on stdout.

positional arguments:
  BBFILE                A BB file containing a line for each bin in each sample and the corresponding values of read-depth ratio and B-allele frequency (BAF)

options:
  -h, --help            show this help message and exit
  -o OUTSEGMENTS, --outsegments OUTSEGMENTS
                        Output filename for the segments computed by clustering bins (default: stdout)
  -O OUTBINS, --outbins OUTBINS
                        Output filename for a BB file adding the clusters (default: stdout)
  -d DIPLOIDBAF, --diploidbaf DIPLOIDBAF
                        Maximum diploid-BAF shift used to determine the largest copy-neutral cluster and to rescale all the cluster inside this threshold accordingly (default: None, scaling is not performed)
  -tR TOLERANCERDR, --tolerancerdr TOLERANCERDR
                        Refine the clustering merging the clusters with this maximum difference in RDR values (default: None, gurobipy required)
  -tB TOLERANCEBAF, --tolerancebaf TOLERANCEBAF
                        Refine the clustering merging the clusters with this maximum difference in BAF values (default: None,  gurobipy required)
  -u BOOTCLUSTERING, --bootclustering BOOTCLUSTERING
                        Number of points to add for bootstraping each bin to improve the clustering. Each point is generated by drawing its values from a normal distribution centered on the values of the bin. This can help the clustering when the input number of bins is low (default: 0)
  -dR RATIODEVIATION, --ratiodeviation RATIODEVIATION
                        Standard deviation of the read ratios used to generate the points in the clouds (default: 0.02)
  -dB BAFDEVIATION, --bafdeviation BAFDEVIATION
                        Standard deviation of the BAFs used to generate the points in the clouds (default: 0.02)
  -e SEED, --seed SEED  Random seed used for clustering AND the normal distributions used in the clouds (default: 0)
  -K INITCLUSTERS, --initclusters INITCLUSTERS
                        The maximum number of clusters to infer (default: 50)
  -c CONCENTRATION, --concentration CONCENTRATION
                        Tuning parameter for clustering (concentration parameter for Dirichlet process prior). Higher favors more clusters, lower favors fewer clusters (default 0.02 = 1/K).
  -R RESTARTS, --restarts RESTARTS
                        Number of restarts performed by the clustering to choose the best (default: 10)
  -v, --verbose         Use verbose log messages
  --disablebar          Disable progress bar
  -V, --version         show program's version number and exit
```

## hatchet_plot_bins

### Tool Description
Plot read-depth ratio, B-allele frequency and clusters of genomic bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
# Parsing and checking input arguments
usage: hatchet plot-bins [-h] [-c COMMAND] [-s SEGFILE] [-m COLORMAP]
                         [-tC CHRTHRESHOLD] [-tS SIZETHRESHOLD]
                         [--resolution RESOLUTION] [--xmin XMIN] [--xmax XMAX]
                         [--ymin YMIN] [--ymax YMAX] [--figsize FIGSIZE]
                         [--markersize MARKERSIZE] [--colwrap COLWRAP]
                         [--fontscale FONTSCALE] [-x RUNDIR] [--pdf]
                         [--dpi DPI] [-V]
                         INPUT

Generate plots for read-depth ratio (RD), B-allele frequency (BAF), and clusters for genomic  bins in multiple samples using .bb, .cbb, .seg files.

positional arguments:
  INPUT                 Input BBC file with RDR and BAF

options:
  -h, --help            show this help message and exit
  -c COMMAND, --command COMMAND
                        The command determining the plots to generate (default: all)

                        	RD: Plot the read-depth ratio  (RD) values of the genomes for each sample.

                        	CRD: Plot the read-depth ratio (CRD) values of  the genomes for each sample colored by corresponding cluster.

                        	BAF: Plot the B-allele  frequency (BAF) values of the genomes for each sample.

                        	CBAF: Plot BAF values for each  sample colored by corresponding cluster.

                        	BB: Plot jointly the values of read-depth ratio  (RD) and B-allele frequency (BAF) for each bin in all samples and their density.

                        	CBB: Plot  jointly the values of read-depth ratio (RD) and B-allele frequency (BAF) for each bin in all samples  by coloring the bins depending on their cluster.

                        	CLUSTER: Plot jointly the values of read-depth ratio (RD) and B-allele frequency (BAF) for each cluster in all samples where the size of  the markers is proportional to the number of bins.
  -s SEGFILE, --segfile SEGFILE
                        When the corresponding seg file is provided the clusters are also plotted (default: none)
  -m COLORMAP, --colormap COLORMAP
                        Colormap to use for the colors in the plots, the available colormaps are the following {Set1, Set2, Paired, Dark2, tab10, tab20}
  -tC CHRTHRESHOLD, --chrthreshold CHRTHRESHOLD
                        Only covering at least this number of chromosomes are considered (default: None)
  -tS SIZETHRESHOLD, --sizethreshold SIZETHRESHOLD
                        Only covering at least this genome proportion (default: None)
  --resolution RESOLUTION
                        Resolution of bins (default: bins are not merged)
  --xmin XMIN           Minimum value on x-axis for supported plots (default: inferred from data)
  --xmax XMAX           Maximum value on x-axis for supported plots (default: inferred from data)
  --ymin YMIN           Minimum value on y-axis for supported plots (default: inferred from data)
  --ymax YMAX           Maximum value on y-axis for supported plots (default: inferred from data)
  --figsize FIGSIZE     Size of the plotted figures in the form "(X-SIZE, Y-SIZE)"
  --markersize MARKERSIZE
                        Size of the markers (default: values inferred for each plot)
  --colwrap COLWRAP     Wrapping the plots in this number of columnes (default: 2)
  --fontscale FONTSCALE
                        Font scale (default: 1)
  -x RUNDIR, --rundir RUNDIR
                        Running dirrectory where output the results (default: current directory)
  --pdf                 Output the bb_clustered figure in PDF format (default: PNG)
  --dpi DPI             DPI of PNG images (default: 900)
  -V, --version         show program's version number and exit
```

## hatchet_plot_bins_1d2d

### Tool Description
Plot one- and two-dimensional views of RDR and mirrored BAF of the bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
# Checking and parsing input arguments
usage: hatchet plot-cn [-h] -b BBC [-s SEG] -O OUTDIR [--baflim BAFLIM]
                       [--rdrlim RDRLIM] [--centers] [--centromeres]
                       [-a ALPHA]

options:
  -h, --help            show this help message and exit
  -b BBC, --bbc BBC     Filename for BBC table (e.g., bbc/bulk.bbc)
  -s SEG, --seg SEG     Filename for SEG table (e.g., bbc/bulk.seg) optional but required to show cluster centers
  -O OUTDIR, --outdir OUTDIR
                        Directory for output files
  --baflim BAFLIM       Axis limits for mirrored BAF as comma-separated values, e.g., '0,0.51' (default: None -- show full range of data)
  --rdrlim RDRLIM       Axis limits for read-depth ratio as comma-separated values, e.g., '0,3' (default: None -- show full range of data)
  --centers             Show cluster centers (requires SEG file provided via -s/--seg)
  --centromeres         Mark centromere locations with grey rectangles
  -a ALPHA, --alpha ALPHA
                        Opacity alpha (default 1)
```

## hatchet_compute_cn

### Tool Description
Infer allele-specific copy numbers, clone proportions and tumor purity/ploidy with the HATCHet solver.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
# Checking and parsing input arguments
# Checking and parsing input arguments
usage: hatchet compute-cn [-h] -i INPUT [-x RUNNINGDIR] [-n CLONES] [-f]
                          [-c CLONAL] [-d CNSTATES] [-eD DIPLOIDCMAX]
                          [-eT TETRAPLOIDCMAX] [-ts MINSIZE] [-tc MINCHRS]
                          [-td MAXNEUTRALSHIFT] [--merge] [-mR MERGERDR]
                          [-mB MERGEBAF] [-l LIMITINC] [-g GHOSTPROP]
                          [-tR TOLERANCERDR] [-tB TOLERANCEBAF] [-p SEEDS]
                          [-j JOBS] [-r RANDOMSEED] [-s TIMELIMIT]
                          [-m MEMLIMIT] [-u MINPROP]
                          [--maxiterations MAXITERATIONS] [--mode MODE]
                          [--diploid] [--tetraploid] [-v VERBOSITY] [-V] [-b]
                          [-P PURITIES]
                          [SOLVER]

positional arguments:
  SOLVER                Path to the executable solver

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Prefix path to seg and bbc input files (required)
  -x RUNNINGDIR, --runningdir RUNNINGDIR
                        Running directory (default: ./)
  -n CLONES, --clones CLONES
                        Either an estimated number of clones or an interval where the
                        number of clones should be looked for given in the form LOWER,UPPER where LOWER and UPPER are two integer defining the interval (default: 2,8)
  -f, --noampdel        Remove amp-del assumption where each mutated allele of every segment can be either amplified or deleted in all tumor clones w.r.t. base (2 for diploid and 4 for tetraploid) (default: use assumption)
  -c CLONAL, --clonal CLONAL
                        Clonal clusters to fix for tetraploid (default: automatically inferred)
  -d CNSTATES, --cnstates CNSTATES
                        Maximum number of distinct copy-number states for each segment (default: None, no limit)
  -eD DIPLOIDCMAX, --diploidcmax DIPLOIDCMAX
                        Maximum copy-number value overall segments (default: 6, 0 means inferred from scaled fractional copy numbers)
  -eT TETRAPLOIDCMAX, --tetraploidcmax TETRAPLOIDCMAX
                        Maximum copy-number value overall segments (default: 12, 0 means inferred from scaled fractional copy numbers)
  -ts MINSIZE, --minsize MINSIZE
                        The minimum proportion of covered genome for potential clonal clusters (default: 0.008)
  -tc MINCHRS, --minchrs MINCHRS
                        The minimum number of covered chromosomes for potential clonal clusters (default: 1)
  -td MAXNEUTRALSHIFT, --maxneutralshift MAXNEUTRALSHIFT
                        Maximum BAF shift for neutral cluster used to automatically infer the diploid/tetraploid cluster (default: 0.1)
  --merge               Merge the clusters (default: false)
  -mR MERGERDR, --mergeRDR MERGERDR
                        RDR tolerance used for finding the clonal copy numbers (default: 0.08)
  -mB MERGEBAF, --mergeBAF MERGEBAF
                        BAF tolerance used for finding the clonal copy numbers (default: 0.04)
  -l LIMITINC, --limitinc LIMITINC
                        Upper bound to the relative increase of objective function. When there are significant small CNAs, their effect on the objective function may be confounded by only larger events, use this value to limit the relative increase of OBJ so that fitting small CNAs is more considered (default: None)
  -g GHOSTPROP, --ghostprop GHOSTPROP
                        Increasing proportion used to compute the value of the first ghost point added in the solution selection (default: 0.3)
  -tR TOLERANCERDR, --toleranceRDR TOLERANCERDR
                        RDR tolerance used for finding the clonal copy numbers (default: 0.08)
  -tB TOLERANCEBAF, --toleranceBAF TOLERANCEBAF
                        BAF tolerance used for finding the clonal copy numbers (default: 0.04)
  -p SEEDS, --seeds SEEDS
                        Number of seeds for coordinate-descent method (default: 400)
  -j JOBS, --jobs JOBS  Number of parallel jobs (default: maximum available on the machine)
  -r RANDOMSEED, --randomseed RANDOMSEED
                        Random seed (default: None)
  -s TIMELIMIT, --timelimit TIMELIMIT
                        Time limit for each ILP run (default: None)
  -m MEMLIMIT, --memlimit MEMLIMIT
                        Memory limit for each ILP run (default: None)
  -u MINPROP, --minprop MINPROP
                        Minimum clone proporion in each sample (default: 0.03)
  --maxiterations MAXITERATIONS
                        Maximum number of iterations composed of C-step/U-step for each seed (default: 10)
  --mode MODE           Solving mode among: Coordinate Descent + exact ILP (0), exact ILP only (1), and Coordinate-descent only (2) (default: 2)
  --diploid             Force the tumor clones to be diploid without WGD (default: false)
  --tetraploid          Force the tumor clones to be tetraploid with an occured WGD (default: false)
  -v VERBOSITY, --verbosity VERBOSITY
                        Level of verbosity among: none (0), essential (1), verbose (2), and debug (3) (default: 1)
  -V, --version         show program's version number and exit
  -b, --binwise         Use bin-wise objective function which requires more variables and constraints but accounts for cluster variances (default False). Only works with non-cpp solvers.
  -P PURITIES, --purities PURITIES
                        To fix purities for each sample, pass a space-separated list of purities
```

## hatchet_plot_cn

### Tool Description
Plot inferred copy numbers, clone proportions and clone profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
# Checking and parsing input arguments
usage: hatchet plot-cn [-h] [-n PATIENTNAMES] [-u MINU] [-x RUNDIR]
                       [-b BASECN] [-sC FIGSIZECLONES] [-sP FIGSIZECN]
                       [-sG FIGSIZEGRID] [-rC RESOLUTIONCLONES]
                       [-rP RESOLUTIONCN] [-rG RESOLUTIONGRID] [-e THRESHOLD]
                       [--ymax YMAX] [--ymin YMIN]
                       [--clonepalette CLONEPALETTE] [--linkage LINKAGE] [-V]
                       INPUT

positional arguments:
  INPUT                 One or more space-separated files in CN_BBC format

options:
  -h, --help            show this help message and exit
  -n PATIENTNAMES, --patientnames PATIENTNAMES
                        One or more space-separated patient names (default: inferred from filenames)
  -u MINU, --minu MINU  Minimum proportion of a CNA to be considered subclonal (default: 0.2)"
  -x RUNDIR, --rundir RUNDIR
                        Running directory (default: current directory)
  -b BASECN, --baseCN BASECN
                        Base copy number (default: inferred from tumor ploidy)
  -sC FIGSIZECLONES, --figsizeclones FIGSIZECLONES
                        Size of clone plots in the form "(X-SIZE, Y-SIZE)"
  -sP FIGSIZECN, --figsizecn FIGSIZECN
                        Size of CN plots in the form "(X-SIZE, Y-SIZE)"
  -sG FIGSIZEGRID, --figsizegrid FIGSIZEGRID
                        Size of grid plots in the form "(X-SIZE, Y-SIZE)"
  -rC RESOLUTIONCLONES, --resolutionclones RESOLUTIONCLONES
                        Number of bins to merge together for plotting clone profiles (default: 100)"
  -rP RESOLUTIONCN, --resolutioncn RESOLUTIONCN
                        Number of bins to merge together for plotting proportions (default: 500)"
  -rG RESOLUTIONGRID, --resolutiongrid RESOLUTIONGRID
                        Number of bins to merge together in grids (default: 100)"
  -e THRESHOLD, --threshold THRESHOLD
                        Threshold used to classify a tumor into either diploid or tetraploid (default: 3.0)"
  --ymax YMAX           Maximum values in y-axis (default: automatically inferred)"
  --ymin YMIN           Minimum values in y-axis (default: automatically inferred)"
  --clonepalette CLONEPALETTE
                        Palette for coloring the clones among Set1, Set2, Set3, Paired (default: Set1)"
  --linkage LINKAGE     Linkage method used for clustering (default: single, available (single, complete, average, weighted, centroid, median, ward) from SciPy)"
  -V, --version         show program's version number and exit
```

## hatchet_plot_cn_1d2d

### Tool Description
Plot one- and two-dimensional views of fractional copy numbers and mirrored BAF.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
# Checking and parsing input arguments
usage: hatchet plot-cn [-h] -O OUTDIR [--baflim BAFLIM] [--fcnlim FCNLIM]
                       [--centromeres] [--bysample]
                       INPUT

positional arguments:
  INPUT                 Filename for BBC table (e.g., results/best.bbc.ucn)

options:
  -h, --help            show this help message and exit
  -O OUTDIR, --outdir OUTDIR
                        Directory for output files
  --baflim BAFLIM       Axis limits for mirrored BAF values to show as comma-separated values, e.g., '0,0.51' (default: None -- show full range of data)
  --fcnlim FCNLIM       Axis limits for fractional copy number values to show as comma-separated values, e.g., '0,3' (default: None -- show full range of data)
  --centromeres         Mark centromere locations with grey rectangles
  --bysample            Write each sample to a separate file rather than combining all into 2 file
```

## hatchet_phase_snps

### Tool Description
Phase germline SNPs using a reference panel.

### Metadata
- **Docker Image**: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
- **Homepage**: https://github.com/raphael-group/hatchet
- **Package**: https://anaconda.org/channels/bioconda/packages/hatchet/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-Oct-08 23:14:49]# log notes
usage: hatchet [-h] [-D REFPANELDIR] -g REFGENOME -V REFVERSION [-N]
               [-o OUTDIR] -L SNPS [SNPS ...] [-j PROCESSES] [-si SHAPEIT]
               [-pc PICARD] [-bt BCFTOOLS] [-bg BGZIP]

Phase germline SNPs using a reference panel

options:
  -h, --help            show this help message and exit
  -D REFPANELDIR, --refpaneldir REFPANELDIR
                        Path to Reference Panel
  -g REFGENOME, --refgenome REFGENOME
                        Path to Reference genome used in BAM files
  -V REFVERSION, --refversion REFVERSION
                        Version of reference genome used in BAM files
  -N, --chrnotation     Use this flag to indicate that chromosomes are named
                        with "chr" (default: no "chr")
  -o OUTDIR, --outdir OUTDIR
                        Output folder for phased VCFs
  -L SNPS [SNPS ...], --snps SNPS [SNPS ...]
                        List of SNPs in the normal sample to phase
  -j PROCESSES, --processes PROCESSES
                        Number of available parallel processes (default: 2)
  -si SHAPEIT, --shapeit SHAPEIT
                        Path to shapeit executable (default: look in $PATH)
  -pc PICARD, --picard PICARD
                        Path to picard executable or jar (default: look in
                        $PATH)
  -bt BCFTOOLS, --bcftools BCFTOOLS
                        Path to the directory of "bcftools" executable
                        (default: look in $PATH)
  -bg BGZIP, --bgzip BGZIP
                        Path to the directory of "bcftools" executable
                        (default: look in $PATH)
```

## Metadata
- **Skill**: generated

