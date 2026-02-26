cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt genotype
label: vt_genotype
doc: "Genotypes variants for each sample.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: debug_alignments
    type:
      - 'null'
      - boolean
    doc: debug alignments
    inputBinding:
      position: 102
      prefix: -d
  - id: input_bam
    type: File
    doc: input BAM file
    inputBinding:
      position: 102
      prefix: -b
  - id: interval_list_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    default: '[]'
    inputBinding:
      position: 102
      prefix: -I
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    default: '[]'
    inputBinding:
      position: 102
      prefix: -i
  - id: reference_fasta
    type: File
    doc: reference FASTA file
    inputBinding:
      position: 102
      prefix: -r
  - id: sample_id
    type: string
    doc: sample ID
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
