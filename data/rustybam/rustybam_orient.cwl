cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam orient
label: rustybam_orient
doc: "Orient paf records so that most of the bases are in the forward direction.\n\
  \nOptionally scaffold the queriers so that there is one query per target.\n\nTool
  homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: "PAF file from minimap2 or unimap. Must have the cg tag, and n matches will
      be zero\n            unless the cigar uses =X"
    inputBinding:
      position: 1
  - id: insert
    type:
      - 'null'
      - int
    doc: Space to add between records
    inputBinding:
      position: 102
      prefix: --insert
  - id: scaffold
    type:
      - 'null'
      - boolean
    doc: "Generate ~1 query per target that scaffolds together all the records that
      map to that\n            target sequence.\n            \nThe order of the scaffold
      will be determined by the average target position across all\n            the
      queries, and the name of the new scaffold will be."
    inputBinding:
      position: 102
      prefix: --scaffold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_orient.out
