cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleave-reads.py
label: khmer_interleave-reads.py
doc: "Interleave left and right reads from paired-end sequencing files.\n\nTool homepage:
  https://khmer.readthedocs.io/"
inputs:
  - id: left_reads
    type: File
    doc: Left (forward) read file
    inputBinding:
      position: 1
  - id: right_reads
    type: File
    doc: Right (reverse) read file
    inputBinding:
      position: 2
  - id: bzip2
    type:
      - 'null'
      - boolean
    doc: Compress output with bzip2.
    inputBinding:
      position: 103
      prefix: --bzip2
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output with gzip.
    inputBinding:
      position: 103
      prefix: --gzip
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: Continue even if the output file already exists.
    inputBinding:
      position: 103
      prefix: --no-force
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the output file. If not specified, output will go to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
