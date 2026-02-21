cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnillumina
label: hmnillumina
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or convert the image due to lack of disk space. It
  does not contain the help text or usage information for the tool 'hmnillumina'.\n
  \nTool homepage: https://github.com/guillaume-gricourt/HmnIllumina"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnillumina:1.5.1--h077b44d_2
stdout: hmnillumina.out
