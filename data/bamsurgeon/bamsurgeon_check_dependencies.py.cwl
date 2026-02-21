cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsurgeon_check_dependencies.py
label: bamsurgeon_check_dependencies.py
doc: "Check dependencies for Bamsurgeon. (Note: The provided help text appears to
  be a container execution log indicating a failure and does not contain usage information
  or argument definitions.)\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
stdout: bamsurgeon_check_dependencies.py.out
