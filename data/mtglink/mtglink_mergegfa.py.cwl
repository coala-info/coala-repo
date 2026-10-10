cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergegfa.py
label: mtglink_mergegfa.py
doc: "Merge two GFA files (GFA 2.0) together.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: gfa1
    type: File
    doc: "GFA 2.0 file number 1 (format: xxx.gfa)"
    inputBinding:
      prefix: "-1"
  - id: gfa2
    type: File
    doc: "GFA 2.0 file number 2 (format: xxx.gfa)"
    inputBinding:
      prefix: "-2"
  - id: merged_gfa
    type: string
    doc: "Name of the output merged GFA file"
    inputBinding:
      prefix: "-out"
outputs:
  - id: merged
    type: File
    doc: Merged GFA file
    outputBinding:
      glob: $(inputs.merged_gfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
