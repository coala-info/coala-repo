# fast2q CWL Generation Report

## fast2q_2fast2q

### Tool Description
A tool for counting and extracting sequences from FASTQ files, typically used for CRISPR screens.

### Metadata
- **Docker Image**: quay.io/biocontainers/fast2q:2.8.1--pyh7e72e81_0
- **Homepage**: https://github.com/afombravo/2FAST2Q
- **Package**: https://anaconda.org/channels/bioconda/packages/fast2q/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fast2q/overview
- **Total Downloads**: 921
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/afombravo/2FAST2Q
- **Stars**: N/A
### Original Help Text
```text
usage: 2fast2q [-h] [-c [C]] [-t [T]] [-v [V]] [--s S] [--g G] [--o O]
               [--fn [FN]] [--pb [PB]] [--m M] [--ph PH] [--st ST] [--l L]
               [--us US] [--ds DS] [--msu MSU] [--msd MSD] [--qsu QSU]
               [--qsd QSD] [--mo MO] [--cp CP] [--fs [FS]] [--k [K]]

options:
  -h, --help  show this help message and exit
  -c [C]      cmd line mode.
  -t [T]      Runs 2FAST2Q in test mode with example data.
  -v [V]      Prints the current version.
  --s S       The full path to the directory with the sequencing files OR
              file.
  --g G       The full path to the .csv file with the sgRNAs.
  --o O       The full path to the output directory
  --fn [FN]   Specify an output compiled file name (default is called
              compiled)
  --pb [PB]   Adds progress bars (default is enabled)
  --m M       The number of allowed mismatches per feature (default = 1). When
              in extract + Count mode, this parameter is ignored as all
              different sequences are returned.
  --ph PH     Minimal Phred-score (default=30). Reads with nucleotides having
              < than the indicated Phred-score will be discarded. The used
              format is Sanger ASCII 33 up to the character 94: 0x21 (lowest
              quality; '!' in ASCII) to 0x7e (highest quality; '~' in ASCII).
  --st ST     The start position of the feature within the read (default = 0,
              meaning the sequenced feature is located at the first position
              of the read sequence)). This parameter is ignored when using
              sequence searches with known delimiting sequences.
  --l L       The length of the feature in bp (default = 20). It is only used
              when not using dual sequence search.
  --us US     Upstream search sequence. This will return any --l X sequence
              downstream of the input sequence.
  --ds DS     Downstream search sequence. This will return any --l X sequence
              upwnstream of the input sequence.
  --msu MSU   Upstream search sequence delimiting search sequence mismatches
              (default is 0).
  --msd MSD   Downstream search sequence delimiting search sequence mismatches
              (default is 0).
  --qsu QSU   Minimal Phred-score (default=30) in the upstream search sequence
  --qsd QSD   Minimal Phred-score (default=30) in the downstream search
              sequence
  --mo MO     Running Mode (default=C) [Counter (C) / Extractor + Counter
              (EC)].
  --cp CP     Number of cpus to be used (default is max(cpu)-2 for >=3 cpus,
              -1 for >=2 cpus, 1 if 1 cpu
  --fs [FS]   File Split mode. If enabled, multiprocessing will split each
              file and process it (Best when using large files or when
              requiring heavy processing). If disabled, multiple files will be
              processed simultaneously (default is disabled).
  --k [K]     If enabled, keeps all temporary files (default is disabled)
```

