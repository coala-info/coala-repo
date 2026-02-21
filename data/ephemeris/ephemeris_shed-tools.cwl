cwlVersion: v1.2
class: CommandLineTool
baseCommand: shed-tools
label: ephemeris_shed-tools
doc: "The provided text is an error log related to a container runtime (Singularity/Apptainer)
  failure and does not contain help documentation or argument definitions for the
  tool.\n\nTool homepage: https://github.com/galaxyproject/ephemeris"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
stdout: ephemeris_shed-tools.out
