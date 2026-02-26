cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./run-t1k
label: t1k_run-t1k
doc: "T1K v1.0.9-r251\n\nTool homepage: https://github.com/mourisl/T1K"
inputs:
  - id: abnormal_unmap_flag
    type:
      - 'null'
      - boolean
    doc: the flag in BAM for the unmapped read-pair is nonconcordant
    inputBinding:
      position: 101
      prefix: --abnormalUnmapFlag
  - id: allele_delimiter
    type:
      - 'null'
      - string
    doc: the delimiter character for digit unit
    default: automatic
    inputBinding:
      position: 101
      prefix: --alleleDelimiter
  - id: allele_digit_units
    type:
      - 'null'
      - int
    doc: the number of units in genotyping result
    default: automatic
    inputBinding:
      position: 101
      prefix: --alleleDigitUnits
  - id: allele_whitelist
    type:
      - 'null'
      - string
    doc: only consider read aligned to the listed allele sereies.
    default: not used
    inputBinding:
      position: 101
      prefix: --alleleWhitelist
  - id: bam_file
    type: File
    doc: path to BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: barcode_bam_field
    type:
      - 'null'
      - string
    doc: if -b, BAM field for barcode; if -1 -2/-u, file containing barcodes
    default: not used
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_range_end
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1), strand in a barcode is the true barcode
    default: -1
    inputBinding:
      position: 101
      prefix: --barcodeRange
  - id: barcode_range_start
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1), strand in a barcode is the true barcode
    default: 0
    inputBinding:
      position: 101
      prefix: --barcodeRange
  - id: barcode_range_strand
    type:
      - 'null'
      - string
    doc: start, end(-1 for length-1), strand in a barcode is the true barcode
    default: +
    inputBinding:
      position: 101
      prefix: --barcodeRange
  - id: barcode_whitelist
    type:
      - 'null'
      - File
    doc: path to the barcode whitelist
    default: not used
    inputBinding:
      position: 101
      prefix: --barcodeWhitelist
  - id: cross_gene_rate
    type:
      - 'null'
      - float
    doc: the effect from other gene's expression
    default: 0.04
    inputBinding:
      position: 101
      prefix: --crossGeneRate
  - id: filter_avg_coverage
    type:
      - 'null'
      - float
    doc: filter genes with average coverage less than the specified value
    default: 1.0
    inputBinding:
      position: 101
      prefix: --cov
  - id: filter_frac
    type:
      - 'null'
      - float
    doc: filter if abundance is less than the frac of dominant allele
    default: 0.15
    inputBinding:
      position: 101
      prefix: --frac
  - id: gene_coordinate_file
    type:
      - 'null'
      - File
    doc: path to the gene coordinate file (required when -b input)
    inputBinding:
      position: 101
      prefix: -c
  - id: interleaved_file
    type: string
    doc: path to interleaved read file
    inputBinding:
      position: 101
      prefix: -i
  - id: mate_id_suffix_len
    type:
      - 'null'
      - int
    doc: the suffix length in read id for mate.
    inputBinding:
      position: 101
      prefix: --mateIdSuffixLen
  - id: max_alleles_per_read
    type:
      - 'null'
      - int
    doc: maximal number of alleles per read
    default: 2000
    inputBinding:
      position: 101
      prefix: -n
  - id: min_alignment_similarity
    type:
      - 'null'
      - float
    doc: minimum alignment similarity
    default: 0.8
    inputBinding:
      position: 101
      prefix: -s
  - id: no_extraction
    type:
      - 'null'
      - boolean
    doc: directly use the files from provided -1 -2/-u for genotyping
    default: extraction first
    inputBinding:
      position: 101
      prefix: --noExtraction
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: the directory for output files.
    default: ./
    inputBinding:
      position: 101
      prefix: --od
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files.
    default: inferred from file prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: output_read_assignment
    type:
      - 'null'
      - boolean
    doc: output the allele assignment for each read to prefix_assign.tsv file
    default: not used
    inputBinding:
      position: 101
      prefix: --outputReadAssignment
  - id: post_var_max_group
    type:
      - 'null'
      - int
    doc: the maximum variant group size to call novel variant. -1 for no 
      limitation
    default: 8
    inputBinding:
      position: 101
      prefix: --post-varMaxGroup
  - id: preset
    type:
      - 'null'
      - string
    doc: 'preset parameters for cases requiring non-default settings: hla: HLA genotyping
      in general; hla-wgs: HLA genotyping on WGS data; kir-wgs: KIR genotyping on
      WGS data; kir-wes: KIR genotyping on WES data'
    inputBinding:
      position: 101
      prefix: --preset
  - id: read1_files
    type:
      type: array
      items: string
    doc: path to paired-end read files
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read1_range_end
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1) in -1/-u files for genomic sequence
    default: -1
    inputBinding:
      position: 101
      prefix: --read1Range
  - id: read1_range_start
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1) in -1/-u files for genomic sequence
    default: 0
    inputBinding:
      position: 101
      prefix: --read1Range
  - id: read2_files
    type:
      type: array
      items: string
    doc: path to paired-end read files
    inputBinding:
      position: 101
      prefix: '-2'
  - id: read2_range_end
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1) in -2 files for genomic sequence
    default: -1
    inputBinding:
      position: 101
      prefix: --read2Range
  - id: read2_range_start
    type:
      - 'null'
      - int
    doc: start, end(-1 for length-1) in -2 files for genomic sequence
    default: 0
    inputBinding:
      position: 101
      prefix: --read2Range
  - id: reference_file
    type: File
    doc: path to the reference sequence file
    inputBinding:
      position: 101
      prefix: -f
  - id: relax_intron_align
    type:
      - 'null'
      - boolean
    doc: allow one more mismatch in intronic alignment
    default: false
    inputBinding:
      position: 101
      prefix: --relaxIntronAlign
  - id: single_end_file
    type: string
    doc: path to single-end read file
    inputBinding:
      position: 101
      prefix: -u
  - id: skip_post_analysis
    type:
      - 'null'
      - boolean
    doc: only conduct genotyping.
    default: conduct the post analysis
    inputBinding:
      position: 101
      prefix: --skipPostAnalysis
  - id: squarem_min_alpha
    type:
      - 'null'
      - float
    doc: minimum value (should be negative) for the alpha (step length) in the 
      SQUAREM algorithm
    inputBinding:
      position: 101
      prefix: --squaremMinAlpha
  - id: stage
    type:
      - 'null'
      - int
    doc: 'start genotyping on specified stage: 0: start from beginning (candidate
      read extraction); 1: start from genotype with candidate reads; 2: start from
      post analysis'
    default: 0
    inputBinding:
      position: 101
      prefix: --stage
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
stdout: t1k_run-t1k.out
