cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryptogenotyper
label: crypto_typer
doc: "A tool for Cryptosporidium parvum and C. hominis subtyping (Note: The provided
  text appears to be a container build log rather than help text; no arguments could
  be extracted from the input).\n\nTool homepage: https://github.com/christineyanta/crypto_typer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryptogenotyper:1.5.0--pyhdfd78af_3
stdout: crypto_typer.out
