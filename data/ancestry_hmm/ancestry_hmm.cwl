cwlVersion: v1.2
class: CommandLineTool
baseCommand: ancestry_hmm
label: ancestry_hmm
doc: "The provided text does not contain help information or usage instructions for
  ancestry_hmm. It appears to be a log of a failed container build process (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: https://github.com/russcd/Ancestry_HMM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ancestry_hmm-s:0.9.0.2--h9948957_6
stdout: ancestry_hmm.out
