# cdskit CWL Generation Report

## cdskit_accession2fasta

### Tool Description
Convert NCBI accession numbers to FASTA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/kfuku52/cdskit
- **Stars**: N/A
### Original Help Text
```text
usage: cdskit accession2fasta [-h] [--version] [-o PATH] [-of STR]
                              [--accession_file PATH] [--email aaa@bbb.com]
                              [--extract_cds yes|no] [--ncbi_database STR]
                              [--seqnamefmt STR] [--list_seqname_keys yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --accession_file PATH
                        default=: PATH to the accession-per-line text file.
  --email aaa@bbb.com   default=: Your email address. This is passed to the
                        NCBI's E-utilities. For details, see here:
                        https://biopython.org/docs/1.75/api/Bio.Entrez.html
  --extract_cds yes|no  default=yes: Whether to extract the CDS feature.
  --ncbi_database STR   default=nucleotide: NCBI database to search.
  --seqnamefmt STR      default=organism_accessions: Underline-separated list
                        of output sequence name elements. Try
                        --list_seqname_keys to check available values.
  --list_seqname_keys yes|no
                        default=no: Listing the keys (and values) available
                        for --seqnamefmt.
```


## cdskit_aggregate

### Tool Description
Aggregate sequences based on a regular expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit aggregate [-h] [--version] [-s PATH] [-if STR] [-o PATH]
                        [-of STR] [-m STR] [-x REGEX [REGEX ...]]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -m, --mode STR        default=longest: Criterion to keep a sequence during
                        aggregation.
  -x, --expression REGEX [REGEX ...]
                        default=-: A regular expression to aggregate the
                        sequences. Multiple values can be specified.
```


## cdskit_backtrim

### Tool Description
Backtrim CDS alignments to match trimmed amino acid alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit backtrim [-h] [--version] [-s PATH] [-if STR] [-o PATH]
                       [-of STR] [-d INT] -a PATH

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -d, --codontable INT  default=1: Codon table ID. The standard code is "1".
                        See here for details: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi
  -a, --trimmed_aa_aln PATH
                        default=: PATH to the trimmed amino acid alignment. In
                        addition to this, please specify the untrimmed CDS
                        alignment by --seqfile.
```


## cdskit_backalign

### Tool Description
Backalign CDS sequences to their corresponding aligned amino acid sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit backalign [-h] [--version] [-s PATH] [-if STR] [-o PATH]
                        [-of STR] [-d INT] -a PATH

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -d, --codontable INT  default=1: Codon table ID. The standard code is "1".
                        See here for details: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi
  -a, --aa_aln PATH     default=: PATH to aligned amino acid sequences. In
                        addition to this, please specify unaligned CDS by
                        --seqfile.
```


## cdskit_gapjust

### Tool Description
Adjusts gap lengths in sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit gapjust [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                      [--ingff PATH] [--outgff PATH] [--gap_len INT]
                      [--gap_just_min INT] [--gap_just_max INT]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --ingff PATH          default=None: Input gff file.
  --outgff PATH         default=out.gff: Output gff file.
  --gap_len INT         default=100: Gap length. Ns will be added or removed
                        to make the gap length fixed.
  --gap_just_min INT    default=None: Minimum gap length to be adjusted. Ns
                        will be extended if the gap length is equal to or
                        greater than this value.
  --gap_just_max INT    default=None: Maximum gap length to be adjusted. Ns
                        will be shortened if the gap length is equal to or
                        smaller than this value.
```


## cdskit_hammer

### Tool Description
Hammer sequences to remove gaps and ambiguous bases.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit hammer [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                     [-d INT] [--nail INT/all] [--prevent_gap_only yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -d, --codontable INT  default=1: Codon table ID. The standard code is "1".
                        See here for details: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi
  --nail INT/all        default=4: Threshold number of "nail sequences" to
                        hammer down. Codon columns are removed if there are no
                        more than this number of non-missing sequences. "all"
                        generates a completely no-gap output.
  --prevent_gap_only yes|no
                        default=yes: Whether to relax (decrease) --nail when a
                        gap-only sequence is generated.
```


## cdskit_intersection

### Tool Description
Performs intersection operations on CDS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit intersection [-h] [--version] [-s PATH] [-if STR] [-o PATH]
                           [-of STR] [--ingff PATH] [--outgff PATH]
                           [--seqfile2 PATH] [--inseqformat2 STR]
                           [--outfile2 PATH] [--outseqformat2 STR]
                           [--fix_outrange_gff_records yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --ingff PATH          default=None: Input gff file.
  --outgff PATH         default=out.gff: Output gff file.
  --seqfile2 PATH       default=None: Input sequence file 2.
  --inseqformat2 STR    default=fasta: Input sequence format for --seqfile2.
  --outfile2 PATH       default=seqfile2.out: Output sequence file 2.
  --outseqformat2 STR   default=fasta: Output sequence format for --outfile2.
  --fix_outrange_gff_records yes|no
                        default=yes: Fix gff records that have coordinates out
                        of the sequence range.
```


## cdskit_label

### Tool Description
Label sequences in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit label [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                    [--replace_chars FROM1FROM2...--TO] [--clip_len INT]
                    [--unique yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --replace_chars FROM1FROM2...--TO
                        default=: Replace sequence label characters. For
                        example, "!@#$%^&*+=/?<>|--_" replaces various
                        characters with underbar ("_").
  --clip_len INT        default=0: Maximum length of sequence labels. Longer
                        labels are truncated.
  --unique yes|no       default=no: Make sequence labels unique by adding
                        suffix (_1, _2, ...).
```


## cdskit_mask

### Tool Description
Masks codons in a sequence file based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit mask [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                   [-d INT] [-c CHAR] [-a yes|no] [-t yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -d, --codontable INT  default=1: Codon table ID. The standard code is "1".
                        See here for details: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi
  -c, --maskchar CHAR   default=N: A character to be used to mask codons.
  -a, --ambiguouscodon yes|no
                        default=yes: Mask ambiguous codons. e.g., "AAN", which
                        may code Asn or Lys in the standard genetic code.
  -t, --stopcodon yes|no
                        default=yes: Mask stop codons.
```


## cdskit_pad

### Tool Description
Pad CDS sequences to be multiples of three.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit pad [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                  [-d INT] [-c CHAR] [-n]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -d, --codontable INT  default=1: Codon table ID. The standard code is "1".
                        See here for details: https://www.ncbi.nlm.nih.gov/Tax
                        onomy/Utils/wprintgc.cgi
  -c, --padchar CHAR    default=N: A character to be used to pad when the
                        sequence length is not multiple of three.
  -n, --nopseudo        default=False: Drop sequences that contain stop
                        codon(s) even after padding to 5'- or 3'- terminal.
```


## cdskit_parsegb

### Tool Description
Parse GenBank files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit parsegb [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                      [--seqnamefmt STR] [--list_seqname_keys yes|no]
                      [--extract_cds yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --seqnamefmt STR      default=organism_accessions: Underline-separated list
                        of sequence name elements. Use --list_seqname_keys to
                        browse available values.
  --list_seqname_keys yes|no
                        default=no: Listing the keys (and values) available
                        for --seqnamefmt.
  --extract_cds yes|no  default=yes: Whether to extract the CDS feature.
```


## cdskit_printseq

### Tool Description
Print sequences from a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit printseq [-h] [--version] [-s PATH] [-if STR] [-n SEQNAME]
                       [--show_seqname yes|no]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -n, --seqname SEQNAME
                        default=: Name of the sequence to print. Regex is
                        supported.
  --show_seqname yes|no
                        default=yes: Whether to show sequence name starting
                        with ">". "no" prints sequences only.
```


## cdskit_rmseq

### Tool Description
Remove sequences based on name or problematic characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit rmseq [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                    [--seqname SEQNAME] [--problematic_char PROBLEMATIC_CHAR]
                    [--problematic_percent PROBLEMATIC_PERCENT]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --seqname SEQNAME     default=: Names of sequences to remove. Regex is
                        supported.
  --problematic_char PROBLEMATIC_CHAR
                        default=NX-?: Problematic characters considered by
                        --problematic_percent. Without separator.
  --problematic_percent PROBLEMATIC_PERCENT
                        default=0: Sequences containing >= this percentage of
                        --problematic_char are removed.
```


## cdskit_split

### Tool Description
Split CDS sequences into multiple files based on sequence identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit split [-h] [--version] [-s PATH] [-if STR] [-o PATH] [-of STR]
                    [--prefix PREFIX]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  -o, --outfile PATH    default=-: Output sequence file. Use "-" for STDOUT.
  -of, --outseqformat STR
                        default=fasta: Output sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
  --prefix PREFIX       default=INFILE: Output prefix PATH. If this is INFILE
                        and --outfile is set, --outfile is used as the prefix.
```


## cdskit_stats

### Tool Description
Calculate statistics for CDS sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
- **Homepage**: https://github.com/kfuku52/cdskit
- **Package**: https://anaconda.org/channels/bioconda/packages/cdskit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cdskit stats [-h] [--version] [-s PATH] [-if STR]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -s, --seqfile PATH    default=-: Input sequence file. Use "-" for STDIN.
  -if, --inseqformat STR
                        default=fasta: Input sequence format. See Biopython
                        documentation for available options.
                        https://biopython.org/wiki/SeqIO
```


## Metadata
- **Skill**: generated
