# ezaai CWL Generation Report

## ezaai_extract

### Tool Description
Extract protein DB from prokaryotic genome sequence(s) using Prodigal

### Metadata
- **Docker Image**: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
- **Homepage**: http://leb.snu.ac.kr/ezaai
- **Package**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/endixk/ezaai
- **Stars**: N/A
### Original Help Text
```text
[32;1m
 EzAAI - extract[0m
[32m Extract protein DB from prokaryotic genome sequence(s) using Prodigal[0m

[33;1m
 USAGE:[0m ezaai extract -i <INPUT> -o <OUTPUT> [-l <LABEL> -t <THREAD>]

[33;1m
 Required options[0m
 SINGLE MODE    
[36m Argument       Description[0m
 -i             Input prokaryotic genome sequence
 -o             Output protein database

 BATCH MODE     
[36m Argument       Description[0m
 -i             Input directory with prokaryotic genome sequences
 -o             Output directory for protein databases

[33m
 Additional options[0m
 SINGLE MODE    
[36m Argument       Description[0m
 -l             Taxonomic label for phylogenetic tree
 -t             Number of CPU threads - multi-threading requires ufasta (default: 1)

 BATCH MODE     
[36m Argument       Description[0m
 -l             Tab separated file with labels
                (FILE_NAME <tab> LABEL, default: use file names as labels)
 -t             Number of CPU threads to use (default: 10)

 COMMON         
[36m Argument       Description[0m
 -tmp           Custom temporary directory (default: /tmp/ezaai)
 -prodigal      Custom path to prodigal binary (default: prodigal)
 -mmseqs        Custom path to MMSeqs2 binary (default: mmseqs)
 -ufasta        Custom path to ufasta binary (default: ufasta)
```


## ezaai_convert

### Tool Description
Convert CDS FASTA file into protein DB

### Metadata
- **Docker Image**: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
- **Homepage**: http://leb.snu.ac.kr/ezaai
- **Package**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m
 EzAAI - convert[0m
[32m Convert CDS FASTA file into protein DB[0m

[33;1m
 USAGE:[0m ezaai convert -i <IN_CDS> -s <SEQ_TYPE> -o <OUT_DB> [-l <LABEL>]

[33;1m
 Required options[0m
[36m Argument       Description[0m
 -i             Input CDS file (FASTA format)
 -s             Sequence type of input file (nucl/prot)
 -o             Output protein DB

[33m
 Additional options[0m
[36m Argument       Description[0m
 -l             Taxonomic label for phylogenetic tree
 -tmp           Custom temporary directory (default: /tmp/ezaai)
 -mmseqs        Custom path to MMSeqs2 binary (default: mmseqs)
```


## ezaai_convertdb

### Tool Description
Convert protein DB into FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
- **Homepage**: http://leb.snu.ac.kr/ezaai
- **Package**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m
 EzAAI - convertdb[0m
[32m Convert protein DB into FASTA file[0m

[33;1m
 USAGE:[0m ezaai convertdb -i <IN_DB> -o <OUT_FA>

[33;1m
 Required options[0m
[36m Argument       Description[0m
 -i             Input protein DB
 -o             Output FASTA file

[33m
 Additional options[0m
[36m Argument       Description[0m
 -tmp           Custom temporary directory (default: /tmp/ezaai)
 -mmseqs        Custom path to MMSeqs2 binary (default: mmseqs)
```


## ezaai_calculate

### Tool Description
Calculate AAI value from protein databases

### Metadata
- **Docker Image**: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
- **Homepage**: http://leb.snu.ac.kr/ezaai
- **Package**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m
 EzAAI - calculate[0m
[32m Calculate AAI value from protein databases[0m

[33;1m
 USAGE:[0m ezaai calculate -i <INPUT_1> -j <INPUT_2> -o <OUTPUT> [-p <PROGRAM> -t <THREAD> -id <IDENTITY> -cov <COVERAGE> -mtx <MTX_OUTPUT>]

[33;1m
 Required options[0m
[36m Argument       Description[0m
 -i             First input protein DB / directory with protein DBs
 -j             Second input protein DB / directory with protein DBs
 -o             Output result file

[33m
 Additional options[0m
[36m Argument       Description[0m
 -p             Customize calculation program [mmseqs / diamond / blastp] (default: mmseqs)
 -t             Number of CPU threads to use (default: 10)
 -tmp           Custom temporary directory (default: /tmp/ezaai)
 -self          Assume self-comparison; -i and -j must be identical [0 / 1] (default: 0)
 -id            Minimum identity threshold for AAI calculations [0 - 1.0] (default: 0.4)
 -cov           Minimum query coverage threshold for AAI calculations [0 - 1.0] (default: 0.5)
 -match         Path to write a result of matched CDS names
 -mtx           Path to write a Matrix Market formatted output
 -mmseqs        Custom path to MMSeqs2 binary (default: mmseqs)
 -diamond       Custom path to DIAMOND binary (default: diamond)
 -blastp        Custom path to BLASTp+ binary (default: blastp)
 -blastdb       Custom path to makeblastdb binary (default: makeblastdb)
```


## ezaai_cluster

### Tool Description
Hierarchical clustering of taxa with AAI values

### Metadata
- **Docker Image**: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
- **Homepage**: http://leb.snu.ac.kr/ezaai
- **Package**: https://anaconda.org/channels/bioconda/packages/ezaai/overview
- **Validation**: PASS

### Original Help Text
```text
[32;1m
 EzAAI - cluster[0m
[32m Hierarchical clustering of taxa with AAI values[0m

[33;1m
 USAGE:[0m ezaai cluster -i <AAI_TABLE> -o <OUTPUT>

[33;1m
 Required options[0m
[36m Argument       Description[0m
 -i             Input EzAAI result file containing all-by-all pairwise AAI values
 -o             Output result file
 -u             Use ID instead of label for tree
```


## Metadata
- **Skill**: generated
