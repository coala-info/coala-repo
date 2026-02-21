cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyasn1-modules
label: pyasn1-modules
doc: "A collection of ASN.1 modules for Python (Note: The provided text is a container
  build error log and does not contain CLI help information).\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyasn1-modules:0.0.8--py35_0
stdout: pyasn1-modules.out
