cwlVersion: v1.2
class: CommandLineTool
baseCommand: reprof
label: reprof_reprofed
doc: "A tool for protein secondary structure and solvent accessibility prediction
  (Note: The provided help text contains only system logs and build errors, no specific
  arguments could be extracted).\n\nTool homepage: https://github.com/ephmo/reprofed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/reprof:v1.0.1-6-deb_cv1
stdout: reprof_reprofed.out
