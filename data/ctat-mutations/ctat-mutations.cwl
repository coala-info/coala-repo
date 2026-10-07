cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctat_mutations
label: ctat-mutations
doc: "The CTAT Mutations pipeline identifies mutations in RNA-Seq data, including
  SNVs and indels, and provides functional annotations.\n\nTool homepage: https://github.com/NCIP/ctat-mutations"
inputs:
  - id: genome_lib_dir
    type:
      - 'null'
      - Directory
    doc: CTAT genome library directory
    inputBinding:
      position: 101
      prefix: --genome_lib_dir
  - id: left
    type:
      - 'null'
      - File
    doc: Left (R1) fastq file
    inputBinding:
      position: 101
      prefix: --left
  - id: right
    type:
      - 'null'
      - File
    doc: Right (R2) fastq file (optional for single-end)
    inputBinding:
      position: 101
      prefix: --right
  - id: bam
    type:
      - 'null'
      - File
    doc: Sample BAM file; if given, no alignment is performed
    inputBinding:
      position: 101
      prefix: --bam
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the reference genome to use in the analysis pipeline
    inputBinding:
      position: 101
      prefix: --reference
  - id: index
    type:
      - 'null'
      - Directory
    doc: Premade index directory
    inputBinding:
      position: 101
      prefix: --index
  - id: dbsnp_vcf
    type:
      - 'null'
      - File
    doc: dbsnp vcf file for the reference genome
    inputBinding:
      position: 101
      prefix: --dbsnp_vcf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: variant_filtering_mode
    type:
      - 'null'
      - string
    doc: Specifies the variant filtering method
    inputBinding:
      position: 101
      prefix: --variant_filtering_mode
  - id: variant_call_mode
    type:
      - 'null'
      - string
    doc: Specifies the variant calling method to use
    inputBinding:
      position: 101
      prefix: --variant_call_mode
  - id: ref_bed
    type:
      - 'null'
      - File
    doc: Bed file for reference genome (for the mutation inspector json)
    inputBinding:
      position: 101
      prefix: --ref_bed
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Turns off plotting recalibration of alignments
    inputBinding:
      position: 101
      prefix: --plot
  - id: cosmic_vcf_gz
    type:
      - 'null'
      - File
    doc: Coding Cosmic Mutation VCF annotated with Phenotype Information, bgzipped
    inputBinding:
      position: 101
      prefix: --cosmic_vcf_gz
  - id: no_filter_rna_editing
    type:
      - 'null'
      - boolean
    doc: Turns off filtering based on known rna-editing sites
    inputBinding:
      position: 101
      prefix: --no_filter_rna_editing
  - id: tissue_type
    type:
      - 'null'
      - string
    doc: Tissue type (used in CRAVAT variant prioritation)
    inputBinding:
      position: 101
      prefix: --tissue_type
  - id: email
    type:
      - 'null'
      - string
    doc: Email used to notify of errors associated with cravat
    inputBinding:
      position: 101
      prefix: --email
  - id: cravat_annotation_header
    type:
      - 'null'
      - string
    doc: Headers for each CRAVAT feature annotated to the VCF file
    inputBinding:
      position: 101
      prefix: --cravat_annotation_header
  - id: alignment_mode
    type:
      - 'null'
      - string
    doc: Specifies the alignment and indexing algorithm to use
    inputBinding:
      position: 101
      prefix: --alignment_mode
  - id: base_depth
    type:
      - 'null'
      - boolean
    doc: Calculates the base coverage per base
    inputBinding:
      position: 101
      prefix: --base_depth
  - id: star_memory
    type:
      - 'null'
      - string
    doc: Memory limit for star index
    inputBinding:
      position: 101
      prefix: --star_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Sets debug mode for logger
    inputBinding:
      position: 101
      prefix: --debug
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Turns off optional indel realignment step
    inputBinding:
      position: 101
      prefix: --realign
  - id: no_recalibrate_bam
    type:
      - 'null'
      - boolean
    doc: Turns off gatk recalibration of bam files before variant calling
    inputBinding:
      position: 101
      prefix: --no_recalibrate_bam
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: The sequencing platform used to generate the samples
    inputBinding:
      position: 101
      prefix: --sequencing_platform
  - id: skip_cravat
    type:
      - 'null'
      - boolean
    doc: Skips CRAVAT services
    inputBinding:
      position: 101
      prefix: --skip_cravat
  - id: output_dir_path
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctat-mutations:2.0.1--py27_1
