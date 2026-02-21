cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - neffy-cli
  - neff
label: neffy-cli_neff
doc: "A command-line tool from the neffy-cli package. (Note: The provided text is
  a system error message regarding container execution and does not contain the tool's
  help documentation or argument definitions.)\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
stdout: neffy-cli_neff.out
