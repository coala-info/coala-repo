cwlVersion: v1.2
class: CommandLineTool
baseCommand: mupbwt_mem_sample.py
label: mupbwt_mem_sample.py
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image acquisition (no
  space left on device).\n\nTool homepage: https://github.com/dlcgold/muPBWT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mupbwt:0.1.2--h5ca1c30_5
stdout: mupbwt_mem_sample.py.out
