cwlVersion: v1.2
class: CommandLineTool
baseCommand: pantax
label: pantax
doc: "The provided text contains system error messages related to a failed container
  execution (Singularity/Apptainer) due to lack of disk space, rather than the tool's
  help documentation. Consequently, no arguments or functional descriptions could
  be extracted.\n\nTool homepage: https://github.com/LuoGroup2023/PanTax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantax:2.0.1--py310h3e1df6f_1
stdout: pantax.out
