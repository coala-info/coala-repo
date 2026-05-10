cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibeliaz
label: sibeliaz
doc: "Process input file and generate output in a specified directory.\n\nTool homepage:
  https://github.com/medvedevgroup/SibeliaZ"
inputs:
  - id: input_file
    type: File
    doc: Input file.
    inputBinding:
      position: 1
  - id: flag_n
    type:
      - 'null'
      - boolean
    doc: A boolean flag.
    inputBinding:
      position: 102
      prefix: -n
  - id: integer_a
    type:
      - 'null'
      - int
    doc: An integer parameter.
    inputBinding:
      position: 102
      prefix: -a
  - id: integer_b
    type:
      - 'null'
      - int
    doc: An integer parameter.
    inputBinding:
      position: 102
      prefix: -b
  - id: integer_f
    type:
      - 'null'
      - int
    doc: An integer parameter.
    inputBinding:
      position: 102
      prefix: -f
  - id: integer_m
    type:
      - 'null'
      - int
    doc: An integer parameter.
    inputBinding:
      position: 102
      prefix: -m
  - id: integer_t
    type:
      - 'null'
      - int
    doc: An integer parameter.
    inputBinding:
      position: 102
      prefix: -t
  - id: odd_integer_k
    type:
      - 'null'
      - int
    doc: An odd integer parameter.
    inputBinding:
      position: 102
      prefix: -k
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 103
      prefix: --output-directory
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibeliaz:1.2.7--h9948957_0
