cwlVersion: v1.2
class: CommandLineTool
baseCommand: rb
label: rustybam_rb
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/execution (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/mrvollger/rustybam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_rb.out
