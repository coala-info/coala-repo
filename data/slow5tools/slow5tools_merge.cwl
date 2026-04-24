cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - merge
label: slow5tools_merge
doc: "Merge multiple SLOW5/BLOW5 files to a single file\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input SLOW5/BLOW5 files or directories
    inputBinding:
      position: 1
  - id: allow_attribute_differences
    type:
      - 'null'
      - boolean
    doc: Allow merging despite attribute differences in the same run_id
    inputBinding:
      position: 102
      prefix: --allow
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of records loaded to the memory at once
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: lossless
    type:
      - 'null'
      - boolean
    doc: Retain information in auxiliary fields during the conversion
    inputBinding:
      position: 102
      prefix: --lossless
  - id: output_format
    type:
      - 'null'
      - string
    doc: Specify output file format [blow5, auto detected using extension if -o 
      FILE is provided]
    inputBinding:
      position: 102
      prefix: --to
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: Record compression method [zlib] (only for blow5 format)
    inputBinding:
      position: 102
      prefix: --compress
  - id: signal_compression_method
    type:
      - 'null'
      - string
    doc: Signal compression method [svb-zd] (only for blow5 format)
    inputBinding:
      position: 102
      prefix: --sig-compress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output to FILE [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
