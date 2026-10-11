# oatk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| oatk | PASS |  |
| oatk_path_to_fasta | PASS |  |
| oatk_pathfinder | PASS |  |
| oatk_syncasm | PASS |  |

## oatk

### Tool Description
Assembly and annotation of mitochondrial and plastid genomes


## Metadata
- **Docker Image**: quay.io/biocontainers/oatk:1.0--h577a1d6_1
- **Homepage**: https://github.com/c-zhou/oatk
- **Package**: https://anaconda.org/channels/bioconda/packages/oatk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oatk/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/c-zhou/oatk
- **Stars**: N/A
### Original Help Text
```text
Usage: oatk [options] <target.fa[stq][.gz]> [...]
Options:
  Input/Output:
    -o FILE              prefix of output files [./oatk.asm]
    -t INT               number of threads [1]
    -G                   using input FILE as assembly graph file instead of raw reads for Syncasm
    -M                   run minicircle mode for small animal mitochondria or plasmid
    -v INT               verbose level [0]
    --version            show version number
  Syncasm:
    -k INT               kmer size [1001]
    -s INT               smer size (no larger than 31) [31]
    -c INT               minimum kmer coverage [30]
    -a FLOAT             minimum arc coverage [0.35]
    -D INT               maximum amount of data to use; suffix K/M/G recognized [0]
    --max-bubble  INT    maximum bubble size for assembly graph clean [100000]
    --max-tip     INT    maximum tip size for assembly graph clean [10000]
    --weak-cross  FLOAT  maximum relative edge coverage for weak crosslink clean [0.30]
    --unzip-round INT    maximum round of assembly graph unzipping [3]
    --no-read-ec         do not do read error correction
  Annotation:
    -m FILE              mitochondria gene annotation HMM profile database [NULL]
    -p FILE              plastid gene annotation HMM profile database [NULL]
    -b INT               batch size [100000]
    -T DIR               temporary directory [NULL]
    --nhmmscan STR       nhmmscan executable path [nhmmscan]
  Pathfinder:
    -f FLOAT             prefer circular path to longest if >= FLOAT sequence covered [0.90]
    -S FLOAT             minimum annotation score of a core gene [300.0]
    -e FLOAT             maximum E-value of a core gene [1.000e-06]
    -g INT[,INT]         minimum number of core gene gain; the second INT for mitochondria [3,1]
    -l INT               minimum length of a singleton sequence to keep [10000]
    -q FLOAT             minimum coverage of a sequence compared to the subgraph average [0.20]
    -C INT               maximum copy number to consider [10]
    --include-trn        include tRNA genes for sequence classification
    --include-rrn        include rRNA genes for sequence classification
    --no-graph-clean     do not do assembly graph clean
    --edge-c-tag STR     edge coverage tag in the GFA file [EC:i] 
    --kmer-c-tag STR     kmer coverage tag in the GFA file [KC:i] 
    --seq-c-tag  STR     sequence coverage tag in the GFA file [SC:f]

Example: ./oatk -o oatk.asm -t 16 -m angiosperm_mito.fam -p angiosperm_pltd.fam hifi.fa.gz
```


## oatk_syncasm

### Tool Description
De novo HiFi read assembler using a sparse de Bruijn graph built from closed syncmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/oatk:1.0--h577a1d6_1
- **Homepage**: https://github.com/c-zhou/oatk
- **Package**: https://anaconda.org/channels/bioconda/packages/oatk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: syncasm [options] <target.fa[stq][.gz]> [...]
Options:
    -k INT               kmer size [1001]
    -s INT               smer size (no larger than 31) [31]
    -c INT               minimum kmer coverage [3]
    -a FLOAT             minimum arc coverage [0.35]
    -D INT               maximum amount of data to use; suffix K/M/G recognized [0]
    -t INT               number of threads [1]
    -o FILE              prefix of output files [syncasm.asm]
    --max-bubble  INT    maximum bubble size for assembly graph clean [100000]
    --max-tip     INT    maximum tip size for assembly graph clean [10000]
    --weak-cross  FLOAT  maximum relative edge coverage for weak crosslink clean [0.30]
    --unzip-round INT    maximum round of assembly graph unzipping [3]
    --no-read-ec         do not do read error correction
    -v INT               verbose level [0]
    --version            show version number

Example: ./syncasm -k 1001 -c 50 -t 8 -o syncasm.asm hifi.fa.gz
```


## oatk_pathfinder

### Tool Description
Parses and circularises organelle genomes from an assembly graph using core gene annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/oatk:1.0--h577a1d6_1
- **Homepage**: https://github.com/c-zhou/oatk
- **Package**: https://anaconda.org/channels/bioconda/packages/oatk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: pathfinder [options] <file>[.gfa[.gz]]
Options:
  Input/Output:
    -m FILE              mitochondria core gene annotation file [NULL]
    -p FILE              plastid core gene annotation file [NULL]
    -o FILE              prefix of output files [oatk.asm]
    -f FLOAT             prefer circular path to longest if >= FLOAT sequence covered [0.90]
    --edge-c-tag STR     edge coverage tag in the GFA file [EC:i] 
    --kmer-c-tag STR     kmer coverage tag in the GFA file [KC:i] 
    --seq-c-tag  STR     sequence coverage tag in the GFA file [SC:f]
    -v INT               verbose level [0]
    --version            show version number
  Classification:
    -s FLOAT             minimum annotation score of a core gene [300.0]
    -e FLOAT             maximum E-value of a core gene [1.000e-06]
    -g INT[,INT]         minimum number of core gene gain; the second INT for mitochondria [3,1]
    -l INT               minimum length of a singleton sequence to keep [10000]
    --include-trn        include tRNA genes for sequence classification
    --include-rrn        include rRNA genes for sequence classification
  Path-finding:
    -q FLOAT             minimum coverage of a sequence compared to the subgraph average [0.20]
    -c INT               maximum copy number to consider [10]
    --max-bubble INT     maximum bubble size for assembly graph clean [100000]
    --max-tip    INT     maximum tip size for assembly graph clean [10000]
    --weak-cross FLOAT   maximum relative edge coverage for weak crosslink clean [0.30]
    --no-graph-clean     do not do assembly graph clean

Example: ./pathfinder -m asm_annot.mito.txt -p asm_annot.pltd.txt -o oatk.asm asm.gfa
```


## oatk_path_to_fasta

### Tool Description
Extracts FASTA sequences from a GFA file given a path.

### Metadata
- **Docker Image**: quay.io/biocontainers/oatk:1.0--h577a1d6_1
- **Homepage**: https://github.com/c-zhou/oatk
- **Package**: https://anaconda.org/channels/bioconda/packages/oatk/overview
- **Validation**: PASS

### Original Help Text
```text

Usage: path_to_fasta [options] <file>[.gfa[.gz]] [path_str]
Options:
    -p STR        two-column path file
    -s STR        output sequence id
    -l INT        number of residues per line; 0 for 2^31-1 [60]
    -n INT        number of 'N' put between sequences with no links [100]
    -o FILE       output results to FILE [stdout]
    -v INT        verbose level [0]
    --linear      force linear output
    --version     show version number

Example: ./path_to_fasta asm.gfa u1+,u2-,u3-,u2+
```
