cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50
label: n50
doc: "A tool for calculating N50 and other assembly statistics. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: http://metacpan.org/pod/Proch::N50"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50.out
