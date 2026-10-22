cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segul, read, summary]
label: segul_read_summary
doc: "Compute sequence read statistics\n\nTool homepage: https://github.com/hhandika/segul"
inputs:
  - id: dir
    type: ['null', Directory]
    doc: "Input a directory"
    inputBinding:
      position: 1
      prefix: "--dir"
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input path(s)"
    inputBinding:
      position: 1
      prefix: "--input"
  - id: force
    type: ['null', boolean]
    doc: "Force overwriting existing output files/directory"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: input_format
    type: ['null', string]
    doc: "Input format: auto, fastq, gzip (default auto)"
    inputBinding:
      position: 1
      prefix: "--input-format"
  - id: mode
    type: ['null', string]
    doc: "Summary mode: minimal, default, complete"
    inputBinding:
      position: 1
      prefix: "--mode"
  - id: output
    type: string
    default: "Read-Summary"
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: log
    type: string
    default: "segul.log"
    doc: "Log file path"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: prefix
    type: ['null', string]
    doc: "Prefix for output files"
    inputBinding:
      position: 1
      prefix: "--prefix"
outputs:
  - id: output_path
    type: [File, Directory]
    doc: Output file or directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type: ['null', File]
    doc: Log file
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segul:0.23.2--hc1c3326_0
stdout: segul_read_summary.out
