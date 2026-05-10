cwlVersion: v1.2
class: CommandLineTool
baseCommand: igfinder.py
label: igfinder
doc: "ver 1.0 filtering fasta file for Ig analysis\n\nTool homepage: https://tx.bioreg.kyushu-u.ac.jp/igfinder"
inputs:
  - id: analysis_frame
    type:
      - 'null'
      - string
    doc: 'Analysis frame: default=starts from M'
    inputBinding:
      position: 101
      prefix: -c
  - id: input_filename
    type: File
    doc: input_filename(fasta_format)
    inputBinding:
      position: 101
      prefix: -i
  - id: sequence_reference
    type: File
    doc: sequence_reference csv file
    inputBinding:
      position: 101
      prefix: -r
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 102
      prefix: --output-dir
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output_dir
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igfinder:1.0--pyhdfd78af_0
