cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - knock-knock
  - process-sample
label: knock-knock_process-sample
doc: "Process a sample using knock-knock.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
  - id: batch_name
    type: string
    doc: batch name
    inputBinding:
      position: 2
  - id: sample_name
    type: string
    doc: sample name
    inputBinding:
      position: 3
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress bars
    inputBinding:
      position: 104
      prefix: --progress
  - id: stages
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --stages
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_process-sample.out
