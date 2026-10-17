cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - create_custom_transcriptome_fa.pl
label: psirc_create_custom_transcriptome_fa.pl
doc: "Create a custom transcriptome FASTA from a reference genome FASTA and an annotation GTF\n\nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: reference_fasta
    type: File
    doc: "Reference genome FASTA file (name must end with .fa or .fasta)"
    inputBinding:
      position: 1
  - id: annotation_gtf
    type: File
    doc: "Annotation GTF file"
    inputBinding:
      position: 2
  - id: output_fasta
    type: string
    doc: "Output FASTA file name (must end with .fa or .fasta)"
    inputBinding:
      position: 3
outputs:
  - id: transcriptome_fasta
    type: File
    doc: "Custom transcriptome FASTA"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
