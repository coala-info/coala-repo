# gfftk CWL Generation Report

## gfftk_consensus

### Tool Description
EvidenceModeler-like tool to generate consensus gene predictions. All gene models are loaded and sorted into loci based on genomic location, in each locus the gene models are scored based on: 1) overlap with protein/transcript evidence 2) AED score in relation to all models at that locus 3) user supplied source weights 4) de novo source weights estimated from evidence overlaps 5) for each locus the gene model with highest score is retained.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/nextgenusfs/gfftk
- **Stars**: N/A
### Original Help Text
```text
usage: gfftk consensus -f FASTA -g GENES -o OUT [-p] [-t] [-r] [-w] [-n] [-m]
                       [--repeat-overlap] [--min-exon] [--max-exon]
                       [--min-intron] [--max-intron] [-l] [--silent] [--debug]
                       [-h] [--version]

EvidenceModeler-like tool to generate consensus gene predictions. All gene
models are loaded and sorted into loci based on genomic location, in each
locus the gene models are scored based on:
 1) overlap with protein/transcript evidence
 2) AED score in relation to all models at that locus
 3) user supplied source weights
 4) de novo source weights estimated from evidence overlaps
 5) for each locus the gene model with highest score is retained.

Required arguments:
  -f FASTA, --fasta FASTA
                          genome in FASTA format
  -g GENES, --genes GENES
                          gene model predictions in GFF3 format [accepts
                          multiple files: space separated]
  -o OUT, --out OUT       output in GFF3 format

Optional arguments:
  -p , --proteins         protein alignments in GFF3 format [accepts multiple
                          files: space separated] (default: [])
  -t , --transcripts      transcripts alignments in GFF3 format [accepts
                          multiple files: space separated] (default: [])
  -r , --repeats          repeat alignments in BED or GFF3 format
  -w , --weights          user supplied source weights [accepts multiple:
                          space separated source:weight] (default: [])
  -n , --num-processes    number of processes to use for parallel execution
                          (default: number of CPU cores)
  -m , --minscore         minimum score to retain gene model (default: auto)
  --repeat-overlap        percent gene model overlap with repeats to remove
                          (default: 90)
  --min-exon              minimum exon length (default: 3)
  --max-exon              maximum exon length (default: -1)
  --min-intron            minimum intron length (default: 10)
  --max-intron            maximum intron length (default: -1)
  -l , --logfile          write logs to file
  --silent                do not write anything to terminal/stderr (default:
                          False)
  --debug                 write/keep intermediate files (default: False)

Other arguments:
  -h, --help              show this help message and exit
  --version               show program's version number and exit
```


## gfftk_convert

### Tool Description
convert GFF3/tbl format into another format [output gff3, gtf, tbl, gbff, fasta, combined]

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfftk convert [-f FASTA] -i INPUT [-o] [--input-format]
                     [--output-format] [--table] [-n] [--organism] [--strain]
                     [--grep] [--grepv] [--debug] [--url-encode] [-h]
                     [--version]

convert GFF3/tbl format into another format [output gff3, gtf, tbl, gbff,
fasta, combined].

Required arguments:
  -f FASTA, --fasta FASTA
                          genome in FASTA format (optional for combined
                          GFF3+FASTA files)
  -i INPUT, --input INPUT
                          annotation in GFF3 or TBL format

Optional arguments:
  -o , --out              write converted output to file (default: stdout)
  --input-format          format of input file [gff3, gtf, tbl]. (default:
                          auto)
  --output-format         format of output file [gff3, gtf, tbl, gbff,
                          proteins, transcripts, cds-transcripts, combined].
                          (default: auto)
  --table                 Codon table. Default: 1 [1,11]
  -n, --no-stop           for proteins output, do not write stop codons (*)
                          (default: False)
  --organism              Organism name, eg. 'Aspergillus fumigatus'
  --strain                Strain name, eg. CBS1001
  --grep                  Filter gene models, keep matches. [key:value]
                          (default: [])
  --grepv                 Filter gene models, remove matches [key:value]
                          (default: [])
  --debug                 write parsing errors to stderr (default: False)
  --url-encode            URL encode attribute values in GFF3 output for
                          downstream tool compatibility (default: False)

Other arguments:
  -h, --help              show this help message and exit
  --version               show program's version number and exit
```


## gfftk_sanitize

### Tool Description
sanitize GFF3 file, load GFF3 and output cleaned up GFF3 output.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfftk sanitize [-f] -g  [-o] [--debug] [--url-encode] [-h] [--version]

sanitize GFF3 file, load GFF3 and output cleaned up GFF3 output.

Required arguments:
  -f , --fasta   genome in FASTA format (optional for combined GFF3+FASTA
                 files)
  -g , --gff3    annotation in GFF3 format (or combined GFF3+FASTA)

Optional arguments:
  -o , --out     write santized GFF3 output to file (default: stdout)
  --debug        write/keep intermediate files (default: False)
  --url-encode   URL encode attribute values in GFF3 output for downstream
                 tool compatibility (default: False)

Other arguments:
  -h, --help     show this help message and exit
  --version      show program's version number and exit
```


## gfftk_rename

### Tool Description
rename gene models in GFF3 annotation file. Script will sort genes by contig and location and then rename using --locus-tag, ie PREFIX_000001.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfftk rename -f  -g  -l  [-o] [-n] [-h] [--version]

rename gene models in GFF3 annotation file. Script will sort genes by contig
and location and then rename using --locus-tag, ie PREFIX_000001.

Required arguments:
  -f , --fasta       genome in FASTA format
  -g , --gff3        annotation in GFF3 format
  -l , --locus-tag   Locus tag for gene names

Optional arguments:
  -o , --out         write santized GFF3 output to file (default: stdout)
  -n , --numbering   start locus tag numbering (default: 1)

Other arguments:
  -h, --help         show this help message and exit
  --version          show program's version number and exit
```


## gfftk_stats

### Tool Description
parse annotation GFF3/tbl and output summary statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfftk stats -f  -i  [-o] [--input-format] [--debug] [-h] [--version]

parse annotation GFF3/tbl and output summary statistics.

Required arguments:
  -f , --fasta     genome in FASTA format
  -i , --input     annotation in GFF3 or TBL format

Optional arguments:
  -o , --out       write converted output to file (default: stdout)
  --input-format   format of input file [gff3, tbl]. (default: auto)
  --debug          write parsing errors to stderr (default: False)

Other arguments:
  -h, --help       show this help message and exit
  --version        show program's version number and exit
```


## gfftk_compare

### Tool Description
compare two GFF3 annotations of a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
- **Homepage**: https://github.com/nextgenusfs/gfftk
- **Package**: https://anaconda.org/channels/bioconda/packages/gfftk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gfftk compare -f  -q  -r  [-o] [--debug] [-h] [--version]

compare two GFF3 annotations of a genome.

Required arguments:
  -f , --fasta       genome in FASTA format
  -q , --query       query annotation in GFF3 format
  -r , --reference   query annotation in GFF3 format

Optional arguments:
  -o , --out         write converted output to file (default: stdout)
  --debug            write parsing errors to stderr (default: False)

Other arguments:
  -h, --help         show this help message and exit
  --version          show program's version number and exit
```


## Metadata
- **Skill**: generated
