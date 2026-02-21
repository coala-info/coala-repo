cwlVersion: v1.2
class: CommandLineTool
baseCommand: pplacer_deduplicate_sequences.py
label: pplacer_deduplicate_sequences.py
doc: "Deduplicate sequences (Note: The provided text contains container runtime errors
  and does not include the tool's help documentation.)\n\nTool homepage: http://matsen.fredhutch.org/pplacer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pplacer:1.1.alpha17--0
stdout: pplacer_deduplicate_sequences.py.out
