cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinker
label: clinker
doc: "Clinker Wrapper Script\nThe command clinker will invoke the Clinker bpipe pipeline
  with simple options. Use the direct pipeline method to use any advanced bpipe features.\n\
  See https://github.com/Oshlack/Clinker/wiki/ for further information onusing Clinker.\n\
  \nTool homepage: https://github.com/Oshlack/Clinker"
inputs:
  - id: input_fastq_gz
    type:
      type: array
      items: File
    doc: Input FASTQ files (glob pattern)
    inputBinding:
      position: 1
  - id: pipeline_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options to pass to the bpipe pipeline
    inputBinding:
      position: 102
      prefix: -p
  - id: wrapper_mode
    type:
      - 'null'
      - boolean
    doc: Invoke Clinker in wrapper mode
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinker:1.33--hdfd78af_0
stdout: clinker.out
