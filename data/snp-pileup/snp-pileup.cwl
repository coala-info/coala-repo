cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-pileup
label: snp-pileup
doc: "Generate a CSV file of read counts for SNP positions from BAM files, typically
  used as input for the FACETS copy number analysis tool.\n\nTool homepage: https://github.com/mskcc/facets"
inputs:
  - id: vcf_file
    type: File
    doc: VCF file containing SNP positions.
    inputBinding:
      position: 2
  - id: output_file_name
    type: string
    doc: Output file name (CSV; BGZF compressed when gzip is set).
    inputBinding:
      position: 3
  - id: bam_files
    type:
      type: array
      items: File
    secondaryFiles:
      - .bai
    doc: Sequence files (BAM, indexed), for example the normal sample first and the tumour sample second.
    inputBinding:
      position: 4
  - id: count_orphans
    type:
      - 'null'
      - boolean
    doc: "Do not discard anomalous read pairs."
    inputBinding:
      position: 1
      prefix: --count-orphans
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Sets the maximum depth. Default is 4000."
    inputBinding:
      position: 1
      prefix: --max-depth
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "Compresses the output file with BGZF."
    inputBinding:
      position: 1
      prefix: --gzip
  - id: progress
    type:
      - 'null'
      - boolean
    doc: "Show a progress bar. WARNING: requires additional time to calculate number of SNPs, and will take longer than normal."
    inputBinding:
      position: 1
      prefix: --progress
  - id: pseudo_snps
    type:
      - 'null'
      - int
    doc: "Every MULTIPLE positions, if there is no SNP, insert a blank record with the total count at the position."
    inputBinding:
      position: 1
      prefix: --pseudo-snps
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: "Sets the minimum threshold for mapping quality. Default is 0."
    inputBinding:
      position: 1
      prefix: --min-map-quality
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: "Sets the minimum threshold for base quality. Default is 0."
    inputBinding:
      position: 1
      prefix: --min-base-quality
  - id: min_read_counts
    type:
      - 'null'
      - string
    doc: "Comma separated list of minimum read counts for a position to be output. Default is 0."
    inputBinding:
      position: 1
      prefix: --min-read-counts
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Show detailed messages."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: ignore_overlaps
    type:
      - 'null'
      - boolean
    doc: "Disable read-pair overlap detection."
    inputBinding:
      position: 1
      prefix: --ignore-overlaps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Read counts at the SNP positions (CSV)
    outputBinding:
      glob: $(inputs.output_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-pileup:0.6.2--h503566f_8
stdout: snp-pileup.out
