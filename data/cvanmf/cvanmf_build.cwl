cwlVersion: v1.2
class: CommandLineTool
baseCommand: cvanmf_build
label: cvanmf_build
doc: "The provided text appears to be a log from a failed container build process
  (Apptainer/Singularity) rather than help text. No command-line arguments, flags,
  or usage instructions were found in the input.\n\nTool homepage: https://github.com/apduncan/cvanmf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvanmf:1.0.0--pyhdfd78af_0
stdout: cvanmf_build.out
