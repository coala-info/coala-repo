cwlVersion: v1.2
class: CommandLineTool
baseCommand: clark_classify_metagenome.sh
label: clark_classify_metagenome.sh
doc: "The provided text does not contain help information or usage instructions for
  clark_classify_metagenome.sh. It contains system logs and a fatal error regarding
  container image extraction (no space left on device).\n\nTool homepage: https://github.com/rouni001/CLARK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clark:1.3.0.0--h9948957_0
stdout: clark_classify_metagenome.sh.out
