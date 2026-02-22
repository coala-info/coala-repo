cwlVersion: v1.2
class: CommandLineTool
baseCommand: biopython
label: biopython
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  http://www.biopython.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopython:1.84
stdout: biopython.out
