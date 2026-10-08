# gofasta CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gofasta_closest | PASS | Real SARS-CoV-2 genomes aligned to MN908947.3; distances agree with the SNP lists. |
| gofasta_sam_indels | PASS | Real SARS-CoV-2 SAM; the 5 and 10 base deletions in the CIGARs were reported at the right positions. The subcommand is deprecated upstream. |
| gofasta_sam_toMultiAlign | PASS | Real SARS-CoV-2 SAM; five sequences of 29903 bases written. |
| gofasta_sam_toPairAlign | PASS | Real SARS-CoV-2 SAM; one pairwise alignment file per sequence (5 files). |
| gofasta_sam_variants | PASS | Real SARS-CoV-2 SAM with the tool's GFF; same variants as the alignment-based variants command. |
| gofasta_snps | PASS | Real SARS-CoV-2 alignment; SNP lists include known sites (C241T, C3037T); removed an unneeded .fai requirement. |
| gofasta_updown_list | PASS | Real SARS-CoV-2 alignment; per-sequence SNP and ambiguity lists written. |
| gofasta_updown_topranking | PASS | Real SARS-CoV-2 alignment; same/up/side neighbours and distances are consistent with the SNP lists. |
| gofasta_variants | PASS | Real SARS-CoV-2 alignment with the tool's GFF; amino acid changes such as rdrp:P323L and S:D614G found; same as sam variants. |

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

## gofasta_sam_indels

### Tool Description
Parse a SAM file for raw indel information

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Parse a SAM file for raw indel information

Parse a sam file for raw insertion and deletion information stored in the CIGAR. No attempt
is made to consolidate indels within one query sequence's sam lines, so there may be some conflict.

Two files (default: insertions.txt and deletions.txt) are written, which contain a list of insertions
or deletions represented in more than a threshold (default: 2) number of queries.

The format of insertions.txt is a three-column, tab-separated file with the headers: ref_start	insertion	samples
The format of deletions.txt is a three-column, tab-separated file with the headers: ref_start	length	samples

the 'samples' column is a "|"-separated list of the queries with the insertion/deletion described by the first two columns.

Example usage:
	gofasta sam indels -s aligned.sam --threshold 2 --insertions-out insertions.txt --deletions-out deletions.txt

Usage:
  gofasta sam indels [flags]

Flags:
      --insertions-out string   Where to write the insertions (default "insertions.txt")
      --deletions-out string    Where to write the deletions (default "deletions.txt")
      --threshold int           Minimum count for an indel to be included in the output (default 2)
  -h, --help                    help for indels

Global Flags:
  -r, --reference string   Reference fasta file used to generate the sam file
  -s, --samfile string     Samfile to read. If none is specified, will read from stdin (default "stdin")
  -t, --threads int        Number of threads to use (default 1)
```


## gofasta_sam_toMultiAlign

### Tool Description
Convert a SAM file to a multiple alignment in fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Convert a SAM file to a multiple alignment in fasta format

Insertions relative to the reference are omitted, so all sequences in the output are the same ( = reference) length.

Example usage:
	gofasta sam toMultiAlign -s aligned.sam -o aligned.fasta

If you want, you can trim (and optionally pad) the output alignment to coordinates of your choosing:
	gofasta sam toMultiAlign -s aligned.sam --start 266 --end 29674 --pad -o aligned.fasta

If input and output files are not specified, the behaviour is to read the sam file from stdin and write
the fasta file to stdout, e.g.:
	minimap2 -a -x asm20 --score-N=0 reference.fasta unaligned.fasta | gofasta sam toMultiAlign > aligned.fasta

Usage:
  gofasta sam toMultiAlign [flags]

Aliases:
  toMultiAlign, tomultialign, toma

Flags:
      --start int          1-based first nucleotide position to retain in the output. Bases before this position are omitted, or are replaced with N if --pad (default -1)
      --end int            1-based last nucleotide position to retain the in output. Bases after this position are omitted, or are replaced with N if --pad (default -1)
      --pad                If --start and/or --end, replace the trimmed-out regions with Ns, else replace external deletions with Ns
  -o, --fasta-out string   Where to write the alignment (default "stdout")
  -w, --wrap int           Wrap the output alignment to this number of nucleotides wide. Omit this option not to wrap the output. (default -1)
  -h, --help               help for toMultiAlign

Global Flags:
  -r, --reference string   Reference fasta file used to generate the sam file
  -s, --samfile string     Samfile to read. If none is specified, will read from stdin (default "stdin")
  -t, --threads int        Number of threads to use (default 1)
```


## gofasta_sam_toPairAlign

### Tool Description
convert a SAM file to pairwise alignments in fasta format

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
convert a SAM file to pairwise alignments in fasta format

Usage:
  gofasta sam toPairAlign [flags]

Aliases:
  toPairAlign, topairalign, topa

Flags:
  -o, --outpath string    Output path where fasta files will be written
      --omit-reference    Omit the reference sequences from the output alignments
      --skip-insertions   Skip insertions relative to the reference from the output alignments
      --start int         1-based first nucleotide position (in reference coordinates) to retain in the output. Bases before this position are omitted (default -1)
      --end int           1-based last nucleotide position (in reference coordinates) to retain in the output. Bases after this position are omitted (default -1)
  -w, --wrap int          Wrap the output alignment to this number of nucleotides wide. Omit this option not to wrap the output. (default -1)
  -h, --help              help for toPairAlign

Global Flags:
  -r, --reference string   Reference fasta file used to generate the sam file
  -s, --samfile string     Samfile to read. If none is specified, will read from stdin (default "stdin")
  -t, --threads int        Number of threads to use (default 1)
```


## gofasta_sam_variants

### Tool Description
Annotate mutations relative to a reference from an alignment in sam format

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Annotate mutations relative to a reference from an alignment in sam format

Example usage:
	gofasta sam variants -s aligned.sam -r reference.fasta -a annotation.gb -o variants.csv
	gofasta sam variants -s aligned.sam -r reference.fasta -a annotation.gff -o variants.csv

If input sam and output csv files are not specified, the behaviour is to read the sam from stdin and write
the variants to stdout.

--reference should be the same sequence that was used to generate the sam file, and should be in the same coordinates
as the --annotation. You don't have to provide a file to --reference if your annotation has the fasta record in it.

gff-format annotations must be valid version 3 files. See github.com/virus-evolution/gofasta for more details
of the format.

Mutations are annotated with ins (insertion), del (deletion), aa (amino acid change) or nuc (a nucleotide change that
isn't in a codon that is represented by an amino acid change). The formats are:

	ins:2028:3 - a 3-base insertion immediately after (1-based) position 2028 in reference coordinates
	del:11288:9 - a 9-base deletion whose first missing nucleotide is at (1-based) position 11288 in reference coordinates
	aa:s:D614G - the amino acid at (1-based) residue 614 in the S gene is a D in the reference and a G in this sequence
	nuc:C3037T - the nucleotide at (1-based) position 3037 is a C in the reference and a T in this sequence

Frame-shifting mutations in coding sequence are reported as indels but are ignored for subsequent amino-acids in the alignment.

Usage:
  gofasta sam variants [flags]

Flags:
  -a, --annotation string   Genbank or GFF3 format annotation file. Must have suffix .gb or .gff
  -o, --outfile string      Where to write the variants (default "stdout")
      --start int           Only report variants after (and including) this position (default -1)
      --end int             Only report variants before (and including) this position (default -1)
      --aggregate           Report the proportions of each change
      --threshold float     If --aggregate, only report changes with a freq greater than or equal to this value
      --append-snps         Report the codon's SNPs in parenthesis after each amino acid mutation
  -h, --help                help for variants

Global Flags:
  -r, --reference string   Reference fasta file used to generate the sam file
  -s, --samfile string     Samfile to read. If none is specified, will read from stdin (default "stdin")
  -t, --threads int        Number of threads to use (default 1)
```


## gofasta_updown_list

### Tool Description
Generate input CSV files for gofasta updown topranking

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Generate input CSV files for gofasta updown topranking

Example usage:

	gofasta updown list -r reference.fasta -q alignment.fasta -o mutationlist.csv

Non-ATGC nucleotides are not recommended in the --reference, and --reference and --query must
be aligned to the same thing.

--outfile is a CSV-format file with the columns: query,SNPs,ambiguities,SNPcount,ambcount. There is one row
for each sequence in --query. SNPs is a "|"-delimited list of SNPs relative to --reference. ambiguities is
a "|"-delimited list of ranges (1-based, inclusive) of tracts of ambiguities (anything that isn't ATGC).

Usage:
  gofasta updown list [flags]

Flags:
  -q, --query string     Alignment of sequences to parse, in fasta format (default "stdin")
  -o, --outfile string   Output to write (default "stdout")
  -h, --help             help for list

Global Flags:
  -r, --reference string   Reference sequence, in fasta format, which is treated as the root of the imaginary tree
```


## gofasta_updown_topranking

### Tool Description
Get pseudo-tree-aware catchments for query sequences from alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/virus-evolution/gofasta
- **Package**: https://anaconda.org/channels/bioconda/packages/gofasta/overview
- **Validation**: PASS

### Original Help Text
```text
Get pseudo-tree-aware catchments for query sequences from alignments

Example usage:
	gofasta updown topranking -q smallquery.fasta -r WH04.fasta -t mutationlist.csv --size-total 1000 -o catchment.csv

For each sequence in --query, this routine finds the closest sequences by SNP-distance in --target, binned according to
whether they are likely children, parents, or siblings of, or on a polytomy with, the query sequence. It does this by comparing
SNPs relative to a common reference sequence which is imagined to be the root of the tree.

--query and --target can either be alignments in fasta format, or the CSV output of gofasta updown list, or one of each. They
must have file extensions .csv .fasta or .fa . If either is an alignment, you must provide --reference, and this should be the
same sequence that was used by gofasta updown list.

Use the --dist flags to filter on SNP-distances in each direction. As long as you haven't also used any --size flags,
the program will return all the targets that are equal or less than the specified SNP-distance(s) away. If --dist-push 
is invoked with an integer (i) argument, the program will push the SNP-distance boundaries to cover the all sequences
that are the closest i SNP-distances away, and then it will return all the neighbours at those distances in that bin.

If you provide a number to --size-total, the output will try to include this many closest sequences to the query, split evenly
between the four bins. If one or more bins has a shortfall, the sizes of the other bins will increase until --size-total is met,
if possible, unless you use --no-fill.

You can provide --size-up, -down, -side and -same, instead of --size-total, if you want different proportions for each bin.
The program will aim to provide the sum of these numbers in total in the output, and will make up for a shortfall in one bin
by increasing the count of the other bins where possible, unless --no-fill.

You can combine the two types of flag (size and dist), to return only the closest n sequences under a set distance (as long as
you haven't also invoked --dist-push).

Usage:
  gofasta updown topranking [flags]

Flags:
  -q, --query string             File with sequences to find neighbours for. Either the CSV output of gofasta updown list, or an alignment in fasta format
  -t, --target string            File of sequences to look for neighbours in. Either the CSV output of gofasta updown list, or an alignment in fasta format
  -o, --outfile string           CSV-format file of closest neighbours to write (default "stdout")
      --table                    Write a long-form table of the output
  -r, --reference string         Reference sequence, in fasta format - only required if --query and --target are fasta files
      --ignore string            Optional plain text file of IDs to ignore in the target file when searching for neighbours
      --dist-all int             Maximum allowed SNP-distance between target and query sequence in any direction. Overrides the settings below
      --dist-up int              Maximum allowed SNP-distance from query for sequences in the parent bin
      --dist-down int            Maximum allowed SNP-distance from query for sequences in the child bin
      --dist-side int            Maximum allowed SNP-distance from query for sequences in the sibling bin
      --size-total int           Max number of neighbours to find (attempts to split equally between same/up/down/side). A hard limit
      --size-up int              Max number of closest parent sequences to find, if size-total not specified. A soft limit unless --no-fill
      --size-down int            Max number of closest child sequences to find, if size-total not specified. A soft limit unless --no-fill
      --size-side int            Max number of closest sibling sequences to find, if size-total not specified. A soft limit unless --no-fill
      --size-same int            Max number of identical sequences to find, if size-total not specified. A soft limit unless --no-fill
      --threshold-pair float32   Up to this proportion of consequential sites is allowed to be ambiguous in either sequence for each pairwise comparison (default 0.1)
      --threshold-target int     Target can have at most this number of ambiguities to be considered (default 10000)
      --dist-push int            Push the --dist boundaries outwards so that bins have at least these many closest SNP-distances for which there are neighbours, where possible
      --no-fill                  Don't make up for a shortfall in any of --size-up, -down, -side or -same by increasing the count for other bins
  -h, --help                     help for topranking
```


## Metadata
- **Skill**: generated
