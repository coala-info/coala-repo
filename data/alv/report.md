# alv CWL Generation Report

## alv

### Tool Description
Alignment Viewer (alv) - a tool for viewing and analyzing sequence alignments in the terminal.

### Metadata
- **Docker Image**: quay.io/biocontainers/alv:1.7.2--pyhdfd78af_0
- **Homepage**: https://github.com/arvestad/alv
- **Package**: https://anaconda.org/channels/bioconda/packages/alv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/alv/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/arvestad/alv
- **Stars**: N/A
### Original Help Text
```text
usage: alv [-h] [--version] [-ai ALIGNMENT_INDEX]
           [-f {guess,fasta,clustal,nexus,phylip,stockholm}]
           [-t {aa,dna,rna,codon,guess}] [-g]
           [-c {clustal,taylor,hydrophobicity}]
           [--code {1,2,3,4,5,6,9,10,11,12,13,14,16,21,22,23,24,25,26,27,28,29,30,31}]
           [-d] [-lc] [-w WIDTH] [-k] [-l] [-i] [-j] [--cite] [--method]
           [-r N] [-s {infile,alpha}] [-si ACCESSION] [-so ACCESSIONS]
           [-sm ACCESSION_PATTERN] [--majority] [--no-indels]
           [--only-variable] [--only-variable-excluding-indels] [-as INT INT]
           [-aa N]
           [infile]

positional arguments:
  infile                The infile is the path to a file, or '-' if reading
                        from stdin.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -ai ALIGNMENT_INDEX, --alignment-index ALIGNMENT_INDEX
                        If reading file with many alignments, choose which one
                        to output with this zero-based index. Default: first
                        alignment in file.
  -f {guess,fasta,clustal,nexus,phylip,stockholm}, --format {guess,fasta,clustal,nexus,phylip,stockholm}
                        Specify what sequence type to assume. Be specific if
                        the file is not recognized automatically. When reading
                        from stdin, the format is always guessed to be FASTA.
                        Default: guess
  -t {aa,dna,rna,codon,guess}, --type {aa,dna,rna,codon,guess}
                        Specify what sequence type to assume. Coding DNA/RNA
                        is assumed with the 'codon' option. Guessing the
                        format only chooses between 'aa' and 'dna', but
                        assumes the standard genetic code. Default: guess
  -g, --glimpse         Give a glimpse of an alignment. If the alignment fits
                        without any scrolling and without line breaks, then
                        just view the alignment. Otherwise, identify a
                        conserved part of the MSA and show a random sample of
                        the sequences that fits the screen.
  -c {clustal,taylor,hydrophobicity}, --color-scheme {clustal,taylor,hydrophobicity}
                        Color scheme for AA and coding DNA/RNA. The clustal
                        coloring scheme is an approximation of the original,
                        due to the limited color choices for consoles. The
                        "hydrophobicity" gives red to hydrophobic, blue to
                        polar, and green to charged residues. Default: clustal
  --code {1,2,3,4,5,6,9,10,11,12,13,14,16,21,22,23,24,25,26,27,28,29,30,31}
                        Genetic code to use, based on NCBI's code list, see
                        details below. Show alternatives with the --list-codes
                        option. Default: 1.
  -d, --dotted          Let the first sequence in output alignment be a
                        template and, for other sequences, show identity to
                        template using a period. Useful for alignments with
                        high similarity.
  -lc, --list-codes     List the available genetic codes and exit.
  -w WIDTH, --width WIDTH
                        Width of alignment blocks. Defaults to terminal width
                        minus accession width, essentially.
  -k, --keep-colors-when-redirecting
                        Do not strip colors when redirecting to stdout, or
                        similar. In particular useful with the command 'less
                        -R'.
  -l, --pipe-to-less    Do not break the alignment into blocks. Implies -k.
                        Suitable when piping to commands like 'less -RS'.

General information:
  -i, --info            Append basic information about the alignment at the
                        end.
  -j, --just-info       Write basic information about the alignment and exit.
  --cite                Write citation example: plain text and a BibTeX item.
  --method              Write a suggested text to add to a methods section.

Sequence selection and ordering:
  -r N, --random-accessions N
                        Only view a random sample of the alignment sequences.
  -s {infile,alpha}, --sorting {infile,alpha}
                        Sort the sequences as given in the infile or
                        alphabetically (by accession). Default: infile
  -si ACCESSION, --sort-by-id ACCESSION
                        Sort the output alignment by similarity (percent
                        identity) to named sequence. Overrides -s.
  -so ACCESSIONS, --sorting-order ACCESSIONS
                        Comma-separated list of accessions. Sequences will be
                        presented in this order. Also note that one can choose
                        which sequences to present with this opion. Overrides
                        -s and -si.
  -sm ACCESSION_PATTERN, --select-matching ACCESSION_PATTERN
                        Only show sequences with accessions containing
                        ACCESSION_PATTERN.

Restricting colorization:
  --majority            Only color those column where the most common amino
                        acid is found in 50 percent of sequences.
  --no-indels           Only color column without indels.
  --only-variable       Only color columns that contain variation.
  --only-variable-excluding-indels
                        Only color columns that contain variation, ignoring
                        indels.

Accession trimming:
  -as INT INT, --acc-substring INT INT
                        Specify what substring of an accession to keep. '-as
                        10 15' discards all but position 10 to 14 in any
                        accession.
  -aa N, --acc-abbreviate N
                        Keep only the first N and last N characters of the
                        accession
```


## Metadata
- **Skill**: generated
