cwlVersion: v1.2
class: CommandLineTool
baseCommand: smallgenomeutilities
label: smallgenomeutilities
doc: "A collection of scripts for processing and analyzing small genomes (e.g., viral
  genomes). Note: The provided text appears to be a container build log rather than
  help text.\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities.out
