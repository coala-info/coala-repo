cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapi_gene_wf
label: metapi_gene_wf
doc: "Pipeline end point. Allowed values are prepare_reads_all, raw_fastqc_all, raw_report_all,
  raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all, trimming_report_all,
  trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all, rmhost_report_all,
  rmhost_all, qcreport_all, assebmly_megahit_all, assembly_idba_ud_all, assembly_metaspades_all,
  assembly_spades_all, assembly_plass_all, assembly_metaquast_all, assembly_report_all,
  predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all, predict_scafitgs_gene_all,
  predict_all, dereplicate_gene_cdhit_all, dereplicate_gene_all, upload_sequencing_all,
  upload_assembly_all, upload_all, all (default: all)\n\nTool homepage: https://github.com/ohmeta/metapi"
inputs:
  - id: task
    type:
      - 'null'
      - string
    doc: 'pipeline end point. Allowed values are prepare_reads_all, raw_fastqc_all,
      raw_report_all, raw_all, trimming_sickle_all, trimming_fastp_all, trimming_trimmomatic_all,
      trimming_report_all, trimming_all, rmhost_bwa_all, rmhost_bowtie2_all, rmhost_minimap2_all,
      rmhost_report_all, rmhost_all, qcreport_all, assebmly_megahit_all, assembly_idba_ud_all,
      assembly_metaspades_all, assembly_spades_all, assembly_plass_all, assembly_metaquast_all,
      assembly_report_all, predict_scaftigs_gene_prodigal_all, predict_scaftigs_gene_prokka_all,
      predict_scafitgs_gene_all, predict_all, dereplicate_gene_cdhit_all, dereplicate_gene_all,
      upload_sequencing_all, upload_assembly_all, upload_all, all (default: all)'
    default: all
    inputBinding:
      position: 1
  - id: check_samples
    type:
      - 'null'
      - boolean
    doc: 'check samples, default: False'
    default: false
    inputBinding:
      position: 102
      prefix: --check-samples
  - id: cluster_engine
    type:
      - 'null'
      - string
    doc: cluster workflow manager engine, support slurm(sbatch) and sge(qsub)
    default: slurm
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
    default: ~/.conda/envs
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: config
    type:
      - 'null'
      - File
    doc: config.yaml
    default: ./config.yaml
    inputBinding:
      position: 102
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: all job cores, available on '--run-local'
    default: 240
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
    default: 30
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
    default: 8
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
    default: 60
    inputBinding:
      position: 102
      prefix: --wait
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: project workdir
    default: ./
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
stdout: metapi_gene_wf.out
