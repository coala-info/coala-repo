cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaprokka_prokka-gv
label: metaprokka_prokka-gv
doc: "Prokaryotic genome annotation tool (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/telatin/metaprokka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0
stdout: metaprokka_prokka-gv.out
