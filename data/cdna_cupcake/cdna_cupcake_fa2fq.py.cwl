cwlVersion: v1.2
class: CommandLineTool
baseCommand: fa2fq.py
label: cdna_cupcake_fa2fq.py
doc: "Convert fasta to fastq. The output is written next to the input as <name>.fastq
  with all qualities set to 60.\n\nTool homepage: https://github.com/Magdoll/cDNA_Cupcake"
inputs:
  - id: fasta_filename
    type: File
    doc: input fasta (must end with .fasta or .fa)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: output_fastq
    type: File
    doc: FASTQ file (<input name without extension>.fastq)
    outputBinding:
      glob: $(inputs.fasta_filename.nameroot).fastq
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdna_cupcake:29.0.0--py310h79ef01b_0
