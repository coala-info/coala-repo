cwlVersion: v1.2
class: CommandLineTool
baseCommand: levenshtein
label: levenshtein
doc: "The provided text does not contain help information or usage instructions for
  the tool 'levenshtein'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to pull a container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/ka-weihe/fastest-levenshtein"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/levenshtein:0.20.1
stdout: levenshtein.out
