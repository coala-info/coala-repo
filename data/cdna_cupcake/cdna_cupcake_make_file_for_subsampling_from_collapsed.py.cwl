cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_make_file_for_subsampling_from_collapsed.py
label: cdna_cupcake_make_file_for_subsampling_from_collapsed.py
doc: "A tool from the cDNA_Cupcake suite for preparing files for subsampling from
  collapsed transcripts. (Note: The provided help text contained system error messages
  and did not list specific arguments.)\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_make_file_for_subsampling_from_collapsed.py.out
