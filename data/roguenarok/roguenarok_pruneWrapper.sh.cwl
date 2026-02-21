cwlVersion: v1.2
class: CommandLineTool
baseCommand: roguenarok_pruneWrapper.sh
label: roguenarok_pruneWrapper.sh
doc: "A wrapper script for RogueNaRok, a tool for identifying and removing rogue taxa
  from phylogenetic tree sets. Note: The provided help text contains only system execution
  errors and no argument definitions.\n\nTool homepage: https://github.com/aberer/RogueNaRok"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/roguenarok:v1.0-3-deb_cv1
stdout: roguenarok_pruneWrapper.sh.out
