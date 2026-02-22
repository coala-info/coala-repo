cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbptyper
label: pbptyper
doc: "Penicillin-binding protein (PBP) typer for Streptococcus pneumoniae. Note: The
  provided text contains system error messages regarding container execution and disk
  space, rather than the tool's help documentation.\n\nTool homepage: https://github.com/rpetit3/pbptyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbptyper:2.0.0--hdfd78af_0
stdout: pbptyper.out
