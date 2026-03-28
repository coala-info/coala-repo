# mapad CWL Generation Report

## mapad_index

### Tool Description
Indexes a genome file

### Metadata
- **Docker Image**: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
- **Homepage**: https://github.com/mpieva/mapAD
- **Package**: https://anaconda.org/channels/bioconda/packages/mapad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapad/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-30
- **GitHub**: https://github.com/mpieva/mapAD
- **Stars**: N/A
### Original Help Text
```text
Indexes a genome file

Usage: mapad index [OPTIONS] --reference <FASTA FILE>

Options:
  -g, --reference <FASTA FILE>  FASTA file containing the genome to be indexed
  -v...                         Sets the level of verbosity
      --threads <INT>           Maximum number of threads. If 0, mapAD will select the number of threads automatically. [default: 1]
      --port <INT>              TCP port to communicate over [default: 3130]
      --seed <INT>              Seed for the random number generator [default: 1234]
  -h, --help                    Print help
```


## mapad_map

### Tool Description
Maps reads to an indexed genome

### Metadata
- **Docker Image**: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
- **Homepage**: https://github.com/mpieva/mapAD
- **Package**: https://anaconda.org/channels/bioconda/packages/mapad/overview
- **Validation**: PASS

### Original Help Text
```text
Maps reads to an indexed genome

Usage: mapad map [OPTIONS] --reads <STRING> --reference <STRING> --output <STRING> --library <STRING> -f <FLOAT> -d <FLOAT> -s <FLOAT> -i <FLOAT>

Options:
  -r, --reads <STRING>            BAM/CRAM/FASTQ or FASTQ.GZ file that contains the reads to be aligned. Specify "-" for reading from stdin.
  -v...                           Sets the level of verbosity
  -g, --reference <STRING>        Prefix of the file names of the index files. The reference FASTA file itself does not need to be present.
      --threads <INT>             Maximum number of threads. If 0, mapAD will select the number of threads automatically. [default: 1]
  -o, --output <STRING>           Path to output BAM file
      --port <INT>                TCP port to communicate over [default: 3130]
  -p <FLOAT>                      Minimum probability of the number of mismatches under `-D` base error rate
      --seed <INT>                Seed for the random number generator [default: 1234]
  -c <FLOAT>                      Per-base average alignment score cutoff (-c > AS / read_len^e ?)
  -e <FLOAT>                      Exponent to be applied to the read length (ignored if `-c` is not used) [default: 1.0]
  -l, --library <STRING>          Library preparation method [possible values: single_stranded, double_stranded]
  -f <FLOAT>                      5'-overhang length parameter
  -t <FLOAT>                      3'-overhang length parameter
  -d <FLOAT>                      Deamination rate in double-stranded stem of a read
  -s <FLOAT>                      Deamination rate in single-stranded ends of a read
  -D <FLOAT>                      Divergence / base error rate [default: 0.02]
  -i <FLOAT>                      Expected rate of indels between reads and reference
  -x <FLOAT>                      Gap extension penalty as a fraction of the representative mismatch penalty [default: 1.0]
      --batch_size <INT>          The number of reads that are processed in parallel [default: 250000]
      --ignore_base_quality       Ignore base qualities in scoring models
      --dispatcher                Run in dispatcher mode for distributed computing in a network. Needs workers to be spawned externally to distribute work among them.
      --gap_dist_ends <INT>       Disallow gaps at read ends (configurable range) [default: 5]
      --max_num_gaps_open <INT>   Max. number of opened gaps [default: 2]
      --no_search_limit_recovery  Mapping of reads which are particularly difficult to align can exceed the limits of the internal search space. By default, mapAD attempts to recover from these cases by discarding the lowest scoring sub-alignments. If this flag is set, these reads are instead immediately reported as unmapped, which slightly increases the mapping speed at the cost of decreasing sensitivity.
      --force_overwrite           Force mapAD to overwrite the output BAM file if it already exists.
  -R, --read_group <read_group>   Read group SAM header line. The given read group ID will be added to every read in the output file. Example: '@RG	ID:identifier1	SM:sample2'.
  -h, --help                      Print help
```


## mapad_worker

### Tool Description
Spawns worker

### Metadata
- **Docker Image**: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
- **Homepage**: https://github.com/mpieva/mapAD
- **Package**: https://anaconda.org/channels/bioconda/packages/mapad/overview
- **Validation**: PASS

### Original Help Text
```text
Spawns worker

Usage: mapad worker [OPTIONS] --host <HOST>

Options:
      --host <HOST>    Hostname or IP address of the running dispatcher node
  -v...                Sets the level of verbosity
      --threads <INT>  Maximum number of threads. If 0, mapAD will select the number of threads automatically. [default: 1]
      --port <INT>     TCP port to communicate over [default: 3130]
      --seed <INT>     Seed for the random number generator [default: 1234]
  -h, --help           Print help
```


## Metadata
- **Skill**: generated
