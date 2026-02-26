cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - genotype
label: graphtyper_genotype
doc: "Run the SNP/indel genotyping pipeline.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 1
  - id: advanced_options
    type:
      - 'null'
      - boolean
    doc: Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype --advanced --help'
    inputBinding:
      position: 102
      prefix: --advanced
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - File
    doc: File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.
    inputBinding:
      position: 102
      prefix: --avg_cov_by_readlen
  - id: force_copy_reference
    type:
      - 'null'
      - boolean
    doc: Force copy of the reference FASTA to temporary folder.
    inputBinding:
      position: 102
      prefix: --force_copy_reference
  - id: force_no_copy_reference
    type:
      - 'null'
      - boolean
    doc: Force that the reference FASTA is NOT copied to temporary folder. 
      Useful if you have limit storage on your local disk or the reference is 
      already on your local disk.
    inputBinding:
      position: 102
      prefix: --force_no_copy_reference
  - id: input_sam
    type:
      - 'null'
      - File
    doc: Input BAM/CRAM to analyze. If you have more than one file then create a
      list and use --sams instead.
    inputBinding:
      position: 102
      prefix: --sam
  - id: input_sams_file
    type:
      - 'null'
      - File
    doc: File with BAM/CRAMs paths to analyze (one per line).
    inputBinding:
      position: 102
      prefix: --sams
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set path to log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: no_decompose
    type:
      - 'null'
      - boolean
    doc: Set to prohibit decomposing variants in VCF output, which means complex
      variants wont be split/decomposed into smaller variants.
    inputBinding:
      position: 102
      prefix: --no_decompose
  - id: prior_vcf
    type:
      - 'null'
      - File
    doc: Input VCF file with prior variants sites. With this option set 
      GraphTyper will be run normally except the given input variant sites are 
      used in constructing the initial graph. We recommend only using common 
      variants as a prior (1% allele frequency or higher). Note that the final 
      output may not necessarily include every prior variant and GraphTyper may 
      discover other variants as well. If you rather want to call only a 
      specific set of variants then use the --vcf option instead.
    inputBinding:
      position: 102
      prefix: --prior_vcf
  - id: region
    type:
      - 'null'
      - string
    doc: Genomic region to genotype. Use --region_file if you have more than one
      region.
    inputBinding:
      position: 102
      prefix: --region
  - id: region_file
    type:
      - 'null'
      - File
    doc: File with a list of genomic regions to genotype (one per line).
    inputBinding:
      position: 102
      prefix: --region_file
  - id: sams_index_file
    type:
      - 'null'
      - File
    doc: File containing a list of BAM/CRAM indices to use when BAM/CRAM files 
      are queried (one per line). The index files must be given in the same 
      order as the BAMs/CRAMs.
    inputBinding:
      position: 102
      prefix: --sams_index
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads to use. Note that it is not possible to utilize 
      more threads than input BAM/CRAMs.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: variant_vcf
    type:
      - 'null'
      - File
    doc: Input VCF file with variant sites. Use this option if you want 
      GraphTyper to only genotype variants from this VCF.
    inputBinding:
      position: 102
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 102
      prefix: --vverbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory. Results will be written in 
      <output>/<contig>/<region>.vcf.gz
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
