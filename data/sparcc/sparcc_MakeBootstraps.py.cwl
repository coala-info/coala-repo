cwlVersion: v1.2
class: CommandLineTool
baseCommand: sparcc_MakeBootstraps.py
label: sparcc_MakeBootstraps.py
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool.\n
  \nTool homepage: https://bitbucket.org/yonatanf/sparcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparcc:0.1.0--0
stdout: sparcc_MakeBootstraps.py.out
