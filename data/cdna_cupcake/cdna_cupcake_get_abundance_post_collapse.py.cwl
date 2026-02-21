cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_get_abundance_post_collapse.py
label: cdna_cupcake_get_abundance_post_collapse.py
doc: "Calculate transcript abundance after collapsing redundant isoforms by mapping
  back to the original cluster reports.\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs:
  - id: collapse_prefix
    type: string
    doc: Prefix of the collapsed output (e.g., the prefix used for .collapsed.gff
      and .collapsed.rep.fq)
    inputBinding:
      position: 1
  - id: cluster_report
    type: File
    doc: The cluster report file (usually cluster_report.csv or similar) from the
      clustering step
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_get_abundance_post_collapse.py.out
