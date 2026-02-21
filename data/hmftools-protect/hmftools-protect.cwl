cwlVersion: v1.2
class: CommandLineTool
baseCommand: protect
label: hmftools-protect
doc: "The provided text does not contain help information or usage instructions; it
  is a container execution error log indicating a failure to build the SIF image due
  to insufficient disk space.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/protect/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-protect:2.3--hdfd78af_0
stdout: hmftools-protect.out
