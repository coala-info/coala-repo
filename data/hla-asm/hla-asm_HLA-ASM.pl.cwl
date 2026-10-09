cwlVersion: v1.2
class: CommandLineTool
baseCommand: HLA-ASM.pl
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
  - id: truth
    type:
      - 'null'
      - File
    doc: An HLA truth file (optional), used to compare the called HLA types with
      known sample HLA types
    inputBinding:
      position: 101
      prefix: --truth
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output of HLA*ASM (output_HLA_ASM/<sampleID>, with summary.txt)
    outputBinding:
      glob: output_HLA_ASM/$(inputs.sample_id)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-asm:1.0.1--pl5321hdfd78af_0
stdout: hla-asm_HLA-ASM.pl.out
