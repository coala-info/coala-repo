# last CWL Generation Report

## last

### Tool Description
Show listing of the last users that logged into the system

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Total Downloads**: 2.4M
- **Last updated**: 2025-11-19
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: last [-HW] [-f FILE]

Show listing of the last users that logged into the system

	-W	Display with no host column truncation
	-f FILE Read from FILE instead of /var/log/wtmp
```

## last_lastdb

### Tool Description
Prepare sequences for subsequent alignment with lastal.

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: lastdb [options] output-name fasta-sequence-file(s)
Prepare sequences for subsequent alignment with lastal.

Main Options:
 -h, --help  show all options and their default settings, and exit
 -p  interpret the sequences as proteins
 -c  soft-mask lowercase letters (in reference *and* query sequences)
 -u  seeding scheme (default: YASS if DNA, else PSEUDO if -q, else exact-match)
 -P  number of parallel threads (default: 1)

Advanced Options (default settings):
 -q  interpret the sequences as proteins and append */STOP
 -S  strand: 0=reverse, 1=forward, 2=both (default: 1)
 -R  lowercase & simple-sequence options (default: 03 for -q, else 01)
 -U  maximum tandem repeat unit length (protein: 50, DNA: 100 or 400)
 -w  use initial matches starting at every w-th position in each sequence (1)
 -W  use "minimum" positions in sliding windows of W consecutive positions (1)
 -Q  input format: fastx, keep, sanger, solexa, illumina (default: fasta)
 -s  volume size (default: unlimited)
 -m  seed patterns (1=match, 0=anything, @=transition)
 -d  DNA seed patterns (N=match, n=anything, R=purine match, etc.)
 -a  user-defined alphabet
 -i  minimum limit on initial matches per query position (default: 0)
 -b  maximum length for buckets
 -B  use max bucket length with memory <= (memory for stored positions) / B (4)
 -C  child table type: 0=none, 1=byte-size, 2=short-size, 3=full (default: 0)
 -x  just count sequences and letters
 -D  print all sequences in lastdb files
 --bits=N  use this many bits per base for DNA sequence (default: 8)
 --circular  these sequences are circular
 -v  be verbose: write messages about what lastdb is doing
 -V, --version  show version information, and exit
```

## last_last-train

### Tool Description
Try to find suitable score parameters for aligning the given sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: last-train [options] lastdb-name sequence-file(s)

Try to find suitable score parameters for aligning the given sequences.

Options:
  -h, --help           show this help message and exit
  -v, --verbose        show more details of intermediate steps

  Training options:
    --revsym           force reverse-complement symmetry
    --matsym           force symmetric substitution matrix
    --gapsym           force insertion/deletion symmetry
    --fixmat=NAME      fix the substitution probabilities to e.g. BLOSUM62
    --pid=PID          skip alignments with > PID% identity (default: 100)
    --postmask=NUMBER  skip mostly-lowercase alignments (default=1)
    --sample-number=N  number of random sequence samples (default: 20000 if
                       --codon else 500)
    --sample-length=L  length of each sample (default: 2000)
    --scale=S          output scores in units of 1/S bits
    --codon            DNA queries & protein reference, with frameshifts

  Initial parameter options:
    -r SCORE           match score
    -q COST            mismatch cost
    -p NAME            match/mismatch score matrix
    -a COST            gap existence cost
    -b COST            gap extension cost
    -A COST            insertion existence cost
    -B COST            insertion extension cost
    -F LIST            frameshift probabilities: del-1,del-2,ins+1,ins+2
                       (default: 1-b,1-b,1-B,1-B)

  Alignment options:
    -D LENGTH          query letters per random alignment (default: total
                       sample length)
    -E EG2             maximum expected alignments per square giga
    -s STRAND          0=reverse, 1=forward, 2=both (default: 2 if DNA and not
                       lastdb -S2, else 1)
    -S NUMBER          use score matrix: 0=as-is, 1=on query forward strands
                       (default: 1)
    -C COUNT           omit gapless alignments in COUNT others with > score-
                       per-length
    -T NUMBER          type of alignment: 0=local, 1=overlap (default: 0)
    -R DIGITS          lowercase & simple-sequence options
    -m COUNT           maximum initial matches per query position (default:
                       10)
    -k STEP            use initial matches starting at every STEP-th position
                       in each query (default: 1)
    -P THREADS         number of parallel threads
    -X NUMBER          N/X is ambiguous in: 0=neither sequence, 1=reference,
                       2=query, 3=both (default=0)
    -Q NAME            input format: fastx, sanger (default=fasta)
```

## last_lastal

### Tool Description
Find and align similar sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: lastal [options] lastdb-name fasta-sequence-file(s)
Find and align similar sequences.

Cosmetic options:
 -h, --help     show all options and their default settings, and exit
 -V, --version  show version information, and exit
 -v             be verbose: write messages about what lastal is doing
 -2             paired query sequences
 -f             output format: TAB, MAF, BlastTab, BlastTab+ (default: MAF)

E-value options (default settings):
 -D  query letters per random alignment (default: 1e+06)
 -H  expected total number of random alignments for all the sequences
 -E  max EG2: expected number of random alignments per square giga

Score options (default settings):
 -r  match score   (2 if -M, else 1)
 -q  mismatch cost (3 if -M, else 1)
 -p  match/mismatch score matrix (DNA-DNA: HUMSUM, protein-protein: BLOSUM62,
                                  DNA-protein: BLOSUM80)
 -X  N/X is ambiguous in: 0=neither sequence, 1=reference, 2=query, 3=both (0)
 -a  gap existence cost (24 if HUMSUM, else 11 if protein reference, else 7)
 -b  gap extension cost ( 1 if HUMSUM, else  2 if protein reference, else 1)
 -A  insertion existence cost (a)
 -B  insertion extension cost (b)
 -c  unaligned residue pair cost (off)
 -F  frameshift cost(s) (off)
 -x  maximum score drop for preliminary gapped alignments (z)
 -y  maximum score drop for gapless alignments (min[t*10, x])
 -z  maximum score drop for final gapped alignments (e-1)
 -d  minimum score for gapless alignments (min[e, 2500/n query letters per hit])
 -e  minimum score for gapped alignments

Initial-match options (default settings):
 -m  maximum initial matches per query position (10)
 -l  minimum length for initial matches (1)
 -L  maximum length for initial matches (infinity)
 -k  use initial matches starting at every k-th position in each query (1)
 -W  use "minimum" positions in sliding windows of W consecutive positions

Miscellaneous options (default settings):
 -P  number of parallel threads (default: 1)
 -K  omit alignments whose query range lies in >= K others with > score (off)
 -C  omit gapless alignments in >= C others with > score-per-length (off)
 -s  strand: 0=reverse, 1=forward, 2=both (2 if DNA and not lastdb -S2, else 1)
 --reverse  reverse the query sequences
 -S  use score matrix: 0=as-is, 1=on query forward strands (0)
 -i  query batch size (64M if multi-volume, else off)
 -M  find minimum-difference alignments (faster but cruder)
 -T  type of alignment: 0=local, 1=overlap (default: 0)
 -n  maximum gapless alignments per query position (infinity if m=0, else m)
 -N  stop after the first N alignments per query strand
 -R  lowercase & simple-sequence options (the same as was used by lastdb)
 -U  maximum tandem repeat unit length (100 if --codon else same as lastdb)
 -u  mask lowercase during extensions: 0=never, 1=gapless,
     2=gapless+postmask, 3=always (2 if lastdb -c and Q!=pssm, else 0)
 -w  suppress repeats inside exact matches, offset by <= this distance (1000)
 -G  genetic code (default: 1)
 -t  'temperature' for calculating probabilities (1/lambda)
 -g  'gamma' parameter for gamma-centroid and LAMA (default: 1)
 -j  output type: 0=match counts, 1=gapless, 2=redundant gapped, 3=gapped,
                  4=column ambiguity estimates, 5=gamma-centroid, 6=LAMA,
                  7=expected counts (default: 3)
 -J  score type: 0=ordinary, 1=full (1 for new-style frameshifts, else 0)
 -Q  input format: fastx, keep, sanger, solexa, illumina, prb, pssm
                   (default: fasta)

Split options:
 --split         do split alignment
 --splice        do spliced alignment
 --split-f=FMT   output format: MAF, MAF+
 --split-d=D     RNA direction: 0=reverse, 1=forward, 2=mixed (default: 1)
 --split-c=PROB  cis-splice probability per base (default: 0.004)
 --split-t=PROB  trans-splice probability per base (default: 1e-05)
 --split-M=MEAN  mean of ln[intron length] (default: 7.0)
 --split-S=SDEV  standard deviation of ln[intron length] (default: 1.7)
 --split-m=PROB  maximum mismap probability (default: 1.0)
 --split-s=INT   minimum alignment score (default: e OR e+t*ln[100])
 --split-n       write original, not split, alignments
 --split-b=B     maximum memory (default: 8T for split, 8G for spliced)
```

## last_maf-convert

### Tool Description
Read MAF-format alignments & write them in another format.

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: 
  maf-convert --help
  maf-convert axt mafFile(s)
  maf-convert bed mafFile(s)
  maf-convert blast mafFile(s)
  maf-convert blasttab mafFile(s)
  maf-convert blasttab+ mafFile(s)
  maf-convert chain mafFile(s)
  maf-convert gff mafFile(s)
  maf-convert html mafFile(s)
  maf-convert psl mafFile(s)
  maf-convert sam mafFile(s)
  maf-convert tab mafFile(s)

Read MAF-format alignments & write them in another format.

Options:
  -h, --help            show this help message and exit
  -s N, --subject=N     which sequence to use as subject/reference
  -p, --protein         assume protein alignments, for psl match counts
  -j N, --join=N        join consecutive co-linear alignments separated by <=
                        N letters
  -J N, --Join=N        join nearest co-linear alignments separated by <= N
                        letters
  -n, --noheader        omit any header lines from the output
  -d, --dictionary      include dictionary of sequence lengths in sam format
  -f DICTFILE, --dictfile=DICTFILE
                        get sequence dictionary from DICTFILE
  -r READGROUP, --readgroup=READGROUP
                        read group info for sam format
  -l LINESIZE, --linesize=LINESIZE
                        line length for blast and html formats (default: 60)
```

## last_last-dotplot

### Tool Description
Draw a dotplot of pair-wise sequence alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/last:1650--h5ca1c30_0
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: last-dotplot --help
   or: last-dotplot [options] maf-or-psl-or-tab-alignments
   or: last-dotplot [options] maf-or-psl-or-tab-alignments dotplot.png|gif|...

Draw a dotplot of pair-wise sequence alignments.

Options:
  -h, --help            show this help message and exit
  -v, --verbose         show progress messages & data about the plot
  -x INT, --width=INT   maximum width in pixels (default: 1000)
  -y INT, --height=INT  maximum height in pixels (default: 1000)
  -m M, --maxseqs=M     maximum number of horizontal or vertical sequences
                        (default=100)
  -1 PATTERN, --seq1=PATTERN
                        which sequences to show from the 1st genome
  -2 PATTERN, --seq2=PATTERN
                        which sequences to show from the 2nd genome
  --alignments=FILE     secondary alignments
  --sort1=N             genome1 sequence order: 0=input order, 1=name order,
                        2=length order, 3=alignment order (default=1)
  --sort2=N             genome2 sequence order: 0=input order, 1=name order,
                        2=length order, 3=alignment order (default=1)
  --strands1=N          genome1 sequence orientation: 0=forward orientation,
                        1=alignment orientation (default=0)
  --strands2=N          genome2 sequence orientation: 0=forward orientation,
                        1=alignment orientation (default=0)
  --max-gap1=FRAC       maximum unaligned (end,mid) gap in genome1: fraction
                        of aligned length (default=1,4)
  --max-gap2=FRAC       maximum unaligned (end,mid) gap in genome2: fraction
                        of aligned length (default=1,4)
  --pad=FRAC            pad length when cutting unaligned gaps: fraction of
                        aligned length (default=0.04)
  -j N, --join=N        join: 0=nothing, 1=alignments adjacent in genome1,
                        2=alignments adjacent in genome2 (default=0)
  --border-pixels=INT   number of pixels between sequences (default=1)
  -a FILE, --bed1=FILE, --rmsk1=FILE, --genePred1=FILE, --gap1=FILE
                        read genome1 annotations
  -b FILE, --bed2=FILE, --rmsk2=FILE, --genePred2=FILE, --gap2=FILE
                        read genome2 annotations

  Text options:
    -f FILE, --fontfile=FILE
                        TrueType or OpenType font file
    -s SIZE, --fontsize=SIZE
                        TrueType or OpenType font size (default: 14)
    --labels1=N         genome1 labels: 0=name, 1=name:length,
                        2=name:start:length, 3=name:start-end (default=0)
    --labels2=N         genome2 labels: 0=name, 1=name:length,
                        2=name:start:length, 3=name:start-end (default=0)
    --rot1=ROT          text rotation for the 1st genome (default=h)
    --rot2=ROT          text rotation for the 2nd genome (default=v)

  Color options:
    -c COLOR, --forwardcolor=COLOR
                        color for forward alignments (default: red)
    -r COLOR, --reversecolor=COLOR
                        color for reverse alignments (default: blue)
    --border-color=COLOR
                        color for pixels between sequences (default=black)
    --margin-color=COLOR
                        margin color
    --exon-color=COLOR  color for exons (default=PaleGreen)
    --cds-color=COLOR   color for protein-coding regions (default=LimeGreen)
    --bridged-color=COLOR
                        color for bridged gaps (default: yellow)
    --unbridged-color=COLOR
                        color for unbridged gaps (default: orange)
```


## Metadata
- **Skill**: generated
