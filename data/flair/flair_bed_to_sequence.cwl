cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed_to_sequence
label: flair_bed_to_sequence
doc: 'Extract the transcript sequences of isoforms in bed format from a genome FASTA.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file with flair phased transcripts
    inputBinding:
      position: 1
      prefix: --vcf
  - id: isoform_haplotypes
    type:
      - 'null'
      - File
    doc: Isoform haplotype assignments
    inputBinding:
      position: 1
      prefix: --isoform_haplotypes
  - id: vcf_out
    type:
      - 'null'
      - string
    doc: VCF output file name
    inputBinding:
      position: 1
      prefix: --vcf_out
  - id: bed
    type: File
    doc: Isoforms in bed format
    inputBinding:
      position: 2
  - id: genome
    type: File
    doc: Genomic sequence (FASTA)
    inputBinding:
      position: 3
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: outfilename
    type: string
    doc: Name of the output file
    inputBinding:
      position: 4
outputs:
  - id: sequences
    type: File
    doc: Output sequence file
    outputBinding:
      glob: $(inputs.outfilename)
  - id: vcf_output
    type:
      - 'null'
      - File
    doc: Output VCF file, if requested
    outputBinding:
      glob: $(inputs.vcf_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
