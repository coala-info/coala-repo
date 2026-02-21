cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-corrprofile
label: dnp-corrprofile
doc: "A tool for DNP (Dynamic Nuclear Polarization) correlation profiling. (Note:
  The provided text contains system error messages regarding container image conversion
  and does not include specific usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-corrprofile:1.0--hd6d6fdc_6
stdout: dnp-corrprofile.out
