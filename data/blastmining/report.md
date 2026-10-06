# blastmining CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| blastmining_besthit | PASS |  |
| blastmining_full_pipeline | PASS |  |
| blastmining_lca | PASS |  |
| blastmining_vote | PASS |  |
| blastmining_voteSpecies | PASS |  |

## blastmining_vote

### Tool Description
blastMining: voting method with pident cut-off

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining vote [-h] [-v] -i INPUT -o OUTDIR [-e EVALUE]
                        [-txl TAXA_LEVEL] [-n TOPN] [-sm SAMPLE_NAME]
                        [-j JOBS] [-p PREFIX] [-kp] [-rm]

blastMining: voting method with pident cut-off

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        blast.out file. Please use this blast outfmt 6 ONLY:
                        ("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")
                        [required]
  -o OUTDIR, --outdir OUTDIR
                        Output directory
                        [required]
  -e EVALUE, --evalue EVALUE
                        Threshold of evalue
                        (Ignore hits if their evalues are above this threshold)
                        [default=1-e3]
  -txl TAXA_LEVEL, --taxa_level TAXA_LEVEL
                        P.identity cut-off for Kingdom,Phylum,Class,Order,Family,Genus,Species
                        A comma separated list of integers as an argument
                        [default=99,97,95,90,85,80,75]
  -n TOPN, --topN TOPN  Top N hits used for voting
                        [default=10]
  -sm SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Sample name in the print out table
                        [default="sample"]
  -j JOBS, --jobs JOBS  Number of jobs to run parallelly
                        [default=1]
  -p PREFIX, --prefix PREFIX
                        Output prefix
                        [default='vote_method']
  -kp, --krona_plot     Draw krona plot
                        [default=False]
  -rm, --rm_tmpdir      Remove temporary directory (TMPDIR)
                        [default=False]
```

## blastmining_voteSpecies

### Tool Description
blastMining: vote at species level for all

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining voteSpecies [-h] [-v] -i INPUT -o OUTDIR [-e EVALUE]
                               [-pi PIDENT] [-n TOPN] [-sm SAMPLE_NAME]
                               [-j JOBS] [-p PREFIX] [-kp] [-rm]

blastMining: vote at species level for all

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        blast.out file. Please use this blast outfmt 6 ONLY:
                        ("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")
                        [required]
  -o OUTDIR, --outdir OUTDIR
                        Output directory
                        [required]
  -e EVALUE, --evalue EVALUE
                        Threshold of evalue
                        (Ignore hits if their evalues are above this threshold)
                        [default=1-e3]
  -pi PIDENT, --pident PIDENT
                        Threshold of p. identity
                        (Ignore hits if their p. identities are below this threshold)
                        [default=99]
  -n TOPN, --topN TOPN  Top N hits used for voting
                        [default=10]
  -sm SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Sample name in the print out table
                        [default="sample"]
  -j JOBS, --jobs JOBS  Number of jobs to run parallelly
                        [default=1]
  -p PREFIX, --prefix PREFIX
                        Output prefix
                        [default='voteSpecies_method']
  -kp, --krona_plot     Draw krona plot
                        [default=False]
  -rm, --rm_tmpdir      Remove temporary directory (TMPDIR)
                        [default=False]
```

## blastmining_lca

### Tool Description
blastMining: lca method

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining lca [-h] [-v] -i INPUT -o OUTDIR [-e EVALUE] [-pi PIDENT]
                       [-n TOPN] [-sm SAMPLE_NAME] [-j JOBS] [-p PREFIX] [-kp]
                       [-rm]

blastMining: lca method

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        blast.out file. Please use this blast outfmt 6 ONLY:
                        ("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")
                        [required]
  -o OUTDIR, --outdir OUTDIR
                        Output directory
                        [required]
  -e EVALUE, --evalue EVALUE
                        Threshold of evalue
                        (Ignore hits if their evalues are above this threshold)
                        [default=1-e3]
  -pi PIDENT, --pident PIDENT
                        Threshold of p. identity
                        (Ignore hits if their p. identities are below this threshold)
                        [default=97]
  -n TOPN, --topN TOPN  Top N hits used for LCA calculation
                        [default=10]
  -sm SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Sample name in the print out table
                        [default="sample"]
  -j JOBS, --jobs JOBS  Number of jobs to run parallelly
                        [default=1]
  -p PREFIX, --prefix PREFIX
                        Output prefix
                        [default='lca_method']
  -kp, --krona_plot     Draw krona plot
                        [default=False]
  -rm, --rm_tmpdir      Remove temporary directory (TMPDIR)
                        [default=False]
```

## blastmining_besthit

### Tool Description
blastMining: besthit method

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining besthit [-h] [-v] -i INPUT -o OUTDIR [-e EVALUE]
                           [-pi PIDENT] [-n TOPN] [-sm SAMPLE_NAME] [-j JOBS]
                           [-p PREFIX] [-kp] [-rm]

blastMining: besthit method

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        Input file. Please use this blast outfmt 6 ONLY:
                        ("qseqid","sseqid","pident","length","mismatch","gapopen","evalue","bitscore","staxid")
                        [required]
  -o OUTDIR, --outdir OUTDIR
                        Output directory
                        [required]
  -e EVALUE, --evalue EVALUE
                        Threshold of evalue
                        (Ignore hits if their evalues are above this threshold)
                        [default=1-e3]
  -pi PIDENT, --pident PIDENT
                        Threshold of p. identity 
                        (Ignore hits if their p. identities are below this threshold)
                        [default=97]
  -n TOPN, --topN TOPN  Top N hits used for sorting
                        [default=10]
  -sm SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Sample name in the print out table
                        [default="sample"]
  -j JOBS, --jobs JOBS  Number of jobs to run parallelly
                        [default=1]
  -p PREFIX, --prefix PREFIX
                        Output prefix
                        [default='besthit_method']
  -kp, --krona_plot     Draw krona plot
                        [default=False]
  -rm, --rm_tmpdir      Remove temporary directory (TMPDIR)
                        [default=False]
```

## blastmining_full_pipeline

### Tool Description
blastMining: Running BLAST + mining the output 

### Metadata
- **Docker Image**: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
- **Homepage**: https://github.com/NuruddinKhoiry/blastMining
- **Package**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blastmining/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NuruddinKhoiry/blastMining
- **Stars**: N/A
### Original Help Text
```text
usage: blastMining full_pipeline [-h] [-v] -i INPUT -o OUTDIR -bp BLAST_PARAM
                                 [-m MINING] [-e EVALUE] [-pi PIDENT]
                                 [-txl TAXA_LEVEL] [-n TOPN] [-sm SAMPLE_NAME]
                                 [-j JOBS] [-p PREFIX] [-kp] [-rm]

blastMining: Running BLAST + mining the output 

blastMining v.1.2.0

Written by: Ahmad Nuruddin Khoiri (nuruddinkhoiri34@gmail.com)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i INPUT, --input INPUT
                        input FASTA
                        [required]
  -o OUTDIR, --outdir OUTDIR
                        Output directory
                        [required]
  -bp BLAST_PARAM, --blast_param BLAST_PARAM
                        BLAST parameters:
                        Note: "-outfmt" has been defined by the package, you don't need to add it
                        [default="-db nt -num_threads 1 -max_target_seqs 10"]
  -m MINING, --mining MINING
                        blastMining method 
                        Available methods={'vote','voteSpecies','lca','besthit'}
                        [default='vote']
  -e EVALUE, --evalue EVALUE
                        Threshold of evalue 
                        (Ignore hits if their evalues are above this threshold)
                        [default=1-e3]
  -pi PIDENT, --pident PIDENT
                        Threshold of p. identity 
                        (Ignore hits if their p. identities are below this threshold)
                        [default=97]
                        **Required** for "voteSpecies, lca, and besthit methods"
                        **Not compatible** with "vote method"
  -txl TAXA_LEVEL, --taxa_level TAXA_LEVEL
                        P.identity cut-off for Kingdom,Phylum,Class,Order,Family,Genus,Species
                        [default=99,97,95,90,85,80,75]
                        **Required** for "vote method"
                        **Not compatible** with "voteSpecies, lca, and besthit methods"
  -n TOPN, --topN TOPN  Top N hits used for voting
                        [default=10]
  -sm SAMPLE_NAME, --sample_name SAMPLE_NAME
                        Sample name in the print out table
                        [default="sample"]
  -j JOBS, --jobs JOBS  Number of jobs to run parallelly
                        [default=1]
  -p PREFIX, --prefix PREFIX
                        Output prefix
                        [default='blastMining']
  -kp, --krona_plot     Draw krona plot
                        [default=False]
  -rm, --rm_tmpdir      Remove temporary directory (TMPDIR)
                        [default=False]
```
