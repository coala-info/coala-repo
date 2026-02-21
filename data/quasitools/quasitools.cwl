cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasitools
label: quasitools
doc: "A collection of tools for analyzing viral quasispecies. (Note: The provided
  text is a container runtime error log and does not contain CLI help information
  or argument definitions.)\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
stdout: quasitools.out
