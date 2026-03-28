# badread CWL Generation Report

## badread_simulate

### Tool Description
Generate fake long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Badread
- **Package**: https://anaconda.org/channels/bioconda/packages/badread/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/badread/overview
- **Total Downloads**: 11.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Badread
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: badread simulate --reference REFERENCE --quantity QUANTITY
                        [--length LENGTH] [--identity IDENTITY]
                        [--error_model ERROR_MODEL]
                        [--qscore_model QSCORE_MODEL] [--seed SEED]
                        [--start_adapter START_ADAPTER]
                        [--end_adapter END_ADAPTER]
                        [--start_adapter_seq START_ADAPTER_SEQ]
                        [--end_adapter_seq END_ADAPTER_SEQ]
                        [--junk_reads JUNK_READS]
                        [--random_reads RANDOM_READS] [--chimeras CHIMERAS]
                        [--glitches GLITCHES] [--small_plasmid_bias] [-h]
                        [--version]

Generate fake long reads

Required arguments:
  --reference REFERENCE   Reference FASTA file (can be gzipped)
  --quantity QUANTITY     Either an absolute value (e.g. 250M) or a relative
                          depth (e.g. 25x)

Simulation parameters:
  Length and identity and error distributions

  --length LENGTH         Fragment length distribution (mean and stdev,
                          default: 15000,13000)
  --identity IDENTITY     Sequencing identity distribution (mean,max,stdev for
                          beta distribution or mean,stdev for normal qscore
                          distribution, default: 95,99,2.5)
  --error_model ERROR_MODEL
                          Can be "nanopore2018", "nanopore2020",
                          "nanopore2023", "pacbio2016", "pacbio2021", "random"
                          or a model filename (default: nanopore2023)
  --qscore_model QSCORE_MODEL
                          Can be "nanopore2018", "nanopore2020",
                          "nanopore2023", "pacbio2016", "pacbio2021",
                          "random", "ideal" or a model filename (default:
                          nanopore2023)
  --seed SEED             Random number generator seed for deterministic
                          output (default: different output each time)

Adapters:
  Controls adapter sequences on the start and end of reads

  --start_adapter START_ADAPTER
                          Adapter parameters for read starts (rate and amount,
                          default: 90,60)
  --end_adapter END_ADAPTER
                          Adapter parameters for read ends (rate and amount,
                          default: 50,20)
  --start_adapter_seq START_ADAPTER_SEQ
                          Adapter sequence for read starts (default:
                          AATGTACTTCGTTCAGTTACGTATTGCT)
  --end_adapter_seq END_ADAPTER_SEQ
                          Adapter sequence for read ends (default:
                          GCAATACGTAACTGAACGAAGT)

Problems:
  Ways reads can go wrong

  --junk_reads JUNK_READS
                          This percentage of reads will be low-complexity junk
                          (default: 1)
  --random_reads RANDOM_READS
                          This percentage of reads will be random sequence
                          (default: 1)
  --chimeras CHIMERAS     Percentage at which separate fragments join together
                          (default: 1)
  --glitches GLITCHES     Read glitch parameters (rate, size and skip,
                          default: 10000,25,25)
  --small_plasmid_bias    If set, then small circular plasmids are lost when
                          the fragment length is too high (default: small
                          plasmids are included regardless of fragment length)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## badread_error_model

### Tool Description
Build a Badread error model

### Metadata
- **Docker Image**: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Badread
- **Package**: https://anaconda.org/channels/bioconda/packages/badread/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: badread error_model --reference REFERENCE --reads READS --alignment
                           ALIGNMENT [--k_size K_SIZE]
                           [--max_alignments MAX_ALIGNMENTS]
                           [--max_alt MAX_ALT] [-h] [--version]

Build a Badread error model

Required arguments:
  --reference REFERENCE   Reference FASTA file
  --reads READS           FASTQ of real reads
  --alignment ALIGNMENT   PAF alignment of reads aligned to reference

Optional arguments:
  --k_size K_SIZE         Error model k-mer size (default: 7)
  --max_alignments MAX_ALIGNMENTS
                          Only use this many alignments when generating error
                          model (default: use all alignments)
  --max_alt MAX_ALT       Only save up to this many alternatives to each k-mer
                          (default: 25)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## badread_qscore_model

### Tool Description
Build a Badread qscore model

### Metadata
- **Docker Image**: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Badread
- **Package**: https://anaconda.org/channels/bioconda/packages/badread/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: badread qscore_model --reference REFERENCE --reads READS --alignment
                            ALIGNMENT [--k_size K_SIZE]
                            [--max_alignments MAX_ALIGNMENTS]
                            [--max_del MAX_DEL] [--min_occur MIN_OCCUR]
                            [--max_output MAX_OUTPUT] [-h] [--version]

Build a Badread qscore model

Required arguments:
  --reference REFERENCE   Reference FASTA file
  --reads READS           FASTQ of real reads
  --alignment ALIGNMENT   PAF alignment of reads aligned to reference

Optional arguments:
  --k_size K_SIZE         Qscore model k-mer size (must be odd, default: 9)
  --max_alignments MAX_ALIGNMENTS
                          Only use this many alignments when generating qscore
                          model (default: use all alignments)
  --max_del MAX_DEL       Deletion runs longer than this will be collapsed to
                          reduce the number of possible alignments (default:
                          6)
  --min_occur MIN_OCCUR   CIGARs which occur less than this many times will
                          not be included in the model (default: 100)
  --max_output MAX_OUTPUT
                          The outputted model will be limited to this many
                          lines (default: 10000)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## badread_plot

### Tool Description
View read identities over a sliding window

### Metadata
- **Docker Image**: quay.io/biocontainers/badread:0.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Badread
- **Package**: https://anaconda.org/channels/bioconda/packages/badread/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: badread plot --reference REFERENCE --reads READS --alignment ALIGNMENT
                    [--window WINDOW] [--qual] [--no_plot] [-h] [--version]

View read identities over a sliding window

Required arguments:
  --reference REFERENCE  Reference FASTA file
  --reads READS          FASTQ of real reads
  --alignment ALIGNMENT  PAF alignment of reads aligned to reference

Optional arguments:
  --window WINDOW        Window size in bp (default: 100)
  --qual                 Include qscores in plot (default: only show identity)
  --no_plot              Do not display plots (for testing purposes) (default:
                         False)

Other:
  -h, --help             Show this help message and exit
  --version              Show program's version number and exit
```


## Metadata
- **Skill**: generated
