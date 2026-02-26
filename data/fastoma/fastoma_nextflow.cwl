cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow
label: fastoma_nextflow
doc: "Nextflow is a workflow system that enables reproducible and scalable scientific
  computing.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: background
    type:
      - 'null'
      - boolean
    doc: Execute nextflow in background
    inputBinding:
      position: 101
      prefix: -bg
  - id: config
    type:
      - 'null'
      - File
    doc: Add the specified file to configuration set
    inputBinding:
      position: 101
      prefix: -config
  - id: config_file
    type:
      - 'null'
      - File
    doc: Use the specified configuration file(s) overriding any defaults
    inputBinding:
      position: 101
      prefix: -C
  - id: config_ignore_includes
    type:
      - 'null'
      - boolean
    doc: Disable the parsing of config includes
    inputBinding:
      position: 101
      prefix: -config-ignore-includes
  - id: jvm_properties
    type:
      - 'null'
      - string
    doc: Set JVM properties
    inputBinding:
      position: 101
      prefix: -D
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set nextflow log file path
    inputBinding:
      position: 101
      prefix: -log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print information messages
    inputBinding:
      position: 101
      prefix: -quiet
  - id: remote_debug
    type:
      - 'null'
      - boolean
    doc: Enable JVM interactive remote debugging (experimental)
    inputBinding:
      position: 101
      prefix: -remote-debug
  - id: syslog
    type:
      - 'null'
      - string
    doc: Send logs to syslog server (eg. localhost:514)
    inputBinding:
      position: 101
      prefix: -syslog
  - id: trace
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable trace level logging for the specified package name - multiple 
      packages can be provided separating them with a comma e.g. '-trace 
      nextflow,io.seqera'
    inputBinding:
      position: 101
      prefix: -trace
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_nextflow.out
