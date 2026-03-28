# labrat CWL Generation Report

## labrat_LABRAT.py

### Tool Description
LABRAT.py

### Metadata
- **Docker Image**: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
- **Homepage**: https://github.com/TaliaferroLab/LABRAT
- **Package**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TaliaferroLab/LABRAT
- **Stars**: N/A
### Original Help Text
```text
usage: LABRAT.py [-h] [--mode {makeTFfasta,runSalmon,calculatepsi,test}]
                 [--librarytype {RNAseq,3pseq}] [--gff GFF]
                 [--genomefasta GENOMEFASTA] [--lasttwoexons]
                 [--txfasta TXFASTA] [--reads1 READS1] [--reads2 READS2]
                 [--samplename SAMPLENAME] [--threads THREADS]
                 [--salmondir SALMONDIR] [--sampconds SAMPCONDS]
                 [--conditionA CONDITIONA] [--conditionB CONDITIONB]

optional arguments:
  -h, --help            show this help message and exit
  --mode {makeTFfasta,runSalmon,calculatepsi,test}
  --librarytype {RNAseq,3pseq}
                        Is this RNAseq data or 3' seq data? Needed for
                        makeTFfasta and calculatepsi.
  --gff GFF             GFF of transcript annotation. Needed for makeTFfasta
                        and calculatepsi.
  --genomefasta GENOMEFASTA
                        Genome sequence in fasta format. Needed for
                        makeTFfasta.
  --lasttwoexons        Used for makeTFfasta. Do you want to only use the last
                        two exons?
  --txfasta TXFASTA     Fasta file of sequences to quantitate with salmon.
                        Often the output of makeTFfasta mode.
  --reads1 READS1       Comma separated list of forward read fastq files.
                        Needed for runSalmon.
  --reads2 READS2       Comma separated list of reverse read fastq files.
                        Needed for runSalmon. Omit for single end data.
  --samplename SAMPLENAME
                        Comma separated list of samplenames. Needed for
                        runSalmon.
  --threads THREADS     Number of threads to use. Needed for runSalmon.
  --salmondir SALMONDIR
                        Salmon output directory. Needed for calculatepsi.
  --sampconds SAMPCONDS
                        File relating sample names and conditions. See README
                        for details.
  --conditionA CONDITIONA
                        Condition A. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
  --conditionB CONDITIONB
                        Condition B. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
```


## labrat_LABRAT_dm6annotation.py

### Tool Description
LABRAT_dm6annotation.py

### Metadata
- **Docker Image**: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
- **Homepage**: https://github.com/TaliaferroLab/LABRAT
- **Package**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LABRAT_dm6annotation.py [-h]
                               [--mode {makeTFfasta,runSalmon,calculatepsi}]
                               [--gff GFF] [--genomefasta GENOMEFASTA]
                               [--lasttwoexons] [--txfasta TXFASTA]
                               [--reads1 READS1] [--reads2 READS2]
                               [--samplename SAMPLENAME] [--threads THREADS]
                               [--salmondir SALMONDIR] [--sampconds SAMPCONDS]
                               [--conditionA CONDITIONA]
                               [--conditionB CONDITIONB]

optional arguments:
  -h, --help            show this help message and exit
  --mode {makeTFfasta,runSalmon,calculatepsi}
  --gff GFF             GFF of transcript annotation. Needed for makeTFfasta
                        and calculatepsi.
  --genomefasta GENOMEFASTA
                        Genome sequence in fasta format. Needed for
                        makeTFfasta.
  --lasttwoexons        Used for makeTFfasta. Do you want to only use the last
                        two exons?
  --txfasta TXFASTA     Fasta file of sequences to quantitate with salmon.
                        Often the output of makeTFfasta mode.
  --reads1 READS1       Comma separated list of forward read fastq files.
                        Needed for runSalmon.
  --reads2 READS2       Comma separated list of reverse read fastq files.
                        Needed for runSalmon.
  --samplename SAMPLENAME
                        Comma separated list of samplenames. Needed for
                        runSalmon.
  --threads THREADS     Number of threads to use. Needed for runSalmon.
  --salmondir SALMONDIR
                        Salmon output directory. Needed for calculatepsi.
  --sampconds SAMPCONDS
                        Needed for calculatepsi. File containing sample names
                        split by condition. Two column, tab delimited text
                        file. Condition 1 samples in first column, condition2
                        samples in second column.
  --conditionA CONDITIONA
                        Condition A. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
  --conditionB CONDITIONB
                        Condition B. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
```


## labrat_LABRAT_rn6annotation.py

### Tool Description
LABRAT_rn6annotation.py

### Metadata
- **Docker Image**: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
- **Homepage**: https://github.com/TaliaferroLab/LABRAT
- **Package**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LABRAT_rn6annotation.py [-h]
                               [--mode {makeTFfasta,runSalmon,calculatepsi,LME}]
                               [--gff GFF] [--genomefasta GENOMEFASTA]
                               [--lasttwoexons] [--txfasta TXFASTA]
                               [--reads1 READS1] [--reads2 READS2]
                               [--samplename SAMPLENAME] [--threads THREADS]
                               [--salmondir SALMONDIR] [--psifile PSIFILE]
                               [--sampconds SAMPCONDS]

optional arguments:
  -h, --help            show this help message and exit
  --mode {makeTFfasta,runSalmon,calculatepsi,LME}
  --gff GFF             GFF of transcript annotation. Needed for makeTFfasta
                        and calculatepsi.
  --genomefasta GENOMEFASTA
                        Genome sequence in fasta format. Needed for
                        makeTFfasta.
  --lasttwoexons        Used for makeTFfasta. Do you want to only use the last
                        two exons?
  --txfasta TXFASTA     Fasta file of sequences to quantitate with salmon.
                        Often the output of makeTFfasta mode.
  --reads1 READS1       Comma separated list of forward read fastq files.
                        Needed for runSalmon.
  --reads2 READS2       Comma separated list of reverse read fastq files.
                        Needed for runSalmon.
  --samplename SAMPLENAME
                        Comma separated list of samplenames. Needed for
                        runSalmon.
  --threads THREADS     Number of threads to use. Needed for runSalmon.
  --salmondir SALMONDIR
                        Salmon output directory. Needed for calculatepsi.
  --psifile PSIFILE     Psi value table. Needed for LME.
  --sampconds SAMPCONDS
                        File containing sample names split by condition. Two
                        column, tab delimited text file. Condition 1 samples
                        in first column, condition2 samples in second column.
```


## labrat_LABRAT_danRer.py

### Tool Description
A Python script for analyzing RNA sequencing data, specifically focusing on transcript quantification and differential splicing analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
- **Homepage**: https://github.com/TaliaferroLab/LABRAT
- **Package**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LABRAT_danRer.py [-h]
                        [--mode {makeTFfasta,runSalmon,calculatepsi,test}]
                        [--librarytype {RNAseq,3pseq}] [--gff GFF]
                        [--genomefasta GENOMEFASTA] [--lasttwoexons]
                        [--txfasta TXFASTA] [--reads1 READS1]
                        [--reads2 READS2] [--samplename SAMPLENAME]
                        [--threads THREADS] [--salmondir SALMONDIR]
                        [--sampconds SAMPCONDS] [--conditionA CONDITIONA]
                        [--conditionB CONDITIONB]

optional arguments:
  -h, --help            show this help message and exit
  --mode {makeTFfasta,runSalmon,calculatepsi,test}
  --librarytype {RNAseq,3pseq}
                        Is this RNAseq data or 3' seq data? Needed for
                        makeTFfasta and calculatepsi.
  --gff GFF             GFF of transcript annotation. Needed for makeTFfasta
                        and calculatepsi.
  --genomefasta GENOMEFASTA
                        Genome sequence in fasta format. Needed for
                        makeTFfasta.
  --lasttwoexons        Used for makeTFfasta. Do you want to only use the last
                        two exons?
  --txfasta TXFASTA     Fasta file of sequences to quantitate with salmon.
                        Often the output of makeTFfasta mode.
  --reads1 READS1       Comma separated list of forward read fastq files.
                        Needed for runSalmon.
  --reads2 READS2       Comma separated list of reverse read fastq files.
                        Needed for runSalmon. Omit for single end data.
  --samplename SAMPLENAME
                        Comma separated list of samplenames. Needed for
                        runSalmon.
  --threads THREADS     Number of threads to use. Needed for runSalmon.
  --salmondir SALMONDIR
                        Salmon output directory. Needed for calculatepsi.
  --sampconds SAMPCONDS
                        File relating sample names and conditions. See README
                        for details.
  --conditionA CONDITIONA
                        Condition A. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
  --conditionB CONDITIONB
                        Condition B. deltapsi will be calculated as B-A. Must
                        be a value in the 'condition' column of the sampconds
                        file.
```


## labrat_LABRATsc.py

### Tool Description
How to perform tests? Either compare psi values of individual cells or subsample cells from clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
- **Homepage**: https://github.com/TaliaferroLab/LABRAT
- **Package**: https://anaconda.org/channels/bioconda/packages/labrat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: LABRATsc.py [-h] [--mode {cellbycell,subsampleClusters}] [--gff GFF]
                   [--alevindir ALEVINDIR] [--readcountfilter READCOUNTFILTER]
                   [--conditions CONDITIONS] [--conditionA CONDITIONA]
                   [--conditionB CONDITIONB]

optional arguments:
  -h, --help            show this help message and exit
  --mode {cellbycell,subsampleClusters}
                        How to perform tests? Either compare psi values of
                        individual cells or subsample cells from clusters.
  --gff GFF             GFF of transcript annotation.
  --alevindir ALEVINDIR
                        Directory containing subdirectories of alevin output.
  --readcountfilter READCOUNTFILTER
                        Minimum read count necessary for calculation of psi
                        values. Genes that do not pass this filter will have
                        reported psi values of NA. If mode == 'cellbycell',
                        then this is the number of reads mapping to a gene in
                        that single cell. If mode == 'subsampleClusters' then
                        this is the summed number of reads across all cells in
                        a predefined cluster.
  --conditions CONDITIONS
                        Two column, tab-delimited file with column names
                        'sample' and 'condition'. First column contains cell
                        ids and second column contains cell condition or
                        cluster.
  --conditionA CONDITIONA
                        Must be found in the second column of the conditions
                        file. Delta psi is calculated as conditionB -
                        conditionA.
  --conditionB CONDITIONB
                        Must be found in the second column of the conditions
                        file. Delta psi is calculated as conditionB -
                        conditionA.
```


## Metadata
- **Skill**: generated
