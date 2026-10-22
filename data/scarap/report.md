# scarap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scarap_build | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_checkgenomes | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_checkgroups | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_concat | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_core | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_fetch | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_filter | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_pan | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_sample | PASS | 3 Mycoplasma proteomes from UniProt (real data) |
| scarap_search | PASS | 3 Mycoplasma proteomes from UniProt (real data) |

## scarap_pan

### Tool Description
Infer a pangenome from a set of faa files.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap pan [-h] [-d {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}] [-i MIN_REPS]
                  [-a MAX_REPS] [-x MAX_ALIGN] [-s SPECIES] [-t THREADS] [-c]
                  faa-files outfolder

positional arguments:
  faa-files             folder with one fasta file with amino acid sequences
                        (faa file) per genome, or file with paths to faa files
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -d {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}, --method {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}
                        pangenome inference method [default: FH]
  -i MIN_REPS, --min-reps MIN_REPS
                        minimum number of representative sequences to use for
                        multiple sequence alignment [default 32]
  -a MAX_REPS, --max-reps MAX_REPS
                        maximum number of representative sequences to use for
                        multiple sequence alignment [default MIN_REPS * 1.25]
  -x MAX_ALIGN, --max-align MAX_ALIGN
                        maximum number of sequences to use for multiple
                        sequence alignment [default MAX_REPS * 16]
  -s SPECIES, --species SPECIES
                        input file with species of genomes; if given, a
                        hierarchical pangenome strategy will be used for final
                        database selection
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_core

### Tool Description
Infer a core genome from a set of faa files.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap core [-h] [-d {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}] [-i MIN_REPS]
                   [-a MAX_REPS] [-x MAX_ALIGN] [-e SEEDS] [-p CORE_PREFILTER]
                   [-f CORE_FILTER] [-m MAX_CORE_GENES] [-t THREADS] [-c]
                   faa-files outfolder

positional arguments:
  faa-files             folder with one fasta file with amino acid sequences
                        (faa file) per genome, or file with paths to faa files
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -d {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}, --method {H,FH,FT,H-nl,T-nl,P,O-B,O-D,S}
                        pangenome inference method [default: FH]
  -i MIN_REPS, --min-reps MIN_REPS
                        minimum number of representative sequences to use for
                        multiple sequence alignment [default 32]
  -a MAX_REPS, --max-reps MAX_REPS
                        maximum number of representative sequences to use for
                        multiple sequence alignment [default MIN_REPS * 1.25]
  -x MAX_ALIGN, --max-align MAX_ALIGN
                        maximum number of sequences to use for multiple
                        sequence alignment [default MAX_REPS * 16]
  -e SEEDS, --seeds SEEDS
                        number of seed genomes to use [default 100]
  -p CORE_PREFILTER, --core-prefilter CORE_PREFILTER
                        minimum relative frequency of single-copy presence to
                        be used for initial database construction [default
                        0.90]
  -f CORE_FILTER, --core-filter CORE_FILTER
                        minimum relative frequency of single-copy presence to
                        be used for [default 0.95]
  -m MAX_CORE_GENES, --max-core-genes MAX_CORE_GENES
                        maximum number of core genes to retrieve (0 = no
                        maximum) [default 0]
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_build

### Tool Description
Build a profile database for a core genome or pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap build [-h] [-p CORE_PREFILTER] [-f CORE_FILTER]
                    [-m MAX_CORE_GENES] [-t THREADS] [-c]
                    faa-files pangenome outfolder

positional arguments:
  faa-files             folder with one fasta file with amino acid sequences
                        (faa file) per genome, or file with paths to faa files
  pangenome             input file with pangenome
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -p CORE_PREFILTER, --core-prefilter CORE_PREFILTER
                        minimum relative frequency of single-copy presence to
                        be used for initial database construction [default 0]
  -f CORE_FILTER, --core-filter CORE_FILTER
                        minimum relative frequency of single-copy presence to
                        be used for [default 0]
  -m MAX_CORE_GENES, --max-core-genes MAX_CORE_GENES
                        maximum number of core genes to retrieve (0 = no
                        maximum) [default 0]
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_search

### Tool Description
Search query genes in a profile database.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap search [-h] [-t THREADS] [-c] faa-files db outfolder

positional arguments:
  faa-files             folder with one fasta file with amino acid sequences
                        (faa file) per genome, or file with paths to faa files
  db                    input database containing alignments and profile score
                        cutoffs
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_checkgenomes

### Tool Description
Assess the genomes in a core genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap checkgenomes [-h] [-c] coregenome outfolder

positional arguments:
  coregenome  input file with a core genome
  outfolder   output folder

options:
  -h, --help  show this help message and exit
  -c, --cont  continue in existing output folder [default False]
```

## scarap_checkgroups

### Tool Description
Assess the orthogroups in a core genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap checkgroups [-h] [-c] coregenome outfolder

positional arguments:
  coregenome  input file with a core genome
  outfolder   output folder

options:
  -h, --help  show this help message and exit
  -c, --cont  continue in existing output folder [default False]
```

## scarap_filter

### Tool Description
Filter the genomes or orthogroups in a pangenome.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap filter [-h] [-g GENOMES] [-o ORTHOGROUPS] [-c]
                     pangenome outfolder

positional arguments:
  pangenome             input file with pangenome
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -g GENOMES, --genomes GENOMES
                        input file with genomes to extract from pangenome
  -o ORTHOGROUPS, --orthogroups ORTHOGROUPS
                        input file with orthogroups to extract from pangenome
  -c, --cont            continue in existing output folder [default False]
```

## scarap_concat

### Tool Description
Construct a concatenated core orthogroup alignment from a core genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap concat [-h] [-f CORE_FILTER] [-m MAX_CORE_GENES] [-n FFN_FILES]
                     [-t THREADS] [-c]
                     faa-files pangenome outfolder

positional arguments:
  faa-files             folder with one fasta file with amino acid sequences
                        (faa file) per genome, or file with paths to faa files
  pangenome             input file with pangenome
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -f CORE_FILTER, --core-filter CORE_FILTER
                        minimum relative frequency of single-copy presence to
                        be used for [default 0]
  -m MAX_CORE_GENES, --max-core-genes MAX_CORE_GENES
                        maximum number of core genes to retrieve (0 = no
                        maximum) [default 0]
  -n FFN_FILES, --ffn-files FFN_FILES
                        file with paths to or folder with ffn files of
                        genomes; if given, a nucleotide supermatrix will be
                        constructed in addition to the amino acid suprmatrix
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_sample

### Tool Description
Sample a subset of representative genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap sample [-h] [-m MAX_GENOMES] [-i IDENTITY] [-d METHOD] [-x]
                     [-t THREADS] [-c]
                     fasta-files pangenome outfolder

positional arguments:
  fasta-files           folder with one fasta file with amino acid sequences
                        (faa file) or one fasta file with nucleic acid
                        sequences (ffn file) per genome, or a file with paths
                        to faa/ffn files
  pangenome             input file with pangenome
  outfolder             output folder

options:
  -h, --help            show this help message and exit
  -m MAX_GENOMES, --max-genomes MAX_GENOMES
                        maximum number of genomes to sample (0 = no maximum)
                        [default 0]
  -i IDENTITY, --identity IDENTITY
                        maximum sequence identity between sampled genomes
                        [default 1]
  -d METHOD, --method METHOD
                        genome-genome comparison method [default: mean]
  -x, --exact           perform full alignments [default False]
  -t THREADS, --threads THREADS
                        number of threads to use
  -c, --cont            continue in existing output folder [default False]
```

## scarap_fetch

### Tool Description
Fetch sequences and store them in a fasta file per orthogroup.

### Metadata
- **Docker Image**: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/SWittouck/SCARAP
- **Package**: https://anaconda.org/channels/bioconda/packages/scarap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scarap fetch [-h] [-c] fasta-files pangenome outfolder

positional arguments:
  fasta-files  folder with one fasta file with amino acid sequences (faa file)
               or one fasta file with nucleic acid sequences (ffn file) per
               genome, or a file with paths to faa/ffn files
  pangenome    input file with pangenome
  outfolder    output folder

options:
  -h, --help   show this help message and exit
  -c, --cont   continue in existing output folder [default False]
```

