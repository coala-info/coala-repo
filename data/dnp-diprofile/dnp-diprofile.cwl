cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-diprofile
label: dnp-diprofile
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-diprofile:1.0--hd6d6fdc_7
stdout: dnp-diprofile.out
