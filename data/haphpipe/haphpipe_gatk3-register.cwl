cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe_gatk3-register
label: haphpipe_gatk3-register
doc: "A tool to register the GATK3 jar file within the haphpipe environment. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_gatk3-register.out
