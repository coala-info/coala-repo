# metapi CWL Generation Report

## metapi_init

### Tool Description
Initialize a metapi project.

### Metadata
- **Docker Image**: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ohmeta/metapi
- **Package**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Total Downloads**: 35.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ohmeta/metapi
- **Stars**: N/A
### Original Help Text
```text
usage: metapi init [-h] [-d WORKDIR] [--check-samples] [-s SAMPLES]
                   [-b {simulate,trimming,rmhost,assembly,binning,checkm}]
                   [--trimmer {sickle,fastp,trimmomatic}]
                   [--rmhoster {bwa,bowtie2,minimap2,kraken2,kneaddata}]
                   [--assembler {idba-ud,megahit,metaspades,spades,opera-ms} [{idba-ud,megahit,metaspades,spades,opera-ms} ...]]
                   [--binner BINNER [BINNER ...]] [--gpu {true,false}]

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  -s, --samples SAMPLES
                        desired input:
                        samples list, tsv format required.
                        
                        if begin from trimming, rmhost, or assembly:
                            if it is fastq:
                                the header is: [sample_id, assembly_group, binning_group, fq1, fq2]
                            if it is sra:
                                the header is: [sample_id, assembly_group, binning_group, sra]
                        
                        if begin from simulate:
                                the header is: [id, genome, abundance, reads_num, model]
                        
  -b, --begin {simulate,trimming,rmhost,assembly,binning,checkm}
                        pipeline starting point (default: trimming)
  --trimmer {sickle,fastp,trimmomatic}
                        which trimmer used (default: fastp)
  --rmhoster {bwa,bowtie2,minimap2,kraken2,kneaddata}
                        which rmhoster used (default: bowtie2)
  --assembler {idba-ud,megahit,metaspades,spades,opera-ms} [{idba-ud,megahit,metaspades,spades,opera-ms} ...]
                        which assembler used, required when begin with binning, can be changed in config.yaml (default: ['megahit'])
  --binner BINNER [BINNER ...]
                        wchich binner used (default: ['metabat2', 'concoct', 'maxbin2', 'vamb', 'dastools'])
  --gpu {true,false}    indicate whether GPU is available (default: true)
```


## metapi_simulate_wf

### Tool Description
Pipeline end point. Allowed values are simulate_all, all (default: all)

### Metadata
- **Docker Image**: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ohmeta/metapi
- **Package**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metapi simulate [-h] [-d WORKDIR] [--check-samples] [--config CONFIG]
                       [--cores CORES] [--local-cores LOCAL_CORES]
                       [--jobs JOBS] [--list] [--debug] [--dry-run]
                       [--run-local] [--run-remote]
                       [--cluster-engine {slurm,sge,lsf,pbs-torque}]
                       [--wait WAIT] [--use-conda]
                       [--conda-prefix CONDA_PREFIX]
                       [--conda-create-envs-only]
                       [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are simulate_all, all (default: all)

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  --config CONFIG       config.yaml (default: ./config.yaml)
  --cores CORES         all job cores, available on '--run-local' (default: 240)
  --local-cores LOCAL_CORES
                        local job cores, available on '--run-remote' (default: 8)
  --jobs JOBS           cluster job numbers, available on '--run-remote' (default: 30)
  --list                list pipeline rules
  --debug               debug pipeline
  --dry-run             dry run pipeline
  --run-local           run pipeline on local computer
  --run-remote          run pipeline on remote cluster
  --cluster-engine {slurm,sge,lsf,pbs-torque}
                        cluster workflow manager engine, support slurm(sbatch) and sge(qsub) (default: slurm)
  --wait WAIT           wait given seconds (default: 60)
  --use-conda           use conda environment
  --conda-prefix CONDA_PREFIX
                        conda environment prefix (default: ~/.conda/envs)
  --conda-create-envs-only
                        conda create environments only
```


## metapi_mag_wf

### Tool Description
Metagenomic MAG workflow

### Metadata
- **Docker Image**: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ohmeta/metapi
- **Package**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metapi mag_wf [-h] [-d WORKDIR] [--check-samples] [--config CONFIG]
                     [--cores CORES] [--local-cores LOCAL_CORES] [--jobs JOBS]
                     [--list] [--debug] [--dry-run] [--run-local]
                     [--run-remote]
                     [--cluster-engine {slurm,sge,lsf,pbs-torque}]
                     [--wait WAIT] [--use-conda] [--conda-prefix CONDA_PREFIX]
                     [--conda-create-envs-only]
                     [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are raw_prepare_reads_all, raw_fastqc_all, raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_kraken2_all, rmhost_kneaddata_all, rmhost_report_all, rmhost_all, qcreport_all, assembly_megahit_all, assembly_idba_ud_all, assembly_metaspades_all, assembly_spades_all, assembly_plass_all, assembly_opera_ms_all, assembly_metaquast_all, assembly_report_all, assembly_all, alignment_base_depth_all, alignment_report_all, alignment_all, binning_metabat2_coverage_all, binning_metabat2_all, binning_maxbin2_all, binning_concoct_all, binning_graphbin2_all, binning_dastools_all, binning_vamb_prepare_all, binning_vamb_all, binning_report_all, binning_all, identify_virsorter2_all, identify_deepvirfinder_all, identify_single_all, identify_phamb_all, identify_multi_all, identify_all, predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all, predict_mags_gene_prodigal_all, predict_mags_gene_prokka_all, predict_scaftigs_gene_all, predict_mags_gene_all, predict_all, annotation_prophage_dbscan_swa_all, annotation_all, checkm_all, checkv_all, check_all, dereplicate_mags_drep_all, dereplicate_mags_galah_all, dereplicate_mags_all, dereplicate_vmags_all, dereplicate_all, taxonomic_gtdbtk_all, taxonomic_all, databases_bacteriome_kmcp_all, databases_bacteriome_kraken2_all, databases_bacteriome_krakenuniq_all, databases_bacteriome_all, databases_all, upload_sequencing_all, upload_assembly_all, upload_all, all (default: all)

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  --config CONFIG       config.yaml (default: ./config.yaml)
  --cores CORES         all job cores, available on '--run-local' (default: 240)
  --local-cores LOCAL_CORES
                        local job cores, available on '--run-remote' (default: 8)
  --jobs JOBS           cluster job numbers, available on '--run-remote' (default: 30)
  --list                list pipeline rules
  --debug               debug pipeline
  --dry-run             dry run pipeline
  --run-local           run pipeline on local computer
  --run-remote          run pipeline on remote cluster
  --cluster-engine {slurm,sge,lsf,pbs-torque}
                        cluster workflow manager engine, support slurm(sbatch) and sge(qsub) (default: slurm)
  --wait WAIT           wait given seconds (default: 60)
  --use-conda           use conda environment
  --conda-prefix CONDA_PREFIX
                        conda environment prefix (default: ~/.conda/envs)
  --conda-create-envs-only
                        conda create environments only
```


## metapi_gene_wf

### Tool Description
Pipeline end point. Allowed values are prepare_reads_all, raw_fastqc_all, raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_report_all, rmhost_all, qcreport_all, assebmly_megahit_all, assembly_idba_ud_all, assembly_metaspades_all, assembly_spades_all, assembly_plass_all, assembly_metaquast_all, assembly_report_all, predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all, predict_scafitgs_gene_all, predict_all, dereplicate_gene_cdhit_all, dereplicate_gene_all, upload_sequencing_all, upload_assembly_all, upload_all, all (default: all)

### Metadata
- **Docker Image**: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ohmeta/metapi
- **Package**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metapi gene_wf [-h] [-d WORKDIR] [--check-samples] [--config CONFIG]
                      [--cores CORES] [--local-cores LOCAL_CORES]
                      [--jobs JOBS] [--list] [--debug] [--dry-run]
                      [--run-local] [--run-remote]
                      [--cluster-engine {slurm,sge,lsf,pbs-torque}]
                      [--wait WAIT] [--use-conda]
                      [--conda-prefix CONDA_PREFIX] [--conda-create-envs-only]
                      [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are prepare_reads_all, raw_fastqc_all, raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_report_all, rmhost_all, qcreport_all, assebmly_megahit_all, assembly_idba_ud_all, assembly_metaspades_all, assembly_spades_all, assembly_plass_all, assembly_metaquast_all, assembly_report_all, predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all, predict_scafitgs_gene_all, predict_all, dereplicate_gene_cdhit_all, dereplicate_gene_all, upload_sequencing_all, upload_assembly_all, upload_all, all (default: all)

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  --config CONFIG       config.yaml (default: ./config.yaml)
  --cores CORES         all job cores, available on '--run-local' (default: 240)
  --local-cores LOCAL_CORES
                        local job cores, available on '--run-remote' (default: 8)
  --jobs JOBS           cluster job numbers, available on '--run-remote' (default: 30)
  --list                list pipeline rules
  --debug               debug pipeline
  --dry-run             dry run pipeline
  --run-local           run pipeline on local computer
  --run-remote          run pipeline on remote cluster
  --cluster-engine {slurm,sge,lsf,pbs-torque}
                        cluster workflow manager engine, support slurm(sbatch) and sge(qsub) (default: slurm)
  --wait WAIT           wait given seconds (default: 60)
  --use-conda           use conda environment
  --conda-prefix CONDA_PREFIX
                        conda environment prefix (default: ~/.conda/envs)
  --conda-create-envs-only
                        conda create environments only
```


## metapi_sync

### Tool Description
Sync project to a directory

### Metadata
- **Docker Image**: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ohmeta/metapi
- **Package**: https://anaconda.org/channels/bioconda/packages/metapi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metapi sync [-h] [-d WORKDIR] [--check-samples] [--config CONFIG]
                   --name NAME --outdir OUTDIR [--split-num SPLIT_NUM]
                   [WORKFLOW] [TASK]

positional arguments:
  WORKFLOW              workflow. Allowed values are simulate_wf, mag_wf, gene_wf (default: mag_wf)
  TASK                  pipeline end point (default: all)

options:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  --config CONFIG       config.yaml (default: ./config.yaml)
  --name NAME           project basename
  --outdir OUTDIR       sync to a directory
  --split-num SPLIT_NUM
                        split project to sync directory (default: 1)
```

