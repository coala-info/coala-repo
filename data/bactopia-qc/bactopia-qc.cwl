cwlVersion: v1.2
class: CommandLineTool
baseCommand: java
label: bactopia-qc
doc: "Splits paired-end reads into separate files for read 1, read 2, and unpaired
  reads.\n\nTool homepage: https://bactopia.github.io/"
inputs:
  - id: main_class
    type: string
    doc: The main Java class to execute
    inputBinding:
      position: 1
  - id: ain
    type:
      - 'null'
      - string
    doc: Additional input parameter
    inputBinding:
      position: 102
      prefix: ain=
  - id: cp
    type:
      - 'null'
      - string
    doc: Classpath for Java classes
    inputBinding:
      position: 102
  - id: ea
    type:
      - 'null'
      - boolean
    doc: Enable assertions
    inputBinding:
      position: 102
  - id: input_r1
    type: File
    doc: Input file for read 1
    inputBinding:
      position: 102
      prefix: in=
  - id: input_r2
    type: File
    doc: Input file for read 2
    inputBinding:
      position: 102
      prefix: in2=
  - id: xmx
    type:
      - 'null'
      - string
    doc: Maximum heap size for the Java Virtual Machine
    inputBinding:
      position: 102
  - id: output_r1_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_r1_path`
    inputBinding:
      position: 103
      prefix: --output-r1
  - id: output_r2_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_r2_path`
    inputBinding:
      position: 104
      prefix: --output-r2
  - id: output_singles_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_singles_path`
    inputBinding:
      position: 105
      prefix: --output-singles
outputs:
  - id: output_r1
    type:
      - 'null'
      - File
    doc: Output file for repaired read 1
    outputBinding:
      glob: $(inputs.output_r1_path)
  - id: output_r2
    type:
      - 'null'
      - File
    doc: Output file for repaired read 2
    outputBinding:
      glob: $(inputs.output_r2_path)
  - id: output_singles
    type:
      - 'null'
      - File
    doc: Output file for unpaired reads
    outputBinding:
      glob: $(inputs.output_singles_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
