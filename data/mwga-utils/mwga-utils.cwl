cwlVersion: v1.2
class: CommandLineTool
baseCommand: mwga-utils
label: mwga-utils
doc: "Multiple Whole Genome Alignment utilities. (Note: The provided text is a system
  error log indicating a failure to pull the container image due to lack of disk space
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/RomainFeron/mgwa_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils.out
