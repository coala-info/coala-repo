cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_simple_stats_post_collapse.py
label: cdna_cupcake_simple_stats_post_collapse.py
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build/extract the Singularity container due to insufficient
  disk space.\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_simple_stats_post_collapse.py.out
