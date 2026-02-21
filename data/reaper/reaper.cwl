cwlVersion: v1.2
class: CommandLineTool
baseCommand: reaper
label: reaper
doc: "A tool for processing short-read sequencing data, typically used for adapter
  stripping, quality filtering, and preprocessing. (Note: The provided text contains
  system logs regarding a container build failure and does not include the actual
  command-line help documentation.)\n\nTool homepage: https://www.ebi.ac.uk/~stijn/reaper/reaper.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reaper:16.098--ha92aebf_2
stdout: reaper.out
