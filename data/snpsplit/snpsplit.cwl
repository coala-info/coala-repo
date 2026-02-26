cwlVersion: v1.2
class: CommandLineTool
baseCommand: SNPsplit
label: snpsplit
doc: "SNPsplit is a tool to sort alignments (SAM/BAM files) into specific alleles
  based on SNP information.\n\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input SAM/BAM file(s) to be split.
    inputBinding:
      position: 1
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Input files are in BAM format (default).
    inputBinding:
      position: 102
      prefix: --bam
  - id: bisulfite
    type:
      - 'null'
      - boolean
    doc: Bisulfite-seq mode. This will assume that the input files are 
      Bismark-aligned files.
    inputBinding:
      position: 102
      prefix: --bisulfite
  - id: conflicting
    type:
      - 'null'
      - boolean
    doc: Report alignments that contain conflicting SNP information.
    inputBinding:
      position: 102
      prefix: --conflicting
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Input files are paired-end.
    inputBinding:
      position: 102
      prefix: --paired
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Input files are in SAM format.
    inputBinding:
      position: 102
      prefix: --sam
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Input files are single-end.
    inputBinding:
      position: 102
      prefix: --single_end
  - id: snp_file
    type: File
    doc: Mandatory SNP file containing the positions of all SNPs to be 
      considered.
    inputBinding:
      position: 102
      prefix: --snp_file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output for debugging.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsplit:0.6.0--hdfd78af_0
stdout: snpsplit.out
