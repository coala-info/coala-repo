cwlVersion: v1.2
class: CommandLineTool
baseCommand: arboreto_build
label: arboreto_build
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than the help documentation for the
  'arboreto_build' tool. As a result, no command-line arguments, flags, or positional
  parameters could be extracted.\n\nTool homepage: https://github.com/tmoerman/arboreto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arboreto:0.1.6--pyh7e72e81_1
stdout: arboreto_build.out
