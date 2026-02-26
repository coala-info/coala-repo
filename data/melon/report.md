# melon CWL Generation Report

## melon

### Tool Description
Melon v0.3.0: metagenomic long-read-based taxonomic identification and quantification using marker genes

### Metadata
- **Docker Image**: quay.io/biocontainers/melon:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/xinehc/melon
- **Package**: https://anaconda.org/channels/bioconda/packages/melon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/melon/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-04-27
- **GitHub**: https://github.com/xinehc/melon
- **Stars**: N/A
### Original Help Text
```text
Usage: melon -d DIR -o DIR [-t INT] [-k DIR] [--skip-profile] [--skip-clean]
             [-m INT] [-e FLOAT] [-i FLOAT] [-s FLOAT] [-n INT] [-p FLOAT]
             [-g INT] [-a INT] [-c FLOAT]
             file [file ...]

Melon v0.3.0: metagenomic long-read-based taxonomic identification and
quantification using marker genes

Positional Arguments:
  file                 Input fasta <*.fa|*.fasta> or fastq <*.fq|*.fastq>
                       file, gzip optional <*.gz>.

Required Arguments:
  -d, --db DIR         Unzipped database folder, should contains <prot.fa>,
                       <nucl.*.fa> and <metadata.tsv>. (default: None)
  -o, --output DIR     Output folder. (default: None)

Optional Arguments:
  -t, --threads INT    Number of threads. [20] (default: 20)
  -k, --db-kraken DIR  Unzipped kraken2 database for pre-filtering of
                       non-prokaryotic reads. Skip if not given. (default:
                       None)
  --skip-profile       Skip profiling, output only total genome copies.
                       (default: False)
  --skip-clean         Skip cleaning, keep all temporary <*.tmp> files.
                       (default: False)

Additional Arguments - Filtering:
  -m INT               Max. number of target sequences to report
                       (--max-target-seqs/-k in diamond). (default: 25)
  -e FLOAT             Max. expected value to report alignments (--evalue/-e
                       in diamond). (default: 1e-15)
  -i FLOAT             Min. identity in percentage to report alignments (--id
                       in diamond). (default: 0)
  -s FLOAT             Min. subject cover to report alignments
                       (--subject-cover in diamond). (default: 75)
  -n INT               Max. number of secondary alignments to report (-N in
                       minimap2). (default: 2147483647)
  -p FLOAT             Min. secondary-to-primary score ratio to report
                       secondary alignments (-p in minimap2). (default: 0.9)
  -g INT               Min. number of unique marker genes required for a
                       species to report its genome copies. (default: 2)

Additional Arguments - Fitting:
  -a INT               Terminal condition for EM - max. iterations. (default:
                       1000)
  -c FLOAT             Terminal condition for EM - epsilon (precision).
                       (default: 1e-10)
```

