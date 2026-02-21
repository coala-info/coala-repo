cwlVersion: v1.2
class: CommandLineTool
baseCommand: md-cogent_tally_Cogent_contigs_per_family.py
label: md-cogent_tally_Cogent_contigs_per_family.py
doc: "Tally Cogent contigs per family. (Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/Magdoll/Cogent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/md-cogent:8.0.0--pyh3252c3a_0
stdout: md-cogent_tally_Cogent_contigs_per_family.py.out
