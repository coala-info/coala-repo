cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bcbio_vm.py, cwlrun]
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: bcbio
  - class: NetworkAccess
    networkAccess: true
label: bcbio-nextgen-vm_cwlrun
doc: "Run Common Workflow Language (CWL) inputs with a specified tool\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen-vm"
inputs:
  - id: tool
    type:
      type: enum
      symbols:
        - cwltool
        - arvados
        - toil
        - bunny
        - funnel
        - cromwell
        - sbg
        - wes
    doc: CWL tool to run
    inputBinding:
      position: 10
  - id: directory
    type: Directory
    doc: Directory with bcbio generated CWL
    inputBinding:
      position: 11
  - id: toolargs
    type:
      - 'null'
      - string[]
    doc: Arguments to pass to CWL tool
    inputBinding:
      position: 12
  - id: no_container
    type:
      - 'null'
      - boolean
    doc: Use local installation of bcbio instead of Docker container
    inputBinding:
      position: 1
      prefix: --no-container
  - id: scheduler
    type:
      - 'null'
      - type: enum
        symbols:
          - lsf
          - sge
          - torque
          - slurm
          - pbspro
          - htcondor
    doc: Scheduler to use, for an HPC system
    inputBinding:
      position: 1
      prefix: --scheduler
  - id: queue
    type:
      - 'null'
      - string
    doc: Scheduler queue to run jobs on, for an HPC system
    inputBinding:
      position: 1
      prefix: --queue
  - id: resources
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --resources
    doc: Cluster specific resources specifications (SGE, Torque, LSF and SLURM parameters)
    inputBinding:
      position: 1
  - id: joblimit
    type:
      - 'null'
      - int
    doc: Maximum number of simultaneous jobs (not cores) submitted; Cromwell runner only
    inputBinding:
      position: 1
      prefix: --joblimit
  - id: runconfig
    type:
      - 'null'
      - File
    doc: Custom configuration HOCON file for Cromwell
    inputBinding:
      position: 1
      prefix: --runconfig
  - id: cloud_project
    type:
      - 'null'
      - string
    doc: Remote cloud project for running jobs (Cromwell AWS/GCP support)
    inputBinding:
      position: 1
      prefix: --cloud-project
  - id: cloud_root
    type:
      - 'null'
      - string
    doc: Remote bucket location for run files (Cromwell AWS/GCP support)
    inputBinding:
      position: 1
      prefix: --cloud-root
  - id: host
    type:
      - 'null'
      - string
    doc: 'WES: host for submitting jobs'
    inputBinding:
      position: 1
      prefix: --host
  - id: auth
    type:
      - 'null'
      - string
    doc: 'WES: authentication token'
    inputBinding:
      position: 1
      prefix: --auth
outputs:
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Runner work directory (<tool>_work, with final/ outputs for Cromwell)
    outputBinding:
      glob: $(inputs.tool)_work
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0
