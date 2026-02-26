cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio_nextgen.py
label: bcbio-nextgen_bcbio_nextgen.py
doc: "Community developed high throughput sequencing analysis.\n\nTool homepage: https://github.com/bcbio/bcbio-nextgen"
inputs:
  - id: global_config
    type:
      - 'null'
      - File
    doc: Global YAML configuration file specifying details about the system 
      (optional, defaults to installed bcbio_system.yaml)
    inputBinding:
      position: 1
  - id: fc_dir
    type:
      - 'null'
      - Directory
    doc: A directory of Illumina output or fastq files to process (optional)
    inputBinding:
      position: 2
  - id: run_config
    type:
      - 'null'
      - type: array
        items: File
    doc: YAML file with details about samples to process (required, unless using
      Galaxy LIMS as input)
    inputBinding:
      position: 3
  - id: force_single
    type:
      - 'null'
      - boolean
    doc: Treat all files as single reads
    inputBinding:
      position: 104
      prefix: --force-single
  - id: local_controller
    type:
      - 'null'
      - boolean
    doc: run controller locally
    inputBinding:
      position: 104
      prefix: --local_controller
  - id: numcores
    type:
      - 'null'
      - int
    doc: Total cores to use for processing
    inputBinding:
      position: 104
      prefix: --numcores
  - id: paralleltype
    type:
      - 'null'
      - string
    doc: Approach to parallelization
    inputBinding:
      position: 104
      prefix: --paralleltype
  - id: queue
    type:
      - 'null'
      - string
    doc: Scheduler queue to run jobs on, for ipython parallel
    inputBinding:
      position: 104
      prefix: --queue
  - id: resources
    type:
      - 'null'
      - type: array
        items: string
    doc: Cluster specific resources specifications. Can be specified multiple 
      times. Supports SGE, Torque, LSF and SLURM parameters.
    inputBinding:
      position: 104
      prefix: --resources
  - id: retries
    type:
      - 'null'
      - int
    doc: Number of retries of failed tasks during distributed processing. 
      Default 0 (no retries)
    default: 0
    inputBinding:
      position: 104
      prefix: --retries
  - id: scheduler
    type:
      - 'null'
      - string
    doc: Scheduler to use for ipython parallel
    inputBinding:
      position: 104
      prefix: --scheduler
  - id: separators
    type:
      - 'null'
      - string
    doc: comma separated list of separators that indicates paired files.
    inputBinding:
      position: 104
      prefix: --separators
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag name to label jobs on the cluster
    inputBinding:
      position: 104
      prefix: --tag
  - id: timeout
    type:
      - 'null'
      - int
    doc: Number of minutes before cluster startup times out.
    default: 15
    inputBinding:
      position: 104
      prefix: --timeout
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Directory to process in. Defaults to current working directory
    inputBinding:
      position: 104
      prefix: --workdir
  - id: workflow
    type:
      - 'null'
      - string
    doc: Run a workflow with the given commandline arguments
    inputBinding:
      position: 104
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-nextgen:1.2.9--pyh5e36f6f_3
stdout: bcbio-nextgen_bcbio_nextgen.py.out
