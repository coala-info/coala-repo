cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_abundance_post_collapse.py
label: cdna_cupcake_get_abundance_post_collapse.py
doc: "Get abundance/read stat information after running collapse script. Works for
  Iso-Seq1, 2, and 3 output.\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs:
  - id: collapse_prefix
    type: string
    doc: Collapse prefix (must have .group.txt), e.g. test.collapsed
    inputBinding:
      position: 1
  - id: group_file
    type: File
    doc: The <collapse_prefix>.group.txt file from collapse_isoforms_by_sam.py; 
      staged as <collapse_prefix>.group.txt
  - id: cluster_report
    type: File
    doc: Cluster CSV report
    inputBinding:
      position: 2
outputs:
  - id: read_stat
    type: File
    doc: Read stat file (<collapse_prefix>.read_stat.txt)
    outputBinding:
      glob: $(inputs.collapse_prefix).read_stat.txt
  - id: abundance
    type: File
    doc: Abundance file (<collapse_prefix>.abundance.txt)
    outputBinding:
      glob: $(inputs.collapse_prefix).abundance.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.group_file)
        entryname: $(inputs.collapse_prefix).group.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
