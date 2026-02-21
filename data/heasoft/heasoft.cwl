cwlVersion: v1.2
class: CommandLineTool
baseCommand: heasoft
label: heasoft
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull the HEASoft image due to insufficient disk space, rather
  than CLI help text. No arguments could be extracted.\n\nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft.out
