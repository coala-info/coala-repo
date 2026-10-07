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
      position: 200
  - id: save_ambiguous_path
    type: string
    doc: ': save ambiguous sequences to this file'
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: unambiguous
    type: stdout
    doc: Sequences without ambiguous bases (Stockholm)
  - id: save_ambiguous
    type:
      - 'null'
      - File
    doc: save ambiguous sequences to this file
    outputBinding:
      glob: $(inputs.save_ambiguous_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
stdout: conus_weedamb.out
