cwlVersion: v1.2
class: CommandLineTool
baseCommand: mfold
label: mfold
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the mfold tool.
  Consequently, no arguments could be parsed.\n\nTool homepage: http://www.unafold.org/mfold/software/download-mfold.php"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mfold:3.6--h8537716_3
stdout: mfold.out
