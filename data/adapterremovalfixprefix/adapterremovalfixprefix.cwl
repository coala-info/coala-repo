cwlVersion: v1.2
class: CommandLineTool
baseCommand: adapterremovalfixprefix
label: adapterremovalfixprefix
doc: "A tool to fix prefixes in AdapterRemoval output. (Note: The provided text is
  a container execution error log and does not contain usage information or argument
  definitions).\n\nTool homepage: https://github.com/apeltzer/AdapterRemovalFixPrefix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adapterremovalfixprefix:0.0.5--0
stdout: adapterremovalfixprefix.out
