cwlVersion: v1.2
class: CommandLineTool
baseCommand: ksnp
label: ksnp
doc: "ksnp\n\nTool homepage: https://github.com/zhouqiansolab/KSNP"
inputs:
  - id: bam_file
    type: File
    doc: aligned reads in BAM format (indexed required)
    inputBinding:
      position: 101
      prefix: -b
  - id: chromosome
    type:
      - 'null'
      - string
    doc: specify a chromosome to phase
    inputBinding:
      position: 101
      prefix: -c
  - id: fasta_file
    type: File
    doc: reference sequence for allele realignment in FASTA format (indexed 
      required)
    inputBinding:
      position: 101
      prefix: -r
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size to construct DBG, currently supporting 2,3,4,5
    inputBinding:
      position: 101
      prefix: -k
  - id: vcf_file
    type: File
    doc: heterozygous variants to phase in VCF format
    inputBinding:
      position: 101
      prefix: -v
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file that phased results are written to (stdout)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ksnp:1.0.3--h077b44d_2
