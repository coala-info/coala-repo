# reveal CWL Generation Report

## reveal_align

### Tool Description
Construct a population graph from input genomes or other graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/reveal/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hakimel/reveal.js
- **Stars**: N/A
### Original Help Text
```text
usage: reveal align [-h] [-o OUTPUT] [-t THREADS] [-m MINLENGTH] [-c MINSCORE]
                    [-n MINN] [--wp WPEN] [--ws WSCORE] [--mumplot] [-i]
                    [--sa SA] [--lcp LCP] [--cache] [-g MINSAMPLES]
                    [-x MAXSAMPLES] [-r REFERENCE] [-s TARGETSAMPLE] [--gml]
                    [--gml-max HWM] [--nometa] [--paths]
                    [inputfiles [inputfiles ...]]

Construct a population graph from input genomes or other graphs.

positional arguments:
  inputfiles            Fasta or gfa files specifying either
                        assembly/alignment graphs (.gfa) or sequences
                        (.fasta). When only one gfa file is supplied, variants
                        are called within the graph file.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Prefix of the variant and alignment graph files to
                        produce, default is "sequence1_sequence2"
  -t THREADS, --threads THREADS
                        The number of threads to use for the alignment.
  -m MINLENGTH          Min length of an exact match (default 20).
  -c MINSCORE           Min score of an exact match (default 0), exact maches
                        are scored by their length and penalized by the indel
                        they create with respect to previously accepted exact
                        matches.
  -n MINN               Only align graph on exact matches that occur in at
                        least this many samples.
  --wp WPEN             Multiply penalty for a MUM by this number in scoring
                        scheme.
  --ws WSCORE           Multiply length of MUM by this number in scoring
                        scheme.
  --mumplot             Save a mumplot for the actual aligned chain of anchors
                        (depends on matplotlib).
  -i                    Show an interactive visualisation of the mumplot
                        (depends on matplotlib).
  --sa SA               Specify a preconstructed suffix array to decouple
                        suffix array construction.
  --lcp LCP             Specify a preconstructed lcp array to decouple lcp
                        array construction.
  --cache               When specified, it caches the suffix and lcp array to
                        disk after construction.
  -g MINSAMPLES         Only index nodes that occur in this many samples or
                        more (default 1).
  -x MAXSAMPLES         Only align nodes that have maximally this many samples
                        (default None).
  -r REFERENCE          Name of the sequence that should be used as a
                        coordinate system or reference.
  -s TARGETSAMPLE       Only align nodes in which this sample occurs.
  --gml                 Produce a gml graph instead gfa.
  --gml-max HWM         Max number of nodes per graph in gml output.
  --nometa              Produce a gfa graph without node annotations, to
                        ensure it's parseable by other programs.
  --paths               Output paths in GFA.
```


## reveal_plot

### Tool Description
Generate mumplot for two fasta files.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal plot [-h] [-m MINLENGTH] [-i] [-u] [-r REGION] fastas fastas

Generate mumplot for two fasta files.

positional arguments:
  fastas        Two fasta files for which a mumplot should be generated.

optional arguments:
  -h, --help    show this help message and exit
  -m MINLENGTH  Minimum length of exact matches to vizualize (default=100).
  -i            Wheter to produce interactive plots which allow zooming on the
                dotplot (default=False).
  -u            Plot only maximal unique matches.
  -r REGION     Highlight interval (as "<start>:<end>") with respect to x-axis
                (first sequence).
```


## reveal_convert

### Tool Description
Convert gfa graph to gml.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal convert [-h] [-n MINSAMPLES] [-x MAXSAMPLES] [-s TARGETSAMPLE]
                      [--gml-max HWM] [--gfa] [--partition]
                      [graphs [graphs ...]]

Convert gfa graph to gml.

positional arguments:
  graphs           The gfa graph to convert to gml.

optional arguments:
  -h, --help       show this help message and exit
  -n MINSAMPLES    Only align nodes that occcur in this many samples (default
                   1).
  -x MAXSAMPLES    Only align nodes that have maximally this many samples
                   (default None).
  -s TARGETSAMPLE  Only align nodes in which this sample occurs.
  --gml-max HWM    Max number of nodes per graph in gml output.
  --gfa            Rewrite gfa file.
  --partition      Output graph as multiple subgraphs if possible.
```


## reveal_extract

### Tool Description
Extract the input sequence from a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal extract [-h] [--width WIDTH] graph [samples [samples ...]]

Extract the input sequence from a graph.

positional arguments:
  graph          gfa file specifying the graph from which the genome should be
                 extracted.
  samples        Name of the sample to be extracted from the graph.

optional arguments:
  -h, --help     show this help message and exit
  --width WIDTH  Line width for fasta output.
```


## reveal_comp

### Tool Description
Reverse complement the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal comp [-h] graph

Reverse complement the graph.

positional arguments:
  graph       The graph to be reverse complemented.

optional arguments:
  -h, --help  show this help message and exit
```


## reveal_finish

### Tool Description
Finish a draft assembly by ordering and orienting contigs with respect to a finished reference assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal finish [-h] [-m MINLENGTH] [--cache] [--sa1 SA1] [--lcp1 LCP1]
                     [--sa2 SA2] [--lcp2 LCP2]
                     reference contigs

Finish a draft assembly by ordering and orienting contigs with respect to a
finished reference assembly.

positional arguments:
  reference     Graph or sequence to which query/contigs should be assigned.
  contigs       Graph or fasta that is to be reverse complemented with respect
                to the reference.

optional arguments:
  -h, --help    show this help message and exit
  -m MINLENGTH  Min length of maximal exact matches for considering (default
                20).
  --cache       When specified, it caches the text, suffix and lcp array to
                disk after construction.
  --sa1 SA1     Specify a preconstructed suffix array for extracting matches
                between the two genomes in their current orientation.
  --lcp1 LCP1   Specify a preconstructed lcp array for extracting matches
                between the two genomes in their current orientation.
  --sa2 SA2     Specify a preconstructed suffix array for extracting matches
                between the two genomes in which the sequence of the contigs
                was reverse complemented.
  --lcp2 LCP2   Specify a preconstructed lcp array for extracting matches
                between the two genomes in which the sequence of the contigs
                was reverse complemented.
```


## reveal_matches

### Tool Description
Outputs all (multi) m(u/e)ms.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal matches [-h] [-m MINLENGTH] [--cache] [--sa1 SA1] [--lcp1 LCP1]
                      [--sa2 SA2] [--lcp2 LCP2]
                      reference contigs

Outputs all (multi) m(u/e)ms.

positional arguments:
  reference     Graph or sequence to which query/contigs should be assigned.
  contigs       Graph or fasta that is to be reverse complemented with respect
                to the reference.

optional arguments:
  -h, --help    show this help message and exit
  -m MINLENGTH  Min length of maximal exact matches for considering (default
                20).
  --cache       When specified, it caches the text, suffix and lcp array to
                disk after construction.
  --sa1 SA1     Specify a preconstructed suffix array for extracting matches
                between the two genomes in their current orientation.
  --lcp1 LCP1   Specify a preconstructed lcp array for extracting matches
                between the two genomes in their current orientation.
  --sa2 SA2     Specify a preconstructed suffix array for extracting matches
                between the two genomes in which the sequence of the contigs
                was reverse complemented.
  --lcp2 LCP2   Specify a preconstructed lcp array for extracting matches
                between the two genomes in which the sequence of the contigs
                was reverse complemented.
```


## reveal_subgraph

### Tool Description
Extract subgraph from gfa by specified node ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal subgraph [-h] [-o OUTFILE] [--gml] [inputfiles [inputfiles ...]]

Extract subgraph from gfa by specified node ids.

positional arguments:
  inputfiles  The gfa graph followed by node ids that make up the subgraph.

optional arguments:
  -h, --help  show this help message and exit
  -o OUTFILE  Prefix of the file to which subgraph will be written.
  --gml       Produce a gml graph instead of gfa.
```


## reveal_bubbles

### Tool Description
Extract all bubbles from the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal bubbles [-h] [-r REFERENCE] graph

Extract all bubbles from the graph.

positional arguments:
  graph         Graph in gfa format from which bubbles are to be extracted.

optional arguments:
  -h, --help    show this help message and exit
  -r REFERENCE  Name of the sequence that, if possible, should be used as a
                coordinate system or reference.
```


## reveal_realign

### Tool Description
Realign between two nodes in the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal realign [-h] [-m MINLENGTH] [-c MINSCORE] [-n MINN] [-o OUTFILE]
                      [--all] [--maxlen MAXLEN] [--maxsize MAXSIZE]
                      graph [source] [sink]

Realign between two nodes in the graph.

positional arguments:
  graph              Graph in gfa format for which a bubble should be
                     realigned.
  source             Source node.
  sink               Sink node.

optional arguments:
  -h, --help         show this help message and exit
  -m MINLENGTH       Min length of an exact match (default 20).
  -c MINSCORE        Min score of an exact match (default 0), exact maches are
                     scored by their length and penalized by the indel they
                     create with respect to previously accepted exact matches.
  -n MINN            Only align graph on exact matches that occur in at least
                     this many samples.
  -o OUTFILE         File to which realigned graph is to be written.
  --all              Trigger realignment for all complex bubbles.
  --maxlen MAXLEN    Maximum length of the cumulative sum of all paths that
                     run through the complex bubble.
  --maxsize MAXSIZE  Maximum allowed number of nodes that are contained in a
                     complex bubble.
```


## reveal_merge

### Tool Description
Combine multiple gfa graphs into a single gfa graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/reveal:0.1--py27_1
- **Homepage**: https://github.com/hakimel/reveal.js
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: reveal merge [-h] [-o OUTPREFIX] [graphs [graphs ...]]

Combine multiple gfa graphs into a single gfa graph.

positional arguments:
  graphs        Graphs in gfa format that should be merged.

optional arguments:
  -h, --help    show this help message and exit
  -o OUTPREFIX  Prefix of the file to which merged graph is written.
```

