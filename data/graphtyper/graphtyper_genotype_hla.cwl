cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - genotype_hla
label: graphtyper_genotype_hla
doc: "Run the HLA genotyping pipeline.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: reference_genome
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 1
  - id: input_vcf
    type: File
    doc: Input VCF file with known HLA variants.
    inputBinding:
      position: 2
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype_hla --advanced --help'
    inputBinding:
      position: 103
      prefix: --advanced
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - string
    doc: File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.
    inputBinding:
      position: 103
      prefix: --avg_cov_by_readlen
  - id: intervals_file
    type:
      - 'null'
      - File
    doc: BED file with intervals to gather reads from. If empty, reads in region
      will be used.
    inputBinding:
      position: 103
      prefix: --intervals
  - id: log_file
    type:
      - 'null'
      - string
    doc: Set path to log file.
    inputBinding:
      position: 103
      prefix: --log
  - id: region
    type:
      - 'null'
      - string
    doc: Genomic region to genotype.
    inputBinding:
      position: 103
      prefix: --region
  - id: region_file
    type:
      - 'null'
      - File
    doc: File with genomic regions to genotype.
    inputBinding:
      position: 103
      prefix: --region_file
  - id: sam_file
    type:
      - 'null'
      - File
    doc: SAM/BAM/CRAM to analyze.
    inputBinding:
      position: 103
      prefix: --sam
  - id: sam_files_list
    type:
      - 'null'
      - File
    doc: File with SAM/BAM/CRAMs to analyze (one per line).
    inputBinding:
      position: 103
      prefix: --sams
  - id: sams_index_file
    type:
      - 'null'
      - File
    doc: File containing a list of BAM/CRAM indices to use when BAM/CRAM files 
      are queried (one per line). The index files must be given in the same 
      order as the BAMs/CRAMs.
    inputBinding:
      position: 103
      prefix: --sams_index
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads to use.
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 103
      prefix: --vverbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
