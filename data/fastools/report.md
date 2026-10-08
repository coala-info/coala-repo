# fastools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastools_add | PASS |  |
| fastools_aln | PASS | numbers correct; the tool prints no separator between records |
| fastools_cat | PASS |  |
| fastools_collapse | Failed | tool bug: fastools collapse crashes with NameError collapse_fasta is not defined |
| fastools_csv2fa2 | PASS |  |
| fastools_descr | PASS |  |
| fastools_dna2rna | PASS |  |
| fastools_edit | PASS |  |
| fastools_fa2fq | PASS |  |
| fastools_fa2gb | PASS |  |
| fastools_famotif2bed | PASS |  |
| fastools_fq2fa | PASS |  |
| fastools_gb2fa | PASS |  |
| fastools_gen | PASS |  |
| fastools_get | PASS | fetched MT192765.1 region from NCBI; NetworkAccess added |
| fastools_lenfilt | PASS |  |
| fastools_length | PASS |  |
| fastools_list_enzymes | PASS | fixed baseCommand to fastools list_enzymes |
| fastools_maln | Failed | tool bug: fastools maln crashes with TypeError (writes an int to stdout) |
| fastools_mangle | PASS |  |
| fastools_merge | PASS |  |
| fastools_raw2fa | PASS |  |
| fastools_restrict | PASS |  |
| fastools_reverse | PASS |  |
| fastools_rna2dna | PASS |  |
| fastools_rselect | PASS |  |
| fastools_s2i | PASS |  |
| fastools_sanitise | PASS |  |
| fastools_select | PASS |  |
| fastools_split_fasta | PASS | new CWL for the split_fasta command |
| fastools_splitseq | PASS |  |
| fastools_tagcount | PASS |  |

## fastools_add

### Tool Description
Add a sequence to the 5' end of each read in a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: fastools add [-h] [-q QUALITY] INPUT OUTPUT SEQ

Add a sequence to the 5' end of each read in a FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  SEQ         a sequence (str)

options:
  -h, --help  show this help message and exit
  -q QUALITY  quality score (int default=40)
```


## fastools_aln

### Tool Description
Calculate the Levenshtein distance between two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools aln [-h] INPUT INPUT

Calculate the Levenshtein distance between two FASTA files.

positional arguments:
  INPUT       input files

options:
  -h, --help  show this help message and exit
```


## fastools_cat

### Tool Description
Return the sequence content of a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools cat [-h] INPUT

Return the sequence content of a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_collapse

### Tool Description
Remove all mononucleotide stretches from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools collapse [-h] [-s MAX_STRETCH] INPUT OUTPUT

Remove all mononucleotide stretches from a FASTA file.

positional arguments:
  INPUT                 input file
  OUTPUT                output file

options:
  -h, --help            show this help message and exit
  -s MAX_STRETCH, --stretch MAX_STRETCH
                        Length of the stretch (int default: 3)
```


## fastools_csv2fa2

### Tool Description
Convert a CSV file to two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools csv2fa2 [-h] [-s] INPUT OUTPUT OUTPUT

Convert a CSV file to two FASTA files.

positional arguments:
  INPUT       input file
  OUTPUT      output files

options:
  -h, --help  show this help message and exit
  -s          skip the first line of the CSV file
```


## fastools_descr

### Tool Description
Return the description of all records in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools descr [-h] INPUT

Return the description of all records in a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_dna2rna

### Tool Description
Convert the FASTA/FASTQ content from DNA to RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools dna2rna [-h] INPUT OUTPUT

Convert the FASTA/FASTQ content from DNA to RNA.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_edit

### Tool Description
Replace regions in a reference sequence. The header of the edits file must have the following strucure: >name chrom:start_end

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools edit [-h] INPUT OUTPUT EDITS

Replace regions in a reference sequence. The header of the edits file must
have the following strucure: >name chrom:start_end

positional arguments:
  INPUT       input file
  OUTPUT      output file
  EDITS       FASTA file containing edits

options:
  -h, --help  show this help message and exit
```


## fastools_fa2fq

### Tool Description
Convert a FASTA file to a FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fa2fq [-h] [-q QUALITY] INPUT OUTPUT

Convert a FASTA file to a FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
  -q QUALITY  quality score (int default=40)
```


## fastools_fa2gb

### Tool Description
Convert a FASTA file to a GenBank file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fa2gb [-h] INPUT OUTPUT ACCNO

Convert a FASTA file to a GenBank file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number

options:
  -h, --help  show this help message and exit
```


## fastools_famotif2bed

### Tool Description
Find a given sequence in a FASTA file and write the results to a Bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools famotif2bed [-h] INPUT OUTPUT MOTIF

Find a given sequence in a FASTA file and write the results to a Bed file.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  MOTIF       The sequence to be found

options:
  -h, --help  show this help message and exit
```


## fastools_fq2fa

### Tool Description
Convert a FASTQ file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools fq2fa [-h] INPUT OUTPUT

Convert a FASTQ file to a FASTA file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_gb2fa

### Tool Description
Convert a GenBank file to a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools gb2fa [-h] INPUT OUTPUT

Convert a GenBank file to a FASTA file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_gen

### Tool Description
Generate a DNA sequence in FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools gen [-h] OUTPUT ACCNO DESCR LENGTH

Generate a DNA sequence in FASTA format.

positional arguments:
  OUTPUT      output file
  ACCNO       accession number
  DESCR       description of the DNA sequence
  LENGTH      length of the DNA sequence

options:
  -h, --help  show this help message and exit
```


## fastools_get

### Tool Description
Retrieve a reference sequence and find the location of a specific gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools get [-h] [-s START] [-p STOP] [-o ORIENTATION]
                    OUTPUT ACCNO EMAIL

Retrieve a reference sequence and find the location of a specific gene.

positional arguments:
  OUTPUT          output file
  ACCNO           accession number
  EMAIL           email address

options:
  -h, --help      show this help message and exit
  -s START        start of the area of interest
  -p STOP         end of the area of interest
  -o ORIENTATION  orientation (1=forward, 2=reverse)
```


## fastools_length

### Tool Description
Report the lengths of all FASTA records in a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools length [-h] INPUT

Report the lengths of all FASTA records in a file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_lenfilt

### Tool Description
Split a FASTA/FASTQ file on length.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools lenfilt [-h] [-l LENGTH] INPUT OUTPUT OUTPUT

Split a FASTA/FASTQ file on length.

positional arguments:
  INPUT       input file
  OUTPUT      output files

options:
  -h, --help  show this help message and exit
  -l LENGTH   length threshold (int default: 25)
```


## fastools_maln

### Tool Description
Calculate the Hamming distance between all sequences in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools maln [-h] INPUT

Calculate the Hamming distance between all sequences in a FASTA file.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
```


## fastools_mangle

### Tool Description
Calculate the complement (not reverse-complement) of a FASTA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools mangle [-h] INPUT OUTPUT

Calculate the complement (not reverse-complement) of a FASTA sequence.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_merge

### Tool Description
Merge two FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools merge [-h] [-f FILL] INPUT INPUT OUTPUT

Merge two FASTA files.

positional arguments:
  INPUT       input files
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
  -f FILL     Add 'N's between the reads (int default: 0)
```


## fastools_raw2fa

### Tool Description
Make a FASTA file from a raw sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools raw2fa [-h] INPUT OUTPUT ACCNO DESCR

Make a FASTA file from a raw sequence.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number
  DESCR       description of the DNA sequence

options:
  -h, --help  show this help message and exit
```


## fastools_restrict

### Tool Description
Fragment a genome with restriction enzymes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools restrict [-h] [-r ENZYME] INPUT

Fragment a genome with restriction enzymes.

positional arguments:
  INPUT       input file

options:
  -h, --help  show this help message and exit
  -r ENZYME   restriction enzyme (use multiple times for more enzymes)
```


## fastools_reverse

### Tool Description
Make the reverse complement a FASTA/FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools reverse [-h] INPUT OUTPUT

Make the reverse complement a FASTA/FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_rna2dna

### Tool Description
Convert the FASTA/FASTQ content from RNA to DNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools rna2dna [-h] INPUT OUTPUT

Convert the FASTA/FASTQ content from RNA to DNA.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_rselect

### Tool Description
Select a substring from every read. Positions are one-based and inclusive.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools rselect [-h] INPUT OUTPUT ACCNO FIRST LAST

Select a substring from every read. Positions are one-based and inclusive.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  ACCNO       accession number
  FIRST       first base of the selection (int)
  LAST        last base of the selection (int)

options:
  -h, --help  show this help message and exit
```


## fastools_s2i

### Tool Description
Convert sanger FASTQ to illumina FASTQ.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools s2i [-h] INPUT OUTPUT

Convert sanger FASTQ to illumina FASTQ.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_sanitise

### Tool Description
Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools sanitise [-h] INPUT OUTPUT

Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file.

positional arguments:
  INPUT       input file
  OUTPUT      output file

options:
  -h, --help  show this help message and exit
```


## fastools_select

### Tool Description
Select a substring from every read. Positions are one-based and inclusive.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools select [-h] INPUT OUTPUT FIRST LAST

Select a substring from every read. Positions are one-based and inclusive.

positional arguments:
  INPUT       input file
  OUTPUT      output file
  FIRST       first base of the selection (int)
  LAST        last base of the selection (int)

options:
  -h, --help  show this help message and exit
```


## fastools_splitseq

### Tool Description
Split a FASTA/FASTQ file based on containing part of the sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools splitseq [-h] INPUT OUTPUT OUTPUT SEQ

Split a FASTA/FASTQ file based on containing part of the sequence

positional arguments:
  INPUT       input file
  OUTPUT      output files
  SEQ         a sequence (str)

options:
  -h, --help  show this help message and exit
```


## fastools_tagcount

### Tool Description
Count tags in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools tagcount [-h] [-m MISMATCHES] INPUT SEQ

Count tags in a FASTA file.

positional arguments:
  INPUT          input file
  SEQ            a sequence (str)

options:
  -h, --help     show this help message and exit
  -m MISMATCHES  amount of mismatches allowed (int default=2)
```


## fastools_list_enzymes

### Tool Description
Return a list of supported restiction enzymes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastools list_enzymes [-h]

Return a list of supported restiction enzymes.

options:
  -h, --help  show this help message and exit
```

## fastools_split_fasta

### Tool Description
Split a FASTA file based on the occurrence of markers.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
- **Homepage**: https://git.lumc.nl/j.f.j.laros/fastools
- **Package**: https://anaconda.org/channels/bioconda/packages/fastools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split_fasta [-h] [-o OUTPUT] [-v] INPUT LIBRARY

Split a FASTA file based on the occurrence of markers.

positional arguments:
  INPUT       input file
  LIBRARY     file containing markers

options:
  -h, --help  show this help message and exit
  -o OUTPUT   output file (default=stdout)
  -v          show program's version number and exit

The output is FASTA-like, depending on the replacement defined in the library.
If the replacement is identical to the marker, the output is in FASTA format.

Per marker, two files are created:
- markername.txt         : all sequences that have the marker as substring
- markername_counted.txt : unique sequences (counts are placed in the header)

Format of the library file:
name marker replacement
```

## Metadata
- **Skill**: not generated
