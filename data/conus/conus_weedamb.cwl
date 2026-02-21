cwlVersion: v1.2
class: CommandLineTool
baseCommand: weedamb
label: conus_weedamb
doc: "Identify and optionally save ambiguous sequences from a sequence file.\n\nTool
  homepage: http://eddylab.org/software/conus/"
inputs:
  - id: seqfile_in
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
outputs:
  - id: save_ambiguous
    type:
      - 'null'
      - File
    doc: save ambiguous sequences to this file
    outputBinding:
      glob: $(inputs.save_ambiguous)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
