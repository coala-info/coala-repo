cwlVersion: v1.2
class: CommandLineTool
baseCommand: prepare_transcripts
label: ribominer_prepare_transcripts
doc: "This script is designed for preparing transcripts annotation files.\n\nTool
  homepage: https://github.com/xryanglab/RiboMiner"
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
outputs:
  - id: out_dir
    type: Directory
    doc: annotation directory name.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribominer:0.2.3.2--pyh5e36f6f_0
