cwlVersion: v1.2
class: CommandLineTool
baseCommand: midas_run_midas.py
label: midas_run_midas.py
doc: "Metagenomic Intra-Species Diversity Analysis System (Note: The provided text
  is an error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/snayfach/MIDAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
stdout: midas_run_midas.py.out
