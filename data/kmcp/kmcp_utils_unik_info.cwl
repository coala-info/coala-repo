cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - utils
  - unik-info
label: kmcp_utils_unik_info
doc: "Print information of .unik files\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: all
    type: ['null', boolean]
    doc: "All information, including the number of k-mers"
    inputBinding:
      position: 1
      prefix: "--all"
  - id: basename
    type: ['null', boolean]
    doc: "Only output basename of files"
    inputBinding:
      position: 1
      prefix: "--basename"
  - id: out_file
    type: ['null', string]
    default: "unik_info.txt"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: skip_err
    type: ['null', boolean]
    doc: "Skip error, only show warning message"
    inputBinding:
      position: 1
      prefix: "--skip-err"
  - id: symbol_false
    type: ['null', string]
    doc: "Symbol for false (default \"✕\")"
    inputBinding:
      position: 1
      prefix: "--symbol-false"
  - id: symbol_true
    type: ['null', string]
    doc: "Symbol for true (default \"✓\")"
    inputBinding:
      position: 1
      prefix: "--symbol-true"
  - id: tabular
    type: ['null', boolean]
    doc: "Output in machine-friendly tabular format"
    inputBinding:
      position: 1
      prefix: "--tabular"
  - id: unik_files
    type:
      type: array
      items: File
    doc: ".unik files"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_file_out
    type: ['null', File]
    doc: "Output file written with --out-file"
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type: ['null', File]
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_utils_unik_info.out
