cwlVersion: v1.2
class: CommandLineTool
baseCommand: strike
label: strike
doc: "v1.2\n\nTool homepage: http://www.tcoffee.org/Projects/strike/index.html"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment File
    inputBinding:
      position: 101
      prefix: -a
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalizes the score
    inputBinding:
      position: 101
      prefix: -n
  - id: template_file
    type: File
    doc: Connection File (lines of 'sequence_name pdb_file chain')
    inputBinding:
      position: 101
      prefix: -c
  - id: out_file_path
    type: string
    inputBinding:
      position: 102
      prefix: -o
  - id: structure_files
    type:
      - 'null'
      - type: array
        items: File
    doc: PDB files named in the connection file; staged in the working directory so the names resolve
outputs:
  - id: out_file
    type: File
    doc: The file where the results will be saved
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.structure_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strike:1.2--h9948957_6
