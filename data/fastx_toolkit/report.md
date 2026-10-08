# fastx_toolkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastx_toolkit_fasta_clipping_histogram | PASS | PNG histogram made; bar heights match the length counts computed from the input (collapsed IDs weighted) |
| fastx_toolkit_fasta_formatter | PASS | output matches the Galaxy expected files for -w 0 and -w 60; -t gives a two-column table |
| fastx_toolkit_fasta_nucleotide_changer | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-r and -d tested) |
| fastx_toolkit_fastq_masker | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-q, -r, -Q tested) |
| fastx_toolkit_fastq_quality_boxplot_graph | Failed | image problem: gnuplot is not installed in the image, so the plot is empty |
| fastx_toolkit_fastq_quality_converter | Failed | tool bug: -z writes an empty file; without -z the output matches the fastx_toolkit Galaxy expected files (flag fixed from --output-file to -o, -Q added) |
| fastx_toolkit_fastq_quality_filter | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-q, -p, -Q tested) |
| fastx_toolkit_fastq_quality_trimmer | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-t, -l, -Q tested) |
| fastx_toolkit_fastq_to_fasta | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected files (flag fixed from --output-file to -o) |
| fastx_toolkit_fastx_artifacts_filter | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (FASTA and FASTQ) |
| fastx_toolkit_fastx_barcode_splitter | PASS | per-barcode counts 11/12/9/1 and 9 unmatched match the Galaxy expected summary; --eol, --exact, --quiet also run |
| fastx_toolkit_fastx_clipper | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-a, -l, -c, -n tested) |
| fastx_toolkit_fastx_collapser | PASS | flag fixed from --output-file to -o; same sequences and counts as the Galaxy expected file (order of equal counts differs) |
| fastx_toolkit_fastx_nucleotide_distribution_graph | Failed | image problem: gnuplot is not installed in the image, so the plot is empty |
| fastx_toolkit_fastx_nucleotide_distribution_line_graph | Failed | image problem: gnuplot is not installed in the image; the script also rejects the fastx_quality_stats report (header check expects 'cycle count') |
| fastx_toolkit_fastx_quality_stats | PASS | output matches the Galaxy expected file (-Q 64); -N gives the new format |
| fastx_toolkit_fastx_renamer | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (-n SEQ and COUNT tested) |
| fastx_toolkit_fastx_reverse_complement | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected file (FASTA and FASTQ) |
| fastx_toolkit_fastx_trimmer | Failed | tool bug: -z writes an empty file; without -z the output matches the Galaxy expected files (flag fixed to -o, -t and -m added) |
| fastx_toolkit_fastx_uncollapser | PASS | output matches the Galaxy expected files for FASTA and for tabular input with -c 10 |

## fastx_toolkit_fasta_clipping_histogram

### Tool Description
Create a Linker Clipping Information Histogram from a FASTA file (can be GZIPped).

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
	
Create a Linker Clipping Information Histogram

usage: fasta_clipping_histogram.pl INPUT_FILE.FA OUTPUT_FILE.PNG

	INPUT_FILE.FA   = input file (in FASTA format, can be GZIPped)
	OUTPUT_FILE.PNG = histogram image
```

## fastx_toolkit_fasta_formatter

### Tool Description
Change the width of sequence lines in a FASTA file, or convert it to a tabular format.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fasta_formatter [-h] [-i INFILE] [-o OUTFILE] [-w N] [-t] [-e]
Part of FASTX Toolkit 0.0.14 by assafgordon@gmail.com

   [-h]         = This helpful help screen.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
   [-w N]       = max. sequence line width for output FASTA file.
                  When ZERO (the default), sequence lines will NOT be wrapped -
                  all nucleotides of each sequences will appear on a single 
                  line (good for scripting).
   [-t]         = Output tabulated format (instead of FASTA format).
                  Sequence-Identifiers will be on first column,
                  Nucleotides will appear on second column (as single line).
   [-e]         = Output empty sequences (default is to discard them).
                  Empty sequences are ones who have only a sequence identifier,
                  but not actual nucleotides.

Input Example:
   >MY-ID
   AAAAAGGGGG
   CCCCCTTTTT
   AGCTN

Output example with unlimited line width [-w 0]:
   >MY-ID
   AAAAAGGGGGCCCCCTTTTTAGCTN

Output example with max. line width=7 [-w 7]:
   >MY-ID
   AAAAAGG
   GGGTTTT
   TCCCCCA
   GCTN

Output example with tabular output [-t]:
   MY-ID	AAAAAGGGGGCCCCCTTTTAGCTN

example of empty sequence:
(will be discarded unless [-e] is used)
  >REGULAR-SEQUENCE-1
  AAAGGGTTTCCC
  >EMPTY-SEQUENCE
  >REGULAR-SEQUENCE-2
  AAGTAGTAGTAGTAGT
  GTATTTTATAT
```

## fastx_toolkit_fasta_nucleotide_changer

### Tool Description
Change nucleotides in a FASTA/Q file: DNA to RNA (T to U) or RNA to DNA (U to T).

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fasta_nucleotide_changer [-h] [-z] [-v] [-i INFILE] [-o OUTFILE] [-r] [-d]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-z]         = Compress output with GZIP.
   [-v]         = Verbose mode. Prints a short summary.
                  with [-o], summary is printed to STDOUT.
                  Otherwise, summary is printed to STDERR.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
   [-r]         = DNA-to-RNA mode - change T's into U's.
   [-d]         = RNA-to-DNA mode - change U's into T's.
```

## fastx_toolkit_fastq_masker

### Tool Description
Mask low-quality nucleotides in a FASTQ file by replacing them with a chosen character (default N).

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_masker [-h] [-v] [-q N] [-r C] [-z] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-q N]       = Quality threshold - nucleotides with lower quality will be masked
                  Default is 10.
   [-r C]       = Replace low-quality nucleotides with character C. Default is 'N'
   [-z]         = Compress output with GZIP.
   [-i INFILE]  = FASTQ input file. default is STDIN.
   [-o OUTFILE] = FASTQ output file. default is STDOUT.
   [-v]         = Verbose - report number of sequences.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.
   [-Q N]       = FASTQ ASCII offset. Default is 33.
```

## fastx_toolkit_fastq_quality_boxplot_graph

### Tool Description
Generate a quality score box-plot graph (PNG or PostScript) from the output of fastx_quality_stats.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
Solexa-Quality BoxPlot plotter
Generates a solexa quality score box-plot graph 

Usage: /usr/bin/fastq_quality_boxplot_graph.sh [-i INPUT.TXT] [-t TITLE] [-p] [-o OUTPUT]

  [-p]           - Generate PostScript (.PS) file. Default is PNG image.
  [-i INPUT.TXT] - Input file. Should be the output of "solexa_quality_statistics" program.
  [-o OUTPUT]    - Output file name. default is STDOUT.
  [-t TITLE]     - Title (usually the solexa file name) - will be plotted on the graph.
```

## fastx_toolkit_fastq_quality_filter

### Tool Description
Filter FASTQ reads by quality: keep reads where at least a given percent of bases reach a minimum quality score.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_quality_filter [-h] [-v] [-q N] [-p N] [-z] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-q N]       = Minimum quality score to keep.
   [-p N]       = Minimum percent of bases that must have [-q] quality.
   [-z]         = Compress output with GZIP.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
   [-v]         = Verbose - report number of sequences.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.
   [-Q N]       = FASTQ ASCII offset. Default is 33.
```

## fastx_toolkit_fastq_quality_trimmer

### Tool Description
Trim low-quality ends of reads in a FASTQ file, and discard reads that are too short after trimming.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq_quality_trimmer [-h] [-v] [-t N] [-l N] [-z] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-t N]       = Quality threshold - nucleotides with lower 
                  quality will be trimmed (from the end of the sequence).
   [-l N]       = Minimum length - sequences shorter than this (after trimming)
                  will be discarded. Default = 0 = no minimum length. 
   [-z]         = Compress output with GZIP.
   [-i INFILE]  = FASTQ input file. default is STDIN.
   [-o OUTFILE] = FASTQ output file. default is STDOUT.
   [-v]         = Verbose - report number of sequences.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.
   [-Q N]       = FASTQ ASCII offset. Default is 33.
```

## fastx_toolkit_fastx_artifacts_filter

### Tool Description
Filter sequencing artifacts (reads with all identical bases, or matching known artifact patterns) from a FASTA/Q file.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_artifacts_filter [-h] [-v] [-z] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
   [-z]         = Compress output with GZIP.
   [-v]         = Verbose - report number of processed reads.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.
```

## fastx_toolkit_fastx_clipper

### Tool Description
Remove adapter sequences from a FASTA/Q file.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_clipper [-h] [-a ADAPTER] [-D] [-l N] [-n] [-d N] [-c] [-C] [-o] [-v] [-z] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-a ADAPTER] = ADAPTER string. default is CCTTAAGG (dummy adapter).
   [-l N]       = discard sequences shorter than N nucleotides. default is 5.
   [-d N]       = Keep the adapter and N bases after it.
                  (using '-d 0' is the same as not using '-d' at all. which is the default).
   [-c]         = Discard non-clipped sequences (i.e. - keep only sequences which contained the adapter).
   [-C]         = Discard clipped sequences (i.e. - keep only sequences which did not contained the adapter).
   [-k]         = Report Adapter-Only sequences.
   [-n]         = keep sequences with unknown (N) nucleotides. default is to discard such sequences.
   [-v]         = Verbose - report number of sequences.
                  If [-o] is specified,  report will be printed to STDOUT.
                  If [-o] is not specified (and output goes to STDOUT),
                  report will be printed to STDERR.
   [-z]         = Compress output with GZIP.
   [-D]	 = DEBUG output.
   [-M N]       = require minimum adapter alignment length of N.
                  If less than N nucleotides aligned with the adapter - don't clip it.   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
```

## fastx_toolkit_fastx_nucleotide_distribution_graph

### Tool Description
Generate a nucleotide distribution graph (PNG or PostScript) from the output of fastx_quality_stats.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
FASTA/Q Nucleotide Distribution Plotter

Usage: /usr/bin/fastx_nucleotide_distribution_graph.sh [-i INPUT.TXT] [-t TITLE] [-p] [-o OUTPUT]

  [-p]           - Generate PostScript (.PS) file. Default is PNG image.
  [-i INPUT.TXT] - Input file. Should be the output of "fastx_quality_statistics" program.
  [-o OUTPUT]    - Output file name. default is STDOUT.
  [-t TITLE]     - Title - will be plotted on the graph.
```

## fastx_toolkit_fastx_nucleotide_distribution_line_graph

### Tool Description
Generate a nucleotide distribution line graph (PNG or PostScript) from the output of fastx_quality_stats.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
FASTA/Q Nucleotide Distribution Plotter

Usage: /usr/bin/fastx_nucleotide_distribution_line_graph.sh [-i INPUT.TXT] [-t TITLE] [-p] [-o OUTPUT]

  [-p]           - Generate PostScript (.PS) file. Default is PNG image.
  [-i INPUT.TXT] - Input file. Should be the output of "fastx_quality_statistics" program.
  [-o OUTPUT]    - Output file name. default is STDOUT.
  [-t TITLE]     - Title - will be plotted on the graph.
```

## fastx_toolkit_fastx_quality_stats

### Tool Description
Calculate per-column (cycle) quality statistics of a FASTQ file: counts, min, max, mean, quartiles, whiskers and nucleotide counts.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_quality_stats [-h] [-N] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h] = This helpful help screen.
   [-i INFILE]  = FASTQ input file. default is STDIN.
   [-o OUTFILE] = TEXT output file. default is STDOUT.
   [-N]         = New output format (with more information per nucleotide/cycle).
   [-Q N]       = FASTQ ASCII offset. Default is 33.

The *OLD* output TEXT file will have the following fields (one row per column):
	column	= column number (1 to 36 for a 36-cycles read solexa file)
	count   = number of bases found in this column.
	min     = Lowest quality score value found in this column.
	max     = Highest quality score value found in this column.
	sum     = Sum of quality score values for this column.
	mean    = Mean quality score value for this column.
	Q1	= 1st quartile quality score.
	med	= Median quality score.
	Q3	= 3rd quartile quality score.
	IQR	= Inter-Quartile range (Q3-Q1).
	lW	= 'Left-Whisker' value (for boxplotting).
	rW	= 'Right-Whisker' value (for boxplotting).
	A_Count	= Count of 'A' nucleotides found in this column.
	C_Count	= Count of 'C' nucleotides found in this column.
	G_Count	= Count of 'G' nucleotides found in this column.
	T_Count	= Count of 'T' nucleotides found in this column.
	N_Count = Count of 'N' nucleotides found in this column.
	max-count = max. number of bases (in all cycles)


The *NEW* output format:
	cycle (previously called 'column') = cycle number
	max-count
	For each nucleotide in the cycle (ALL/A/C/G/T/N):
		count   = number of bases found in this column.
		min     = Lowest quality score value found in this column.
		max     = Highest quality score value found in this column.
		sum     = Sum of quality score values for this column.
		mean    = Mean quality score value for this column.
		Q1	= 1st quartile quality score.
		med	= Median quality score.
		Q3	= 3rd quartile quality score.
		IQR	= Inter-Quartile range (Q3-Q1).
		lW	= 'Left-Whisker' value (for boxplotting).
		rW	= 'Right-Whisker' value (for boxplotting).
```

## fastx_toolkit_fastx_renamer

### Tool Description
Rename the sequence identifiers of a FASTA/Q file, using either the nucleotide sequence or a counter.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_renamer [-n TYPE] [-h] [-z] [-v] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-n TYPE]    = rename type:
                  SEQ - use the nucleotides sequence as the name.
                  COUNT - use simply counter as the name.
   [-h]         = This helpful help screen.
   [-z]         = Compress output with GZIP.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
```

## fastx_toolkit_fastx_reverse_complement

### Tool Description
Produce the reverse-complement of each sequence in a FASTA/Q file.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastx_reverse_complement [-h] [-r] [-z] [-v] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-z]         = Compress output with GZIP.
   [-i INFILE]  = FASTA/Q input file. default is STDIN.
   [-o OUTFILE] = FASTA/Q output file. default is STDOUT.
```

## fastx_toolkit_fastx_uncollapser

### Tool Description
Restore sequences collapsed by fastx_collapser: expand each collapsed identifier (e.g. '1-1000') back into its repeated sequences. Also works on a tabular file.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fasta_uncollapser [-c N] [-h] [-v] [-i INFILE] [-o OUTFILE]
Part of FASTX Toolkit 0.0.14 by A. Gordon (assafgordon@gmail.com)

   [-h]         = This helpful help screen.
   [-v]         = verbose: print short summary of input/output counts
   [-c N]       = Assume input is a tabular file (not FASTA file),
                  And the collapsed identifier (e.g. '1-1000') is on column N.
   [-i INFILE]  = FASTA/Tabular input file. default is STDIN.
   [-o OUTFILE] = FASTA/Tabular output file. default is STDOUT.
```

## fastx_toolkit_fastx_barcode_splitter

### Tool Description
Split a FASTA/FASTQ file into several smaller files, based on barcode matching.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/fastx_toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
Barcode Splitter, by Assaf Gordon (gordon@cshl.edu), 11sep2008

This program reads FASTA/FASTQ file and splits it into several smaller files,
Based on barcode matching.
FASTA/FASTQ data is read from STDIN (format is auto-detected.)
Output files will be writen to disk.
Summary will be printed to STDOUT.

usage: fastx_barcode_splitter.pl --bcfile FILE --prefix PREFIX [--suffix SUFFIX] [--bol|--eol] 
         [--mismatches N] [--exact] [--partial N] [--help] [--quiet] [--debug]

Arguments:

--bcfile FILE	- Barcodes file name. (see explanation below.)
--prefix PREFIX	- File prefix. will be added to the output files. Can be used
		  to specify output directories.
--suffix SUFFIX	- File suffix (optional). Can be used to specify file
		  extensions.
--bol		- Try to match barcodes at the BEGINNING of sequences.
		  (What biologists would call the 5' end, and programmers
		  would call index 0.)
--eol		- Try to match barcodes at the END of sequences.
		  (What biologists would call the 3' end, and programmers
		  would call the end of the string.)
		  NOTE: one of --bol, --eol must be specified, but not both.
--mismatches N	- Max. number of mismatches allowed. default is 1.
--exact		- Same as '--mismatches 0'. If both --exact and --mismatches 
		  are specified, '--exact' takes precedence.
--partial N	- Allow partial overlap of barcodes. (see explanation below.)
		  (Default is not partial matching)
--quiet		- Don't print counts and summary at the end of the run.
		  (Default is to print.)
--debug		- Print lots of useless debug information to STDERR.
--help		- This helpful help screen.

Example (Assuming 's_2_100.txt' is a FASTQ file, 'mybarcodes.txt' is 
the barcodes file):

   $ cat s_2_100.txt | fastx_barcode_splitter.pl --bcfile mybarcodes.txt --bol --mismatches 2 \
   	--prefix /tmp/bla_ --suffix ".txt"

Barcode file format
-------------------
Barcode files are simple text files. Each line should contain an identifier 
(descriptive name for the barcode), and the barcode itself (A/C/G/T), 
separated by a TAB character. Example:

    #This line is a comment (starts with a 'number' sign)
    BC1 GATCT
    BC2 ATCGT
    BC3 GTGAT
    BC4 TGTCT

For each barcode, a new FASTQ file will be created (with the barcode's 
identifier as part of the file name). Sequences matching the barcode 
will be stored in the appropriate file.

Running the above example (assuming "mybarcodes.txt" contains the above 
barcodes), will create the following files:
	/tmp/bla_BC1.txt
	/tmp/bla_BC2.txt
	/tmp/bla_BC3.txt
	/tmp/bla_BC4.txt
	/tmp/bla_unmatched.txt
The 'unmatched' file will contain all sequences that didn't match any barcode.

Barcode matching
----------------

** Without partial matching:

Count mismatches between the FASTA/Q sequences and the barcodes.
The barcode which matched with the lowest mismatches count (providing the
count is small or equal to '--mismatches N') 'gets' the sequences.

Example (using the above barcodes):
Input Sequence:
    GATTTACTATGTAAAGATAGAAGGAATAAGGTGAAG

Matching with '--bol --mismatches 1':
   GATTTACTATGTAAAGATAGAAGGAATAAGGTGAAG
   GATCT (1 mismatch, BC1)
   ATCGT (4 mismatches, BC2)
   GTGAT (3 mismatches, BC3)
   TGTCT (3 mismatches, BC4)

This sequence will be classified as 'BC1' (it has the lowest mismatch count).
If '--exact' or '--mismatches 0' were specified, this sequence would be 
classified as 'unmatched' (because, although BC1 had the lowest mismatch count,
it is above the maximum allowed mismatches).

Matching with '--eol' (end of line) does the same, but from the other side
of the sequence.

** With partial matching (very similar to indels):

Same as above, with the following addition: barcodes are also checked for
partial overlap (number of allowed non-overlapping bases is '--partial N').

Example:
Input sequence is ATTTACTATGTAAAGATAGAAGGAATAAGGTGAAG
(Same as above, but note the missing 'G' at the beginning.)

Matching (without partial overlapping) against BC1 yields 4 mismatches:
   ATTTACTATGTAAAGATAGAAGGAATAAGGTGAAG
   GATCT (4 mismatches)

Partial overlapping would also try the following match:
   -ATTTACTATGTAAAGATAGAAGGAATAAGGTGAAG
   GATCT (1 mismatch)

Note: scoring counts a missing base as a mismatch, so the final
mismatch count is 2 (1 'real' mismatch, 1 'missing base' mismatch).
If running with '--mismatches 2' (meaning allowing upto 2 mismatches) - this 
seqeunce will be classified as BC1.
```

## Metadata
- **Skill**: generated

## fastx_toolkit_fastx_trimmer

### Tool Description
The FASTX-Toolkit Fastx Trimmer is used to shorten sequences in a FASTA or FASTQ file (trimming bases from the beginning or end of the sequences).

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1889753452: no space left on device
```

## fastx_toolkit_fastq_to_fasta

### Tool Description
Convert FASTQ files to FASTA files.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4257216261: no space left on device
```

## fastx_toolkit_fastx_collapser

### Tool Description
Collapses identical sequences in a FASTA/Q file into a single sequence.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-2810181561: no space left on device
```

## fastx_toolkit_fastq_quality_converter

### Tool Description
Converts FASTQ quality scores from ASCII to numeric (or vice versa). Part of the FASTX Toolkit.

### Metadata
- **Docker Image**: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
- **Homepage**: https://github.com/agordon/fastx_toolkit
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3996110718: no space left on device
```

