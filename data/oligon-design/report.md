# oligon-design CWL Generation Report

## oligon-design_oligoNdesign

### Tool Description
This script is a wrapper to run a basic pipeline and select the best oligonucleotides from a target and a excluding file.

### Metadata
- **Docker Image**: quay.io/biocontainers/oligon-design:1.1.0--py314hdfd78af_0
- **Homepage**: https://github.com/MiguelMSandin/oligoN-design
- **Package**: https://anaconda.org/channels/bioconda/packages/oligon-design/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oligon-design/overview
- **Total Downloads**: 168
- **Last updated**: 2026-02-26
- **GitHub**: https://github.com/MiguelMSandin/oligoN-design
- **Stars**: N/A
### Original Help Text
```text
This is oligoNdesign v1.1.0
https://github.com/MiguelMSandin/oligoN-design

This script is a wrapper to run a basic pipeline and select the best oligonucleotides from a target and a excluding file.

Usage: oligoNdesign -t TARGET -e EXCLUDING -p PREFIX

Required arguments:
  -t    The fasta file containing the target group.
  -e    The fasta file containing the excluding group.
  -o    The prefix for the output files.

Optional arguments:
  -l    The lengths of the desired oligonucleotides (in between quotes). Default = '18 20'.
  -m    The minimum presence in the target file. Default = 0.8
  -s    The maximum presence in the excluding file. Default = 0.01.
  -c    A minimum (and maximum) GC content (in between quotes). Default = 0.
  -n    The number of best oligonucleotides to select. Default = 4.
  -f    It will not test for indels when searching for 1 and 2 mismatches, speeding up completion.
  -a    It will not test accessibility of the oligonucleotides. Recommended for very large target files.
  -g    The Small SubUnit of the rDNA: Either '18S' (default) or '16S'.
  -k    It will keep intermediate relevant files.
  -r    It will print the exact commands to the console without running them.
  -h    Show this help message and exit.
  -v    If selected, will not print information to the console.
  -V    Print version information and exit.

-------------------------------- Overview of the pipeline --------------------------------
The basic pipeline will run the following functions in the given order:

'findOligo': extract all candidate oligos of lengths 18 and 20 bases that are present in at least 80% of the sequences in the target file, and at most 1% in the excluding file.

'testOligo': (if not disabled) test for 1 and 2 mismatches allowing insertions and deletions of the candidate oligos against the excluding file.

'alignOligo': (if not disabled) align all candidate oligos against a template of the SSU and consensus sequences from the target file.

'rateAccess': (if not disabled) test the accessibility in the tertiary structure of the given oligonucleotide region.

'bindLogs': bind all log files.

'selectLog': selects the best 4 oligonucleotides.

For further details of each function call the help command ('-h') on the given function.

--------------------------------- Output of the pipeline ---------------------------------
Its most basic output is composed of three final files:
'PREFIX_log.tsv': A tab delimited table containing details for each candidate oligonucleotide.
'PREFIX_candidates.fasta': A fasta file containing all candidate oligonucleotides.
'PREFIX_best.tsv': A filtered table containing only the details of the 4 best oligonucleotides ranked.

Although  the '-k' argument will keep other intermediate files:
'PREFIX_aligned.fasta': An aligned fasta file containing the SSU template, 2 consensus sequences of the target file, and all candidate oligos.
'PREFIX_best.fasta': A fasta file containing the 4 best oligonucleotides ranked.

------------------------------------------------------------------------------------------

This wrapper uses MAFFT (https://mafft.cbrc.jp/alignment/software/) and agrep among others
Please cite:
Katoh, Misawa, Kuma, Miyata (2002) MAFFT: a novel method for rapid multiple sequence alignment based on fast Fourier transform. Nucleic Acids Res. 30:3059-3066

The accessibility map of the SSU of the ribosome is based on Behrens S, Rühland C, Inácio J, Huber H, Fonseca A, Spencer-Martins I, Fuchs BM, Amann R (2003) In situ accessibility of small-subunit rRNA of members of the domains Bacteria, Archaea, and Eucarya to Cy3-labeled oligonucleotide probes. Appl Environ Microbiol 69(3):1748-58. doi: 10.1128/AEM.69.3.1748-1758.2003
```

