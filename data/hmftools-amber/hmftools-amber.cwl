cwlVersion: v1.2
class: CommandLineTool
baseCommand: amber
label: hmftools-amber
doc: "The provided text is an error log indicating a failure to pull or run the container
  image (no space left on device) and does not contain help information or argument
  definitions.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/amber"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-amber:4.2--hdfd78af_0
stdout: hmftools-amber.out
