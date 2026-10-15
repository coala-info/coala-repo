# phyx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| phyx_pxaa2cdn | PASS | 70 taxa codon alignment built from the amino acid and nucleotide example files. |
| phyx_pxbdfit | PASS |  |
| phyx_pxbdsim | PASS | 3 trees with 12 extant tips each; a 2.0 time run gives a tree with root age 2. |
| phyx_pxboot | PASS | bootstrap and 50% jackknife give 8 sequences of the expected length; the partitioned jackknife (--part with --frac) stops with the tool's own 'not implemented' message. |
| phyx_pxbp | PASS | fixed: --maptree input is now staged writable and its .pxbpmapped.tre output is collected. |
| phyx_pxcat | PASS | fixed: --flist works with the listed files staged; the positional FILES form is ignored by the tool (it prints an error), use --seqf or --flist. |
| phyx_pxclsq | PASS | synthetic data: a real alignment with 50 columns planted as N in five taxa; they were removed (1503 to 1453 sites); the unmodified real alignment keeps all columns. |
| phyx_pxcltr | PASS |  |
| phyx_pxcolt | PASS | real tree with support values: all 93 nodes below 0.9 collapsed, 42 nodes remain. |
| phyx_pxcomp | PASS |  |
| phyx_pxconsq | PASS |  |
| phyx_pxcontrates | Failed | tool bug: -o is accepted but ignored (results go to standard output, the file stays empty); the long options are not recognised, so the CWL uses the short ones. |
| phyx_pxfqfilt | PASS | 696 of 1000 reads kept, all with mean quality of 30 or more. |
| phyx_pxlog | PASS | real BEAST tree logs combined and thinned (101 trees to 5 per file); column list, keep and delete options checked on a synthetic parameter log; the --rand option is documented as not yet implemented. |
| phyx_pxlssq | PASS |  |
| phyx_pxlstr | PASS |  |
| phyx_pxmono | PASS |  |
| phyx_pxmrca | PASS |  |
| phyx_pxmrcacut | PASS |  |
| phyx_pxmrcaname | PASS |  |
| phyx_pxnj | PASS |  |
| phyx_pxnw | Failed | tool bug: the scores go to standard output; the -o file stays empty and -a writes no alignment file. |
| phyx_pxrecode | PASS |  |
| phyx_pxrevcomp | PASS | reverse complement of the named sequences is correct with --seqf and --ids; the positional file form fails because the tool reads standard input. |
| phyx_pxrls | PASS |  |
| phyx_pxrlt | PASS |  |
| phyx_pxrmk | PASS |  |
| phyx_pxrms | PASS |  |
| phyx_pxrmt | PASS |  |
| phyx_pxrr | PASS |  |
| phyx_pxs2fa | PASS |  |
| phyx_pxs2nex | PASS |  |
| phyx_pxs2phy | PASS |  |
| phyx_pxseqgen | Failed | tool bug: --nreps is accepted but ignored (always one replicate; not implemented in the source); size, base frequencies, rate options and root sequence work. |
| phyx_pxssort | PASS |  |
| phyx_pxsstat | PASS |  |
| phyx_pxstrec | Not completed | the tool's own 4-state, 10-taxon example did not finish in 15 minutes (nor did a 6-taxon tree); a synthetic 4-taxon, 2-state case ran and wrote all output files. |
| phyx_pxsw | Failed | tool bug: with --seqtype 1 and no --matrix all scores are 0 (the AA default matrix is not implemented); DNA mode and a given matrix work. |
| phyx_pxt2new | PASS |  |
| phyx_pxt2nex | PASS |  |
| phyx_pxtcol | Failed | tool bug: the --mrcaf option is read but never used, so MRCA annotations are not added; --nodeidf annotation of node and tip labels works. |
| phyx_pxtcomb | Failed | tool bug: on a 6-taxon tree with a 3-taxon subtree it returns a tree that lost taxon s3; other inputs loop forever or crash. |
| phyx_pxtgen | PASS | 5 taxa give the 15 unrooted topologies; the count option reports 105 for 6 taxa. |
| phyx_pxtlate | PASS |  |
| phyx_pxtrt | PASS | fixed: names file option is -f (the long form --namesf is not accepted by pxtrt). |
| phyx_pxtscale | PASS |  |
| phyx_pxupgma | PASS |  |
| phyx_pxvcf2fa | PASS |  |

## Metadata
- **Skill**: generated

## phyx_pxcat

### Tool Description
Sequence file concatenation. This will take fasta, fastq, phylip, and nexus sequence formats. Individual files may be of different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Sequence file concatenation.
Can use wildcards e.g.:
  pxcat -s *.phy -o my_cat_file.fa
However, if the argument list is too long (shell limit), put filenames in a file:
  for x in *.phy; do echo $x >> flist.txt; done
and call using the -f option:
  pxcat -f flist.txt -o my_cat_file.fa
This will take fasta, fastq, phylip, and nexus sequence formats.
Individual files may be of different formats.

Usage: pxcat [OPTIONS]... FILES

Options:
 -s, --seqf=FILE     list of input sequence files (space delimited)
 -f, --flistFILE     file listing input files (one per line)
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -p, --partf=FILE    output partition file, none otherwise
 -u, --uppercase     export characters in uppercase
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxclsq

### Tool Description
Clean alignments by removing positions/taxa with too much ambiguous data. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results are written in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Clean alignments by removing positions/taxa with too much ambiguous data.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
Results are written in fasta format.

Usage: pxclsq [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output fasta file, STOUT otherwise
 -p, --prop=DOUBLE   proportion required to be present, default=0.5
 -t, --taxa          consider missing data per taxon (default: per site)
 -c, --codon         examine sequences by codon rather than site
                       - requires all sequences be in frame and of correct length
 -i, --info          report counts of missing data and exit
                       - combine with -t to get report by taxon (rather than site)
                       - combine with -c to use codons as units
 -v, --verbose       more verbose output (i.e. if entire seqs are removed)
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxs2phy

### Tool Description
Convert seqfiles from nexus, phylip, or fastq to phylip. Can read from STDIN or file.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Convert seqfiles from nexus, phylip, or fastq to phylip.
Can read from STDIN or file.

Usage: pxs2phy [OPTIONS]...

 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -u, --uppercase     export characters in uppercase
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtlate

### Tool Description
Translate DNA alignment to amino acids. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. NOTE: assumes sequences are in frame.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Translate DNA alignment to amino acids.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
NOTE: assumes sequences are in frame.

Usage: pxtlate [OPTIONS]...

Options:
 -s, --seqf=FILE     input nucleotide sequence file, STDIN otherwise
 -t, --table=STRING  which translation table to use. currently available:
                       'std' (standard, default)
                       'vmt' (vertebrate mtDNA)
                       'ivmt' (invertebrate mtDNA)
                       'ymt' (yeast mtDNA)
 -o, --outf=FILE     output aa sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrevcomp

### Tool Description
Reverse complement sequences. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results are written in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Reverse complement sequences.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
Results are written in fasta format.

Usage: pxrevcomp [OPTIONS]... [FILE]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -i, --ids=IDS       a comma sep list of ids to flip (NO SPACES!)
 -g, --guess         EXPERIMENTAL: guess whether there are seqs that need to be 
                       rev comp. uses edlib library on first seq
 -p, --pguess        EXPERIMENTAL: progressively guess 
 -m, --sguess        EXPERIMENTAL: sampled guess 
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxnj

### Tool Description
Basic neighbour-joining tree maker. This will take fasta, fastq, phylip, and nexus inputs from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Basic neighbour-joining tree maker.
This will take fasta, fastq, phylip, and nexus inputs from a file or STDIN.

Usage: pxnj [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output newick file, STOUT otherwise
 -n, --nthreads=INT  number of threads, default=1
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxupgma

### Tool Description
Bare bones UPGMA tree generator. Currently only uses uncorrected p-distances. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Bare bones UPGMA tree generator
Currently only uses uncorrected p-distances.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

Usage: pxupgma [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output newick file, STOUT otherwise
 -h, --help          display this help and exit
 -V,  --version      display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrr

### Tool Description
Reroot (or unroot) a tree file and produce a newick. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Reroot (or unroot) a tree file and produce a newick.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxrr [OPTIONS]...

Options:
 -t, --treef=FILE     input tree file, STDIN otherwise
 -g, --outgroups=CSL  outgroup sep by commas (NO SPACES!)
 -r, --ranked         turn on ordering of outgroups. will root on first one present
 -u, --unroot         unroot the tree
 -o, --outf=FILE      output tree file, STOUT otherwise
 -s, --silent         do not error if outgroup(s) not found
 -h, --help           display this help and exit
 -V, --version        display version and exit
 -C, --citation       display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrmt

### Tool Description
Remove tree tips by label. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Remove tree tips by label.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxrmt [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -n, --names=CSL     names sep by commas (NO SPACES!)
 -f, --namesf=FILE   names in a file (each on a line)
 -r, --regex=STRING  match tip labels by a regular expression
 -c, --comp          take the complement (i.e. remove any taxa not in list)
 -o, --outf=FILE     output tree file, STOUT otherwise
 -s, --silent        suppress warnings of missing tips
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtrt

### Tool Description
This will trace a big tree given a taxon list and produce newick. Data can be read from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
This will trace a big tree given a taxon list and and produce newick.
Data can be read from a file or STDIN.

Usage: pxtrt [OPTIONS]...

Options:
 -t, --treef=FILE     input tree file, STDIN otherwise
 -n, --names=CSL      names sep by commas (NO SPACES!)
 -f, --namesf=FILE    names in a file (each on a line)
 -c, --comp           take the complement (i.e. remove any taxa not in list)
 -o, --outf=FILE      output tree file, STOUT otherwise
 -s, --silent         suppress warnings of missing tips
 -h, --help           display this help and exit
 -V, --version        display version and exit
 -C, --citation       display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxs2fa

### Tool Description
Convert seqfiles from nexus, phylip, fastq to fasta. Data can be read from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Convert seqfiles from nexus, phylip, fastq to fasta.
Data can be read from a file or STDIN.

Usage: pxs2fa [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -u, --uppercase     export characters in uppercase
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxs2nex

### Tool Description
Convert seqfiles from nexus, phylip, or fastq to nexus. Can read from STDIN or file.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Convert seqfiles from nexus, phylip, or fastq to nexus.
Can read from STDIN or file.

Usage: pxs2nex [OPTIONS]...

 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -u, --uppercase     export characters in uppercase
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxt2new

### Tool Description
Converts a tree file (newick or nexus) to newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
This will convert a tree file to newick.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxt2new [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -o, --outf=FILE     output tree file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxcomp

### Tool Description
Sequence compositional homogeneity test. Chi-square test for equivalent character state counts across lineages. This will take fasta, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
Sequence compositional homogeneity test.
Chi-square test for equivalent character state counts across lineages.
This will take fasta, phylip, and nexus formats from a file or STDIN.

Usage: pxcomp [OPTIONS]...

Options:
 -s, --seqf=FILE     input seq file, STDIN otherwise
 -o, --outf=FILE     output stats file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxbp

### Tool Description
Print out bipartitions found in treefile. Trees are assumed rooted unless the -e argument is provided. This will take a newick- or nexus-formatted tree from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS
### Original Help Text
```text
This will print out bipartitions found in treefile.
Trees are assumed rooted unless the -e argument is provided.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxbp [OPTIONS]...

Options:
 -t, --treef=FILE    input treefile, STDIN otherwise
 -v, --verbose       give more output
 -e, --edgeall       force edgewise (not node - so when things are unrooted) and
                           assume all taxa are present in all trees
 -u, --uniquetree    output unique trees and *no* other output
 -m, --maptree=FILE  put the bipart freq on the edges of this tree. This will 
                           create a *.pxbpmapped.tre file.
 -c, --cutoff        skip biparts that have support lower than this.
 -s, --suppress      don't print all the output (maybe you use this
                           with the maptree feature
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxaa2cdn

### Tool Description
Generate a codon alignment from aligned amino acids and unaligned nucleotides. Taxa found in only 1 input file will be removed. This will take fasta, fastq, phylip, and nexus inputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Generate a codon alignment from aligned amino acids and unaligned nucleotides.
Taxa found in only 1 input file will be removed.
This will take fasta, fastq, phylip, and nexus inputs.

Usage: pxaa2cdn [OPTIONS]...

Options:
 -a, --aaseqf=FILE   input sequence file, STDIN otherwise
 -n, --nucseqf=FILE  input sequence file, STDIN otherwise
 -o, --outf=FILE     output fasta file, STOUT otherwise
 -r, --rmlastcdn     removes last codon (default: false)
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxbdfit

### Tool Description
Fit a lineage diversification model to a tree. This will take a newick- or nexus-formatted tree from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Fit a lineage diversification model to a tree.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxbdfit [OPTIONS]...

Options:
 -t, --treef=FILE    input treefile, STDIN otherwise
 -m, --model=STRING  diversification model; either 'yule', 'bd' (default), or 'best'
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxbdsim

### Tool Description
Birth-death tree simulator.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Birth-death tree simulator.

Usage: pxbdsim [OPTIONS]...

Options:
 -e, --extant=INT    number of extant species, alt to time
 -t, --time=DOUBLE   timespan of simulation (age of root), alt to extant
 -b, --birth=DOUBLE  birth rate, default=1
 -d, --death=DOUBLE  death rate, default=0
 -n, --nreps=INT     number of replicates, default=1
 -o, --outf=FILE     output file, STOUT otherwise
 -s, --showextinct   show lineages that went extinct, default=false
 -x, --seed=INT      random number seed, clock otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxboot

### Tool Description
Sequence alignment bootstrap or jackknife resampling. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Sequence alignment bootstrap or jackknife resampling.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

Usage: pxboot [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -p, --partf=FILE    file listing empirical partitions: NAME = START-STOP[\INTERVAL]
 -f, --frac=DOUBLE   jackknife percentage, default bootstrap (i.e. -f 1.0)
 -x, --seed=INT      random number seed, clock otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxcltr

### Tool Description
General tree cleaner. Removes annotations (node labels), 'knuckles' (2-degree nodes), and root edges to generate a 'vanilla' newick representation. By default removes all properties. Alternatively choose 1 property. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
General tree cleaner.
Removes annotations (node labels), 'knuckles' (2-degree nodes), and
root edges to generate a 'vanilla' newick representation.
By default removes all properties. Alternatively choose 1 property.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxcltr [OPTIONS]...

Options:
 -t, --treef=FILE    input treefile, STDIN otherwise
 -r, --root          remove root edge (if present)
 -l, --labels        remove internal node labels
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxcolt

### Tool Description
Collapse edges with support below some threshold. If annotated Nexus, may require passing in the support identifier (-s). This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Collapse edges with support below some threshold.
If annotated Nexus, may require passing in the support identifier (-s).
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxcolt [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -l, --limit=DOUBLE  minimum support threshold as proportion (default = 0.5)
 -s, --sup=STRING    string identifying support values (if default fails)
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxconsq

### Tool Description
Compute a consensus sequence from an alignment. This will take fasta, phylip, and nexus formats from a file or STDIN. Results are written in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Compute a consensus sequence from an alignment.
This will take fasta, phylip, and nexus formats from a file or STDIN.
Results are written in fasta format.

Usage: pxconsq [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxcontrates

### Tool Description
Continuous character rate estimation with Brownian and OU. This will take fasta, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Continuous character rate estimation with Brownian and OU.
This will take fasta, phylip, and nexus formats from a file or STDIN.

Usage: pxcontrates [OPTIONS]...

Options:
 -c, --charf=FILE     input character file, STDIN otherwise
 -t, --treef=FILE     input tree file, STDIN otherwise
 -a, --analysis=NUM   analysis type (0=anc[DEFAULT], 1=ratetest)
 -o, --outf=FILE      output sequence file, STOUT otherwise
 -h, --help           display this help and exit
 -V, --version        display version and exit
 -C, --citation       display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxfqfilt

### Tool Description
Filter fastq files by mean quality. Data can be read from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Filter fastq files by mean quality.
Data can be read from a file or STDIN.

Usage: pxfqfilt [OPTIONS]...

Options:
 -m, --mean=VALUE    mean value under which seqs are filtered
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxlog

### Tool Description
MCMC log file manipulator. Can combine and resample parameters or trees across files. Log files need not contain the same number of samples. Input files may be indicated using wildcards e.g. '*.trees' Parameter log files are expected to be whitespace delimited. *NOTE* All values are in terms of number of SAMPLES (NOT generations).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
MCMC log file manipulator.
Can combine and resample parameters or trees across files.
Log files need not contain the same number of samples.
Input files may be indicated using wildcards e.g. '*.trees'
Parameter log files are expected to be whitespace delimited.
*NOTE* All values are in terms of number of SAMPLES (NOT generations).

Usage: pxlog [OPTIONS]...

Options:
 -p, --parmf=FILE    input parameter log file(s)
 -t, --treef=FILE    input tree log file(s)
 -o, --outf=FILE     output file, STOUT otherwise
 -b, --burnin=INT    number of samples to exclude at the beginning of a file
 -n, --thin=INT      interval of resampling
 -r, --rand=INT      number of random samples (without replacement) not yet implemented!
 -i, --info          calculate log file attributes and exit
 -c, --columns       print out column names (parameter logs only)
 -d, --delete=CSL    delete columns by 1-index sep by commas (NO SPACES!) (parameter logs only)
 -k, --keep=CSL      keep only columns by 1-index sep by commas (NO SPACES!) (parameter logs only)
 -x, --seed=INT      random number seed, clock otherwise
 -v, --verbose       make the output more verbose
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxlssq

### Tool Description
Print sequence file summary. By default returns all properties. Alternatively choose 1 property. This will take fasta, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Print sequence file summary.
By default returns all properties. Alternatively choose 1 property.
This will take fasta, phylip, and nexus formats from a file or STDIN.

Usage: pxlssq [OPTIONS]...

Options:
 -s, --seqf=FILE     input seq file, STDIN otherwise
 -i, --indiv         output stats for individual sequences
 -n, --nseq          return the number of sequences
 -c, --nchar         return the number of characters (only if aligned)
                        - for unaligned seqs, use with -i flag
 -l, --labels        return all taxon labels (one per line)
 -p, --prot          force interpret as protein (if inference fails)
 -a, --aligned       return whether sequences are aligned (same length)
 -f, --freqs         return character state frequencies
 -m, --missing       return the proportion of missing (-,?) characters
 -o, --outf=FILE     output stats file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxlstr

### Tool Description
Print tree summary. By default returns all properties. Alternatively choose 1 property. This will take a newick- or nexus-formatted tree from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Print tree summary.
By default returns all properties. Alternatively choose 1 property.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxlstr [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -r, --rooted        return whether the tree is rooted
 -a, --age           return the height of root (must be rooted and ultrametric)
 -n, --ntips         return the number of terminals
 -u, --ultrametric   return whether tree is ultrametric
 -b, --binary        return whether tree is binary
 -l, --length        return the length of the tree
 -i, --tiplabels     return all tip labels (one per line)
 -v, --rtvar         return root-to-tip variance
 -o, --outf=FILE     output tree stats file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxmono

### Tool Description
Monophyly checker. This will take a newick- or nexus-formatted tree from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Monophyly checker.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxmono [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -n, --names=CSL     names separated by commas (NO SPACES!)
 -f, --namesf=FILE   names in a file (each on a line)
 -c, --comp          take the complement (i.e. check monophyly of taxa not in list)
 -o, --outf=FILE     output tree file, STOUT otherwise
 -i, --ignore        ignore missing (default: exit if names are not in the tree)
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit


Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxmrca

### Tool Description
Get the number of descendant tips of internal nodes specified by mrca statements. This will take a newick- or nexus-formatted tree from a file or STDIN, and an MRCA file with format: MRCANAME = tip1 tip2 ...

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Get the number of descendant tips of internal nodes specified by mrca statements.
This will take a newick- or nexus-formatted tree from a file or STDIN,
and an MRCA file with format:
MRCANAME = tip1 tip2 ...

Usage: pxmrca [OPTIONS]...

Options:
 -t, --treef=FILE    input newick tree file, STDIN otherwise
 -m, --mrca=FILE     file containing MRCA declarations
 -o, --outf=FILE     output newick file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxmrcacut

### Tool Description
Extract subclade(s) from tree(s). This will take a newick- or nexus-formatted tree from a file or STDIN, and an MRCA file with format: MRCANAME = tip1 tip2 ... If multiple MRCAs are provided, multiple subtrees are returned

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Extract subclade(s) from tree(s).
This will take a newick- or nexus-formatted tree from a file or STDIN,
and an MRCA file with format:
MRCANAME = tip1 tip2 ...
If multiple MRCAs are provided, multiple subtrees are returned

Usage: pxmrcacut [OPTIONS]...

Options:
 -t, --treef=FILE    input newick tree file, STDIN otherwise
 -m, --mrca=FILE     file containing MRCA declarations
 -o, --outf=FILE     output newick file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxmrcaname

### Tool Description
Label internal nodes with clade names. This will take a newick- or nexus-formatted tree from a file or STDIN, and an MRCA file with format: MRCANAME = tip1 tip2 ... If no MRCA file is present, this will label anything that isn't labeled

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Label internal nodes with clade names.
This will take a newick- or nexus-formatted tree from a file or STDIN,
and an MRCA file with format:
MRCANAME = tip1 tip2 ...
If no MRCA file is present, this will label anything
that isn't labeled

Usage: pxmrcaname [OPTIONS]...

Options:
 -t, --treef=FILE    input newick tree file, STDIN otherwise
 -m, --mrca=FILE     file containing MRCA declarations
 -o, --outf=FILE     output newick file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxnw

### Tool Description
Conduct Needleman-Wunsch analysis for all the seqs in a file. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Output is a list of the scores and distances (and the alignments if asked).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Conduct Needleman-Wunsch analysis for all the seqs in a file.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
Output is a list of the scores and distances (and the alignments if asked).

Usage: pxnw [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output score/distance file, STOUT otherwise
 -a, --outalnf=FILE  output sequence file, won't output otherwise
 -t, --seqtype=INT   sequence type, default=DNA (DNA=0,AA=1)
 -m, --matrix=FILE   scoring matrix, default DNA=EDNAFULL, AA=BLOSUM62
 -n, --nthreads=INT  number of threads (open mp), default=2
 -v, --verbose       make the output more verbose, turns off parallel
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrecode

### Tool Description
Nucleotide sequence recoding. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Nucleotide sequence recoding.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

Usage: pxrecode [OPTIONS]...

Options:
 -s, --seqf=FILE      input sequence file, STDIN otherwise
 -r, --recode=STRING  string identifying recoding scheme (default: RY)
  Supported recodings (use any valid combination):
      R = A|G
      Y = C|T
      S = C|G
      W = A|T
      M = A|C
      K = G|T
      B = C|G|T
      D = A|G|T
      H = A|C|T
      V = A|C|G
 -o, --outf=FILE      output sequence file, STOUT otherwise
 -h, --help           display this help and exit
 -V, --version        display version and exit
 -C, --citation       display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrls

### Tool Description
Taxon relabelling for alignments. This will take fasta, phylip, and nexus formats from a file or STDIN. Two ordered lists of taxa, -c (current) and -n (new) must be provided. Results are written in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Taxon relabelling for alignments.
This will take fasta, phylip, and nexus formats from a file or STDIN.
Two ordered lists of taxa, -c (current) and -n (new) must be provided.
Results are written in fasta format.

Usage: pxrls [OPTIONS]... FILES

Options:
 -s, --seqf=FILE     input seq file, STDIN otherwise
 -c, --cnames=FILE   file containing current taxon labels (one per line)
 -n, --nnames=FILE   file containing new taxon labels (one per line)
 -o, --outf=FILE     output file, STOUT otherwise
 -v, --verbose       make the output more verbose
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrlt

### Tool Description
Taxon relabelling for trees. Two ordered lists of taxa, -c (current) and -n (new) must be provided. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Taxon relabelling for trees.
Two ordered lists of taxa, -c (current) and -n (new) must be provided.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxrlt [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -c, --cnames=FILE   file containing current taxon labels (one per line)
 -n, --nnames=FILE   file containing new taxon labels (one per line)
 -o, --outf=FILE     output file, STOUT otherwise
 -v, --verbose       make the output more verbose
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrmk

### Tool Description
Remove two-degree internal nodes ('knuckles') from a tree. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Remove two-degree internal nodes ('knuckles') from a tree.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxrmk [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -o, --outf=FILE     output tree file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxrms

### Tool Description
Remove sequences by label. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results are written in fasta format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Remove sequences by label.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
Results are written in fasta format.

Usage: pxrms [OPTIONS]...

Options:
 -s, --seqf=FILE     input nucleotide sequence file, STDIN otherwise
 -n, --names=CSL     names sep by commas (NO SPACES!)
 -f, --namesf=FILE   names in a file (each on a line)
 -r, --regex=STRING  match tip labels by a regular expression
 -c, --comp          take the complement (i.e. remove any taxa not in list)
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxseqgen

### Tool Description
Basic sequence simulator under the GTR model. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Basic sequence simulator under the GTR model.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

Usage: pxseqgen [OPTIONS]...

Options:
 -t, --treef=FILE       input treefile, STDIN otherwise
 -o, --outf=FILE        output seq file, STOUT otherwise
 -l, --length=INT       length of sequences to generate. default is 1000
 -b, --basef=Input      comma-delimited base freqs in order: A,C,G,T. default is equal
 -g, --gamma=INT        gamma shape value. default is no rate variation
 -i, --pinvar=FLOAT     proportion of invariable sites. default is 0.0
 -r, --ratemat=Input    comma-delimited input values for rate matrix. default is JC69
                          order: A<->C,A<->G,A<->T,C<->G,C<->T,G<->T
 -w, --aaratemat=Input  comma-delimited amino acid rate matrix. default is all freqs equal
                        order is ARNDCQEGHILKMFPSTWYV
 -q, --aabasefreq=Input AA frequencies, order: ARNDCQEGHILKMFPSTWYV
 -c, --protein          run as amino acid
 -n, --nreps=INT        number of replicates
 -x, --seed=INT         random number seed, clock otherwise
 -a, --ancestors        print the ancestral node sequences. default is no
                          use -p for the nodes labels
 -p, --printnodelabels  print newick with internal node labels. default is no
 -m, --multimodel=Input specify multiple models across tree
                          input is as follows:
                            A<->C,A<->G,A<->T,C<->G,C<->T,G<->T,Node#,A<->C,A<->G,A<->T,C<->G,C<->T,G<->T
                            EX:.3,.3,.3,.3,.3,1,.3,.3,.2,.5,.4
 -k, --rootseq=STRING   set root sequence. default is random (from basefreqs)
 -h, --help             display this help and exit
 -V, --version          display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxssort

### Tool Description
Sort sequences by id or length. This will take fasta, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Sort sequences by id or length.
This will take fasta, phylip, and nexus formats from a file or STDIN.

Usage: pxssort [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -b, --sortby        what to sort by: 1:id (default) 2:id rev
                                      3:length (<)   4:length (>)
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxsstat

### Tool Description
Calculates multinomial alignment test statistics. Currently only calculates the test statistic from Bollback (2002) MBE. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Calculates multinomial alignment test statistics.
Currently only calculates the test statistic from Bollback (2002) MBE.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.

Usage: pxsstat [OPTIONS]... 

Options:
 -s, --seqf=FILE     input seq file, STDIN otherwise
 -o, --outf=FILE     output sequence file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxstrec

### Tool Description
This will conduct state reconstruction analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
This will conduct state reconstruction analyses.

Usage: pxstrec [OPTIONS]... FILES

Options:
 -d, --dataf=FILE    input data file
 -w, --datawide      data is in wide format so (001 instead of 2)
 -z, --dataz         data is in probability format (0,1,0,0)
 -t, --treef=FILE    input tree file
 -c, --conf=FILE     configuration file
 -o, --outanc=FILE   output file for ancestral calc
 -n, --outstnum=FILE output file for stochastic mapping number
 -a, --outstnumany=FILE output file for stochastic mapping number any
 -m, --outsttim=FILE output file for stochastic mapping duration
 -p, --periods=NUMS  comma separated times
 -l, --logf=FILE     log file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxsw

### Tool Description
Conduct Smith-Waterman analysis for all the seqs in a file. This will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Output is a list of the scores and distances (and the alignments if asked).

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Conduct Smith-Waterman analysis for all the seqs in a file.
This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.
Output is a list of the scores and distances (and the alignments if asked).

Usage: pxsw [OPTIONS]...

Options:
 -s, --seqf=FILE     input sequence file, STDIN otherwise
 -o, --outf=FILE     output score/distance file, STOUT otherwise
 -a, --outalnf=FILE  output sequence file, won't output otherwise
 -t, --seqtype=INT   sequence type, default=DNA (DNA=0,AA=1)
 -m, --matrix=FILE   scoring matrix, default DNA=EDNAFULL, AA=BLOSUM62
 -n, --nthreads=INT  number of threads (open mp), default=2
 -v, --verbose       make the output more verbose, turns off parallel
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxt2nex

### Tool Description
This will convert a tree file to vanilla Nexus format. This will take a newick- or nexus-formatted tree from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
This will convert a tree file to vanilla Nexus format.
This will take a newick- or nexus-formatted tree from a file or STDIN.

Usage: pxt2nex [OPTIONS]...

Options:
 -t, --treef=FILE    input tree file, STDIN otherwise
 -o, --outf=FILE     output tree file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtcol

### Tool Description
Add information to a tree so that you can color the edges. This will take nexus and newick inputs from a file or STDIN. Results are written in nexus format so that it can be read by figtree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Add information to a tree so that you can color the edges.
This will take nexus and newick inputs from a file or STDIN.
Results are written in nexus format so that it can be read by figtree.

Usage: pxtcol [OPTIONS]...

Options:
 -t, --treef=FILE     input tree file, STDIN otherwise
 -m, --mrcaf=FILE     file with mrcas and annotations, tab separated
 -d, --nodeidf=FILE   file with nodeids (labels) and annotations, tab separated
 -o, --outf=FILE      output file, STOUT otherwise
 -h, --help           display this help and exit
 -V, --version        display version and exit
 -C, --citation       display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtcomb

### Tool Description
Combine a set of trees from one file into a tree from another. Pass in 2 trees with `t` and `a`.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Combine a set of trees from one file into a tree from another.
Pass in 2 trees with `t` and `a`.

Usage: pxtcomb [OPTIONS]... FILE

Options:
 -t, --treef=FILE    reference treefile, STDIN otherwise
 -a, --addtree=FILE  alternate treefile
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtgen

### Tool Description
Generate all tree topologies for n taxa. Random tree samples are a-coming.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Generate all tree topologies for n taxa.
Random tree samples are a-coming.

Usage: pxtgen [OPTIONS]...

Options:
 -n, --ntax=INT      number of taxa
 -r, --rooted        whether generated trees are rooted (default: false)
 -c, --count         give the number of possible trees for n taxa and exit
 -l, --label=STRING  prefix label for taxon names (default: 't')
 -o, --outf=FILE     output file, STOUT otherwise
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxtscale

### Tool Description
Tree rescaling by providing either scaling factor or root height. This will take a newick- or nexus-formatted tree from a file or STDIN. Output is written in newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Tree rescaling by providing either scaling factor or root height.
This will take a newick- or nexus-formatted tree from a file or STDIN.
Output is written in newick format.

Usage: pxtscale [OPTIONS]...

Options:
 -t, --treef=FILE        input tree file, STDIN otherwise
 -s, --scale=DOUBLE      edge length scaling factor
 -r, --rootheight=DOUBLE height of root (tree must be ultrametric)
 -o, --outf=FILE         output file, STOUT otherwise
 -h, --help              display this help and exit
 -V, --version           display version and exit
 -C, --citation          display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```

## phyx_pxvcf2fa

### Tool Description
Convert vcf file to fasta. Currently only handles haploid data; phased data will come soon. Data can be read from a file or STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: PASS

### Original Help Text
```text
Convert vcf file to fasta.
Currently only handles haploid data; phased data will come soon.
Data can be read from a file or STDIN.

Usage: pxvcf2fa [OPTIONS]...

Options:
 -s, --seqf=FILE     input vcf file, STDIN otherwise
 -o, --outf=FILE     output fasta sequence file, STOUT otherwise
 -u, --uppercase     export characters in uppercase
 -h, --help          display this help and exit
 -V, --version       display version and exit
 -C, --citation      display phyx citation and exit

Report bugs to: <https://github.com/FePhyFoFum/phyx/issues>
phyx home page: <https://github.com/FePhyFoFum/phyx>
```
