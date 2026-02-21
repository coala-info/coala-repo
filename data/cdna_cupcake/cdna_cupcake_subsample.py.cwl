cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_subsample.py
label: cdna_cupcake_subsample.py
doc: "A tool for subsampling cDNA Cupcake data. (Note: The provided help text contains
  container build error logs and does not list command-line arguments.)\n\nTool homepage:
  https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_subsample.py.out
