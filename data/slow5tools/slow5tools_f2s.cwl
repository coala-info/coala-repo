cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - f2s
label: slow5tools_f2s
doc: "Convert FAST5 files to SLOW5/BLOW5 format.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: fast5_files_dirs
    type:
      - 'null'
      - type: array
        items: File
    doc: FAST5 file or directory to convert
    inputBinding:
      position: 1
  - id: allow_run_id_mismatches
    type:
      - 'null'
      - boolean
    doc: allow run id mismatches in a multi-fast5 file or in a single-fast5 
      directory
    inputBinding:
      position: 102
      prefix: --allow
  - id: io_processes
    type:
      - 'null'
      - int
    doc: number of I/O processes
    default: 8
    inputBinding:
      position: 102
      prefix: --iop
  - id: lossless
    type:
      - 'null'
      - boolean
    doc: retain information in auxiliary fields during the conversion
    default: true
    inputBinding:
      position: 102
      prefix: --lossless
  - id: output_format
    type:
      - 'null'
      - string
    doc: specify output file format [blow5, auto detected using extension if -o 
      FILE is provided]
    inputBinding:
      position: 102
      prefix: --to
  - id: record_compression_method
    type:
      - 'null'
      - string
    doc: record compression method [zlib] (only for blow5 format)
    default: zlib
    inputBinding:
      position: 102
      prefix: --compress
  - id: retain_directory_structure
    type:
      - 'null'
      - boolean
    doc: retain the same directory structure in the converted output as the 
      input (experimental)
    inputBinding:
      position: 102
      prefix: --retain
  - id: signal_compression_method
    type:
      - 'null'
      - string
    doc: signal compression method [svb-zd] (only for blow5 format)
    default: svb-zd
    inputBinding:
      position: 102
      prefix: --sig-compress
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output to directory
    outputBinding:
      glob: $(inputs.output_dir)
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
