# schavott CWL Generation Report

## schavott

### Tool Description
Scaffold genomes in real time

### Metadata
- **Docker Image**: quay.io/biocontainers/schavott:0.5.0--py35_0
- **Homepage**: http://github.com/emilhaegglund/schavott
- **Package**: https://anaconda.org/channels/bioconda/packages/schavott/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/schavott/overview
- **Total Downloads**: 28.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/emilhaegglund/schavott
- **Stars**: N/A
### Original Help Text
```text
usage: schavott [-h] [--run_mode {scaffold,assembly}]
                [--scaffolder {links,sspace}] [--sspace_path SSPACE_PATH]
                [--read_type {fast5,fastq,fasta}]
                [--min_read_length MIN_READ_LENGTH]
                [--min_quality MIN_QUALITY] --watch WATCH
                [--contig_file CONTIG_FILE] [--trigger_mode {time,reads}]
                [--skip SKIP] [--intensity INTENSITY] [--plot]
                [--output OUTPUT]

Scaffold genomes in real time

optional arguments:
  -h, --help            show this help message and exit
  --run_mode {scaffold,assembly}, -r {scaffold,assembly}
                        Run scaffolding or assembly
  --scaffolder {links,sspace}, -s {links,sspace}
                        Which scaffolder to use.
  --sspace_path SSPACE_PATH, -p SSPACE_PATH
                        Path to SSPACE (Only for scaffolding)
  --read_type {fast5,fastq,fasta}, -rt {fast5,fastq,fasta}
                        Select input type: fastq, fast5 or fasta, this is also
                        the search pattern for shavott (*.read_type)
  --min_read_length MIN_READ_LENGTH, -l MIN_READ_LENGTH
                        Minimum read length from MinION to use.
  --min_quality MIN_QUALITY, -q MIN_QUALITY
                        Minimum quality for reads from MinION to use.
  --watch WATCH, -w WATCH
                        Directory to watch for fast5 files
  --contig_file CONTIG_FILE, -c CONTIG_FILE
                        Path to contig file (Only for scaffolding)
  --trigger_mode {time,reads}, -t {time,reads}
                        Use timer or read count. [reads]
  --skip SKIP, -j SKIP  Skips the first j read of the sequencing
  --intensity INTENSITY, -i INTENSITY
                        How often the scaffolding process should run. If run
                        mode is set to reads, scaffolding will run every i:th
                        read. If run mode is time, scaffolding will run every
                        i:th second. [100 reads]
  --plot                Plot result in web-browser
  --output OUTPUT, -o OUTPUT
                        Set output filename. (Defaut: schavott)
```

