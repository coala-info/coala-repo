cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmasker
label: kmasker
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for kmasker. As a result, no arguments
  could be extracted.\n\nTool homepage: https://kmasker.ipk-gatersleben.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmasker:1.1.1--py36pl526r36hc9558a2_0
stdout: kmasker.out
