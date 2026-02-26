cwlVersion: v1.2
class: CommandLineTool
baseCommand: knock-knock table
label: knock-knock_table
doc: "Generates a table of knock-knock results.\n\nTool homepage: https://github.com/jeffhussmann/knock-knock"
inputs:
  - id: base_dir
    type: Directory
    doc: the base directory to store input data, reference annotations, and 
      analysis output for a project
    inputBinding:
      position: 1
  - id: batches
    type:
      - 'null'
      - string
    doc: if specified, a comma-separated list of batches to include; if not 
      specified, all batches in base_dir will be generated
    inputBinding:
      position: 102
      prefix: --batches
  - id: title
    type:
      - 'null'
      - string
    doc: if specified, a title for output files
    inputBinding:
      position: 102
      prefix: --title
  - id: unsorted
    type:
      - 'null'
      - boolean
    doc: don't sort samples
    inputBinding:
      position: 102
      prefix: --unsorted
  - id: vmax_multiple
    type:
      - 'null'
      - float
    doc: fractional value that corresponds to full horizontal bar
    inputBinding:
      position: 102
      prefix: --vmax_multiple
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knock-knock:0.8.0--pyhdfd78af_0
stdout: knock-knock_table.out
