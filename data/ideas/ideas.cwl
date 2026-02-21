cwlVersion: v1.2
class: CommandLineTool
baseCommand: ideas
label: ideas
doc: "The provided text is a container runtime error log (Apptainer/Singularity) and
  does not contain the help documentation or argument definitions for the 'ideas'
  tool.\n\nTool homepage: https://github.com/yuzhang123/IDEAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ideas:1.20--h9948957_7
stdout: ideas.out
