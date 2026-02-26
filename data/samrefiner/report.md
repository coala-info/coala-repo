# samrefiner CWL Generation Report

## samrefiner_SAM_Refiner

### Tool Description
process Sam files for variant information

### Metadata
- **Docker Image**: quay.io/biocontainers/samrefiner:1.4.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/degregory/SAM_Refiner
- **Package**: https://anaconda.org/channels/bioconda/packages/samrefiner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samrefiner/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-08-30
- **GitHub**: https://github.com/degregory/SAM_Refiner
- **Stars**: N/A
### Original Help Text
```text
Failed to import pysam.  Processing of bams/crams skipped
usage: SAM_Refiner [-h] [-r REF] [-S [SAM_FILES ...]] [--use_count {0,1}]
                   [--min_count MIN_COUNT] [--min_samp_abund MIN_SAMP_ABUND]
                   [--min_col_abund MIN_COL_ABUND] [--ntabund NTABUND]
                   [--ntcover NTCOVER] [--max_dist MAX_DIST]
                   [--max_covar MAX_COVAR] [--covar_tile_coverage {0,1}]
                   [--AAreport {0,1}] [--AAcodonasMNP {0,1}]
                   [--AAcentered {0,1}] [--chim_in_abund CHIM_IN_ABUND]
                   [--alpha ALPHA] [--foldab FOLDAB] [--redist {0,1}]
                   [--max_cycles MAX_CYCLES] [--beta BETA]
                   [--autopass AUTOPASS] [--colID COLID] [--collect {0,1}]
                   [--read {0,1}] [--nt_call {0,1}] [--ntvar {0,1}]
                   [--indel {0,1}] [--seq {0,1}] [--covar {0,1}]
                   [--pass_out {0,1}] [--chim_rm {0,1}] [--deconv {0,1}]
                   [--wgs {0,1}] [--mp MP]

process Sam files for variant information

options:
  -h, --help            show this help message and exit
  -r, -reference REF    reference fasta or genbank file. Only chimera removal
                        and collections will be performed if omitted.
  -S, --Sam_files [SAM_FILES ...]
                        optional .sam files, can use multiple files i.e. "-S
                        Sample1.sam -S Sample2.sam" or "-S Sample1.sam
                        Sample2.sam"
  --use_count {0,1}     Enable/Disable (1/0) use of counts in sequence IDs,
                        default enabled (--use_count 1) (default: 1)
  --min_count MIN_COUNT
                        Minimum observations required to be included in sample
                        reports; >= 1 occurance count; < 1 % observed (.1 =
                        10%), (default: .001)
  --min_samp_abund MIN_SAMP_ABUND
                        Minimum abundance required for inclusion in sample
                        reports; % observed (.1 = 10%), (default: .001)
  --min_col_abund MIN_COL_ABUND
                        Minimum abundance required for variants to be included
                        in collection reports; must be non-negative and < 1, %
                        observed (.1 = 10%), (default: .01)
  --ntabund NTABUND     Minimum abundance relative to total reads required for
                        a position to be reported in the nt call output; must
                        be non-negative and < 1, % observed (.1 = 10%),
                        (default: .001)
  --ntcover NTCOVER     Minimum coverage at a position to be reported in the
                        nt call output. (default: 5)
  --max_dist MAX_DIST   Maximum number of variances from the reference a
                        sequence can have to be consider in covars processing
                        (default: 40)
  --max_covar MAX_COVAR
                        Maximum number of variances from the reference to be
                        reported in covars (default: 8)
  --covar_tile_coverage {0,1}
                        Enable/Disable (1/0) using tiles covering positions
                        instead of minimum nt coverage to calculate abundance
                        of covariants (--covar_tile_coverage), require --wgs 1
                        (default: 0)
  --AAreport {0,1}      Enable/Disable (1/0) amino acid reporting, default
                        enabled (--AAreport 1) (default: 1)
  --AAcodonasMNP {0,1}  Enable/Disable (1/0) reporting multiple nt changes in
                        a single codon as one polymorphism, default enabled
                        (--AAcodonasMNP 1), requires AAreport enabled
                        (default: 1)
  --AAcentered {0,1}    Enable/Disable (1/0) amino acid centered seq and covar
                        outputs for .gb processing (--AAcentered 0), requires
                        AAreport enabled (default: 0)
  --chim_in_abund CHIM_IN_ABUND
                        Minimum abundance a unique sequence must have to be
                        considered in chimera removal / deconvolution
                        (default: .001)
  --alpha ALPHA         Modifier for chim_rm chimera checking, default 1.2.
                        Higher = more sensitive, more false chimeras removed;
                        lower = less sensitive, fewer chimeras removed
  --foldab FOLDAB       Threshold for potential parent / chimera abundance
                        ratio for chim_rm; default is 1.8
  --redist {0,1}        Enable/Disable (1/0) redistribution of chimera counts
                        for chim_rm, default enabled (--redist 1)
  --max_cycles MAX_CYCLES
                        Max number of times chimera removal will be performed
                        for chim_rm; default is 100
  --beta BETA           Modifier for covar pass checking, default 1. Higher =
                        more sensitive, more failed checks; lower = less
                        sensitive, fewer failed checks
  --autopass AUTOPASS   threshold for a sequence to automatically pass the
                        covar pass checking (default: 0.3)
  --colID COLID         ID to prepend collections
  --collect {0,1}       Enable/Disable (1/0) collection step, default enabled
                        (--collect 1) (default: 1)
  --read {0,1}          Enable/Disable (1/0) reads output, default disabled
                        (--read 0) (default: 0)
  --nt_call {0,1}       Enable/Disable (1/0) nt_call output, default enabled
                        (--nt_call 1) (default: 1)
  --ntvar {0,1}         Enable/Disable (1/0) nt_call output, default enabled
                        (--ntvar 1) (default: 0)
  --indel {0,1}         Enable/Disable (1/0) indel output, default enabled
                        (--indel 1) (default: 1)
  --seq {0,1}           Enable/Disable (1/0) unique seq output, default
                        enabled (--seq 1) (default: 1)
  --covar {0,1}         Enable/Disable (1/0) covar output, default enabled
                        (--covar 1) (default: 1)
  --pass_out {0,1}      Enable/Disable (1/0) covar_pass output, default
                        disabled (--pass_out 0) (default: 0)
  --chim_rm {0,1}       Enable/Disable (1/0) chim_rm output, default enabled
                        (--chim_rm 1) (default: 1)
  --deconv {0,1}        Enable/Disable (1/0) covar deconv, default enabled
                        (--deconv 1) (default: 1)
  --wgs {0,1}           Enable/Disable (1/0) covar deconv, default enabled
                        (--wgs 1)(default: 0)
  --mp MP               set number of processes SAM Refiner will run in
                        parallel, default = 4 (--mp 4)
```

