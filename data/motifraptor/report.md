# motifraptor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| motifraptor_celltype | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_motiffilter | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_motifspecific | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_preprocess | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_preprocess_ukbb_v3 | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpfeature | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpindex | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpmotif | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpmotifradar | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpscan | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |
| motifraptor_snpspecific | Failed | image problem: MotifRaptor writes globalpara.txt inside its install folder at start, so it fails read-only or as a non-root user (OSError Read-only file system); also needs a 32 GB database |

## motifraptor_preprocess

### Tool Description
usage: MotifRaptor preprocess [-h] [-gwas SUMMARYSTATSFILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor preprocess [-h] [-gwas SUMMARYSTATSFILE]
                              [-cn COLUMN_NUMBERS] [-st SCORE_TYPE]
                              [-th SCORE_PVALUE_THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  -gwas SUMMARYSTATSFILE, --gwas_summary SUMMARYSTATSFILE
                        GWAS summary statistic file
  -cn COLUMN_NUMBERS, --column_numbers COLUMN_NUMBERS
                        provide six column numbers for information in such
                        order: ID,CHR,POS,A1,A2,SCORE eg. 1,2,3,4,5,6
  -st SCORE_TYPE, --score_type SCORE_TYPE
                        Score type in GWAS summary statistic file: pvalue or
                        zscore or chisquare
  -th SCORE_PVALUE_THRESHOLD, --threshold SCORE_PVALUE_THRESHOLD
                        threads for pvalue - default 5E-8
```

## motifraptor_preprocess_ukbb_v3

### Tool Description
usage: MotifRaptor preprocess_ukbb_v3 [-h] [-gwas SUMMARYSTATSFILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor preprocess_ukbb_v3 [-h] [-gwas SUMMARYSTATSFILE]
                                      [-th SCORE_PVALUE_THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  -gwas SUMMARYSTATSFILE, --gwas_summary SUMMARYSTATSFILE
                        GWAS summary statistic - UKBB v3 tsv filename
  -th SCORE_PVALUE_THRESHOLD, --threshold SCORE_PVALUE_THRESHOLD
                        threads for pvalue - default 5E-8
```

## motifraptor_celltype

### Tool Description
usage: MotifRaptor celltype [-h] [-vcf SNP_HIT_VCF] [-sh SNP_HIT]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor celltype [-h] [-vcf SNP_HIT_VCF] [-sh SNP_HIT]
                            [-snh SNP_NON_HIT] [-wd WORKDIR] [-p THREAD_NUM]

optional arguments:
  -h, --help            show this help message and exit
  -vcf SNP_HIT_VCF, --snp_hit_withseq SNP_HIT_VCF
                        need header and columns in this text file with
                        sequence (CHR is only a number): ID CHR POS REF ALT
  -sh SNP_HIT, --snp_hit SNP_HIT
                        need header and columns in this text file (CHR is only
                        a number): ID CHR POS
  -snh SNP_NON_HIT, --snp_non_hit SNP_NON_HIT
                        need header and columns in this text file (CHR is only
                        a number): ID CHR POS
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -p THREAD_NUM, --threads THREAD_NUM
                        number of threads
```

## motifraptor_snpmotif

### Tool Description
usage: MotifRaptor snpmotif [-h] [-wd WORKDIR] [-c CELL_TYPE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpmotif [-h] [-wd WORKDIR] [-c CELL_TYPE]
                            [-sb HIT_SNP_UNION_BED] [-se HIT_SNP_UNION]
                            [-bg BG_SNPS] [-m MOTIF_LIST] [-p THREAD_NUM]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -c CELL_TYPE, --cell_type CELL_TYPE
                        Cell type or Tissue type ID
  -sb HIT_SNP_UNION_BED, --snp_hit_bed HIT_SNP_UNION_BED
                        hit snps on union bed file, usually from step1
  -se HIT_SNP_UNION, --snp_hit_seq HIT_SNP_UNION
                        hit snps with sequence information, usually from step1
  -bg BG_SNPS, --bg_snp BG_SNPS
                        background snp list file or (genome)
  -m MOTIF_LIST, --motifs MOTIF_LIST
                        motif list file, no header, or (all)
  -p THREAD_NUM, --threads THREAD_NUM
                        number of threads
```

## motifraptor_snpfeature

### Tool Description
usage: MotifRaptor snpfeature [-h] [-wd WORKDIR] [-c CELL_TYPE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpfeature [-h] [-wd WORKDIR] [-c CELL_TYPE]
                              [-cb SNP_BED_FILES]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -c CELL_TYPE, --cell_type CELL_TYPE
                        Cell type or Tissue type ID
  -cb SNP_BED_FILES, --snp_bed_files SNP_BED_FILES
                        SNP cell type bed file folder, usually from step1
```

## motifraptor_motiffilter

### Tool Description
usage: MotifRaptor motiffilter [-h] [-wd WORKDIR] [-ms MOTIFFILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor motiffilter [-h] [-wd WORKDIR] [-ms MOTIFFILE]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -ms MOTIFFILE, --motif_summary MOTIFFILE
                        Motif Summary File, usually from step2
```

## motifraptor_motifspecific

### Tool Description
usage: MotifRaptor motifspecific [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor motifspecific [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]
                                 [-md MOTIF_ID_NAME] [-bs BG_SCORE_FOLDER]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -sm SNP_MOTIF_FILE, --snp_motif_file SNP_MOTIF_FILE
                        SNP motif pair-wise list File, usually from step2
  -md MOTIF_ID_NAME, --motif_id MOTIF_ID_NAME
                        motif id with name, in the format of motifID__NAME
  -bs BG_SCORE_FOLDER, --bg_score_folder BG_SCORE_FOLDER
                        background score folder, usually from step2
```

## motifraptor_snpspecific

### Tool Description
usage: MotifRaptor snpspecific [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpspecific [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]
                               [-snp SNP_ID]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -sm SNP_MOTIF_FILE, --snp_motif_file SNP_MOTIF_FILE
                        SNP motif pair-wise list File, usually from step2
  -snp SNP_ID, --snp_id SNP_ID
                        SNP id
```

## motifraptor_snpmotifradar

### Tool Description
usage: MotifRaptor snpmotifradar [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpmotifradar [-h] [-wd WORKDIR] [-sm SNP_MOTIF_FILE]
                                 [-sf SNP_FEATURE_FILE] [-pid SNP_MOTIF_ID]

optional arguments:
  -h, --help            show this help message and exit
  -wd WORKDIR, --workdir WORKDIR
                        Working directory
  -sm SNP_MOTIF_FILE, --snp_motif_file SNP_MOTIF_FILE
                        SNP motif pair-wise list File, usually from step2
  -sf SNP_FEATURE_FILE, --snp_feature_file SNP_FEATURE_FILE
                        SNP feature file, usually from step2
  -pid SNP_MOTIF_ID, --snp_motif_id SNP_MOTIF_ID
                        SNP motif pair-wise ID
```

## motifraptor_snpindex

### Tool Description
usage: MotifRaptor snpindex [-h] [-vcf VCF_FILENAME] [-gi INDEXED_GENOME_DB]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpindex [-h] [-vcf VCF_FILENAME] [-gi INDEXED_GENOME_DB]
                            [-mk MKSARY_PATH] [-p THREAD_NUM]

optional arguments:
  -h, --help            show this help message and exit
  -vcf VCF_FILENAME, --vcf_filename VCF_FILENAME
                        input - VCF file for SNPs, first five columns need to
                        be CHR,POS,ID,REF,ALT
  -gi INDEXED_GENOME_DB, --indexed_genome_db INDEXED_GENOME_DB
                        output - indexed genome_database_folder
  -mk MKSARY_PATH, --mksary MKSARY_PATH
                        Mksary program path
  -p THREAD_NUM, --threads THREAD_NUM
                        number of threads
```

## motifraptor_snpscan

### Tool Description
usage: MotifRaptor snpscan [-h] [-gi INDEXED_GENOME_DB] [-pfm PFM_FOLDER]

### Metadata
- **Docker Image**: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
- **Homepage**: https://github.com/pinellolab/MotifRaptor
- **Package**: https://anaconda.org/channels/bioconda/packages/motifraptor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MotifRaptor snpscan [-h] [-gi INDEXED_GENOME_DB] [-pfm PFM_FOLDER]
                           [-mo OUTPUTMOTIFSCANDIR] [-p THREAD_NUM]

optional arguments:
  -h, --help            show this help message and exit
  -gi INDEXED_GENOME_DB, --indexed_genome_db INDEXED_GENOME_DB
                        indexed genome_database_folder
  -pfm PFM_FOLDER, --pfm_folder PFM_FOLDER
                        motif pmf files folder
  -mo OUTPUTMOTIFSCANDIR, --motifscan_output OUTPUTMOTIFSCANDIR
                        Motif Scan Ouput Folder
  -p THREAD_NUM, --threads THREAD_NUM
                        number of threads
```

