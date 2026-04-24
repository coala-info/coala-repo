cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - genotype_sv
label: graphtyper_genotype_sv
doc: "Run the structural variant (SV) genotyping pipeline.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: ref_fa
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file with structural variant sites and optionally also 
      SNP/indel sites.
    inputBinding:
      position: 2
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: Set to enable advanced options. See a list of all options (including 
      advanced) with 'graphtyper genotype_sv --advanced --help'
    inputBinding:
      position: 103
      prefix: --advanced
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - File
    doc: File with average coverage by read length (one value per line). The 
      values are used for subsampling regions with extremely high coverage and 
      should be in the same order as the BAM/CRAM list.
    inputBinding:
      position: 103
      prefix: --avg_cov_by_readlen
  - id: log
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
  - id: sam
    type:
      - 'null'
      - File
    doc: SAM/BAM/CRAM to analyze.
    inputBinding:
      position: 103
      prefix: --sam
  - id: sams
    type:
      - 'null'
      - File
    doc: File with SAM/BAM/CRAMs to analyze (one per line).
    inputBinding:
      position: 103
      prefix: --sams
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
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 103
      prefix: --vverbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
