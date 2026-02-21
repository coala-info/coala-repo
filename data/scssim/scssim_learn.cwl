cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scssim
  - learn
label: scssim_learn
doc: "Learn parameters from a normal BAM file for single-cell sequencing simulation\n
  \nTool homepage: https://github.com/qasimyu/scssim"
inputs:
  - id: bam
    type: File
    doc: normal BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: kmer
    type:
      - 'null'
      - int
    doc: the length of kmer sequence
    default: 3
    inputBinding:
      position: 101
      prefix: --kmer
  - id: ref
    type: File
    doc: genome reference file (.fasta) to which the reads were aligned
    inputBinding:
      position: 101
      prefix: --ref
  - id: samtools
    type:
      - 'null'
      - File
    doc: the path of samtools
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: target
    type:
      - 'null'
      - File
    doc: exome target file (.bed) for whole-exome sequencing
    default: 'null'
    inputBinding:
      position: 101
      prefix: --target
  - id: vcf
    type: File
    doc: the VCF file generated from the normal BAM
    inputBinding:
      position: 101
      prefix: --vcf
  - id: wsize
    type:
      - 'null'
      - int
    doc: the length of windows used to infer GC-content bias
    default: 1000
    inputBinding:
      position: 101
      prefix: --wsize
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scssim:1.0--h9948957_5
