cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanosim_read_analysis.py
label: nanosim_read_analysis.py
doc: "A tool for analyzing nanopore reads as part of the NanoSim simulation pipeline.
  Note: The provided text contains container runtime error messages rather than help
  documentation, so no arguments could be extracted.\n\nTool homepage: https://github.com/bcgsc/NanoSim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosim:3.2.3--hdfd78af_0
stdout: nanosim_read_analysis.py.out
