cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5tools_view
label: slow5tools_view
doc: "View a slow5 as blow5 FILE and vice versa.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (slow5 or blow5)
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: number of records loaded to the memory at once
    default: 4096
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: from_format
    type:
      - 'null'
      - string
    doc: specify input file format [auto]
    default: auto
    inputBinding:
      position: 102
      prefix: --from
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: record compression method [zlib] (only for blow5 format)
    default: zlib
    inputBinding:
      position: 102
      prefix: --compress
  - id: signal_compression_method
    type:
      - 'null'
      - string
    doc: signal compression method [svb-zd] (only for blow5 format)
    default: svb-zd
    inputBinding:
      position: 102
      prefix: --sig-compress
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
  - id: to_format
    type:
      - 'null'
      - string
    doc: specify output file format [slow5, auto detected using extension if -o 
      FILE is provided]
    inputBinding:
      position: 102
      prefix: --to
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to FILE [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
