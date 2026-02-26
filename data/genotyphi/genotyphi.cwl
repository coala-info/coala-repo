cwlVersion: v1.2
class: CommandLineTool
baseCommand: genotyphi
label: genotyphi
doc: "VCF to Typhi genotypes\n\nTool homepage: https://github.com/katholt/genotyphi"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM file(s) to genotype (Mapping MUST have been done using CT18 as a 
      reference sequence)
    inputBinding:
      position: 101
      prefix: --bam
  - id: bcftools_location
    type:
      - 'null'
      - Directory
    doc: Location of folder containing bcftools installation if not standard/in 
      path.
    inputBinding:
      position: 101
      prefix: --bcftools_location
  - id: min_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of reads required to call a SNP
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_prop
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode to run in based on input files (vcf, bam, or vcf_parsnp)
    inputBinding:
      position: 101
      prefix: --mode
  - id: phred
    type:
      - 'null'
      - int
    doc: Minimum phred quality to count a variant call vs CT18 as a true SNP
    default: 20
    inputBinding:
      position: 101
      prefix: --phred
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference sequence in fasta format. Required if bam files provided.
    inputBinding:
      position: 101
      prefix: --ref
  - id: ref_id
    type:
      - 'null'
      - string
    doc: Name of the reference in the VCF file (#CHROM column) or fasta file. 
      Note that CT18 has genotype 3.2.1. If all your strains return this 
      genotype, it is likely you have specified the name of the refrence 
      sequence incorrectly; please check your VCFs.
    inputBinding:
      position: 101
      prefix: --ref_id
  - id: samtools_location
    type:
      - 'null'
      - Directory
    doc: Location of folder containing samtools installation if not standard/in 
      path.
    inputBinding:
      position: 101
      prefix: --samtools_location
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF file(s) to genotype (Mapping MUST have been done using CT18 as a 
      reference sequence)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Location and name for output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotyphi:2.0--hdfd78af_0
