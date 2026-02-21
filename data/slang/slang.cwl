cwlVersion: v1.2
class: CommandLineTool
baseCommand: slang
label: slang
doc: "The provided text appears to be an error log from a container build process
  (Apptainer/Singularity) rather than the help text for the 'slang' tool itself. As
  a result, no command-line arguments, flags, or options could be extracted from the
  input.\n\nTool homepage: https://github.com/shader-slang/slang"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slang:2.3.0--hd3527cb_3
stdout: slang.out
