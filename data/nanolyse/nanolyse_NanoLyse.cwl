cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoLyse
label: nanolyse_NanoLyse
doc: "Remove reads mapping to DNA CS. Reads fastq on stdin and writes to stdout.\n\
  \nTool homepage: https://github.com/wdecoster/NanoLyse"
inputs:
  - id: reference
    type:
      - 'null'
      - File
    doc: Specify a fasta file against which to filter. Standard is DNA CS.
    inputBinding:
      position: 101
      prefix: --reference
  - id: summary_in
    type:
      - 'null'
      - File
    doc: Summary file to filter
    inputBinding:
      position: 101
      prefix: --summary_in
outputs:
  - id: summary_out
    type:
      - 'null'
      - File
    doc: 'with --summary_in: name of output file.'
    outputBinding:
      glob: $(inputs.summary_out)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Specify the path and filename for the log file.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanolyse:1.2.1--pyhdfd78af_0
