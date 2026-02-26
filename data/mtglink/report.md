# mtglink CWL Generation Report

## mtglink_bed2gfa.py

### Tool Description
Convert a BED file containing the 'N's coordinates for each scaffold (or locus coordinates) to a GFA file (GFA 2.0) ('N's regions are treated as gaps). We can filter the 'N's regions by their size (e.g. gap lengths) and by the contigs' sizes on both sides (long enough for ex to get enough barcodes)

### Metadata
- **Docker Image**: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
- **Homepage**: https://github.com/anne-gcd/MTG-Link
- **Package**: https://anaconda.org/channels/bioconda/packages/mtglink/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mtglink/overview
- **Total Downloads**: 36.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/anne-gcd/MTG-Link
- **Stars**: N/A
### Original Help Text
```text
usage: bed2gfa.py -bed <bedFile.bed> -fa <fastaFile.fasta> -out <outputGFAFile> [options]

Convert a BED file containing the 'N's coordinates for each scaffold (or locus coordinates) to a GFA file (GFA 2.0) ('N's regions are treated as gaps). We can filter the 'N's regions by their size (e.g. gap lengths) and by the contigs' sizes on both sides (long enough for ex to get enough barcodes)

options:
  -h, --help            show this help message and exit
  -bed BED              BED file containing the 'Ns' coordinates for each scaffold (format: 'xxx.bed')
  -fa FASTA             FASTA file containing the sequences of the scaffolds (reference genome) (format: 'xxx.fasta' or 'xxx.fa')
  -min MIN              Minimum size of the 'Ns' region to treat as a gap
  -max MAX              Maximum size of the 'Ns' region to treat as a gap
  -contigs CONTIGS_SIZE
                        Minimum size of the flanking contigs of the 'Ns' region to treat as a gap
  -out OUTGFA           Name of the output GFA file
```


## mtglink_LRez

### Tool Description
LRez allows to work with barcoded Linked-Reads, and offers various barcode management functionalities.

### Metadata
- **Docker Image**: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
- **Homepage**: https://github.com/anne-gcd/MTG-Link
- **Package**: https://anaconda.org/channels/bioconda/packages/mtglink/overview
- **Validation**: PASS

### Original Help Text
```text
LRez v2.2.4
Pierre Morisse <pierre.morisse@inria.fr>
LRez allows to work with barcoded Linked-Reads, and offers various barcode management functionalities.

USAGE:
	LRez [SUBCOMMAND]

SUBCOMMANDS:
	compare		 Compute the number of common barcodes between pairs of regions, or between pairs of contigs' extremities
	extract		 Extract the barcodes from a given region of a BAM file
	stats		 Retrieve general stats from a BAM file
	index bam	 Index the offsets or occurrences positions of the barcodes contained in a BAM file
	query bam	 Query the barcodes index to retrieve alignments in a BAM file, given a barcode or list of barcodes
	index fastq	 Index the offsets of the barcodes contained in a fastq file
	query fastq	 Query the barcodes index to retrieve alignments in a fastq file, given a barcode or list of barcodes
```


## mtglink_mtglink.py

### Tool Description
Local assembly with linked read data, using either a De Bruijn Graph (DBG) algorithm or an Iterative Read Overlap (IRO) algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
- **Homepage**: https://github.com/anne-gcd/MTG-Link
- **Package**: https://anaconda.org/channels/bioconda/packages/mtglink/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mtglink.py [-h] [-v] {DBG,IRO} ...

Local assembly with linked read data, using either a De Bruijn Graph (DBG) algorithm or an Iterative Read Overlap (IRO) algorithm

positional arguments:
  {DBG,IRO}   MTGLink module used for the Local Assembly step
    DBG       Local assembly using a De Bruijn Graph (DBG) algorithm
    IRO       Local assembly using an Iterative Read Overlap (IRO) algorithm

options:
  -h, --help  show this help message and exit
  -v          show program's version number and exit
```

