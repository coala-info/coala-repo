cwlVersion: v1.2
class: CommandLineTool
baseCommand: nifflr_nifflr.sh
label: nifflr_nifflr.sh
doc: "A tool for processing sequencing data (Note: The provided text is a system error
  log and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/alguoo314/NIFFLR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nifflr:2.0.0--pl5321haf24da9_0
stdout: nifflr_nifflr.sh.out
