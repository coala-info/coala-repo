cwlVersion: v1.2
class: CommandLineTool
baseCommand: rs3
label: rs3
doc: "The provided text appears to be a system log or error message from a container
  build process (Singularity/Apptainer) rather than CLI help text. No command-line
  arguments, options, or usage instructions were found in the input.\n\nTool homepage:
  https://github.com/gpp-rnd/rs3/tree/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rs3:0.0.16--pyhdfd78af_0
stdout: rs3.out
