# syngap CWL Generation Report

## syngap_initdb

### Tool Description
Initialize a new syngap database by importing a masterdb.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yanyew/SynGAP
- **Stars**: N/A
### Original Help Text
```text
usage: syngap initdb [-h] --sp SP --file FILE

options:
  -h, --help   show this help message and exit
  --sp SP      The species type of masterdb to be imported, plant|animal
               [required]
  --file FILE  The compressed file of masterdb (.tar.gz) to be imported
               [required]
```


## syngap_master

### Tool Description
This tool appears to be a master script for processing genomic data, likely involving species comparison and annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap master [-h] --sp SP --sp1fa SP1FA --sp1gff SP1GFF [--sp1 SP1]
                     [--annoType1 ANNOTYPE1] [--annoKey1 ANNOKEY1]
                     [--annoparentKey1 ANNOPARENTKEY1] [--datatype DATATYPE]
                     [--cscore CSCORE] [--threads THREADS] [--process PROCESS]
                     [--evalue EVALUE] [--rank RANK] [--coverage COVERAGE]
                     [--kmer1 KMER1] [--kmer2 KMER2] [--outs OUTS]
                     [--intron INTRON]

options:
  -h, --help            show this help message and exit
  --sp SP               The species type of the polished object, plant|animal
                        [required]
  --sp1fa SP1FA         The genome squence file (.fasta format) for species1
                        [required]
  --sp1gff SP1GFF       The genome annotation file (.gff format) for species1
                        [required]
  --sp1 SP1             The short name for species1, e.g. Ath [default: sp1]
  --annoType1 ANNOTYPE1
                        Feature type to extract for species1 [default: mRNA]
  --annoKey1 ANNOKEY1   Key in the attributes to extract for species1
                        [default: ID]
  --annoparentKey1 ANNOPARENTKEY1
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --datatype DATATYPE   The type of squences for jcvi, nucl|prot [default:
                        nucl]
  --cscore CSCORE       C-score cutoff for jcvi [default: 0.7]
  --threads THREADS     Number of threads to use [default: 8]
  --process PROCESS     Process for gapanno, genblastg|miniprot [default:
                        genblastg]
  --evalue EVALUE       Threshold for evalue in genBlast [default: 1e-5]
  --rank RANK           The number of ranks in genBlast output [default: 5]
  --coverage COVERAGE   Minimum percentage of query gene coverage of the HSP
                        group in the genBlast output [default: 0.5]
  --kmer1 KMER1         K-mer size for Indexing in miniprot [default: 5]
  --kmer2 KMER2         K-mer size for the second round of chaining in
                        miniprot [default: 4]
  --outs OUTS           Threshold of Score for miniprot output [default: 0.95]
  --intron INTRON       Max intron size allowed for miniprot output [default:
                        40k]
```


## syngap_dual

### Tool Description
Compare two species' genomes and annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap dual [-h] --sp1fa SP1FA --sp1gff SP1GFF --sp2fa SP2FA --sp2gff
                   SP2GFF [--sp1 SP1] [--sp2 SP2] [--annoType1 ANNOTYPE1]
                   [--annoKey1 ANNOKEY1] [--annoparentKey1 ANNOPARENTKEY1]
                   [--annoType2 ANNOTYPE2] [--annoKey2 ANNOKEY2]
                   [--annoparentKey2 ANNOPARENTKEY2] [--datatype DATATYPE]
                   [--cscore CSCORE] [--threads THREADS] [--process PROCESS]
                   [--evalue EVALUE] [--rank RANK] [--coverage COVERAGE]
                   [--kmer1 KMER1] [--kmer2 KMER2] [--outs OUTS]
                   [--intron INTRON]

options:
  -h, --help            show this help message and exit
  --sp1fa SP1FA         The genome squence file (.fasta format) for species1
                        [required]
  --sp1gff SP1GFF       The genome annotation file (.gff format) for species1
                        [required]
  --sp2fa SP2FA         The genome squence file (.fasta format) for species2
                        [required]
  --sp2gff SP2GFF       The genome annotation file (.gff format) for species2
                        [required]
  --sp1 SP1             The short name for species1, e.g. Ath [default: sp1]
  --sp2 SP2             The short name for species2, e.g. Ath [default: sp2]
  --annoType1 ANNOTYPE1
                        Feature type to extract for species1 [default: mRNA]
  --annoKey1 ANNOKEY1   Key in the attributes to extract for species1
                        [default: ID]
  --annoparentKey1 ANNOPARENTKEY1
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --annoType2 ANNOTYPE2
                        Feature type to extract for species2 [default: mRNA]
  --annoKey2 ANNOKEY2   Key in the attributes to extract for species2
                        [default: ID]
  --annoparentKey2 ANNOPARENTKEY2
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --datatype DATATYPE   The type of squences for jcvi, nucl|prot [default:
                        nucl]
  --cscore CSCORE       C-score cutoff for jcvi [default: 0.7]
  --threads THREADS     Number of threads to use [default: 8]
  --process PROCESS     Process for gapanno, genblastg|miniprot [default:
                        genblastg]
  --evalue EVALUE       Threshold for evalue in genBlast [default: 1e-5]
  --rank RANK           The number of ranks in genBlast output [default: 5]
  --coverage COVERAGE   Minimum percentage of query gene coverage of the HSP
                        group in the genBlast output [default: 0.5]
  --kmer1 KMER1         K-mer size for Indexing in miniprot [default: 5]
  --kmer2 KMER2         K-mer size for the second round of chaining in
                        miniprot [default: 4]
  --outs OUTS           Threshold of Score for miniprot output [default: 0.95]
  --intron INTRON       Max intron size allowed for miniprot output [default:
                        40k]
```


## syngap_triple

### Tool Description
Compare three species genomes and their annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap triple [-h] --sp1fa SP1FA --sp1gff SP1GFF --sp2fa SP2FA --sp2gff
                     SP2GFF --sp3fa SP3FA --sp3gff SP3GFF [--sp1 SP1]
                     [--sp2 SP2] [--sp3 SP3] [--annoType1 ANNOTYPE1]
                     [--annoKey1 ANNOKEY1] [--annoparentKey1 ANNOPARENTKEY1]
                     [--annoType2 ANNOTYPE2] [--annoKey2 ANNOKEY2]
                     [--annoparentKey2 ANNOPARENTKEY2] [--annoType3 ANNOTYPE3]
                     [--annoKey3 ANNOKEY3] [--annoparentKey3 ANNOPARENTKEY3]
                     [--datatype DATATYPE] [--cscore CSCORE]
                     [--threads THREADS] [--process PROCESS] [--evalue EVALUE]
                     [--rank RANK] [--coverage COVERAGE] [--kmer1 KMER1]
                     [--kmer2 KMER2] [--outs OUTS] [--intron INTRON]

options:
  -h, --help            show this help message and exit
  --sp1fa SP1FA         The genome squence file (.fasta format) for species1
                        [required]
  --sp1gff SP1GFF       The genome annotation file (.gff format) for species1
                        [required]
  --sp2fa SP2FA         The genome squence file (.fasta format) for species2
                        [required]
  --sp2gff SP2GFF       The genome annotation file (.gff format) for species2
                        [required]
  --sp3fa SP3FA         The genome squence file (.fasta format) for species3
                        [required]
  --sp3gff SP3GFF       The genome annotation file (.gff format) for species3
                        [required]
  --sp1 SP1             The short name for species1, e.g. Ath [default: sp1]
  --sp2 SP2             The short name for species2, e.g. Ath [default: sp2]
  --sp3 SP3             The short name for species2, e.g. Ath [default: sp3]
  --annoType1 ANNOTYPE1
                        Feature type to extract for species1 [default: mRNA]
  --annoKey1 ANNOKEY1   Key in the attributes to extract for species1
                        [default: ID]
  --annoparentKey1 ANNOPARENTKEY1
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --annoType2 ANNOTYPE2
                        Feature type to extract for species2 [default: mRNA]
  --annoKey2 ANNOKEY2   Key in the attributes to extract for species2
                        [default: ID]
  --annoparentKey2 ANNOPARENTKEY2
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --annoType3 ANNOTYPE3
                        Feature type to extract for species3 [default: mRNA]
  --annoKey3 ANNOKEY3   Key in the attributes to extract for species3
                        [default: ID]
  --annoparentKey3 ANNOPARENTKEY3
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --datatype DATATYPE   The type of squences for jcvi, nucl|prot [default:
                        nucl]
  --cscore CSCORE       C-score cutoff for jcvi [default: 0.7]
  --threads THREADS     Number of threads to use [default: 8]
  --process PROCESS     Process for gapanno, genblastg|miniprot [default:
                        genblastg]
  --evalue EVALUE       Threshold for evalue in genBlast [default: 1e-5]
  --rank RANK           The number of ranks in genBlast output [default: 5]
  --coverage COVERAGE   Minimum percentage of query gene coverage of the HSP
                        group in the genBlast output [default: 0.5]
  --kmer1 KMER1         K-mer size for Indexing in miniprot [default: 5]
  --kmer2 KMER2         K-mer size for the second round of chaining in
                        miniprot [default: 4]
  --outs OUTS           Threshold of Score for miniprot output [default: 0.95]
  --intron INTRON       Max intron size allowed for miniprot output [default:
                        40k]
```


## syngap_custom

### Tool Description
Custom synteny analysis between two species.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap custom [-h] --sp1fa SP1FA --sp1gff SP1GFF --sp2fa SP2FA --sp2gff
                     SP2GFF --custom_anchors CUSTOM_ANCHORS [--sp1 SP1]
                     [--sp2 SP2] [--annoType1 ANNOTYPE1] [--annoKey1 ANNOKEY1]
                     [--annoparentKey1 ANNOPARENTKEY1] [--annoType2 ANNOTYPE2]
                     [--annoKey2 ANNOKEY2] [--annoparentKey2 ANNOPARENTKEY2]
                     [--datatype DATATYPE] [--cscore CSCORE]
                     [--threads THREADS] [--process PROCESS] [--evalue EVALUE]
                     [--rank RANK] [--coverage COVERAGE] [--kmer1 KMER1]
                     [--kmer2 KMER2] [--outs OUTS] [--intron INTRON]

options:
  -h, --help            show this help message and exit
  --sp1fa SP1FA         The squence file (.fasta format) for species1
                        [required]
  --sp1gff SP1GFF       The annotation file (.gff format) for species1
                        [required]
  --sp2fa SP2FA         The squence file (.fasta format) for species2
                        [required]
  --sp2gff SP2GFF       The annotation file (.gff format) for species2
                        [required]
  --custom_anchors CUSTOM_ANCHORS
                        Choose the self-defined Syntenic anchors file
                        [required]
  --sp1 SP1             The short name for species1, e.g. Ath [default: sp1]
  --sp2 SP2             The short name for species2, e.g. Ath [default: sp2]
  --annoType1 ANNOTYPE1
                        Feature type to extract for species1 [default: mRNA]
  --annoKey1 ANNOKEY1   Key in the attributes to extract for species1
                        [default: ID]
  --annoparentKey1 ANNOPARENTKEY1
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --annoType2 ANNOTYPE2
                        Feature type to extract for species2 [default: mRNA]
  --annoKey2 ANNOKEY2   Key in the attributes to extract for species2
                        [default: ID]
  --annoparentKey2 ANNOPARENTKEY2
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --datatype DATATYPE   The type of squences for jcvi, nucl|prot [default:
                        nucl]
  --cscore CSCORE       C-score cutoff for jcvi [default: 0.7]
  --threads THREADS     Number of threads to use [default: 8]
  --process PROCESS     Process for gapanno, genblastg|miniprot [default:
                        genblastg]
  --evalue EVALUE       Threshold for evalue in genBlast [default: 1e-5]
  --rank RANK           The number of ranks in genBlast output [default: 5]
  --coverage COVERAGE   Minimum percentage of query gene coverage of the HSP
                        group in the genBlast output [default: 0.5]
  --kmer1 KMER1         K-mer size for Indexing in miniprot [default: 5]
  --kmer2 KMER2         K-mer size for the second round of chaining in
                        miniprot [default: 4]
  --outs OUTS           Threshold of Score for miniprot output [default: 0.95]
  --intron INTRON       Max intron size allowed for miniprot output [default:
                        40k]
```


## syngap_genepair

### Tool Description
Compares gene pairs between two species.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap genepair [-h] --sp1fa SP1FA --sp1gff SP1GFF --sp2fa SP2FA
                       --sp2gff SP2GFF [--sp1 SP1] [--sp2 SP2]
                       [--annoType1 ANNOTYPE1] [--annoKey1 ANNOKEY1]
                       [--annoparentKey1 ANNOPARENTKEY1]
                       [--annoType2 ANNOTYPE2] [--annoKey2 ANNOKEY2]
                       [--annoparentKey2 ANNOPARENTKEY2] [--datatype DATATYPE]
                       [--cscore CSCORE] [--evalue EVALUE] [--iTAK ITAK]
                       [--threads THREADS]

options:
  -h, --help            show this help message and exit
  --sp1fa SP1FA         The squence file (.fasta format) for species1
                        [required]
  --sp1gff SP1GFF       The annotation file (.gff format) for species1
                        [required]
  --sp2fa SP2FA         The squence file (.fasta format) for species2
                        [required]
  --sp2gff SP2GFF       The annotation file (.gff format) for species2
                        [required]
  --sp1 SP1             The short name for species1, e.g. Ath [default: sp1]
  --sp2 SP2             The short name for species2, e.g. Ath [default: sp2]
  --annoType1 ANNOTYPE1
                        Feature type to extract for species1 [default: mRNA]
  --annoKey1 ANNOKEY1   Key in the attributes to extract for species1
                        [default: ID]
  --annoparentKey1 ANNOPARENTKEY1
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --annoType2 ANNOTYPE2
                        Feature type to extract for species2 [default: mRNA]
  --annoKey2 ANNOKEY2   Key in the attributes to extract for species2
                        [default: ID]
  --annoparentKey2 ANNOPARENTKEY2
                        Parent gene key to group with --primary_only in jcvi
                        [default: Parent]
  --datatype DATATYPE   The type of squences for jcvi, nucl|prot [default:
                        nucl]
  --cscore CSCORE       C-score cutoff for jcvi [default: 0.7]
  --evalue EVALUE       Threshold for evalue in two-way blast [default: 1e-2]
  --iTAK ITAK           Perform iTAK to identify TFs and kinases (only for
                        plants), yse|no [default: no]
  --threads THREADS     Number of threads to use [default: 8]
```


## syngap_evi

### Tool Description
Calculate EVI (Expression Variation Index) for gene pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap evi [-h] --genepair GENEPAIR --sp1exp SP1EXP --sp2exp SP2EXP
                  [--weight WEIGHT] [--format FORMAT]

options:
  -h, --help           show this help message and exit
  --genepair GENEPAIR  The genepair file (tab-divided) for EVI counting
                       [required]
  --sp1exp SP1EXP      The expression file (tab-divided) for species1
                       [required]
  --sp2exp SP2EXP      The expression file (tab-divided) for species2
                       [required]
  --weight WEIGHT      The weight of three indexes in EVI calulating
                       (ML:FC:PCC) [default=1:1:4]
  --format FORMAT      The format of output figure
```


## syngap_eviplot

### Tool Description
Generate an EVI plot from a tab-divided EVI file.

### Metadata
- **Docker Image**: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
- **Homepage**: https://github.com/yanyew/SynGAP
- **Package**: https://anaconda.org/channels/bioconda/packages/syngap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: syngap eviplot [-h] --EVI EVI [--highlightid HIGHLIGHTID]
                      [--highlightcolor HIGHLIGHTCOLOR] --outgraph OUTGRAPH
                      [--figsize FIGSIZE] [--fontsize FONTSIZE]

options:
  -h, --help            show this help message and exit
  --EVI EVI             The EVI file (tab-divided) for ploting [required]
  --highlightid HIGHLIGHTID
                        The id list file (tab-divided) for highlightid
  --highlightcolor HIGHLIGHTCOLOR
                        The color for highlight label [default=red]
  --outgraph OUTGRAPH   The output graph file (output format determined by the
                        file suffix) [required]
  --figsize FIGSIZE     The size of output graph (LengthxWidth) [default=10x5]
  --fontsize FONTSIZE   The font size of output graph [default=10]
```

