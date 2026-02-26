cwlVersion: v1.2
class: CommandLineTool
baseCommand: hla-asm_HLA-ASM.pl
label: hla-asm_HLA-ASM.pl
doc: "Please specify parameters --assembly_fasta and --sampleID. --assembly_fasta
  should specify a path to a unified FASTA of your assembly with unique contig IDs,
  and sampleID should be an alphanumeric sample ID at /usr/local/bin/HLA-ASM.pl line
  83.\n\nTool homepage: https://github.com/DiltheyLab/HLA-LA/blob/master/HLA-ASM.md"
inputs:
  - id: assembly_fasta
    type: File
    doc: a path to a unified FASTA of your assembly with unique contig IDs
    inputBinding:
      position: 101
      prefix: --assembly_fasta
  - id: sample_id
    type: string
    doc: an alphanumeric sample ID
    inputBinding:
      position: 101
      prefix: --sampleID
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-asm:1.0.1--pl5321hdfd78af_0
stdout: hla-asm_HLA-ASM.pl.out
