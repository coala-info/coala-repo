cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdmix_summary.sh
label: ibdmix_summary.sh
doc: "A script to summarize ibdmix results. (Note: The provided text contains system
  error logs and does not include usage instructions or argument definitions.)\n\n
  Tool homepage: https://github.com/PrincetonUniversity/IBDmix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
stdout: ibdmix_summary.sh.out
