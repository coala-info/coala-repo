cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_find_model_changes.py
label: gs-tama_tama_find_model_changes.py
doc: "This script looks at read support files and finds reads that have mapped to different genes\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: annotation_bed_file
    type:
      - 'null'
      - File
    doc: Annotation bed file
    inputBinding:
      position: 101
      prefix: -b
  - id: read_support_file
    type:
      - 'null'
      - File
    doc: Read support file
    inputBinding:
      position: 101
      prefix: -r
  - id: output_prefix
    type: string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: reference_source
    type:
      - 'null'
      - string
    doc: Reference source
    inputBinding:
      position: 101
      prefix: -ref
  - id: alternative_source
    type:
      - 'null'
      - string
    doc: Alternative source
    inputBinding:
      position: 101
      prefix: -alt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_find_model_changes.py.out
