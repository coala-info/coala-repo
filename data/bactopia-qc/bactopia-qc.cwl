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
    default: /usr/local/opt/bbmap-39.08-0/current/
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
    default: 34970m
    inputBinding:
      position: 102
outputs:
  - id: output_r1
    type:
      - 'null'
      - File
    doc: Output file for repaired read 1
    outputBinding:
      glob: $(inputs.output_r1)
  - id: output_r2
    type:
      - 'null'
      - File
    doc: Output file for repaired read 2
    outputBinding:
      glob: $(inputs.output_r2)
  - id: output_singles
    type:
      - 'null'
      - File
    doc: Output file for unpaired reads
    outputBinding:
      glob: $(inputs.output_singles)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
