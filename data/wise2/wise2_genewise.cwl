cwlVersion: v1.2
class: CommandLineTool
baseCommand: genewise
label: wise2_genewise
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) failing to fetch the image. Genewise
  is typically used for comparing protein sequences to genomic DNA.\n\nTool homepage:
  https://www.ebi.ac.uk/~birney/wise2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h17e8430_6
stdout: wise2_genewise.out
