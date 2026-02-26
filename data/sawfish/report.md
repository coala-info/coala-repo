# sawfish CWL Generation Report

## sawfish_discover

### Tool Description
Discover SV candidate alleles in one sample

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-11-07
- **GitHub**: https://github.com/PacificBiosciences/sawfish
- **Stars**: N/A
### Original Help Text
```text
Discover SV candidate alleles in one sample

Usage: sawfish discover [OPTIONS] --bam <FILE> --ref <FILE>

Options:
      --output-dir <DIR>
          Directory for all discover command output (must not already exist)
          
          [default: sawfish_discover_output]

      --threads <THREAD_COUNT>
          Number of threads to use. Defaults to all logical cpus detected

      --bam <FILE>
          Alignment file for query sample in BAM or CRAM format

      --clobber
          Overwrite an existing output directory

      --debug
          Turn on extra debug logging
          
          This option enables extra logging intended for debugging only. It is highly recommended (but not required) to set --threads to 1 when this is enabled.

      --ref <FILE>
          Genome reference in FASTA format

      --expected-cn <FILE>
          Expected copy number values by genomic interval, in BED format.
          
          Copy number will be read from column 5 of the input BED file. Column 4 is ignored and can be used as a region label. The default copy number is 2 for unspecified regions. These copy number values will be stored in discover output for each sample and automatically selected for the given sample during joint-calling.
          
          Note this option is especially useful to clarify expected sex chromosome copy number in the sample.
          
          By default, the expected copy number only affects CNV calling behavior. If the option "treat-single-copy-as-haploid" is given during joint calling, then SV genotyping is updated for single copy regions as well.

      --cnv-excluded-regions <FILE>
          Regions of the genome to exclude from CNV analysis, in BED format.
          
          Note this does not impact SV breakpoint analysis

      --maf <FILE>
          Variant file used to generate minor allele frequency track for this sample, in VCF or BCF format.
          
          The bigwig track file will be output for each sample in the joint-call step as 'maf.bw' in each sample directory. The frequencies may also be used to improve copy-number segmentation in a future update.

      --maf-sample-name <MAF_SAMPLE_NAME>
          Specify the sample name to extract from the minor allele frequency variant file. By default the file is searched for the sample name found in the input alignment file. This option allows an alternative name to be specificied

      --fast-cnv-mode
          This mode is designed to more quickly run a CNV-focused analysis by analyzing only the larger-scale SV breakpoint evidence that could be useful to improve CNV/large-variant accuracy, together with depth-based CNV analysis which is run regardless of this mode setting.
          
          Smaller assembly regions are skipped in his mode, which will remove all insertions, and most deletions below about 1kb.

      --disable-cnv
          Disable CNV calling
          
          Disable CNV calling and read depth GC-bias estimation for this sample.

      --cov-regex <REGEX>
          Regex used to select chromosomes for mean haploid coverage estimation. All selected chromosomes are assumed diploid
          
          [default: ^(chr)?\d{1,2}$]

      --min-indel-size <MIN_INDEL_SIZE>
          Co-linear SVs must have either an insertion or deletion of this size or greater to be included in the output. All other SV evidence patterns such as those consistent with duplications, inversions and translocations will always be included in the output
          
          [default: 35]

      --min-sv-mapq <MIN_SV_MAPQ>
          Minimum MAPQ value for reads to be used in SV breakend finding. This does not change depth analysis
          
          [default: 5]

      --reduce-overlapping-sv-alleles
          Reduce overlapping SV alleles to a single copy
          
          Certain benchmarks like GIAB SV v0.6 tend to compress both alleles at a VNTR to a single allele, often genotyped as homozygous. Using this flag will make the SV caller's output more directly comparable to such representations, but should not be used otherwise.

      --disable-path-canonicalization
          Don't canonicalize input file paths
          
          By default, all file paths input to the discover step are canonicalized and stored in the discover output directory for use in follow-on joint-call steps. This flag disables all canonicalization, which allows all paths to be stored as-is, including as relative paths. This may be useful for situations where the sample discover and joint-call steps are run in different directory structures.

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## sawfish_joint-call

### Tool Description
Merge and genotype SVs from one or more samples, given the discover command results from each

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
Merge and genotype SVs from one or more samples, given the discover command results from each

Usage: sawfish joint-call [OPTIONS] <--sample <DIR>|--sample-csv <FILE>>

Options:
      --output-dir <DIR>
          Directory for all joint-call command output (must not already exist)
          
          [default: sawfish_joint-call_output]

      --threads <THREAD_COUNT>
          Number of threads to use. Defaults to all logical cpus detected

      --clobber
          Overwrite an existing output directory

      --sample <DIR>
          Sample discover-mode results directory (required). Can be specified multiple times to joint call over multiple samples

      --debug
          Turn on extra debug logging
          
          This option enables extra logging intended for debugging only. It is highly recommended (but not required) to set --threads to 1 when this is enabled.

      --sample-csv <FILE>
          Sample csv file

      --ref <FILE>
          Genome reference in FASTA format. If not specified, the reference path from the first sample's discover command will be automatically selected instead

      --min-sv-mapq <MIN_SV_MAPQ>
          Minimum MAPQ value for reads to be used in joint-genotyping
          
          [default: 5]

      --report-supporting-reads
          Create a JSON output file listing the reads supporting each variant

      --treat-single-copy-as-haploid
          By default the SV caller ignores the expected copy number values ("--expected-cn" argument in discover).
          
          With this option, all SVs in single copy regions are genotyped as haploid.

      --skip-sample-input-check
          Skip checks on input sample discover directory contents

      --disable-max-dapth-chrom-regex <REGEX>
          Regex used to select chromosomes where max depth filtration is disabled
          
          Default value is intended to disable high depth filtration on mitochondria
          
          [default: (?i)^(chr)?(m|mt|mito|mitochondria)$]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## sawfish_Number

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: sawfish --help <COMMAND>

For more information, try '--help'.
```


## sawfish_Overwrite

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: sawfish --help <COMMAND>

For more information, try '--help'.
```


## sawfish_Turn

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: sawfish --help <COMMAND>

For more information, try '--help'.
```


## sawfish_This

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: sawfish --help <COMMAND>

For more information, try '--help'.
```


## sawfish_Print

### Tool Description
Print help information for sawfish commands.

### Metadata
- **Docker Image**: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/sawfish
- **Package**: https://anaconda.org/channels/bioconda/packages/sawfish/overview
- **Validation**: PASS

### Original Help Text
```text
error: unexpected argument '--h' found

  tip: a similar argument exists: '--help'

Usage: sawfish --help <COMMAND>

For more information, try '--help'.
```


## Metadata
- **Skill**: generated
