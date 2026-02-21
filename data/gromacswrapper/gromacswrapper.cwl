cwlVersion: v1.2
class: CommandLineTool
baseCommand: gromacswrapper
label: gromacswrapper
doc: "A Python wrapper for the GROMACS molecular dynamics software. (Note: The provided
  help text contains only container runtime error messages and no argument definitions.)\n
  \nTool homepage: https://github.com/Becksteinlab/GromacsWrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gromacswrapper:0.8.2--pyh5e36f6f_0
stdout: gromacswrapper.out
