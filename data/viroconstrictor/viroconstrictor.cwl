cwlVersion: v1.2
class: CommandLineTool
baseCommand: viroconstrictor
label: viroconstrictor
doc: "The provided text appears to be a system log or error message from a container
  runtime (Singularity/Apptainer) rather than the help text for the tool 'viroconstrictor'.
  As a result, no command-line arguments, flags, or tool descriptions could be extracted
  from this input.\n\nTool homepage: https://rivm-bioinformatics.github.io/ViroConstrictor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viroconstrictor:1.6.3--pyhdfd78af_0
stdout: viroconstrictor.out
