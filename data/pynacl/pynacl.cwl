cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynacl
label: pynacl
doc: "PyNaCl is a Python binding to the Networking and Cryptography (NaCl) library.
  (Note: The provided text appears to be a container build log error rather than CLI
  help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/pyca/pynacl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynacl:0.3.0--py35_0
stdout: pynacl.out
