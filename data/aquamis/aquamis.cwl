cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquamis
label: aquamis
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system error log from an Apptainer/Singularity build process
  that failed due to insufficient disk space ('no space left on device').\n\nTool
  homepage: https://gitlab.com/bfr_bioinformatics/AQUAMIS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquamis:1.4.0--hdfd78af_0
stdout: aquamis.out
