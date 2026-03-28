# proovframe CWL Generation Report

## proovframe_map

### Tool Description
For consensus sequences with rather low expected error rates
and if your reference database has a good represention of similar
sequences, you might want to switch to '-m fast' or '-m sensitive'
to speed things up.
Also note, I've experienced inefficient parallelization if
correcting a small number of Mb sized genomes (as opposed to thousands
of long-reads) - presumably because diamond threads on a per-sequence
basis

### Metadata
- **Docker Image**: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
- **Homepage**: https://github.com/thackl/proovframe
- **Package**: https://anaconda.org/channels/bioconda/packages/proovframe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proovframe/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/thackl/proovframe
- **Stars**: N/A
### Original Help Text
```text
Usage: proovframe map [-a|-d proteins] -o alignments.o6 seqs.fa -- extra-diamond-params
 -a/--aa              protein file, not required if db provided.
 -d/--db              created if not existing and --aa given [basename(aa).dmnd]
 -o/--out             write alignments to this file [basename(seqs).o6]
 -t/--threads         number of CPU threads
 -m/--diamond-mode    one of fast,sensitive,{mid,more,very,ultra}-sensitive' [more-sensitive]
 -y/--dry-run         print the diamond command, but don't run it
 -h/--help            show this help
 -D/--debug           show debug messages

For consensus sequences with rather low expected error rates
and if your reference database has a good represention of similar
sequences, you might want to switch to '-m fast' or '-m sensitive'
to speed things up.
Also note, I've experienced inefficient parallelization if
correcting a small number of Mb sized genomes (as opposed to thousands
of long-reads) - presumably because diamond threads on a per-sequence
basis
```


## proovframe_fix

### Tool Description
Fixes frameshifts in sequences based on Diamond output.

### Metadata
- **Docker Image**: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
- **Homepage**: https://github.com/thackl/proovframe
- **Package**: https://anaconda.org/channels/bioconda/packages/proovframe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: proovframe fix seqs.fa diamond.tsv > out
 -g/--genetic-code      genetic code table, sets stop codons [11]
 -S/--no-stop-masking   disable internal stop codon masking
 -o/--out               write to this file [STDOUT]
 -h/--help              show this help
 -D/--debug             show debug messages

diamond.tsv - diamond long-reads mode blastx 6 with extra cigar columns
```


## proovframe_prf

### Tool Description
Assess error rate of a query sequence against a reference sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
- **Homepage**: https://github.com/thackl/proovframe
- **Package**: https://anaconda.org/channels/bioconda/packages/proovframe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: proovframe error ref.fa qry.fa
 -n/--num-reads       only assess first [1000]
 -m/--min-map-frac    only assess seqs with at least this fraction aligned [0.8]
 -o/--out             write to this file [STDOUT]
 -h/--help            show this help
 -D/--debug           show debug messages

Requires minimap2 and seqkit in PATH
```


## Metadata
- **Skill**: generated
