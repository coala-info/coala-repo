cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-corrprofile_dnp-correlation-between-profiles.sh
label: dnp-corrprofile_dnp-correlation-between-profiles.sh
doc: "A tool to calculate the correlation between profiles. (Note: The provided help
  text contains only system error messages regarding container image acquisition and
  does not list specific arguments.)\n\nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-corrprofile:1.0--hd6d6fdc_6
stdout: dnp-corrprofile_dnp-correlation-between-profiles.sh.out
