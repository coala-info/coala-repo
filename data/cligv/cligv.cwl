cwlVersion: v1.2
class: CommandLineTool
baseCommand: cligv
label: cligv
doc: "command line Interactive Genome Viewer. Displays FASTA sequence, VCF variants,
  and BAM alignments.\n\nTool homepage: https://github.com/jonasfreudig/cligv"
inputs:
  - id: fasta
    type: File
    doc: Path to the reference genome FASTA file (indexed with .fai)
    inputBinding:
      position: 1
  - id: bam
    type:
      - 'null'
      - File
    doc: Path to BAM file (indexed with .bai or .csi)
    inputBinding:
      position: 102
      prefix: --bam
  - id: light_mode
    type:
      - 'null'
      - boolean
    doc: Use light color theme (for light background terminals)
    inputBinding:
      position: 102
      prefix: --light-mode
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: region
    type:
      - 'null'
      - string
    doc: Initial region (e.g., chr1:1000-2000, chrX:50000, chrY)
    inputBinding:
      position: 102
      prefix: --region
  - id: tag
    type:
      - 'null'
      - string
    doc: BAM tag name to use for coloring reads (e.g., 'ha' to use haplotype 
      tags of STAR diploid)
    inputBinding:
      position: 102
      prefix: --tag
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to VCF file (indexed with tabix)
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cligv:0.1.0--pyhdfd78af_0
stdout: cligv.out
