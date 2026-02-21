cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal-gv_parallel-prodigal-gv.py
label: prodigal-gv_parallel-prodigal-gv.py
doc: "A parallelized version of Prodigal-GV (Gene caller for Viruses). Note: The provided
  text contains system logs and error messages rather than command-line help documentation;
  therefore, no arguments could be extracted.\n\nTool homepage: https://github.com/apcamargo/prodigal-gv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal-gv:2.11.0--h577a1d6_5
stdout: prodigal-gv_parallel-prodigal-gv.py.out
