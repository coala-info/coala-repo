# gofasta CWL Generation Report

## gofasta_closest

### Tool Description
Find the closest sequence(s) to a query by genetic distance

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Total Downloads**: 203.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cov-ert/gofasta
- **Stars**: N/A
### Original Help Text
```text
Find the closest sequence(s) to a query by genetic distance

The usecase is imagined to be a small number of query sequences, whose nearest neighbours
by genetic distance need to be found amongst a large number of target sequences. The query 
alignment is read into memory and the target alignment is streamed from disk and iterated 
over once, so it can be arbitrarily large.

You can find the single closest neighbour like:

	gofasta closest -t 2 --query query.fasta --target target.fasta -o closest.csv

and the output will be a CSV format file with the headers query, closest, distance, SNPs.

Or you can find the nearest n neighbours:

	gofasta closest -t 2 -n 1000 --query query.fasta --target target.fasta -o closest.n1000.csv

or you can find all the neighbours under a -d distance away:

	gofasta closest -t 2 --measure snp -d 5 --query query.fasta --target target.fasta -o closest.d5snps.csv

and the default output will be a CSV format file with the headers query, closest.  The 'closest' column
is a ";"-delimited list of neighbours, closest first. Ties for distance are broken by genome completeness.

You can combine -d with -n to find the nearest n neighbours less than or equal to a distance, d.

Possible measures of distance are raw number of nucleotide changes per site (the default, raw), raw number
of nucleotide changes in total (snp), or Tamura and Nei's 1993 evolutionary distance (tn93).

Use --table in combination with the -n and/or -d flags to write a long-form output including the distance
between every pair.

Usage:
  gofasta closest [flags]

Flags:
  -t, --threads int       Number of CPUs to use (Default: all available CPUs)
      --query string      Alignment of sequences to find neighbours for, in fasta format
      --target string     Alignment of sequences to search for neighbours in, in fasta format
  -m, --measure string    Which distance measure to use (raw, snp or tn93) (default "raw")
  -n, --number int        (Optional) the closest n sequences to each query will be returned
  -d, --max-dist string   (Optional) return all sequences less than or equal to this distance away
  -o, --outfile string    The output file to write (default "stdout")
      --table             Write a long-form table of the output
  -h, --help              help for closest
```


## gofasta_completion

### Tool Description
Generate the autocompletion script for gofasta for the specified shell.

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Generate the autocompletion script for gofasta for the specified shell.
See each sub-command's help for details on how to use the generated script.

Usage:
  gofasta completion [command]

Available Commands:
  bash        Generate the autocompletion script for bash
  fish        Generate the autocompletion script for fish
  powershell  Generate the autocompletion script for powershell
  zsh         Generate the autocompletion script for zsh

Flags:
  -h, --help   help for completion

Use "gofasta completion [command] --help" for more information about a command.
```


## gofasta_licences

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Jackson B (2022). gofasta: command-line utilities for genomic epidemiology research. Bioinformatics 38 (16), 4033-4035
https://doi.org/10.1093/bioinformatics/btac424.

gofasta is distributed under the MIT licence

it incorporates the following libraries that are distributed under licence:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

bíogo (https://github.com/biogo/biogo):

Copyright ©2012 The bíogo Authors. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the bíogo project nor the names of its authors and
      contributors may be used to endorse or promote products derived from this
      software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```


## gofasta_sam

### Tool Description
Do things with sam files

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Do things with sam files

Usage:
  gofasta sam [flags]
  gofasta sam [command]

Available Commands:
  indels       Parse a SAM file for raw indel information
  toMultiAlign Convert a SAM file to a multiple alignment in fasta format
  toPairAlign  convert a SAM file to pairwise alignments in fasta format
  variants     Annotate mutations relative to a reference from an alignment in sam format

Flags:
  -h, --help               help for sam
  -r, --reference string   Reference fasta file used to generate the sam file
  -s, --samfile string     Samfile to read. If none is specified, will read from stdin (default "stdin")
  -t, --threads int        Number of threads to use (default 1)

Use "gofasta sam [command] --help" for more information about a command.
```


## gofasta_snps

### Tool Description
Find snps relative to a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Find snps relative to a reference.

Example usage:
	gofasta snps -r reference.fasta -q alignment.fasta -o snps.csv

reference.fasta and alignment.fasta must be the same width.

With the default settings the output is a csv-format file with one line per query sequence, and two columns:
'query' and 'SNPs', the second of which is a "|"-delimited list of snps in that query.

If you set --aggregate (and optionally a --threshold) it will return the SNPs present in the entire sample
(whose frequency is equal to/above --threshold) and their frequencies.

Setting --hard-gaps treats alignment gaps as different from {ATGC}.

If query and outfile are not specified, the behaviour is to read the query alignment
from stdin and write the snps file to stdout, e.g. you could do this:
	cat alignment.fasta | gofasta snps -r reference.fasta > snps.csv

Usage:
  gofasta snps [flags]

Flags:
  -r, --reference string   Reference sequence, in fasta format
  -q, --query string       Alignment of sequences to find snps in, in fasta format (default "stdin")
  -o, --outfile string     Output to write (default "stdout")
      --hard-gaps          Don't treat alignment gaps as missing data
      --aggregate          Report the proportions of each change
      --threshold float    If --aggregate, only report snps with a freq greater than or equal to this value
  -h, --help               help for snps
```


## gofasta_updown

### Tool Description
Get pseudo-tree-aware catchments for query sequences from alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Get pseudo-tree-aware catchments for query sequences from alignments

Usage:
  gofasta updown [flags]
  gofasta updown [command]

Available Commands:
  list        Generate input CSV files for gofasta updown topranking
  topranking  Get pseudo-tree-aware catchments for query sequences from alignments

Flags:
  -h, --help               help for updown
  -r, --reference string   Reference sequence, in fasta format, which is treated as the root of the imaginary tree

Use "gofasta updown [command] --help" for more information about a command.
```


## gofasta_variants

### Tool Description
Annotate mutations relative to a reference from a multiple sequence alignment in fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/cov-ert/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Annotate mutations relative to a reference from a multiple sequence alignment in fasta format

Example usage:

	./gofasta variants --msa alignment.fasta --annotation MN908947.gb --reference MN908947.3 > variants.csv
	./gofasta variants --msa another.fasta --annotation MN908947.gff --reference Wuhan-Hu-1 > variants.csv

--reference is the name of the reference record in --msa. If you are reading the --msa from stdin, it must
be the first sequence. If you don't provide a --reference the program will try to use the fasta record in the
annotation file, in which case the --msa must be in the same coordinates.

gff-format annotations must be valid version 3 files. See github.com/virus-evolution/gofasta for more details
of the format.

If input --msa and output csv files are not specified, the behaviour is to read the alignment from stdin and write
the variants to stdout.

You can use --aggregate to report the overall proportions of each mutation in the --msa, and --threshold to filter on 
frequency.

Mutations are annotated with ins (insertion), del (deletion), aa (amino acid change) or nuc (a nucleotide change that
isn't in a codon that is represented by an amino acid change). The formats are:

	ins:2028:3 - a 3-base insertion immediately after (1-based) position 2028 in reference coordinates
	del:11288:9 - a 9-base deletion whose first missing nucleotide is at (1-based) position 11288 in reference coordinates
	aa:s:D614G - the amino acid at (1-based) residue 614 in the S gene is a D in the reference and a G in this sequence
	nuc:C3037T - the nucleotide at (1-based) position 3037 in reference coordinates is a C in the reference and a T in this sequence

Frame-shifting mutations in coding sequence are reported as indels but are ignored for subsequent amino-acids in the alignment.

Usage:
  gofasta variants [flags]

Flags:
      --msa string          Multiple sequence alignment in fasta format (default "stdin")
  -r, --reference string    The ID of the reference record in the msa
  -a, --annotation string   Genbank or GFF3 format annotation file. Must have suffix .gb or .gff
  -o, --outfile string      Name of the file of variants to write (default "stdout")
      --start int           Only report variants after (and including) this position (default -1)
      --end int             Only report variants before (and including) this position (default -1)
      --aggregate           Report the proportions of each change
      --threshold float     If --aggregate, only report changes with a freq greater than or equal to this value
      --append-snps         Report the codon's SNPs in parenthesis after each amino acid mutation
  -t, --threads int         Number of threads to use (default 1)
  -h, --help                help for variants
```


## Metadata
- **Skill**: generated
