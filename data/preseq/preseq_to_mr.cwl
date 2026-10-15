cwlVersion: v1.2
class: CommandLineTool
baseCommand: to-mr
label: preseq_to_mr
doc: "to-mr converts the SAM/BAM output from a read mapper to the MethPipe mapped read (MR) format used by preseq.

Tool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: "Input SAM or BAM file"
    inputBinding:
      position: 200
  - id: suffix_length
    type:
      - 'null'
      - int
    doc: "Read name suffix length [1]"
    inputBinding:
      position: 102
      prefix: -s
  - id: max_frag
    type:
      - 'null'
      - int
    doc: "Maximum allowed insert size"
    inputBinding:
      position: 102
      prefix: -L
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print more information"
    inputBinding:
      position: 102
      prefix: -v
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output file name (default: stdout)"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Mapped reads in MR format"
    outputBinding:
      glob: "$(inputs.output_file_path ? inputs.output_file_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_to_mr.out
