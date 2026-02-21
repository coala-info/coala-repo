cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervene
label: intervene_bedtools
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool. Intervene
  is a tool for intersection and visualization of genomic sets.\n\nTool homepage:
  https://github.com/asntech/intervene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
stdout: intervene_bedtools.out
