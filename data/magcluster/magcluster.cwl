cwlVersion: v1.2
class: CommandLineTool
baseCommand: magcluster
label: magcluster
doc: "A tool for clustering Metagenome-Assembled Genomes (MAGs). Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/runjiaji/magcluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
stdout: magcluster.out
