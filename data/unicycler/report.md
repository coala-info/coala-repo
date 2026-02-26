# unicycler CWL Generation Report

## unicycler

### Tool Description
Unicycler: an assembly pipeline for bacterial genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/unicycler:0.5.1--py312hdcc493e_5
- **Homepage**: https://github.com/rrwick/Unicycler
- **Package**: https://anaconda.org/channels/bioconda/packages/unicycler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unicycler/overview
- **Total Downloads**: 620.2K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/rrwick/Unicycler
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: unicycler [-h] [--help_all] [--version] [-1 SHORT1] [-2 SHORT2]
                 [-s UNPAIRED] [-l LONG] -o OUT [--verbosity VERBOSITY]
                 [--min_fasta_length MIN_FASTA_LENGTH] [--keep KEEP]
                 [-t THREADS] [--mode {conservative,normal,bold}]
                 [--linear_seqs LINEAR_SEQS]

[31m[1m       __
[0m[31m[1m       \ \___
[0m[31m[1m        \ ___\
[0m[31m[1m        //
[0m[31m[1m   ____//      [0m[93m[1m_    _         _                     _
[0m[31m[1m //_  //\\    [0m[93m[1m| |  | |       |_|                   | |
[0m[31m[1m//  \//  \\   [0m[93m[1m| |  | | _ __   _   ___  _   _   ___ | |  ___  _ __
[0m[31m[1m||  (O)  ||   [0m[93m[1m| |  | || '_ \ | | / __|| | | | / __|| | / _ \| '__|
[0m[31m[1m\\    \_ //   [0m[93m[1m| |__| || | | || || (__ | |_| || (__ | ||  __/| |
[0m[31m[1m \\_____//     [0m[93m[1m\____/ |_| |_||_| \___| \__, | \___||_| \___||_|
[0m[93m[1m                                        __/ |
[0m[93m[1m                                       |___/[0m

[1mUnicycler: an assembly pipeline for bacterial genomes[0m

Help:
  -h, --help              Show this help message and exit
  --help_all              Show a help message with all program options
  --version               Show Unicycler's version number

Input:
  -1 SHORT1, --short1 SHORT1
                          FASTQ file of first short reads in each pair
  -2 SHORT2, --short2 SHORT2
                          FASTQ file of second short reads in each pair
  -s UNPAIRED, --unpaired UNPAIRED
                          FASTQ file of unpaired short reads
  -l LONG, --long LONG    FASTQ or FASTA file of long reads

Output:
  -o OUT, --out OUT       Output directory (required)
  --verbosity VERBOSITY   Level of stdout and log file information (default: 1)
                            0 = no stdout, 1 = basic progress indicators,
                            2 = extra info, 3 = debugging info
  --min_fasta_length MIN_FASTA_LENGTH
                          Exclude contigs from the FASTA file which are
                          shorter than this length (default: 100)
  --keep KEEP             Level of file retention (default: 1)
                            0 = only keep final files: assembly (FASTA,
                            GFA and log),
                            1 = also save graphs at main checkpoints,
                            2 = also keep SAM (enables fast rerun in different mode),
                            3 = keep all temp files and save all graphs (for debugging)

Other:
  -t THREADS, --threads THREADS
                          Number of threads used (default: 8)
  --mode {conservative,normal,bold}
                          Bridging mode (default: normal)
                            conservative = smaller contigs, lowest misassembly
                                           rate
                            normal = moderate contig size and misassembly rate
                            bold = longest contigs, higher misassembly rate
  --linear_seqs LINEAR_SEQS
                          The expected number of linear (i.e. non-circular)
                          sequences in the underlying sequence (default: 0)
```

