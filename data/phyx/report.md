# phyx CWL Generation Report

## phyx

### Tool Description
FAIL to generate CWL: phyx not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/phyx:1.1--hc0837bd_5
- **Homepage**: https://github.com/FePhyFoFum/phyx
- **Package**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/phyx/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FePhyFoFum/phyx
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: phyx not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: phyx not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


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

