cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-corrprofile
label: dnp-corrprofile_dnp-diprofile
doc: "The provided text does not contain help information as it is a system error
  log regarding container image conversion and disk space. No arguments could be extracted.\n
  \nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-corrprofile:1.0--hd6d6fdc_6
stdout: dnp-corrprofile_dnp-diprofile.out
