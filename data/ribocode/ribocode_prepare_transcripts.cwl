cwlVersion: v1.2
class: CommandLineTool
baseCommand: prepare_transcripts
label: ribocode_prepare_transcripts
doc: "This script is designed for preparing transcripts annotation files.\n\nTool
  homepage: https://github.com/xryanglab/RiboCode"
inputs:
  - id: genome_fasta
    type: File
    doc: The genome sequences file in fasta format.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gtf_file
    type: File
    doc: 'Default, suitable for GENCODE and ENSEMBL GTF file, please refer: https://en.wikipedia.org/wiki/GENCODE,
      or using GTFupdate command to update your GTF file.'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: out_dir
    type: Directory
    doc: annotation directory name.
    inputBinding:
      position: 101
      prefix: --out_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_prepare_transcripts.out
