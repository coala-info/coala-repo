cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_filter_away_subset.py
label: cdna_cupcake_filter_away_subset.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_filter_away_subset.py.out
