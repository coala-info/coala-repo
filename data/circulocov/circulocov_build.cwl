cwlVersion: v1.2
class: CommandLineTool
baseCommand: circulocov_build
label: circulocov_build
doc: "The provided text appears to be a log of a failed container build process (Apptainer/Singularity)
  rather than the help documentation for the tool itself. No command-line arguments
  or usage instructions were found in the input.\n\nTool homepage: https://github.com/erinyoung/CirculoCov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circulocov:0.1.20240104--pyhdfd78af_0
stdout: circulocov_build.out
