cwlVersion: v1.2
class: CommandLineTool
baseCommand: DISCASM
label: discasm_DISCASM
doc: "Performs de novo transcriptome assembly on discordant and unmapped reads\n\n\
  Tool homepage: https://github.com/DISCASM/DISCASM"
inputs:
  - id: add_trinity_params
    type:
      - 'null'
      - string
    doc: any additional parameters to pass on to Trinity if Trinity is the 
      chosen assembler.
    inputBinding:
      position: 101
      prefix: --add_trinity_params
  - id: aligned_bam
    type:
      - 'null'
      - File
    doc: aligned bam file from your favorite rna-seq alignment tool
    inputBinding:
      position: 101
      prefix: --aligned_bam
  - id: chimeric_junctions
    type: File
    doc: STAR Chimeric.out.junction file
    inputBinding:
      position: 101
      prefix: --chimeric_junctions
  - id: denovo_assembler
    type: string
    doc: 'de novo assembly method: Trinity|Oases|OasesMultiK'
    inputBinding:
      position: 101
      prefix: --denovo_assembler
  - id: left_fq
    type: File
    doc: left fastq file
    inputBinding:
      position: 101
      prefix: --left_fq
  - id: normalize_reads
    type:
      - 'null'
      - boolean
    doc: perform in silico normalization prior to de novo assembly (not needed 
      if using Trinity, since Trinity performs normalization internally
    inputBinding:
      position: 101
      prefix: --normalize_reads
  - id: out_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: right_fq
    type: File
    doc: right fastq file
    inputBinding:
      position: 101
      prefix: --right_fq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discasm:0.1.3--py27pl5.22.0_0
stdout: discasm_DISCASM.out
