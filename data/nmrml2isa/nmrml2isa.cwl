cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmrml2isa
label: nmrml2isa
doc: "Extract meta information from nmrML files and create ISA-tab structure\n\nTool
  homepage: http://github.com/ISA-tools/nmrml2isa"
inputs:
  - id: input_path
    type: Directory
    doc: input folder or archive containing nmrML files
    inputBinding:
      position: 101
      prefix: -i
  - id: jobs
    type:
      - 'null'
      - int
    doc: launch different processes for parsing
    inputBinding:
      position: 101
      prefix: -j
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not show any output
    inputBinding:
      position: 101
      prefix: -q
  - id: study_id
    type: string
    doc: study identifier (e.g. MTBLSxxx)
    inputBinding:
      position: 101
      prefix: -s
  - id: template_dir
    type:
      - 'null'
      - Directory
    doc: directory containing default template files
    inputBinding:
      position: 101
      prefix: -t
  - id: usermeta
    type:
      - 'null'
      - string
    doc: additional user provided metadata (JSON or XLSX format)
    inputBinding:
      position: 101
      prefix: -m
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more output (default if progressbar2 is not installed)
    inputBinding:
      position: 101
      prefix: -v
  - id: warning_control
    type:
      - 'null'
      - string
    doc: warning control (with python default behaviour)
    inputBinding:
      position: 101
      prefix: -W
outputs:
  - id: output_path
    type: Directory
    doc: out folder (a new directory will be created here)
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nmrml2isa:0.3.3--pyhdfd78af_0
