cwlVersion: v1.2
class: CommandLineTool
baseCommand: split-paired-reads.py
label: khmer_split-paired-reads.py
doc: |-
  Split interleaved reads into two files, left and right. The default outputs are <input file>.1 and <input file>.2 in the current directory; with --output-orphaned, orphaned reads (broken-paired format) are saved separately.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: infile
    type: File
    doc: Input interleaved FAST[AQ] file
    inputBinding:
      position: 1
  - id: info
    type: ['null', boolean]
    doc: print citation information
    inputBinding:
      position: 103
      prefix: --info
  - id: output_dir
    type: ['null', string]
    doc: Output split reads to specified directory. Creates directory if necessary
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: output_orphaned
    type: ['null', string]
    doc: Allow orphaned reads and extract them to this file
    inputBinding:
      position: 103
      prefix: --output-orphaned
  - id: output_first
    type: ['null', string]
    doc: Output left reads to this file
    inputBinding:
      position: 103
      prefix: --output-first
  - id: output_second
    type: ['null', string]
    doc: Output right reads to this file
    inputBinding:
      position: 103
      prefix: --output-second
  - id: force
    type: ['null', boolean]
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: gzip
    type: ['null', boolean]
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --gzip
  - id: bzip
    type: ['null', boolean]
    doc: Compress output using bzip2
    inputBinding:
      position: 103
      prefix: --bzip
outputs:
  - id: left_reads
    type: File
    doc: Left (first) reads
    outputBinding:
      glob: "${ var d = inputs.output_dir ? inputs.output_dir + '/' : ''; return inputs.output_first ? inputs.output_first : d + '*.1'; }"
  - id: right_reads
    type: File
    doc: Right (second) reads
    outputBinding:
      glob: "${ var d = inputs.output_dir ? inputs.output_dir + '/' : ''; return inputs.output_second ? inputs.output_second : d + '*.2'; }"
  - id: orphaned_reads
    type: ['null', File]
    doc: Orphaned reads (when --output-orphaned is given)
    outputBinding:
      glob: "$(inputs.output_orphaned)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
