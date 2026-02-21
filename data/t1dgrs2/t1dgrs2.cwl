cwlVersion: v1.2
class: CommandLineTool
baseCommand: t1dgrs2
label: t1dgrs2
doc: "The provided text appears to be a container engine log (Apptainer/Singularity)
  reporting a fatal error during an image build process, rather than the help text
  for the 't1dgrs2' tool itself. As a result, no command-line arguments or descriptions
  could be extracted from this specific input.\n\nTool homepage: https://github.com/t2diabetesgenes/t1dgrs2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1dgrs2:0.1.2--pyhdfd78af_0
stdout: t1dgrs2.out
