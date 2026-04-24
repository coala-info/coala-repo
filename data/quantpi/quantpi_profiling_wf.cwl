cwlVersion: v1.2
class: CommandLineTool
baseCommand: quantpi_profiling_wf
label: quantpi_profiling_wf
doc: "Pipeline end point.\n\nTool homepage: https://github.com/ohmeta/quantpi"
inputs:
  - id: task
    type:
      - 'null'
      - string
    doc: pipeline end point. Allowed values are prepare_short_reads_all, 
      prepare_long_reads_all, prepare_reads_all, raw_fastqc_all, raw_report_all,
      raw_all, trimming_sickle_all, trimming_fastp_all, 
      trimming_trimmomatic_all, trimming_report_all, trimming_all, 
      rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, 
      rmhost_kraken2_all, rmhost_kneaddata_all, rmhost_report_all, rmhost_all, 
      qcreport_all, profiling_kraken2_all, profiling_kraken2_bracken_all, 
      profiling_krakenuniq_all, profiling_krakenuniq_bracken_all, 
      profiling_kmcp_all, profiling_metaphlan2_all, profiling_metaphlan3_all, 
      profiling_metaphlan40_all, profiling_metaphlan41_all, 
      profiling_strainphlan3_all, profiling_strainphlan40_all, 
      profiling_strainphlan41_all, profiling_genomecov_all, 
      profiling_genome_coverm_all, profiling_custom_bgi_soap_all, 
      profiling_custom_bowtie2_all, profiling_custom_jgi_all, 
      profiling_humann2_all, profiling_humann35_all, profiling_humann38_all, 
      profiling_humann39_all, profiling_all, all
    inputBinding:
      position: 1
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: check samples
    inputBinding:
      position: 102
      prefix: --check-samples
  - id: cluster_engine
    type:
      - 'null'
      - string
    doc: cluster workflow manager engine, support slurm(sbatch) and sge(qsub)
    inputBinding:
      position: 102
      prefix: --cluster-engine
  - id: conda_create_envs_only
    type:
      - 'null'
      - boolean
    doc: conda create environments only
    inputBinding:
      position: 102
      prefix: --conda-create-envs-only
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: conda environment prefix
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: config
    type:
      - 'null'
      - File
    doc: config.yaml
    inputBinding:
      position: 102
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: all job cores, available on '--run-local'
    inputBinding:
      position: 102
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug pipeline
    inputBinding:
      position: 102
      prefix: --debug
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: dry run pipeline
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: jobs
    type:
      - 'null'
      - int
    doc: cluster job numbers, available on '--run-remote'
    inputBinding:
      position: 102
      prefix: --jobs
  - id: list
    type:
      - 'null'
      - boolean
    doc: list pipeline rules
    inputBinding:
      position: 102
      prefix: --list
  - id: local_cores
    type:
      - 'null'
      - int
    doc: local job cores, available on '--run-remote'
    inputBinding:
      position: 102
      prefix: --local-cores
  - id: run_local
    type:
      - 'null'
      - boolean
    doc: run pipeline on local computer
    inputBinding:
      position: 102
      prefix: --run-local
  - id: run_remote
    type:
      - 'null'
      - boolean
    doc: run pipeline on remote cluster
    inputBinding:
      position: 102
      prefix: --run-remote
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: use conda environment
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: wait
    type:
      - 'null'
      - int
    doc: wait given seconds
    inputBinding:
      position: 102
      prefix: --wait
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: project workdir
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quantpi:1.0.0--pyh7e72e81_0
stdout: quantpi_profiling_wf.out
