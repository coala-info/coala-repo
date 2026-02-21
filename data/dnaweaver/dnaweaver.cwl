cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaweaver
label: dnaweaver
doc: "DNAweaver is a tool for finding optimal DNA assembly strategies. (Note: The
  provided text is a container runtime error log and does not contain the standard
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/Edinburgh-Genome-Foundry/DnaWeaver/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaweaver:v0.3.7--pyhdfd78af_0
stdout: dnaweaver.out
