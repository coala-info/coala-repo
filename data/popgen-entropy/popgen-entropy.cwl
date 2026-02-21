cwlVersion: v1.2
class: CommandLineTool
baseCommand: entropy
label: popgen-entropy
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or image fetch operation (Singularity/Apptainer).
  No arguments or usage instructions were found in the input.\n\nTool homepage: https://bitbucket.org/buerklelab/mixedploidy-entropy/src/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popgen-entropy:2.0--h60038e2_5
stdout: popgen-entropy.out
