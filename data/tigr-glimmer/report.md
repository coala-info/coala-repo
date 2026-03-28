# tigr-glimmer CWL Generation Report

## tigr-glimmer_anomaly

### Tool Description
Read DNA sequence in <sequence-file> and for each region specified by the coordinates in <coord-file>, check whether the region represents a normal gene, i.e., it begins with a start codon, ends with a stop codon, and has no frame shifts. Output goes to standard output.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tigr-glimmer/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE:  anomaly [options] <sequence-file> <coord-file>

Read DNA sequence in <sequence-file> and for each region specified
by the coordinates in <coord-file>, check whether the region
represents a normal gene, i.e., it begins with a start codon, ends
with a stop codon, and has no frame shifts.
Output goes to standard output.

Options:
 -A <codon-list>
    Use comma-separated list of codons as start codons
    Sample format:  -A atg,gtg
    Default start codons are atg,gtg,ttg
 -s
    Omit the check that the first codon is a start codon.
 -t
    Check whether the codon preceding the start coordinate position
    is a stop codon.  This is useful if the coordinates represent
    the entire region between stop codons.
 -Z <codon-list>
    Use comma-separated list of codons as stop codons
    Sample format:  -Z tag,tga,taa
```


## tigr-glimmer_build-fixed

### Tool Description
Read sequences from stdin and output to stdout the fixed-length interpolated context model built from them

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  /usr/lib/tigr-glimmer/build-fixed [<options>]  < <input-file>  > <output-file>

Read sequences from  stdin  and output to  stdout 
the fixed-length interpolated context model built from them

Options:
 -d <num>  Set depth of model to <num>
 -h        Print this message
 -i <fn>   Train using strings specified by subscripts in file
           named <fn>
 -p n1,n2,...,nk  Permutation describing re-ordering of
           character positions of input string to build model
 -s <num>  Specify special position in model
 -t        Output model as text (for debugging only)
 -v <num>  Set verbose level; higher is more diagnostic printouts
```


## tigr-glimmer_build-icm

### Tool Description
Read sequences from standard input and output to output-file the interpolated context model built from them.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  build-icm [options] output_file < input-file

Read sequences from standard input and output to  output-file
the interpolated context model built from them.
Input also can be piped into the program, e.g.,
  cat abc.in | build-icm xyz.icm
If <output-file> is "-", then output goes to standard output

Options:
 -d <num>
    Set depth of model to <num>
 -F
    Ignore input strings with in-frame stop codons
 -h
    Print this message
 -p <num>
    Set period of model to <num>
 -r
    Use the reverse of input strings to build the model
 -t
    Output model as text (for debugging only)
 -v <num>
    Set verbose level; higher is more diagnostic printouts
 -w <num>
    Set length of model window to <num>
```


## tigr-glimmer_entropy-profile

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
--- Forward Translation ----    --- Reverse Translation ----
AA  Count Percen  Entrpy   EFrac    Count Percen  Entrpy   EFrac
A:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
C:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
D:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
E:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
F:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
G:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
H:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
I:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
K:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
L:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
M:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
N:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
P:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
Q:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
R:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
S:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
T:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
V:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
W:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
Y:      0   0.0%    -nan   0.000        0   0.0%    -nan   0.000
```


## tigr-glimmer_entropy-score

### Tool Description
Read fasta-format <sequence-file> and then score regions in it specified by <coords>. By default, <coords> is the name of a file containing lines of the form <tag> <start> <stop> [<frame>] ... Coordinates are inclusive counting from 1, e.g., "1 3" represents the 1st 3 characters of the sequence. Output is the same format as <coords> put with the entropy distance score appended to each line Output goes to stdout.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  entropy-score [options] <sequence-file> <coords>

Read fasta-format <sequence-file> and then score regions in
it specified by <coords>.  By default, <coords>
is the name of a file containing lines of the form
  <tag>  <start>  <stop>  [<frame>] ...
Coordinates are inclusive counting from 1, e.g., "1 3"
represents the 1st 3 characters of the sequence.
Output is the same format as <coords> put with the entropy
distance score appended to each line
Output goes to  stdout .

Options:
 -d
 --dir
    Use the 4th column of each input line to specify the direction
    of the sequence.  Positive is forward, negative is reverse
    The input sequence is assumed to be circular
 -E <filename>
 --entropy <filename>
    Read entropy profiles from <filename>.  Format is one header
    line, then 20 lines of 3 columns each.  Columns are amino acid,
    positive entropy, negative entropy.  Rows must be in order
    by amino acid code letter
 -h
 --help
    Print this message
 -l <n>
 --minlen <n>
    Don't output any sequence shorter than <n> characters
 -s
 --nostart
    Omit the first 3 characters of each specified string
 -t
 --nostop
    Omit the last 3 characters of each specified string
 -w
 --nowrap
    Use the actual input coordinates without any wraparound
    that would be needed by a circular genome.  Without this
    option, the output sequence is the shorter of the two ways
    around the circle.  Use the -d option to specify direction
    explicitly.
```


## tigr-glimmer_extract

### Tool Description
Read fasta-format <sequence-file> and extract from it the subsequences specified by <coords>. By default, <coords> is the name of a file containing lines of the form <tag> <start> <stop> [<frame>] ... Coordinates are inclusive counting from 1, e.g., "1 3" represents the 1st 3 characters of the sequence. For each line the corresponding region of <sequence-file> is extracted and output (after reverse-complementing if necessary) Output goes to stdout in multi-fasta format, unless the -2 option is specified

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  extract [options] <sequence-file> <coords>

Read fasta-format <sequence-file> and extract from it the
subsequences specified by <coords>.  By default, <coords>
is the name of a file containing lines of the form
  <tag>  <start>  <stop>  [<frame>] ...
Coordinates are inclusive counting from 1, e.g., "1 3"
represents the 1st 3 characters of the sequence.
For each line the corresponding region of <sequence-file>
is extracted and output (after reverse-complementing if necessary)
Output goes to stdout in multi-fasta format, unless the -2 option
is specified

Options:
 -2
 --2_fields
    Output each sequence as 2 fields (tag and sequence) on a single line
 -d
 --dir
    Use the 4th column of each input line to specify the direction
    of the sequence.  Positive is forward, negative is reverse
    The input sequence is assumed to be circular
 -h
 --help
    Print this message
 -l <n>
 --minlen <n>
    Don't output any sequence shorter than <n> characters
 -s
 --nostart
    Omit the first 3 characters of each output string
 -t
 --nostop
    Omit the last 3 characters of each output string
 -w
 --nowrap
    Use the actual input coordinates without any wraparound
    that would be needed by a circular genome.  Without this
    option, the output sequence is the shorter of the two ways
    around the circle.  Use the -d option to specify direction
    explicitly.
```


## tigr-glimmer_glimmer3

### Tool Description
Read DNA sequences in <sequence-file> and predict genes
in them using the Interpolated Context Model in <icm-file>.
Output details go to file <tag>.detail and predictions go to
file <tag>.predict

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Starting at Wed Feb 25 23:18:38 2026

USAGE:  glimmer3 [options] <sequence-file> <icm-file> <tag>

Read DNA sequences in <sequence-file> and predict genes
in them using the Interpolated Context Model in <icm-file>.
Output details go to file <tag>.detail and predictions go to
file <tag>.predict

Options:
 -A <codon-list>
 --start_codons <codon-list>
    Use comma-separated list of codons as start codons
    Sample format:  -A atg,gtg
    Use -P option to specify relative proportions of use.
    If -P not used, then proportions will be equal
 -b <filename>
 --rbs_pwm <filename>
    Read a position weight matrix (PWM) from <filename> to identify
    the ribosome binding site to help choose start sites
 -C <p>
 --gc_percent <p>
    Use <p> as GC percentage of independent model
    Note:  <p> should be a percentage, e.g., -C 45.2
 -E <filename>
 --entropy <filename>
    Read entropy profiles from <filename>.  Format is one header
    line, then 20 lines of 3 columns each.  Columns are amino acid,
    positive entropy, negative entropy.  Rows must be in order
    by amino acid code letter
 -f
 --first_codon
    Use first codon in orf as start codon
 -g <n>
 --gene_len <n>
    Set minimum gene length to <n>
 -h
 --help
    Print this message
 -i <filename>
 --ignore <filename>
    <filename> specifies regions of bases that are off 
    limits, so that no bases within that area will be examined
 -l
 --linear
    Assume linear rather than circular genome, i.e., no wraparound
 -L <filename>
 --orf_coords <filename>
    Use <filename> to specify a list of orfs that should
    be scored separately, with no overlap rules
 -M
 --separate_genes
    <sequence-file> is a multifasta file of separate genes to
    be scored separately, with no overlap rules
 -o <n>
 --max_olap <n>
    Set maximum overlap length to <n>.  Overlaps this short or shorter
    are ignored.
 -P <number-list>
 --start_probs <number-list>
    Specify probability of different start codons (same number & order
    as in -A option).  If no -A option, then 3 values for atg, gtg and ttg
    in that order.  Sample format:  -P 0.6,0.35,0.05
    If -A is specified without -P, then starts are equally likely.
 -q <n>
 --ignore_score_len <n>
    Do not use the initial score filter on any gene <n> or more
    base long
 -r
 --no_indep
    Don't use independent probability score column
 -t <n>
 --threshold <n>
    Set threshold score for calling as gene to n.  If the in-frame
    score >= <n>, then the region is given a number and considered
    a potential gene.
 -X
 --extend
    Allow orfs extending off ends of sequence to be scored
 -z <n>
 --trans_table <n>
    Use Genbank translation table number <n> for stop codons
 -Z <codon-list>
 --stop_codons <codon-list>
    Use comma-separated list of codons as stop codons
    Sample format:  -Z tag,tga,taa
```


## tigr-glimmer_long-orfs

### Tool Description
Read DNA sequence in <sequence-file> and find and output the coordinates of long, non-overlapping orfs in it.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Starting at Wed Feb 25 23:19:21 2026

USAGE:  long-orfs [options] <sequence-file> <output-file>

Read DNA sequence in <sequence-file> and find and output the
coordinates of long, non-overlapping orfs in it.
Output goes to file <output-file> or standard output if <output-file>
is "-"

Options:
 -A <codon-list>
 --start_codons <codon-list>
    Use comma-separated list of codons as start codons
    Sample format:  -A atg,gtg
 -E <filename>
 --entropy <filename>
    Read entropy profiles from <filename>.  Format is one header
    line, then 20 lines of 3 columns each.  Columns are amino acid,
    positive entropy, negative entropy.  Rows must be in order
    by amino acid code letter
 -f
 --fixed
    Do *NOT* automatically determine the minimum gene length so as
    to maximize the total length of output regions
 -g <n>
 --min_len <n>
    Only genes with length >= <n> will be considered
 -h
 --help
    Print this message
 -i <filename>
 --ignore <filename>
    <filename> specifies regions of bases that are off 
    limits, so that no bases within that area will be examined
 -l
 --linear
    Assume linear rather than circular genome, i.e., no wraparound
 -L
 --length_opt
    Find and use the minimum gene length that maximizes the total
    length of non-overlapping genes, instead of maximizing the
    number of such genes
 -n
 --no_header
    Do not include heading information in the output; only output
    the orf-coordinate lines
 -o <n>
 --max_olap <n>
    Set maximum overlap length to <n>.  Overlaps this short or shorter
    are ignored.
 -t <x>
 --cutoff <x>
    Only genes with entropy distance score less than <x> will be considered
 -w
 --without_stops
    Do *NOT* include the stop codon in the output coordinates.
    By default, it is included.
 -z <n>
 --trans_table <n>
    Use Genbank translation table number <n> for stop codons
 -Z <codon-list>
 --stop_codons <codon-list>
    Use comma-separated list of codons as stop codons
    Sample format:  -Z tag,tga,taa
```


## tigr-glimmer_multi-extract

### Tool Description
Read multi-fasta-format <sequence-file> and extract from it the subsequences specified by <coords>

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  multi-extract [options] <sequence-file> <coords>

Read multi-fasta-format <sequence-file> and extract from it the
subsequences specified by <coords>.  By default, <coords>
is the name of a file containing lines of the form
  <id>  <tag>  <start>  <stop>  [<frame>] ...
<id> is the identifier for the subsequence
<tag> is the tag of the sequence in <sequence-file> from which
to extract the entry
Coordinates are inclusive counting from 1, e.g., "1 3"
represents the 1st 3 characters of the sequence.
Specify "-" for <coords> to read it from standard input
For each line the corresponding region of <sequence-file>
is extracted and output (after reverse-complementing if necessary)
Output goes to stdout in multi-fasta format, unless the -2 option
is specified

Options:
 -2
 --2_fields
    Output each sequence as 2 fields (tag and sequence) on a single line
 -d
 --dir
    Use the 4th column of each input line to specify the direction
    of the sequence.  Positive is forward, negative is reverse
    The input sequence is assumed to be circular
 -h
 --help
    Print this message
 -l <n>
 --minlen <n>
    Don't output any sequence shorter than <n> characters
 -s
 --nostart
    Omit the first 3 characters of each output string
 -t
 --nostop
    Omit the last 3 characters of each output string
 -w
 --nowrap
    Use the actual input coordinates without any wraparound
    that would be needed by a circular genome.  Without this
    option, the output sequence is the shorter of the two ways
    around the circle.  Use the -d option to specify direction
    explicitly.
```


## tigr-glimmer_score-fixed

### Tool Description
Read sequences from stdin and score them using fixed-length model in file <model>. Output scores to stdout. Output columns are: sequence number, positive total score, positive score per base, negative total score, negative score per base, delta positive/negative per-base scores.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  /usr/lib/tigr-glimmer/score-fixed [options]  <pos-model>  <neg-model>  < input-file

Read sequences from  stdin  and score them using fixed-length
model in file  <model> .  Output scores to  stdout.
Output columns are:  sequence number, positive total score,
  positive score per base, negative total score,
  negative score per base, delta positive/negative per-base scores.

Options:
 -h        Print this message
 -I        Negative model is regular ICM, not fixed-length ICM
 -N        Use NULL negative model, i.e., constant zero
 -s        Output simple format of string num and 1 or -1
```


## tigr-glimmer_start-codon-distrib

### Tool Description
Read fasta-format <sequence-file> and count the number of different start codons for the genes specified in <coords>. By default, <coords> is the name of a file containing lines of the form <tag> <start> <stop> [<frame>] ... Coordinates are inclusive counting from 1, e.g., "1 3" represents the 1st 3 characters of the sequence. Output goes to stdout.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: https://github.com/alexdobin/STAR
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  start-codon-distrib [options] <sequence-file> <coords>

Read fasta-format <sequence-file> and count the number of
different start codons for the genes specified in <coords>.
By default, <coords> is the name of a file containing lines of the form
  <tag>  <start>  <stop>  [<frame>] ...
Coordinates are inclusive counting from 1, e.g., "1 3"
represents the 1st 3 characters of the sequence.
Output goes to stdout.

Options:
 -d
 --dir
    Use the 4th column of each input line to specify the direction
    of the sequence.  Positive is forward, negative is reverse
    The input sequence is assumed to be circular
 -h
    Print this message
 -w
 --nowrap
    Use the actual input coordinates without any wraparound
    that would be needed by a circular genome.  Without this
    option, the output sequence is the shorter of the two ways
    around the circle.  Use the -d option to specify direction
    explicitly.
 -3
 --3comma
    output only a comma separated list (no spaces) of atg, gtg, ttg
start proportions, in that order
```


## tigr-glimmer_test

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Starting at Wed Feb 25 23:22:54 2026
```


## tigr-glimmer_uncovered

### Tool Description
Read fasta-format <sequence-file> and extract from it the subsequences not covered by regions specified in <coords>.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  uncovered [options] <sequence-file> <coords>

Read fasta-format <sequence-file> and extract from it the
subsequences not covered by regions specified in <coords>.
By default, <coords>
is the name of a file containing lines of the form
  <tag>  <start>  <stop>  [<frame>] ...
Coordinates are inclusive counting from 1, e.g., "1 3"
represents the 1st 3 characters of the sequence.
Output goes to stdout in multi-fasta format, unless the -2 option
is specified

Options:
 -2    Output each sequence as 2 fields (tag and sequence) on a single line
 -d
 --dir
    Use the 4th column of each input line to specify the direction
    of the sequence.  Positive is forward, negative is reverse
    The input sequence is assumed to be circular
 -h
    Print this message
 -l <n>
 --minlen <n>
    Don't output any sequence shorter than <n> characters
 -s
 --nostart
    Omit the first 3 characters of each <coords> region
 -t
 --nostop
    Omit the last 3 characters of each <coords> region
 -w
 --nowrap
    Use the actual input coordinates without any wraparound
    that would be needed by a circular genome.  Without this
    option, the output sequence is the shorter of the two ways
    around the circle.  Use the -d option to specify direction
    explicitly.
```


## tigr-glimmer_window-acgt

### Tool Description
Read multi-fasta-format file from standard input. Print the acgt-content of windows in each sequence.

### Metadata
- **Docker Image**: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
USAGE:  window-acgt [options] window-len window-skip < input-file

Read multi-fasta-format file from standard input.
Print the acgt-content of windows in each sequence.
The width of windows is <window-len>.  The number of
positions between windows to report is <window-skip>
So the overlap between consecutive windows is
<window-len> - <window-skip> positions
Output goes to standard output in the format:
  window-start  window-len  A's C's G's T's #other %GC
Note the last window in the sequence can be shorter than
<window-len> if the sequence ends prematurely

Options:
 -h  or  --help
    Print this message
 -p  or  --percent
    Output percentages instead of counts
```


## Metadata
- **Skill**: not generated
