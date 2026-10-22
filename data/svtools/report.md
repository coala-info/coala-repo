# svtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svtools_afreq | PASS |  |
| svtools_bedpesort | Failed | image problem: sort in the image is BusyBox and rejects the -k1,1V key the script uses |
| svtools_bedpetobed12 | PASS |  |
| svtools_bedpetovcf | PASS |  |
| svtools_classify | PASS |  |
| svtools_copynumber | Not completed | needs the CNVnator program and a CNVnator .root histogram file; neither is in the image or in test data |
| svtools_create_coordinates | PASS |  |
| svtools_genotype | PASS |  |
| svtools_lmerge | PASS | output equals the expected file up to float rounding (relative difference below 1e-11) |
| svtools_lsort | PASS |  |
| svtools_prune | PASS |  |
| svtools_svtools_vcftobedpe | PASS |  |
| svtools_varlookup | PASS |  |
| svtools_vcfpaste | PASS |  |
| svtools_vcfsort | Failed | image problem: sort in the image is BusyBox and rejects the -k1,1V key the script uses |

## svtools_afreq

### Tool Description
Add allele frequency information to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools afreq [-h] [-t <DIR>] [<VCF>]

positional arguments:
  <VCF>                 VCF input

optional arguments:
  -h, --help            show this help message and exit
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

Specify the path to an (optionally) bgzipped VCF. If no file is specified then
input is read from stdin.
```

## svtools_bedpetovcf

### Tool Description
Convert a BEDPE file to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools bedpetovcf [-h] [-i <BEDPE>] [-o <VCF>] [-t <DIR>]

optional arguments:
  -h, --help            show this help message and exit
  -i <BEDPE>, --input <BEDPE>
                        BEDPE input (default: stdin)
  -o <VCF>, --output <VCF>
                        Output VCF to write (default: stdout)
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

The input BEDPE file can be gzipped if it is specified explicitly.
```

## svtools_vcfsort

### Tool Description
Sort a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools vcfsort [-h] [<VCF>] [<VCF>]

positional arguments:
  <VCF>       VCF file to sort (default: stdin)
  <VCF>       output file to write to (default: stdout)

optional arguments:
  -h, --help  show this help message and exit

To read in stdin and output to a file, use /dev/stdin or - as the first
positional argument.
```

## svtools_bedpesort

### Tool Description
Sort a BEDPE file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools bedpesort [-h] [<BEDPE file>] [<output file>]

positional arguments:
  <BEDPE file>   BEDPE file to sort
  <output file>  output file to write to

optional arguments:
  -h, --help     show this help message and exit

To read in stdin and output to a file, use /dev/stdin or - as the first
positional argument.
```

## svtools_lsort

### Tool Description
Combine and sort multiple VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools lsort [-h] [-f <FILE>] [-r] [-t <DIRECTORY_PATH>] [-b <INT>]
                     [<VCF> [<VCF> ...]]

positional arguments:
  <VCF>                 VCF files to combine and sort

optional arguments:
  -h, --help            show this help message and exit
  -f <FILE>, --vcf-list <FILE>
                        file containing a line-delimited list of VCF files to
                        combine and sort
  -r, --include-reference
                        whether or not to include homozygous reference or
                        missing calls in the output.
  -t <DIRECTORY_PATH>, --tempdir <DIRECTORY_PATH>
                        temporary directory
  -b <INT>, --batchsize <INT>
                        number of files to sort in batch

Specify -t to override where temporary files are placed. Use -b to control the
amount of memory required. This will vary depending on the number of lines in
your input files. VCF files may be gzipped and the -f argument is available
for convenience.
```

## svtools_lmerge

### Tool Description
Merge variant calls in a VCF file sorted by svtools lsort.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools lmerge [-h] [-i <FILE>] [-p <FLOAT>] [-f <INT>] [--sum] [-g]
                      [-w <STRING>] [-t <DIR>]

optional arguments:
  -h, --help            show this help message and exit
  -i <FILE>, --inFile <FILE>
                        a sorted VCF file generated by svtools lsort. Each
                        INFO field must contain an SNAME tag containing the
                        sample name (e.g. SNAME=SAMPLE_NAME)
  -p <FLOAT>, --percent-slop <FLOAT>
                        increase the the breakpoint confidence interval both
                        up and down stream by a given proportion of the
                        original size
  -f <INT>, --fixed-slop <INT>
                        increase the the breakpoint confidence interval both
                        up and down stream by a given fixed size
  --sum                 calculate breakpoint PDF and position using sum
                        algorithm instead of product
  -g                    include original genotypes in output. When multiple
                        variants are merged, the last will dictate the
                        genotype field
  -w <STRING>           weighting scheme (intended for use in tiered merging),
                        options: unweighted, carrier_wt, evidence_wt
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

Note that if both slop parameters are set then the maximum is used.
```

## svtools_vcfpaste

### Tool Description
Paste VCF files from multiple samples into one VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools vcfpaste [-h] -f <FILE> [-m <VCF>] [-t <DIR>] [-q]

optional arguments:
  -h, --help            show this help message and exit
  -f <FILE>, --vcf-list <FILE>
                        file containing a line-delimited list of VCF files to
                        paste (required)
  -m <VCF>, --master <VCF>
                        VCF file to set first 8 columns of variant info
                        (otherwise first file in --vcf-list)
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads
  -q, --sum-quals       sum QUAL scores of input VCFs as output QUAL score

VCF files may be gzipped. If the -m argument is omitted then the first file in
the list of files in --vcf-list is treated as the master.
```

## svtools_prune

### Tool Description
Cluster and prune a BEDPE file of breakpoint calls, keeping the best call per cluster.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools prune [-h] [-d <INT>] [-e <STRING>] [-s] [-o <BEDPE>]
                     [-t <DIR>]
                     [<BEDPE>]

positional arguments:
  <BEDPE>               BEDPE file to read. If '-' or absent then defaults to
                        stdin.

optional arguments:
  -h, --help            show this help message and exit
  -d <INT>, --distance <INT>
                        max separation distance (bp) of adjacent loci in
                        cluster [50]
  -e <STRING>, --eval-param <STRING>
                        evaluating parameter for choosing best bedpe in a
                        cluster(e.g. af=AlleleFrequency default:af)
  -s, --is-sorted       specify if an input file is sorted. Sort with svtools
                        bedpesort. (default=False)
  -o <BEDPE>, --output <BEDPE>
                        output bedpe to write (default: stdout)
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

The input BEDPE file can be gzipped if it is specified explicitly.
```

## svtools_varlookup

### Tool Description
Look up variants of a pruned, merged BEDPE (A file) in another pruned, merged BEDPE (B file).

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools varlookup [-h] [-d <INT>] [-a <BEDPE>] [-b <BEDPE>]
                         [-c <STRING>] [-o <BEDPE>]

optional arguments:
  -h, --help            show this help message and exit
  -d <INT>, --distance <INT>
                        max separation distance (bp) of adjacent loci between
                        bedpe files [50]
  -a <BEDPE>, --aFile <BEDPE>
                        pruned, merged BEDPE (A file) or standard input (-a
                        stdin).
  -b <BEDPE>, --bFile <BEDPE>
                        pruned merged BEDPE (B file) (-b stdin). For pruning
                        use svtools prune
  -c <STRING>, --cohort <STRING>
                        cohort name to add information of matching variants
                        (default:bFile)
  -o <BEDPE>, --output <BEDPE>
                        output BEDPE to write (default: stdout)
```

## svtools_classify

### Tool Description
Classify structural variants (reclassify DEL/DUP/MEI) in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools classify [-h] [-i <VCF>] [-o <VCF>] -g <FILE> [-a <BED>]
                        [-f <FLOAT>] [-e <FILE>] [-s <FLOAT>] [-r <FLOAT>]
                        [-t <STRING>] [-m <STRING>] [-d <STRING>]
                        [--sex-chrom <STRING>] [--tempdir <DIR>]

optional arguments:
  -h, --help            show this help message and exit
  -i <VCF>, --input <VCF>
                        VCF input
  -o <VCF>, --output <VCF>
                        VCF output [stdout]
  -g <FILE>, --gender <FILE>
                        tab delimited file of sample genders (male=1,
                        female=2) ex: SAMPLE_A 2
  -a <BED>, --annotation <BED>
                        BED file of annotated elements
  -f <FLOAT>, --fraction <FLOAT>
                        fraction of reciprocal overlap to apply annotation to
                        variant [0.9]
  -e <FILE>, --exclude <FILE>
                        list of samples to exclude from classification
                        algorithms
  -s <FLOAT>, --slope_threshold <FLOAT>
                        minimum slope absolute value of regression line to
                        classify as DEL or DUP[1.0]
  -r <FLOAT>, --rsquared_threshold <FLOAT>
                        minimum R^2 correlation value of regression line to
                        classify as DEL or DUP [0.2], for large sample
                        reclassification
  -t <STRING>, --tSet <STRING>
                        high quality deletions & duplications training
                        dataset[vcf], required by naive Bayes reclassification
  -m <STRING>, --method <STRING>
                        reclassification method, one of (large_sample,
                        naive_bayes, hybrid)
  -d <STRING>, --diag_file <STRING>
                        text file to output method comparisons
  --sex-chrom <STRING>  Comma-separated list of sex chromosome names
                        [chrX,chrY]
  --tempdir <DIR>       Directory for temp file downloads
```

## svtools_copynumber

### Tool Description
Add copy number annotations (from CNVnator) to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools copynumber [-h] -c <FILE> -r <FILE> -w <INT> -s <STRING>
                          --cnvnator <PATH> [-i <VCF>] [-o <PATH>] [-t <DIR>]

optional arguments:
  -h, --help            show this help message and exit
  -c <FILE>, --coordinates <FILE>
                        file containing coordinate for which to retrieve
                        copynumber (required)
  -r <FILE>, --root <FILE>
                        CNVnator .root histogram file (required)
  -w <INT>, --window <INT>
                        CNVnator window size (required)
  -s <STRING>, --sample <STRING>
                        sample to annotate (required)
  --cnvnator <PATH>     path to cnvnator binary for the cnvnator used by
                        speedseq (required)
  -i <VCF>, --input <VCF>
                        VCF input
  -o <PATH>, --output <PATH>
                        output VCF to write (default: stdout)
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

As this program runs cnvnator you must provide its location and must remember
to have the ROOT package installed and properly configured. The input VCF file
may be gzipped. If the input VCF file is omitted then the tool reads from
stdin. Note that the coordinates file must end with a line containing the word
exit.
```

## svtools_genotype

### Tool Description
Genotype structural variants in a VCF file using the read evidence in a BAM or CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools genotype [-h] [-i <VCF>] [-o <VCF>] -B <BAM> [-T <FASTA>]
                        [-l <JSON>] [-m <INT>] [-n <INT>] [-q]
                        [--max_reads <INT>] [--max_ci_dist <INT>]
                        [--split_weight <FLOAT>] [--disc_weight <FLOAT>]
                        [-w <BAM>]

optional arguments:
  -h, --help            show this help message and exit
  -i <VCF>, --input_vcf <VCF>
                        VCF input (default: stdin)
  -o <VCF>, --output_vcf <VCF>
                        output VCF to write (default: stdout)
  -B <BAM>, --bam <BAM>
                        BAM or CRAM file
  -T <FASTA>, --ref_fasta <FASTA>
                        Indexed reference FASTA file (recommended for reading
                        CRAM files)
  -l <JSON>, --lib_info <JSON>
                        create/read JSON file of library information
  -m <INT>, --min_aligned <INT>
                        minimum number of aligned bases to consider read as
                        evidence [20]
  -n <INT>              number of pairs to sample from BAM file for building
                        insert size distribution [1000000]
  -q, --sum_quals       add genotyping quality to existing QUAL (default:
                        overwrite QUAL field)
  --max_reads <INT>     maximum number of reads to assess at any variant
                        (reduces processing time in high-depth regions,
                        default: 10000)
  --max_ci_dist <INT>   maximum size of a confidence interval before 95% CI is
                        used intead (default: 1e10)
  --split_weight <FLOAT>
                        weight for split reads [1]
  --disc_weight <FLOAT>
                        weight for discordant paired-end reads [1]
  -w <BAM>, --write_alignment <BAM>
                        write relevant reads to BAM file
```

## svtools_create_coordinates

### Tool Description
Generate the BED coordinate file required by the svtools copynumber annotation program.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: create_coordinates [-h] [-i INPUT_VCF] [-o OUTPUT]

create coordinates
author: Abhijit Badve
version: $Revision: 0.0.1 $
description: Generate Bed file required for copynumber annotations program

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_VCF, --input_vcf INPUT_VCF
                        VCF input
  -o OUTPUT, --output OUTPUT
                        output coordinates to write (default: stdout)
```

## svtools_bedpetobed12

### Tool Description
Convert a BEDPE file to BED12 format for viewing in IGV or the UCSC browser.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtools bedpetobed12 [-h] [-i <BEDPE>] [-o <BED12>] [-n <STRING>]
                            [-d <INT>] [-t <DIR>]

optional arguments:
  -h, --help            show this help message and exit
  -i <BEDPE>, --input <BEDPE>
                        BEDPE input file
  -o <BED12>, --output <BED12>
                        Output BED12 to write (default: stdout)
  -n <STRING>, --name <STRING>
                        The name of the track. Default is 'BEDPE'
  -d <INT>, --maxdist <INT>
                        The minimum distance for drawing intrachromosomal
                        features as if they are interchromosomal (i.e.,
                        without a line spanning the two footprints). Default
                        is 1Mb.
  -t <DIR>, --tempdir <DIR>
                        Directory for temp file downloads

The input BEDPE file may be gzipped. If the input file is omitted then input
is read from stdin. Output is written to stdout.
```

## Metadata
- **Skill**: generated

## svtools_svtools_vcftobedpe

### Tool Description
Convert a VCF file to a BEDPE file

### Metadata
- **Docker Image**: quay.io/biocontainers/svtools:0.5.1--py_0
- **Homepage**: https://github.com/hall-lab/svtools
- **Package**: https://anaconda.org/channels/bioconda/packages/svtools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/svtools:0.5.1--py_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

