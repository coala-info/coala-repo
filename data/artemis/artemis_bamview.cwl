cwlVersion: v1.2
class: CommandLineTool
baseCommand: artemis_bamview
label: artemis_bamview
doc: "Starting BamView with arguments\n\nTool homepage: http://sanger-pathogens.github.io/Artemis/"
inputs:
  - id: artemis_environment
    type:
      - 'null'
      - string
    doc: Artemis environment setting
    inputBinding:
      position: 101
      prefix: -Dartemis.environment
  - id: jdbc_drivers
    type:
      - 'null'
      - string
    doc: JDBC drivers to use
    inputBinding:
      position: 101
      prefix: -Djdbc.drivers
  - id: max_heap_size
    type:
      - 'null'
      - string
    doc: Maximum heap size
    inputBinding:
      position: 101
      prefix: -mx
  - id: max_stack_size
    type:
      - 'null'
      - string
    doc: Maximum stack size
    inputBinding:
      position: 101
      prefix: -ms
  - id: no_verify
    type:
      - 'null'
      - boolean
    doc: Disable verification
    inputBinding:
      position: 101
      prefix: -noverify
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artemis:18.2.0--hdfd78af_0
stdout: artemis_bamview.out
