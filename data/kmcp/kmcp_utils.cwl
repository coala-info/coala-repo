cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp utils
label: kmcp_utils
doc: "Some utilities\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: infile_list
    type:
      - 'null'
      - string
    doc: File of input files list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to file 
      with --log.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_utils.out
