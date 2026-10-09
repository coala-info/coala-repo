cwlVersion: v1.2
class: CommandLineTool
baseCommand: interleave-reads.py
label: khmer_interleave-reads.py
doc: Produce interleaved files from R1/R2 paired files
inputs:
  - id: left
    type: File
    doc: Left/R1 paired file
    inputBinding:
      position: 1
  - id: right
    type: File
    doc: Right/R2 paired file
    inputBinding:
      position: 2
  - id: info
    type:
      - 'null'
      - boolean
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: output
    type:
      - 'null'
      - string
    doc: Output filename
    inputBinding:
      position: 103
      prefix: --output
  - id: no_reformat
    type:
      - 'null'
      - boolean
    doc: Do not reformat read names or enforce consistency
    inputBinding:
      position: 103
      prefix: --no-reformat
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --gzip
  - id: bzip
    type:
      - 'null'
      - boolean
    doc: Compress output using bzip2
    inputBinding:
      position: 103
      prefix: --bzip
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Interleaved reads written to standard output (when --output is not given)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_interleave-reads.py.out
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
