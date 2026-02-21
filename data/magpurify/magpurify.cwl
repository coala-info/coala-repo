cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify
label: magpurify
doc: "A tool for purifying metagenome-assembled genomes (MAGs). Note: The provided
  help text contains only system error messages and no usage information.\n\nTool
  homepage: https://github.com/snayfach/MAGpurify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
stdout: magpurify.out
