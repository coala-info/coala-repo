cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftoff
label: liftoff
doc: "Liftoff is a tool to lift over gene annotations between assemblies. (Note: The
  provided text is an error log and does not contain usage information or argument
  definitions.)\n\nTool homepage: https://github.com/agshumate/Liftoff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftoff:1.6.3--pyhdfd78af_0
stdout: liftoff.out
