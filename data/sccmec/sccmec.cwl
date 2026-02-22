cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccmec
label: sccmec
doc: "A tool for Staphylococcal Cassette Chromosome mec (SCCmec) typing. (Note: The
  provided help text contains only system error messages and no usage information.)\n\
  \nTool homepage: https://github.com/rpetit3/sccmec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
stdout: sccmec.out
