cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_fq2fa.py
label: cdna_cupcake_fq2fa.py
doc: "A tool to convert FASTQ files to FASTA format (Note: The provided help text
  contains system error messages and does not list command-line arguments).\n\nTool
  homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_fq2fa.py.out
