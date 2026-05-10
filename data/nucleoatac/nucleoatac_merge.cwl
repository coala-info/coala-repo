cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleoatac merge
label: nucleoatac_merge
doc: "Merge nucleosome occupancy and position files.\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs:
  - id: min_occ
    type:
      - 'null'
      - float
    doc: minimum lower bound occupancy of nucleosomes to be considered for 
      excluding NFR.
    inputBinding:
      position: 101
      prefix: --min_occ
  - id: min_separation
    type:
      - 'null'
      - string
    doc: minimum separation between call
    inputBinding:
      position: 101
      prefix: --sep
  - id: nucpos_file
    type: File
    doc: Output from nuc utility
    inputBinding:
      position: 101
      prefix: --nucpos
  - id: occpeaks_file
    type: File
    doc: Output from occ utility
    inputBinding:
      position: 101
      prefix: --occpeaks
  - id: out_basename_path
    type: string
    doc: Output or path parameter `out_basename_path`
    inputBinding:
      position: 102
      prefix: --out-basename
outputs:
  - id: out_basename
    type:
      - 'null'
      - File
    doc: output file basename
    outputBinding:
      glob: $(inputs.out_basename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5
