# mummer2circos CWL Generation Report

## mummer2circos

### Tool Description
Convert MUMmer output to Circos plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/mummer2circos:1.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/metagenlab/mummer2circos
- **Package**: https://anaconda.org/channels/bioconda/packages/mummer2circos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mummer2circos/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/metagenlab/mummer2circos
- **Stars**: N/A
### Original Help Text
```text
usage: mummer2circos [-h] [-r FASTA1] [-q FASTA2 [FASTA2 ...]] [-fr] [-fq]
                     [-l] [-s SAMTOOLS_DEPTH [SAMTOOLS_DEPTH ...]]
                     [-o OUTPUT_NAME] [-g] [-gb GENBANK] [-b BLAST]
                     [-bc BLAST_IDENTITY_CUTOFF]
                     [-n HIGHLIGHT [HIGHLIGHT ...]] [-a ALGO]
                     [-m MIN_GAP_SIZE] [-bn] [-w WINDOW]
                     [-ss SECRETION_SYSTEMS] [-c] [-lf LABEL_FILE]
                     [-lt LOCUS_TAXONOMY] [-f]

optional arguments:
  -h, --help            show this help message and exit
  -r FASTA1, --fasta1 FASTA1
                        reference fasta
  -q FASTA2 [FASTA2 ...], --fasta2 FASTA2 [FASTA2 ...]
                        query fasta
  -fr, --filterr        do not remove reference sequences without any
                        similarity from the plot (default False)
  -fq, --filterq        do not remove query sequences without any similarity
                        from the plot (default False)
  -l, --link            link circos and not heatmap circos
  -s SAMTOOLS_DEPTH [SAMTOOLS_DEPTH ...], --samtools_depth SAMTOOLS_DEPTH [SAMTOOLS_DEPTH ...]
                        samtools depth file
  -o OUTPUT_NAME, --output_name OUTPUT_NAME
                        output circos pefix
  -g, --gaps            highlight gaps
  -gb GENBANK, --genbank GENBANK
                        add ORF based on GBK file
  -b BLAST, --blast BLAST
                        input fasta file (aa sequence) for BLAST
  -bc BLAST_IDENTITY_CUTOFF, --blast_identity_cutoff BLAST_IDENTITY_CUTOFF
                        Blast identity cutoff
  -n HIGHLIGHT [HIGHLIGHT ...], --highlight HIGHLIGHT [HIGHLIGHT ...]
                        highlight instead of heatmap corresponding list of
                        records
  -a ALGO, --algo ALGO  algorythm to use to compare the genome (megablast,
                        nucmer or promer)
  -m MIN_GAP_SIZE, --min_gap_size MIN_GAP_SIZE
                        minimum gap size to consider
  -bn, --blastn         excute blastn and not blastp
  -w WINDOW, --window WINDOW
                        window size (default=1000)
  -ss SECRETION_SYSTEMS, --secretion_systems SECRETION_SYSTEMS
                        macsyfinder table
  -c, --condensed       condensed display (for mor tracks)
  -lf LABEL_FILE, --label_file LABEL_FILE
                        label file ==> tab file with: contig, start, end label
                        (and color)
  -lt LOCUS_TAXONOMY, --locus_taxonomy LOCUS_TAXONOMY
                        Color locus based on taxonomy: tab delimited file
                        with: locus phylum. Color locus matching the Taxon set
                        in comment as the first row (#Chlamydiae)
  -f, --force           Don't prompt before every removal
```

