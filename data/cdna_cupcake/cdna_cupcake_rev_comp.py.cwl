cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_rev_comp.py
label: cdna_cupcake_rev_comp.py
doc: "A tool from the cDNA_Cupcake suite, likely used for reverse complementing sequences.
  (Note: The provided text is a system error log regarding container extraction and
  does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_rev_comp.py.out
