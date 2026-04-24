cwlVersion: v1.2
class: CommandLineTool
baseCommand: coidb
label: coidb
doc: "Builds a DAG of jobs for processing biological data.\n\nTool homepage: https://github.com/johnne/coidb"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use for job execution.
    inputBinding:
      position: 101
      prefix: --cores
  - id: jobs
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify jobs to execute.
    inputBinding:
      position: 101
      prefix: --jobs
  - id: rule
    type:
      - 'null'
      - string
    doc: Specify a specific rule to execute.
    inputBinding:
      position: 101
      prefix: --rule
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: Enable Singularity container usage (currently ignored).
    inputBinding:
      position: 101
      prefix: --singularity
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for job execution.
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: output_zipfile
    type:
      - 'null'
      - File
    doc: Output zip file name.
    outputBinding:
      glob: $(inputs.output_zipfile)
  - id: output_log
    type:
      - 'null'
      - File
    doc: Output log file name.
    outputBinding:
      glob: $(inputs.output_log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coidb:0.4.8--pyhdfd78af_0
