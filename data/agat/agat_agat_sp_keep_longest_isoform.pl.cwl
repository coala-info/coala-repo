cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_keep_longest_isoform.pl
label: agat_agat_sp_keep_longest_isoform.pl
doc: "This script filters a GFF file to keep only the longest isoform (based on CDS
  or exon length) for each gene.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: input_gff
    type: File
    doc: Input GFF3 file.
    inputBinding:
      position: 101
      prefix: --gff
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output GFF file. If no output file is specified, the result will be written
      to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
