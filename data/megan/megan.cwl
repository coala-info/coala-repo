cwlVersion: v1.2
class: CommandLineTool
baseCommand: megan
label: megan
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the MEGAN tool. As a result, no
  arguments could be extracted.\n\nTool homepage: http://ab.inf.uni-tuebingen.de/software/megan6/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megan:6.25.10--h9ee0642_0
stdout: megan.out
