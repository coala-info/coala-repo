cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmztabm-cli
label: jmztab-m_jmztabm-cli.jar
doc: "A command-line interface for the mzTab-M format. Note: The provided text contains
  system error logs regarding container execution and does not list specific tool
  arguments.\n\nTool homepage: https://github.com/lifs-tools/jmztab-m"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmztab-m:1.0.6--hdfd78af_1
stdout: jmztab-m_jmztabm-cli.jar.out
