cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwtupdate
label: bwa_bwtupdate
doc: "Update the BWT (Burrows-Wheeler Transform) file.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: bwt_file
    type: File
    doc: The .bwt file to update; a copy is updated and returned
    inputBinding:
      position: 201
      valueFrom: $(self.basename)
outputs:
  - id: updated_bwt
    type: File
    doc: The updated .bwt file
    outputBinding:
      glob: $(inputs.bwt_file.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bwt_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
