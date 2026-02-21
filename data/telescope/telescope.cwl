cwlVersion: v1.2
class: CommandLineTool
baseCommand: telescope
label: telescope
doc: "The provided text is a container engine error log and does not contain CLI help
  information or argument definitions. Telescope is a computational tool for quantifying
  transposable element expression from RNA-seq data.\n\nTool homepage: https://github.com/mlbendall/telescope"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/telescope:1.0.3--py36h14c3975_0
stdout: telescope.out
