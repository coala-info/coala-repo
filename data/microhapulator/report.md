# microhapulator CWL Generation Report

## microhapulator_mhpl8r

### Tool Description
Invoke `mhpl8r <subcmd> --help` and replace `<subcmd>` with one of the subcommands listed below to see instructions for that operation.

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Total Downloads**: 21.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bioforensics/MicroHapulator
- **Stars**: N/A
### Original Help Text
```text
usage: mhpl8r [-h] [-v] subcmd ...

≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠
  __  __ _            _  _                _      _
 |  \/  (_)__ _ _ ___| || |__ _ _ __ _  _| |__ _| |_ ___ _ _
 | |\/| | / _| '_/ _ \ __ / _` | '_ \ || | / _` |  _/ _ \ '_|
 |_|  |_|_\__|_| \___/_||_\__,_| .__/\_,_|_\__,_|\__\___/_|
                               |_|
≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠
Invoke `mhpl8r <subcmd> --help` and replace `<subcmd>` with one of the
subcommands listed below to see instructions for that operation.

Subcommands:
  subcmd         contain, contrib, convert, diff, dist, filter, getrefr,
                 hetbalance, locbalance, mappingqc, mix, pipe, prob,
                 repetitive, seq, sim, type, unite

Global arguments:
  -h, --help     show this help message and exit
  -v, --version  show program's version number and exit
```


## microhapulator_mhpl8r pipe

### Tool Description
Perform a complete end-to-end microhap analysis pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r pipe [-h] [-w D] [-n] [-t T] [-s ST] [-d DT] [-a AT] [-l LT]
                   [-D DA] [-G GA] [-c CSV] [--single] [--copy-input]
                   [--hspace HS]
                   markerrefr markerdefn seqpath samples [samples ...]

Perform a complete end-to-end microhap analysis pipeline

positional arguments:
  markerrefr            path to a FASTA file containing marker reference
                        sequences
  markerdefn            path to a TSV file containing marker definitions
  seqpath               path to a directory containing FASTQ files
  samples               list of sample names or path to .txt file containing
                        sample names

optional arguments:
  -h, --help            show this help message and exit
  -w D, --workdir D     pipeline working directory; default is current
                        directory
  -n, --dryrun          do not execute the workflow, but display what would
                        have been done
  -t T, --threads T     process each batch using T threads; by default, one
                        thread per available core is used
  -s ST, --static ST    global fixed read count threshold; ST=5 by default
  -d DT, --dynamic DT   global percentage of total read count threshold; e.g.
                        use --dynamic=0.02 to apply a 2% analytical threshold;
                        DT=0.02 by default
  -a AT, --ambiguous-thresh AT
                        filter out reads with more than AT percent of
                        ambiguous characters ('N'); AT=0.2 by default
  -l LT, --length-thresh LT
                        filter out reads that are less than LT bp long; LT=50
                        by default
  -D DA, --discard-alert DA
                        issue an alert in the final report for each marker
                        whose read discard rate (proportion of reads that
                        could not be typed) exceeds DA; by default DA=0.25
  -G GA, --gap-alert GA
                        issue an alert in the final report for each marker
                        whose gap rate (proportion of reads containing one or
                        more gap alleles) exceeds DA; by default DA=0.05
  -c CSV, --config CSV  CSV file specifying marker-specific thresholds to
                        override global thresholds; three required columns:
                        'Marker' for the marker name; 'Static' and 'Dynamic'
                        for marker-specific thresholds
  --single              accept single-end reads only; by default, only paired-
                        end reads are accepted
  --copy-input          copy input files to working directory; by default,
                        input files are symlinked
  --hspace HS           horizontal spacing between samples in the read
                        distribution length ridge plots; negative value for
                        this parameter enables overlapping plots; HS=-0.7 by
                        default
```


## microhapulator_mhpl8r seq

### Tool Description
Simulate paired-end Illumina MiSeq sequencing of the given profile(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r seq [-h] [-o OUT [OUT ...]] [-n N] [-p P [P ...]]
                  [-s INT [INT ...]]
                  tsv refrseqs profiles [profiles ...]

Simulate paired-end Illumina MiSeq sequencing of the given profile(s)

positional arguments:
  tsv                   microhaplotype marker definitions in tabular (TSV)
                        format
  refrseqs              microhaplotype reference sequences in FASTA format
  profiles              one or more simple or complex profiles (JSON files)

optional arguments:
  -h, --help            show this help message and exit
  -o OUT [OUT ...], --out OUT [OUT ...]
                        write simulated paired-end MiSeq reads in FASTQ format
                        to the specified file(s); if one filename is provided,
                        reads are interleaved and written to the file; if two
                        filenames are provided, reads are written to paired
                        files; by default, reads are interleaved and written
                        to the terminal (standard output)
  -n N, --num-reads N   number of reads to simulate; default is 500000
  -p P [P ...], --proportions P [P ...]
                        simulated mixture samples with multiple contributors
                        at the specified proportions; by default even
                        proportions are used
  -s INT [INT ...], --seeds INT [INT ...]
                        seeds for random number generator, 1 per profile
```


## microhapulator_mhpl8r filter

### Tool Description
Apply static and/or dynamic thresholds to distinguish true and false haplotypes. Thresholds are applied to the haplotype read counts of a raw typing result. Static integer thresholds are commonly used as detection thresholds, below which any haplotype count is considered noise. Dynamic thresholds are commonly used as analytical thresholds and represent a percentage of the total read count at the marker, after any haplotypes failing a static threshold are discarded.

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r filter [-h] [-o FILE] [-s ST] [-d DT] [-c CSV] result

Apply static and/or dynamic thresholds to distinguish true and false
haplotypes. Thresholds are applied to the haplotype read counts of a raw
typing result. Static integer thresholds are commonly used as detection
thresholds, below which any haplotype count is considered noise. Dynamic
thresholds are commonly used as analytical thresholds and represent a
percentage of the total read count at the marker, after any haplotypes failing
a static threshold are discarded.

positional arguments:
  result                MicroHapulator typing result in JSON format

optional arguments:
  -h, --help            show this help message and exit
  -o FILE, --out FILE   write output to FILE; by default, output is written to
                        the terminal (standard output)
  -s ST, --static ST    global fixed read count threshold
  -d DT, --dynamic DT   global percentage of total read count threshold; e.g.
                        use --dynamic=0.02 to apply a 2% analytical threshold
  -c CSV, --config CSV  CSV file specifying marker-specific thresholds to
                        override global thresholds; three required columns:
                        'Marker' for the marker name; 'Static' and 'Dynamic'
                        for marker-specific thresholds
```


## microhapulator_mhpl8r contribution

### Tool Description
Microhaplotype analysis tool

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapulator/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapulator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mhpl8r [-h] [-v] subcmd ...
mhpl8r: error: argument subcmd: invalid choice: 'contribution' (choose from 'contain', 'contrib', 'convert', 'diff', 'dist', 'filter', 'getrefr', 'hetbalance', 'locbalance', 'mappingqc', 'mix', 'repetitive', 'pipe', 'prob', 'seq', 'sim', 'type', 'unite')
```


## Metadata
- **Skill**: generated
