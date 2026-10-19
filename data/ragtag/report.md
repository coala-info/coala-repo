# ragtag CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ragtag_agp2fa | PASS |  |
| ragtag_agpcheck | PASS |  |
| ragtag_asmstats | PASS |  |
| ragtag_correct | PASS | output equals the Galaxy tools-iuc expected AGP and FASTA |
| ragtag_delta2paf | PASS |  |
| ragtag_merge | PASS | output equals the Galaxy tools-iuc expected AGP and FASTA |
| ragtag_paf2delta | PASS |  |
| ragtag_patch | PASS | output equals the Galaxy tools-iuc expected AGP and FASTA |
| ragtag_scaffold | PASS | output equals the Galaxy tools-iuc expected AGP and FASTA |
| ragtag_splitasm | PASS |  |
| ragtag_updategff | PASS | synthetic data: planted AGP shifts the real Galaxy GFF by 100 bp |


## ragtag_correct

### Tool Description
usage: ragtag.py correct <reference.fa> <query.fa>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py correct <reference.fa> <query.fa>

Homology-based misassembly correction: Correct sequences in 'query.fa' by
comparing them to sequences in 'reference.fa'>

positional arguments:
  <reference.fa>        reference fasta file (uncompressed or bgzipped)
  <query.fa>            query fasta file (uncompressed or bgzipped)

optional arguments:
  -h, --help            show this help message and exit

correction options:
  -f INT                minimum unique alignment length [1000]
  --remove-small        remove unique alignments shorter than -f
  -q INT                minimum mapq (NA for Nucmer alignments) [10]
  -d INT                maximum alignment merge distance [100000]
  -b INT                minimum break distance from contig ends [5000]
  -e <exclude.txt>      list of reference headers to ignore [null]
  -j <skip.txt>         list of query headers to leave uncorrected [null]
  --inter               only break misassemblies between reference sequences
  --intra               only break misassemblies within reference sequences
  --gff <features.gff>  don't break sequences within gff intervals [null]

input/output options:
  -o PATH               output directory [./ragtag_output]
  -w                    overwrite intermediate files
  -u                    add suffix to unaltered sequence headers

mapping options:
  -t INT                number of minimap2/unimap threads [1]
  --aligner PATH        whole genome aligner executable ('nucmer', 'unimap' or
                        'minimap2') [minimap2]
  --mm2-params STR      space delimited minimap2 whole genome alignment
                        parameters (overrides '-t') ['-x asm5']
  --unimap-params STR   space delimited unimap parameters (overrides '-t')
                        ['-x asm5']
  --nucmer-params STR   space delimted nucmer whole genome alignment
                        parameters ['--maxmatch -l 100 -c 500']

validation options:
  --read-aligner PATH   read aligner executable (only 'minimap2' is allowed)
                        [minimap2]
  -R <reads.fasta>      validation reads (uncompressed or gzipped) [null]
  -F <reads.fofn>       same as '-R', but a list of files [null]
  -T STR                read type. 'sr', 'ont' and 'corr' accepted for
                        Illumina, nanopore and error corrected long-reads,
                        respectively [null]
  -v INT                coverage validation window size [10000]
  --max-cov INT         break sequences at regions at or above this coverage
                        level [AUTO]
  --min-cov INT         break sequences at regions at or below this coverage
                        level [AUTO]
```

## ragtag_scaffold

### Tool Description
usage: ragtag.py scaffold <reference.fa> <query.fa>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py scaffold <reference.fa> <query.fa>

Homology-based assembly scaffolding: Order and orient sequences in 'query.fa'
by comparing them to sequences in 'reference.fa'

positional arguments:
  <reference.fa>       reference fasta file (uncompressed or bgzipped)
  <query.fa>           query fasta file (uncompressed or bgzipped)

optional arguments:
  -h, --help           show this help message and exit

scaffolding options:
  -e <exclude.txt>     list of reference sequences to ignore [null]
  -j <skip.txt>        list of query sequences to leave unplaced [null]
  -J <hard-skip.txt>   list of query headers to leave unplaced and exclude
                       from 'chr0' ('-C') [null]
  -f INT               minimum unique alignment length [1000]
  --remove-small       remove unique alignments shorter than '-f'
  -q INT               minimum mapq (NA for Nucmer alignments) [10]
  -d INT               maximum alignment merge distance [100000]
  -i FLOAT             minimum grouping confidence score [0.2]
  -a FLOAT             minimum location confidence score [0.0]
  -s FLOAT             minimum orientation confidence score [0.0]
  -C                   concatenate unplaced contigs and make 'chr0'
  -r                   infer gap sizes. if not, all gaps are 100 bp
  -g INT               minimum inferred gap size [100]
  -m INT               maximum inferred gap size [100000]

input/output options:
  -o PATH              output directory [./ragtag_output]
  -w                   overwrite intermediate files
  -u                   add suffix to unplaced sequence headers

mapping options:
  -t INT               number of minimap2/unimap threads [1]
  --aligner PATH       aligner executable ('nucmer', 'unimap' or 'minimap2')
                       [minimap2]
  --mm2-params STR     space delimited minimap2 parameters (overrides '-t')
                       ['-x asm5']
  --unimap-params STR  space delimited unimap parameters (overrides '-t') ['-x
                       asm5']
  --nucmer-params STR  space delimted nucmer parameters ['--maxmatch -l 100 -c
                       500']
```

## ragtag_patch

### Tool Description
usage: ragtag.py patch <target.fa> <query.fa>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py patch <target.fa> <query.fa>

Homology-based assembly patching: Make continuous joins and fill gaps in
'target.fa' using sequences from 'query.fa'

positional arguments:
  <target.fa>          target fasta file (uncompressed or bgzipped)
  <query.fa>           query fasta file (uncompressed or bgzipped)

optional arguments:
  -h, --help           show this help message and exit

patching:
  -e <exclude.txt>     list of target sequences to ignore [null]
  -j <skip.txt>        list of query sequences to ignore [null]
  -f INT               minimum unique alignment length [1000]
  --remove-small       remove unique alignments shorter than '-f'
  -q INT               minimum mapq (NA for Nucmer alignments) [10]
  -d INT               maximum alignment merge distance [100000]
  -s INT               minimum merged alignment length [50000]
  -i FLOAT             maximum merged alignment distance from sequence
                       terminus. fraction of the sequence length if < 1 [0.05]
  --fill-only          only fill existing target gaps. do not join target
                       sequences
  --join-only          only join and patch target sequences. do not fill
                       existing gaps

input/output options:
  -o PATH              output directory [./ragtag_output]
  -w                   overwrite intermediate files
  -u                   add suffix to unplaced sequence headers

mapping options:
  -t INT               number of minimap2/unimap threads [1]
  --aligner PATH       aligner executable ('nucmer' (recommended), 'unimap' or
                       'minimap2') [nucmer]
  --mm2-params STR     space delimited minimap2 parameters (overrides '-t')
                       ['-x asm5']
  --unimap-params STR  space delimited unimap parameters (overrides '-t') ['-x
                       asm5']
  --nucmer-params STR  space delimted nucmer parameters ['--maxmatch -l 100 -c
                       500']
```

## ragtag_merge

### Tool Description
usage: ragtag.py merge <asm.fa> <scf1.agp> <scf2.agp> [...]

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py merge <asm.fa> <scf1.agp> <scf2.agp> [...]

Scaffold merging: derive a consensus scaffolding solution by reconciling
distinct scaffoldings of 'asm.fa'

positional arguments:
  <asm.fasta>           assembly fasta file (uncompressed or bgzipped)
  <scf1.agp> <scf2.agp> [...]
                        scaffolding AGP files

optional arguments:
  -h, --help            show this help message and exit

merging options:
  -f FILE               CSV list of (AGP file,weight) [null]
  -j <skip.txt>         list of query headers to leave unplaced [null]
  -l INT                minimum assembly sequence length [100000]
  -e FLOAT              minimum edge weight. NA if using Hi-C [0.0]
  --gap-func STR        function for merging gap lengths {'min', 'max', or
                        'mean'} [min]

input/output options:
  -o PATH               output directory [./ragtag_output]
  -w                    overwrite intermediate files
  -u                    add suffix to unplaced sequence headers

Hi-C options:
  -b FILE               Hi-C alignments in BAM format, sorted by read name
                        [null]
  -r STR                CSV list of restriction enzymes/sites or 'DNase'
                        [GATC]
  -p FLOAT              portion of the sequence termini to consider for links
                        [1.0]
  --list-enzymes        list all available restriction enzymes/sites
```

## ragtag_agp2fa

### Tool Description
usage: ragtag.py agp2fa <scaffolds.agp> <components.fasta>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py agp2fa <scaffolds.agp> <components.fasta>

Build sequences in FASTA format from an AGP v2.1 file.

positional arguments:
  <scaffolds.agp>     AGP v2.1 file
  <components.fasta>  component FASTA file (can be uncompressed or bgzipped)

optional arguments:
  -h, --help          show this help message and exit
```

## ragtag_agpcheck

### Tool Description
usage: ragtag.py agpcheck <asm1.agp> [<asm2.agp> ... <asmN.agp>]

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py agpcheck <asm1.agp> [<asm2.agp> ... <asmN.agp>]

Check AGP v2.1 files for validity.

positional arguments:
  <asm1.agp> [<asm2.agp> ... <asmN.agp>]
                        AGP v2.1 files

optional arguments:
  -h, --help            show this help message and exit
```

## ragtag_asmstats

### Tool Description
usage: ragtag.py asmstats [options] <in.fa>|<in.fa.fai>|<in.fa.sizes>|<in.gfa>|<in.agp> [...]

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py asmstats [options] <in.fa>|<in.fa.fai>|<in.fa.sizes>|<in.gfa>|<in.agp> [...]

Calculate assembly sequence stats.

positional arguments:
  <in.fa>|<in.fa.fai>|<in.fa.sizes>|<in.gfa>|<in.agp> [...]
                        assembly files (bgzipped or uncompressed for FASTA)

optional arguments:
  -h, --help            show this help message and exit
  -g INT                genome size for NGx [null]
```

## ragtag_splitasm

### Tool Description
usage: ragtag.py splitasm <asm.fa>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py splitasm <asm.fa>

Split sequencs at gaps

positional arguments:
  <asm.fa>    assembly fasta file (uncompressed or bgzipped)

optional arguments:
  -h, --help  show this help message and exit
  -n INT      minimum gap size [0]
  -o PATH     output AGP file path [./ragtag.splitasm.agp]
```

## ragtag_delta2paf

### Tool Description
usage: ragtag.py delta2paf <alns.delta>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py delta2paf <alns.delta>

Convert a Nucmer delta file to a PAF file.

positional arguments:
  <alns.delta>  delta file to convert.

optional arguments:
  -h, --help    show this help message and exit
```

## ragtag_paf2delta

### Tool Description
usage: ragtag.py paf2delta <with-cg.paf>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py paf2delta <with-cg.paf>

Convert a PAF file to a Nucmer delta file. PAF file lines must have CIGAR
strings ('-c' when using Minimap2)

positional arguments:
  <with-cg.paf>  PAF file to convert (gzip allowed).

optional arguments:
  -h, --help     show this help message and exit
  -r PATH        PATH to there reference fasta file
  -q PATH        PATH to there query fasta file
```

## ragtag_updategff

### Tool Description
usage: ragtag.py updategff [-c] <genes.gff> <ragtag.agp>

### Metadata
- **Docker Image**: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
- **Homepage**: https://github.com/malonge/RagTag
- **Package**: https://anaconda.org/channels/bioconda/packages/ragtag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ragtag.py updategff [-c] <genes.gff> <ragtag.agp>

Update gff intervals given a RagTag AGP file

positional arguments:
  <genes.gff>     gff file
  <ragtag.*.agp>  agp file

optional arguments:
  -h, --help      show this help message and exit
  -c              update for misassembly correction (ragtag.correction.agp)
```

