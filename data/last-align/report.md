# last-align CWL Generation Report

## last-align_lastdb

### Tool Description
Prepare sequences for subsequent alignment with lastal.

### Metadata
- **Docker Image**: biocontainers/last-align:v963-2-deb_cv1
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/last-align/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: lastdb [options] output-name fasta-sequence-file(s)
Prepare sequences for subsequent alignment with lastal.

Main Options:
-h, --help: show all options and their default settings, and exit
-p: interpret the sequences as proteins
-R: repeat-marking options (default=10)
-c: soft-mask lowercase letters (in reference *and* query sequences)
-u: seeding scheme (default: YASS for DNA, else exact-match seeds)

Advanced Options (default settings):
-w: use initial matches starting at every w-th position in each sequence (1)
-W: use "minimum" positions in sliding windows of W consecutive positions (1)
-S: strand: 0=reverse, 1=forward, 2=both (1)
-s: volume size (unlimited)
-Q: input format: 0=fasta or fastq-ignore,
                  1=fastq-sanger, 2=fastq-solexa, 3=fastq-illumina (fasta)
-P: number of parallel threads (1)
-m: seed pattern
-a: user-defined alphabet
-i: minimum limit on initial matches per query position (0)
-b: bucket depth
-C: child table type: 0=none, 1=byte-size, 2=short-size, 3=full (0)
-x: just count sequences and letters
-v: be verbose: write messages about what lastdb is doing
-V, --version: show version information, and exit

Report bugs to: last-align (ATmark) googlegroups (dot) com
LAST home page: http://last.cbrc.jp/
```


## last-align_last-train

### Tool Description
Try to find suitable score parameters for aligning the given sequences.

### Metadata
- **Docker Image**: biocontainers/last-align:v963-2-deb_cv1
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
    --pid=PID          skip alignments with > PID% identity (default: 100)
    --postmask=NUMBER  skip mostly-lowercase alignments (default=1)
    --sample-number=N  number of random sequence samples (default: 500)
    --sample-length=L  length of each sample (default: 2000)

  Initial parameter options:
    -r SCORE           match score (default: 6 if Q>0, else 5)
    -q COST            mismatch cost (default: 18 if Q>0, else 5)
    -p NAME            match/mismatch score matrix
    -a COST            gap existence cost (default: 21 if Q>0, else 15)
    -b COST            gap extension cost (default: 9 if Q>0, else 3)
    -A COST            insertion existence cost
    -B COST            insertion extension cost

  Alignment options:
    -D LENGTH          query letters per random alignment (default: 1e6)
    -E EG2             maximum expected alignments per square giga
    -s STRAND          0=reverse, 1=forward, 2=both (default: 2 if DNA, else
                       1)
    -S NUMBER          score matrix applies to forward strand of: 0=reference,
                       1=query (default: 1)
    -C COUNT           omit gapless alignments in COUNT others with > score-
                       per-length
    -T NUMBER          type of alignment: 0=local, 1=overlap (default: 0)
    -m COUNT           maximum initial matches per query position (default:
                       10)
    -k STEP            use initial matches starting at every STEP-th position
                       in each query (default: 1)
    -P THREADS         number of parallel threads
    -Q NUMBER          input format: 0=fasta or fastq-ignore, 1=fastq-sanger
                       (default=fasta)
```


## last-align_lastal

### Tool Description
Find and align similar sequences.

### Metadata
- **Docker Image**: biocontainers/last-align:v963-2-deb_cv1
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lastal [options] lastdb-name fasta-sequence-file(s)
Find and align similar sequences.

Cosmetic options:
-h, --help: show all options and their default settings, and exit
-V, --version: show version information, and exit
-v: be verbose: write messages about what lastal is doing
-f: output format: TAB, MAF, BlastTab, BlastTab+ (default=MAF)

E-value options (default settings):
-D: query letters per random alignment (1e+06)
-E: maximum expected alignments per square giga (1e+18/D/refSize/numOfStrands)

Score options (default settings):
-r: match score   (2 if -M, else  6 if 0<Q<5, else 1 if DNA)
-q: mismatch cost (3 if -M, else 18 if 0<Q<5, else 1 if DNA)
-p: match/mismatch score matrix (protein-protein: BL62, DNA-protein: BL80)
-a: gap existence cost (DNA: 7, protein: 11, 0<Q<5: 21)
-b: gap extension cost (DNA: 1, protein:  2, 0<Q<5:  9)
-A: insertion existence cost (a)
-B: insertion extension cost (b)
-c: unaligned residue pair cost (off)
-F: frameshift cost (off)
-x: maximum score drop for preliminary gapped alignments (z)
-y: maximum score drop for gapless alignments (min[t*10, x])
-z: maximum score drop for final gapped alignments (e-1)
-d: minimum score for gapless alignments (min[e, t*ln(1000*refSize/n)])
-e: minimum score for gapped alignments

Initial-match options (default settings):
-m: maximum initial matches per query position (10)
-l: minimum length for initial matches (1)
-L: maximum length for initial matches (infinity)
-k: use initial matches starting at every k-th position in each query (1)
-W: use "minimum" positions in sliding windows of W consecutive positions

Miscellaneous options (default settings):
-s: strand: 0=reverse, 1=forward, 2=both (2 for DNA, 1 for protein)
-S: score matrix applies to forward strand of: 0=reference, 1=query (0)
-K: omit alignments whose query range lies in >= K others with > score (off)
-C: omit gapless alignments in >= C others with > score-per-length (off)
-P: number of parallel threads (1)
-i: query batch size (8 KiB, unless there is > 1 thread or lastdb volume)
-M: find minimum-difference alignments (faster but cruder)
-T: type of alignment: 0=local, 1=overlap (0)
-n: maximum gapless alignments per query position (infinity if m=0, else m)
-N: stop after the first N alignments per query strand
-R: repeat-marking options (the same as was used for lastdb)
-u: mask lowercase during extensions: 0=never, 1=gapless,
    2=gapless+postmask, 3=always (2 if lastdb -c and Q<5, else 0)
-w: suppress repeats inside exact matches, offset by <= this distance (1000)
-G: genetic code file
-t: 'temperature' for calculating probabilities (1/lambda)
-g: 'gamma' parameter for gamma-centroid and LAMA (1)
-j: output type: 0=match counts, 1=gapless, 2=redundant gapped, 3=gapped,
                 4=column ambiguity estimates, 5=gamma-centroid, 6=LAMA,
                 7=expected counts (3)
-Q: input format: 0=fasta or fastq-ignore, 1=fastq-sanger, 2=fastq-solexa,
                  3=fastq-illumina, 4=prb, 5=PSSM (fasta)

Report bugs to: last-align (ATmark) googlegroups (dot) com
LAST home page: http://last.cbrc.jp/
```


## last-align_maf-convert

### Tool Description
Read MAF-format alignments & write them in another format.

### Metadata
- **Docker Image**: biocontainers/last-align:v963-2-deb_cv1
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
  maf-convert --help
  maf-convert axt mafFile(s)
  maf-convert blast mafFile(s)
  maf-convert blasttab mafFile(s)
  maf-convert chain mafFile(s)
  maf-convert html mafFile(s)
  maf-convert psl mafFile(s)
  maf-convert sam mafFile(s)
  maf-convert tab mafFile(s)

Read MAF-format alignments & write them in another format.

Options:
  -h, --help            show this help message and exit
  -p, --protein         assume protein alignments, for psl match counts
  -j N, --join=N        join co-linear alignments separated by <= N letters
  -n, --noheader        omit any header lines from the output
  -d, --dictionary      include dictionary of sequence lengths in sam format
  -f DICTFILE, --dictfile=DICTFILE
                        get sequence dictionary from DICTFILE
  -r READGROUP, --readgroup=READGROUP
                        read group info for sam format
  -l LINESIZE, --linesize=LINESIZE
                        line length for blast and html formats (default: 60)
```


## last-align_last-dotplot

### Tool Description
Draw a dotplot of pair-wise sequence alignments in MAF or tabular format.

### Metadata
- **Docker Image**: biocontainers/last-align:v963-2-deb_cv1
- **Homepage**: https://gitlab.com/mcfrith/last
- **Package**: https://anaconda.org/channels/bioconda/packages/last/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: last-dotplot --help
   or: last-dotplot [options] maf-or-tab-alignments dotplot.png
   or: last-dotplot [options] maf-or-tab-alignments dotplot.gif
   or: ...

Draw a dotplot of pair-wise sequence alignments in MAF or tabular format.

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
  -c COLOR, --forwardcolor=COLOR
                        color for forward alignments (default: red)
  -r COLOR, --reversecolor=COLOR
                        color for reverse alignments (default: blue)
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
                        of aligned length (default=0.5,2)
  --max-gap2=FRAC       maximum unaligned (end,mid) gap in genome2: fraction
                        of aligned length (default=0.5,2)
  --pad=FRAC            pad length when cutting unaligned gaps: fraction of
                        aligned length (default=0.04)
  --border-pixels=INT   number of pixels between sequences (default=1)
  --border-color=COLOR  color for pixels between sequences (default=black)
  --margin-color=COLOR  margin color

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

  Annotation options:
    --bed1=FILE         read genome1 annotations from BED file
    --bed2=FILE         read genome2 annotations from BED file
    --rmsk1=FILE        read genome1 repeats from RepeatMasker .out or
                        rmsk.txt file
    --rmsk2=FILE        read genome2 repeats from RepeatMasker .out or
                        rmsk.txt file

  Gene options:
    --genePred1=FILE    read genome1 genes from genePred file
    --genePred2=FILE    read genome2 genes from genePred file
    --exon-color=COLOR  color for exons (default=PaleGreen)
    --cds-color=COLOR   color for protein-coding regions (default=LimeGreen)

  Unsequenced gap options:
    --gap1=FILE         read genome1 unsequenced gaps from agp or gap file
    --gap2=FILE         read genome2 unsequenced gaps from agp or gap file
    --bridged-color=COLOR
                        color for bridged gaps (default: yellow)
    --unbridged-color=COLOR
                        color for unbridged gaps (default: orange)
```

