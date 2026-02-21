cwlVersion: v1.2
class: CommandLineTool
baseCommand: smhasher
label: smhasher
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage information for the smhasher
  tool.\n\nTool homepage: https://github.com/aappleby/smhasher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smhasher:0.150.1--py312hf731ba3_11
stdout: smhasher.out
