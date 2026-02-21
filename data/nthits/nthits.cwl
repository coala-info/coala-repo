cwlVersion: v1.2
class: CommandLineTool
baseCommand: nthits
label: nthits
doc: "A tool for counting k-mer occurrences (Note: The provided text was a container
  runtime error log and did not contain usage instructions or argument descriptions).\n
  \nTool homepage: https://github.com/bcgsc/ntHits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nthits:1.0.3--h9948957_2
stdout: nthits.out
