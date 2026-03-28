# mvip CWL Generation Report

## mvip_MVP_00_set_up_MVP

### Tool Description
Check for any potential errors/issues in the metadata and the sequencing/read files, create all the directories that MVP needs, and install the latest versions of geNomad and checkV databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Total Downloads**: 4.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Check for any potential errors/issues in the metadata and the sequencing/read files, create all the directories that MVP needs, and install the latest versions of geNomad and checkV databases.

usage: mvip MVP_00_set_up_MVP -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to the working directory where MVP will be run.
  --metadata METADATA, -m METADATA
                        Path to the metadata that will be use to run MVP.
  --skip_install_databases
                        Install geNomad and CheckV databases in the respective
                        repositories. (default = False).
  --genomad_db_path GENOMAD_DB_PATH
                        Path to the directory where geNomad database will be
                        installed.
  --checkv_db_path CHECKV_DB_PATH
                        Path to the directory where CheckV database will be
                        installed.
  --skip_check_errors   Skip to run sequence data error checking. (default =
                        False).
```


## mvip_MVP_01_run_genomad_checkv

### Tool Description
Run geNomad and CheckV.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Run geNomad and CheckV.

usage: mvip MVP_01_run_genomad_checkv -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --sample_group SAMPLE_GROUP
                        Specific sample number(s) to run the script on (can be
                        a comma-separated list: 1,2,6 for example). By
                        default, MVP processes all datasets listed in the
                        metadata file one after the other.
  --skip_modify_assemblies
                        Modify sequence headers by adding sample name, False
                        by default.
  --min_seq_size MIN_SEQ_SIZE
                        Minimum sequence size to keep (in base pairs).
  --genomad_relaxed     Run geNomad with relaxed filtering.
  --genomad_conservative
                        Run geNomad with conservative filtering.
  --genomad_db_path GENOMAD_DB_PATH
                        Path to the geNomad database directory.
  --checkv_db_path CHECKV_DB_PATH
                        Path to the CheckV database directory.
  --force_genomad       Run geNomad even if output already exists.
  --force_checkv        Run CheckV even if output already exists.
  --threads THREADS     Number of threads to use (default = 1)
```


## mvip_MVP_02_filter_genomad_checkv

### Tool Description
Merge and filter geNomad and CheckV outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Merge and filter geNomad and CheckV outputs.

usage: mvip MVP_02_filter_genomad_checkv -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --sample_group SAMPLE_GROUP
                        Specific sample number(s) to run the script on (can be
                        a comma-separated list: 1,2,6 for example). By
                        default, MVP processes all datasets listed in the
                        metadata file one after the other.
  --viral_min_genes VIRAL_MIN_GENES
                        the minimum number of viral genes required to consider
                        a row as a virus prediction (default = 1)
  --host_viral_genes_ratio HOST_VIRAL_GENES_RATIO
                        the maximum ratio of host genes to viral genes
                        required to consider a row as a virus prediction
                        (default = 1
```


## mvip_MVP_03_do_clustering

### Tool Description
Sequence clustering based on pairwise ANI.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Sequence clustering based on pairwise ANI.

usage: mvip MVP_03_do_clustering -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --min_ani MIN_ANI     Minimum ANI value for clustering (default = 95)
  --min_tcov MIN_TCOV   Minimum coverage of the target sequence (default = 85)
  --min_qcov MIN_QCOV   Minimum coverage of the query sequence (default = 0)
  --read-type READ_TYPE
                        Sequencing data type (e.g. short vs long reads).
                        Default = short
  --unfiltered_protein_file
                        Create protein FASTA file from unfiltered virus
                        sequence. Default = False. Warning = If argument
                        provided, the script might run for a long period of
                        time.
  --threads THREADS     Number of threads to use (default = 1)
```


## mvip_MVP_04_do_read_mapping

### Tool Description
Run CoverM to calculate coverage based on read mapping, using the sorted BAM files sorted by reference, and return to one tabular file per sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Run CoverM to calculate coverage based on read mapping, using the sorted BAM files sorted by reference, and return to one tabular file per sample.

usage: mvip MVP_04_do_read_mapping -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --sample_group SAMPLE_GROUP
                        Specific sample number(s) to run the script on (can be
                        a comma-separated list: 1,2,6 for example). By
                        default, MVP processes all datasets listed in the
                        metadata file one after the other.
  --force_read_mapping  Do the read mapping even if outputs already exist.
  --read_type READ_TYPE
                        Sequencing data type (e.g. short vs long reads).
                        Default = short.
  --interleaved INTERLEAVED
                        Enable or disable the --interleaved option in Bowtie2
                        command (TRUE/FALSE).
  --delete_files        flag to delete unwanted files.
  --threads THREADS     Number of threads to use (default = 1)
```


## mvip_MVP_05_create_vOTU_table

### Tool Description
Merge all the CoverM output tables and create a set of viral OTU tables based on the cutoffs (i.e., horizontal coverage) and filtration mode (i.e., conservative and relaxed).

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Merge all the CoverM output tables and create a set of viral OTU tables based on the cutoffs (i.e., horizontal coverage) and filtration mode (i.e., conservative and relaxed).

usage: mvip MVP_05_create_vOTU_table -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --covered_fraction COVERED_FRACTION [COVERED_FRACTION ...]
                        minimum covered fraction for filtering Default: 0.1
                        0.5 0.9
  --normalization {RPKM,FPKM}
                        Metrics to normalize
  --filtration {relaxed,conservative}
                        Filtration level (relaxed or conservative). Default =
                        conservative
  --viral_min_genes VIRAL_MIN_GENES
                        the minimum number of viral genes required to consider
                        a row as a virus prediction (default = 1)
  --host_viral_genes_ratio HOST_VIRAL_GENES_RATIO
                        the maximum ratio of host genes to viral genes
                        required to consider a row as a virus prediction
                        (default = 1
```


## mvip_MVP_06_do_functional_annotation

### Tool Description
Functional annotation of protein sequences against multiple databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Functional annotation of protein sequences against multiple databases.

usage: mvip MVP_06_do_functional_annotation -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --fasta_files {representative,all}
                        Sequence and protein FASTA files (representative or
                        all sequences) to use for functional annotation.
                        Default = representative
  --delete_files        flag to delete unwanted files
  --PHROGS_evalue PHROGS_EVALUE
                        Significance e-value of match between target sequences
                        and query (default = 0.01)
  --PHROGS_score PHROGS_SCORE
                        Significant score of match between target sequences
                        and query (default = 50)
  --PFAM_evalue PFAM_EVALUE
                        Significance e-value of match between target sequences
                        and query (default = 0.01)
  --PFAM_score PFAM_SCORE
                        Significant score of match between target sequences
                        and query (default = 50)
  --ADS                 Include this flag to search ADS profiles.
  --ADS_evalue ADS_EVALUE
                        Significance e-value of match between target sequences
                        and query (default = 0.01)
  --ADS_score ADS_SCORE
                        Significant score of match between target sequences
                        and query (default = 60)
  --RdRP                Include this flag to create the 07_RDRP_PHYLOGENY
                        folder and search RdRP profiles.
  --RdRP_evalue RDRP_EVALUE
                        Significance e-value of match between target sequences
                        and query (default = 0.01)
  --RdRP_score RDRP_SCORE
                        Significant score of match between target sequences
                        and query (default = 50)
  --DRAM                Include this flag to create a file to be process
                        through DRAM-v.
  --force_prodigal      Force execution of protein prediction by Prodigal.
  --force_PHROGS        Force PHROGS annotation.
  --force_PFAM          Force PFAM annotation.
  --force_ADS           Force ADS annotation.
  --force_RdRP          Force RdRP annotation.
  --force_outputs       Force creation of final annotation table even though
                        it exists.
  --threads THREADS     Number of threads to use (default = 1)
```


## mvip_MVP_07_do_binning

### Tool Description
Run vRhyme for binning virus genomes and return outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Run vRhyme for binning virus genomes and return outputs.

usage: mvip MVP_07_do_binning -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --binning_sample_group BINNING_SAMPLE_GROUP
                        Specific sample number(s) to run the script on. You
                        can provide a comma-separated list (1,2,3,4) or a
                        range (1:4).
  --read_mapping_sample_group READ_MAPPING_SAMPLE_GROUP
                        Specific sample number(s) to run the script on. You
                        can provide a comma-separated list (1,2,3,4) or a
                        range (1:4).
  --keep_bam            Flag to indicate whether to keep BAM files
  --force_vrhyme        Force execution of all steps, even if
                        final_annotation_output_file exists.
  --force_checkv        Force execution of all steps, even if
                        final_annotation_output_file exists.
  --checkv_db_path CHECKV_DB_PATH
                        Path to the CheckV database directory.
  --force_read_mapping  Force execution of all steps, even if
                        final_annotation_output_file exists.
  --read_type {short,long}
                        Sequencing data type (e.g. short vs long reads).
                        Default = short
  --interleaved INTERLEAVED
                        Enable or disable the --interleaved option in Bowtie2
                        command (TRUE/FALSE)
  --delete_files        flag to delete unwanted files
  --normalization {RPKM,FPKM}
                        Metrics to normalize
  --force_outputs       Force execution of all steps, even if
                        final_annotation_output_file exists.
  --filtration {relaxed,conservative}
                        Filtration level ("relaxed" or "conservative").
                        Default = conservative
  --viral_min_genes VIRAL_MIN_GENES
                        the minimum number of viral genes required to include
                        a virus prediction (default = 0)
  --host_viral_genes_ratio HOST_VIRAL_GENES_RATIO
                        the maximum ratio of host genes to viral genes
                        required to include a virus prediction (default = 1)
  --threads THREADS     Number of threads to use (default = 1)
```


## mvip_MVP_99_prep_MIUViG_submission

### Tool Description
Additional module to assist with submitting metagenome-assembled viral genome(s) to GenBank, including MIUViG metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Additional module to assist with submitting metagenome-assembled viral genome(s) to GenBank, including MIUViG metadata.

usage: mvip MVP_99_prep_MIUViG_submission -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  -g GENOME, --genome GENOME
                        Identifier of the sequence to be processed.
  -s {setup_metadata,prep_submission}, --step {setup_metadata,prep_submission}
                        Should be one of "setup_metadata" (to be run first) or
                        "prep_submission" (once sequence metadata have been
                        checked and completed).
  -t TEMPLATE, --template TEMPLATE
                        path to the BioSample submission template file,
                        generated from https://submit.ncbi.nlm.nih.gov/genbank
                        /template/submission/, only required for the step 2:
                        prep_submission
```


## mvip_MVP_100_summarize_outputs

### Tool Description
Summarize outputs and create figures.

### Metadata
- **Docker Image**: quay.io/biocontainers/mvip:1.1.5--pyhdfd78af_1
- **Homepage**: https://gitlab.com/ccoclet/mvp
- **Package**: https://anaconda.org/channels/bioconda/packages/mvip/overview
- **Validation**: PASS

### Original Help Text
```text
Summarize outputs and create figures.

usage: mvip MVP_100_summarize_outputs -i <working_directory_path> -m <metadata_path> [options]

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to your working directory where you want to run
                        MVP.
  --metadata METADATA, -m METADATA
                        Path to your metadata that you want to use to run MVP.
  --force               Force execution of all steps, even if
                        final_annotation_output_file exists.
```


## Metadata
- **Skill**: not generated
