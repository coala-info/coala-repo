cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mwga-utils
  - missing_regions
label: mwga-utils_missing_regions
doc: "A tool from the mwga-utils suite (Multiple Whole Genome Alignment utilities).
  No description or usage information was provided in the help text.\n\nTool homepage:
  https://github.com/RomainFeron/mgwa_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_missing_regions.out
