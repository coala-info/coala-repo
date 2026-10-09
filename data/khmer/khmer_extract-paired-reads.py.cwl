cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract-paired-reads.py
label: khmer_extract-paired-reads.py
doc: |-
  Take a mixture of reads and split into pairs and orphans. The default output is two files, <input file>.pe (interleaved, properly paired sequences) and <input file>.se (orphan sequences), placed in the current directory.

  Tool homepage: https://khmer.readthedocs.io/
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: infile
    type: File
    doc: Input FAST[AQ] file with a mixture of paired and orphan reads
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
  - id: output_paired
    type: ['null', string]
    doc: Output paired reads to this file
    inputBinding:
      position: 103
      prefix: --output-paired
  - id: output_single
    type: ['null', string]
    doc: Output orphaned reads to this file
    inputBinding:
      position: 103
      prefix: --output-single
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
  - id: paired_reads
    type: File
    doc: Interleaved, properly paired reads
    outputBinding:
      glob: "${ var d = inputs.output_dir ? inputs.output_dir + '/' : ''; return inputs.output_paired ? inputs.output_paired : d + '*.pe'; }"
  - id: single_reads
    type: File
    doc: Orphaned reads
    outputBinding:
      glob: "${ var d = inputs.output_dir ? inputs.output_dir + '/' : ''; return inputs.output_single ? inputs.output_single : d + '*.se'; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
s:url: https://khmer.readthedocs.io/
$namespaces:
  s: https://schema.org/
