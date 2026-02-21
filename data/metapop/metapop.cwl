cwlVersion: v1.2
class: CommandLineTool
baseCommand: metapop
label: metapop
doc: "A tool for MetaPop analysis (Note: The provided text contains container runtime
  error messages rather than CLI help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://https://github.com/metaGmetapop/metapop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metapop:1.0.2--hdfd78af_1
stdout: metapop.out
