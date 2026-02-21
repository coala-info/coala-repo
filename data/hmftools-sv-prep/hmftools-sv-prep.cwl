cwlVersion: v1.2
class: CommandLineTool
baseCommand: sv-prep
label: hmftools-sv-prep
doc: "Structural Variant preparation tool (Note: The provided text contains only container
  execution logs and error messages, no help documentation was found to extract arguments).\n
  \nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/sv-prep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-sv-prep:1.2.4--hdfd78af_0
stdout: hmftools-sv-prep.out
