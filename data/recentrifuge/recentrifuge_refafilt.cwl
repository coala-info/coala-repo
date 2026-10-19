cwlVersion: v1.2
class: CommandLineTool
baseCommand: refafilt
label: recentrifuge_refafilt
doc: "Filter a FASTA file by sequence length\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs:
  - id: input
    type: File
    doc: input FASTA file, which may be gzipped
    inputBinding:
      position: 101
      prefix: --input
  - id: output_pass
    type:
      - 'null'
      - string
    doc: output file for sequences passing the filter(s)
    inputBinding:
      position: 102
      prefix: --output_pass
  - id: output_short
    type:
      - 'null'
      - string
    doc: output file for sequences too short
    inputBinding:
      position: 103
      prefix: --output_short
  - id: output_long
    type:
      - 'null'
      - string
    doc: output file for sequences too long
    inputBinding:
      position: 104
      prefix: --output_long
  - id: output_plot
    type:
      - 'null'
      - string
    doc: output PDF file for histogram plot
    inputBinding:
      position: 105
      prefix: --output_plot
  - id: filter_less_than
    type:
      - 'null'
      - int
    doc: minimum length of the accepted sequences
    inputBinding:
      position: 106
      prefix: --filter_less_than
  - id: filter_more_than
    type:
      - 'null'
      - int
    doc: maximum length of the accepted sequences
    inputBinding:
      position: 107
      prefix: --filter_more_than
  - id: maxreads
    type:
      - 'null'
      - int
    doc: 'maximum number of FASTA reads to process; default: no maximum'
    inputBinding:
      position: 108
      prefix: --maxreads
  - id: compress
    type:
      - 'null'
      - boolean
    doc: the resulting FASTA files will be gzipped
    inputBinding:
      position: 109
      prefix: --compress
  - id: expand
    type:
      - 'null'
      - boolean
    doc: expand multiple headers in multiple sequences
    inputBinding:
      position: 110
      prefix: --expand
  - id: debug
    type:
      - 'null'
      - boolean
    doc: increase output verbosity and perform additional checks
    inputBinding:
      position: 111
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pass_file
    type:
      - 'null'
      - File
    doc: FASTA file with the sequences passing the filter(s)
    outputBinding:
      glob: '$(inputs.output_pass === null ? "__no_pass__" : inputs.output_pass)'
  - id: short_file
    type:
      - 'null'
      - File
    doc: FASTA file with the sequences that are too short
    outputBinding:
      glob: '$(inputs.output_short === null ? "__no_short__" : inputs.output_short)'
  - id: long_file
    type:
      - 'null'
      - File
    doc: FASTA file with the sequences that are too long
    outputBinding:
      glob: '$(inputs.output_long === null ? "__no_long__" : inputs.output_long)'
  - id: plot_file
    type:
      - 'null'
      - File
    doc: PDF histogram of the sequence lengths
    outputBinding:
      glob: '$(inputs.output_plot === null ? "__no_plot__" : inputs.output_plot)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
stdout: recentrifuge_refafilt.out
