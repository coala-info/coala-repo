cwlVersion: v1.2
class: CommandLineTool
baseCommand: patchify
label: patchify
doc: "No description available (provided text is an error log).\n\nTool homepage:
  https://github.com/dovahcrow/patchify.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/patchify:0.2.3--pyhdfd78af_0
stdout: patchify.out
