cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - csmap2nt
label: maq_csmap2nt
doc: "Convert cs.map to nt.map\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_ref_nt_bfa
    type: File
    doc: Input ref.nt.bfa file
    inputBinding:
      position: 1
  - id: input_cs_map
    type: File
    doc: Input cs.map file
    inputBinding:
      position: 2
outputs:
  - id: output_nt_map
    type: File
    doc: Output nt.map file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
