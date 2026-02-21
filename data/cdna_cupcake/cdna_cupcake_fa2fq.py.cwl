cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdna_cupcake_fa2fq.py
label: cdna_cupcake_fa2fq.py
doc: "Convert FASTA format files to FASTQ format. (Note: The provided help text contained
  system error logs; arguments are derived from the tool's standard usage).\n\nTool
  homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs:
  - id: fasta_filename
    type: File
    doc: Input FASTA file to be converted
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
stdout: cdna_cupcake_fa2fq.py.out
