cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapi simulate
label: metapi_simulate_wf
doc: "Pipeline end point. Allowed values are simulate_all, all (default: all)\n\n\
  Tool homepage: https://github.com/ohmeta/metapi"
inputs:
  - id: task
    type:
      - 'null'
      - string
    doc: 'pipeline end point. Allowed values are simulate_all, all (default: all)'
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
    dockerPull: quay.io/biocontainers/metapi:3.0.0--pyhdfd78af_0
stdout: metapi_simulate_wf.out
