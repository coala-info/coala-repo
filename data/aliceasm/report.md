# aliceasm CWL Generation Report

## aliceasm

### Tool Description
Alice Assembler: a tool for genome assembly using MSR compression and k-mer analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/aliceasm:0.6.41--h9948957_0
- **Homepage**: https://github.com/RolandFaure/alice-asm
- **Package**: https://anaconda.org/channels/bioconda/packages/aliceasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aliceasm/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-07-30
- **GitHub**: https://github.com/RolandFaure/alice-asm
- **Stars**: N/A
### Original Help Text
```text
_______ _                     _ _                                            _     _                               
  |__   __| |              /\   | (_)              /\                          | |   | |                              
     | |  | |__   ___     /  \  | |_  ___ ___     /  \   ___ ___  ___ _ __ ___ | |__ | | ___ _ __      ::     _.mnm._ 
     | |  | '_ \ / _ \   / /\ \ | | |/ __/ _ \   / /\ \ / __/ __|/ _ \ '_ ` _ \| '_ \| |/ _ \ '__|    :  :   ( _____ )
     | |  | | | |  __/  / ____ \| | | (_|  __/  / ____ \\__ \__ \  __/ | | | | | |_) | |  __/ |       :  :    |     | 
     |_|  |_| |_|\___| /_/    \_\_|_|\___\___| /_/    \_\___/___/\___|_| |_| |_|_.__/|_|\___|_|       :__:     `___/  

Command line: /usr/local/bin/aliceasm -help 
Alice Assembler version 0.6.41
Last update: 2024-04-09
Author: Roland Faure

Could not parse the arguments
SYNOPSIS
        /usr/local/bin/aliceasm -r [<r>] -o [<o>] [-t [<t>]] [-l [<o>]] [-c [<c>]] [-H] [-m [<m>]]
                                [-k [<k>]] [--single-genome] [--bcalm [<b>]] [--clean] [--test
                                [<t>]] [-v] [-h]

OPTIONS
        -r, --reads input file (fasta/q)
        -o, --output
                    output folder

        -t, --threads
                    number of threads [1]

        -l, --order order of MSR compression (odd) [101]
        -c, --compression
                    compression factor [20]

        -H, --no-hpc
                    turn off homopolymer and homodimer compression

        -m, --min-abundance
                    minimum abundance of kmer to consider solid - RECOMMENDED to set to coverage/2
                    if single-genome [5]

        -k, --kmer-sizes
                    comma-separated increasing sizes of k for assembly, must go at least to 31
                    [17,31]

        --single-genome
                    Switch on if assembling a single genome

        --bcalm     path to bcalm [bcalm]
        --clean     remove the tmp folder at the end [off]
        --test      (developers only) to compare the result against this reference
        -v, --version
                    print version and exit

        -h, --help  print this help message and exit
```


## Metadata
- **Skill**: generated
