cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo_make-consensi.py
label: dunovo_make-consensi.py
doc: "The provided help text contains only system error messages related to a container
  environment (Singularity/Apptainer) and does not contain usage information for the
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_make-consensi.py.out
