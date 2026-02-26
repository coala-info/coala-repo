cwlVersion: v1.2
class: CommandLineTool
baseCommand: canon-gff3
label: aegean_canon-gff3
doc: "Clean up and canonicalize GFF3 data, including inferring missing gene features
  and resetting feature sources.\n\nTool homepage: https://github.com/BrendelGroup/AEGeAn"
inputs:
  - id: gff3_files
    type:
      type: array
      items: File
    doc: Input GFF3 file(s) to be processed
    inputBinding:
      position: 1
  - id: infer
    type:
      - 'null'
      - boolean
    doc: for transcript features lacking an explicitly declared gene feature as 
      a parent, create this feature on-they-fly
    inputBinding:
      position: 102
      prefix: --infer
  - id: source
    type:
      - 'null'
      - string
    doc: reset the source of each feature to the given value
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: name of file to which GFF3 data will be written; default is terminal 
      (stdout)
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aegean:0.16.0--h71bfec9_5
