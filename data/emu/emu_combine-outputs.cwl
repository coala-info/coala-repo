cwlVersion: v1.2
class: CommandLineTool
baseCommand: emu combine-outputs
label: emu_combine-outputs
doc: "Combines Emu output files into a single table.\n\nTool homepage: https://gitlab.com/treangenlab/emu"
inputs:
  - id: dir_path
    type: Directory
    doc: path to directory containing Emu output files
    inputBinding:
      position: 1
  - id: rank
    type: string
    doc: taxonomic rank to include in combined table
    inputBinding:
      position: 2
  - id: counts
    type:
      - 'null'
      - boolean
    doc: counts rather than abundances in output table
    inputBinding:
      position: 103
      prefix: --counts
  - id: split_tables
    type:
      - 'null'
      - boolean
    doc: two output tables:abundances and taxonomy lineages
    inputBinding:
      position: 103
      prefix: --split-tables
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
stdout: emu_combine-outputs.out
