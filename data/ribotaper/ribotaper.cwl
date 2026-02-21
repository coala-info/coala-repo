cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotaper
label: ribotaper
doc: "The provided text does not contain help information for ribotaper. It contains
  error logs related to an Apptainer/Singularity container build failure.\n\nTool
  homepage: https://github.com/boboppie/RiboTaper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper.out
