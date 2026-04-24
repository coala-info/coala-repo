cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: cellqc
doc: "CellQC is a Snakemake pipeline for quality control of single-cell RNA sequencing
  data.\n\nTool homepage: https://github.com/lijinbio/cellqc"
inputs:
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: Configuration parameters
    inputBinding:
      position: 101
      prefix: --config
  - id: configfile
    type:
      - 'null'
      - File
    doc: Path to a configuration file
    inputBinding:
      position: 101
      prefix: --config configfile
  - id: cores
    type: int
    doc: Number of cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug_dag
    type:
      - 'null'
      - boolean
    doc: Print the DAG in debug mode
    inputBinding:
      position: 101
      prefix: --debug-dag
  - id: directory
    type: Directory
    doc: Directory to run Snakemake in
    inputBinding:
      position: 101
      prefix: --directory
  - id: jobs
    type: int
    doc: Maximum number of jobs to run in parallel
    inputBinding:
      position: 101
      prefix: --jobs
  - id: nowtimestr
    type:
      - 'null'
      - string
    doc: Timestamp string
    inputBinding:
      position: 101
      prefix: --config nowtimestr
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --config outdir
  - id: printshellcmds
    type:
      - 'null'
      - boolean
    doc: Print shell commands before execution
    inputBinding:
      position: 101
      prefix: --printshellcmds
  - id: samplefile
    type:
      - 'null'
      - string
    doc: Path to the sample file
    inputBinding:
      position: 101
      prefix: --config samplefile
  - id: skip_script_cleanup
    type:
      - 'null'
      - boolean
    doc: Skip cleanup of script files after execution
    inputBinding:
      position: 101
      prefix: --skip-script-cleanup
  - id: snakefile
    type: File
    doc: Path to the Snakefile
    inputBinding:
      position: 101
      prefix: --snakefile
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use Conda environments for jobs
    inputBinding:
      position: 101
      prefix: --use-conda
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellqc:0.1.0--pyh7e72e81_0
stdout: cellqc.out
