cwlVersion: v1.2
class: CommandLineTool
baseCommand: cospar_build
label: cospar_build
doc: "The provided text appears to be a log of a failed container build process (Apptainer/Singularity)
  rather than a help menu. No command-line arguments, flags, or usage instructions
  were found in the text.\n\nTool homepage: https://github.com/ShouWenWang-Lab/cospar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cospar:0.4.1--pyhdfd78af_0
stdout: cospar_build.out
