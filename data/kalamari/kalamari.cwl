cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalamari
label: kalamari
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the kalamari
  tool.\n\nTool homepage: https://github.com/lskatz/kalamari"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalamari:5.8.0--pl5321hdfd78af_0
stdout: kalamari.out
