cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_strandedness
label: how_are_we_stranded_here_check_strandedness
doc: "A tool to check the strandedness of RNA-seq data.\n\nTool homepage: https://github.com/betsig/how_are_we_stranded_here"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
stdout: how_are_we_stranded_here_check_strandedness.out
