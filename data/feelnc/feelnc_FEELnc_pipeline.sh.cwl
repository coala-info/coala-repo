cwlVersion: v1.2
class: CommandLineTool
baseCommand: FEELnc_pipeline.sh
label: feelnc_FEELnc_pipeline.sh
doc: "FEELnc pipeline for transcript model annotation.\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs:
  - id: candidate
    type: File
    doc: Transcript model GTF file
    inputBinding:
      position: 101
      prefix: --candidate
  - id: genome
    type: File
    doc: Genome sequence FASTA file
    inputBinding:
      position: 101
      prefix: --genome
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outname
    type: string
    doc: Output name prefix
    inputBinding:
      position: 101
      prefix: --outname
  - id: reference
    type: File
    doc: Reference GTF file
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_pipeline.sh.out
