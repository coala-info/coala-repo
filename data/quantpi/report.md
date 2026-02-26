# quantpi CWL Generation Report

## quantpi_init

### Tool Description
Initialize a quantpi project.

### Metadata
- **Docker Image**: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ohmeta/quantpi
- **Package**: https://anaconda.org/channels/bioconda/packages/quantpi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quantpi/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ohmeta/quantpi
- **Stars**: N/A
### Original Help Text
```text
usage: quantpi init [-h] [-d WORKDIR] [--check-samples] [-s SAMPLES]
                    [-b {simulate,trimming,rmhost,profiling}]
                    [--trimmer {oas1,sickle,fastp}]
                    [--rmhoster {bwa,bowtie2,minimap2,kraken2,kneaddata}]

optional arguments:
  -h, --help            show this help message and exit
  -d, --workdir WORKDIR
                        project workdir (default: ./)
  --check-samples       check samples, default: False
  -s, --samples SAMPLES
                        desired input:
                        samples list, tsv format required.
                        
                        if begin from trimming, rmhost, or assembly:
                            if it is fastq:
                                the header is: [sample_id, fq1, fq2]
                            if it is sra:
                                the header is: [sample_id, sra]
                        
                        if begin from simulate:
                                the header is: [id, genome, abundance, reads_num, model]
                        
  -b, --begin {simulate,trimming,rmhost,profiling}
                        pipeline starting point (default: trimming)
  --trimmer {oas1,sickle,fastp}
                        which trimmer used (default: fastp)
  --rmhoster {bwa,bowtie2,minimap2,kraken2,kneaddata}
                        which rmhoster used (default: bowtie2)
```


## quantpi_simulate_wf

### Tool Description
Pipeline for simulating data with quantpi

### Metadata
- **Docker Image**: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ohmeta/quantpi
- **Package**: https://anaconda.org/channels/bioconda/packages/quantpi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: quantpi simulate_wf [-h] [-d WORKDIR] [--check-samples]
                           [--config CONFIG] [--cores CORES]
                           [--local-cores LOCAL_CORES] [--jobs JOBS] [--list]
                           [--debug] [--dry-run] [--run-local] [--run-remote]
                           [--cluster-engine {slurm,sge,lsf,pbs-torque}]
                           [--wait WAIT] [--use-conda]
                           [--conda-prefix CONDA_PREFIX]
                           [--conda-create-envs-only]
                           [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are simulate_all, all (default: all)

optional arguments:
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


## quantpi_profiling_wf

### Tool Description
Pipeline end point.

### Metadata
- **Docker Image**: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ohmeta/quantpi
- **Package**: https://anaconda.org/channels/bioconda/packages/quantpi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: quantpi profiling_wf [-h] [-d WORKDIR] [--check-samples]
                            [--config CONFIG] [--cores CORES]
                            [--local-cores LOCAL_CORES] [--jobs JOBS] [--list]
                            [--debug] [--dry-run] [--run-local] [--run-remote]
                            [--cluster-engine {slurm,sge,lsf,pbs-torque}]
                            [--wait WAIT] [--use-conda]
                            [--conda-prefix CONDA_PREFIX]
                            [--conda-create-envs-only]
                            [TASK]

positional arguments:
  TASK                  pipeline end point. Allowed values are prepare_short_reads_all, prepare_long_reads_all, prepare_reads_all, raw_fastqc_all, raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_kraken2_all, rmhost_kneaddata_all, rmhost_report_all, rmhost_all, qcreport_all, profiling_kraken2_all, profiling_kraken2_bracken_all, profiling_krakenuniq_all, profiling_krakenuniq_bracken_all, profiling_kmcp_all, profiling_metaphlan2_all, profiling_metaphlan3_all, profiling_metaphlan40_all, profiling_metaphlan41_all, profiling_strainphlan3_all, profiling_strainphlan40_all, profiling_strainphlan41_all, profiling_genomecov_all, profiling_genome_coverm_all, profiling_custom_bgi_soap_all, profiling_custom_bowtie2_all, profiling_custom_jgi_all, profiling_humann2_all, profiling_humann35_all, profiling_humann38_all, profiling_humann39_all, profiling_all, all (default: all)

optional arguments:
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


## quantpi_sync

### Tool Description
Sync project data to a directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/ohmeta/quantpi
- **Package**: https://anaconda.org/channels/bioconda/packages/quantpi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: quantpi sync [-h] [-d WORKDIR] [--check-samples] [--config CONFIG]
                    --name NAME --outdir OUTDIR [--split-num SPLIT_NUM]
                    [WORKFLOW] [TASK]

positional arguments:
  WORKFLOW              workflow. Allowed values are profiling_wf (default: profiling_wf)
  TASK                  pipeline end point (default: all)

optional arguments:
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

