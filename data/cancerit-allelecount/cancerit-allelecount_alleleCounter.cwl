cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCounter
label: cancerit-allelecount_alleleCounter
doc: "Counts alleles in a BAM/CRAM file based on a loci file.\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs:
  - id: contig
    type:
      - 'null'
      - string
    doc: Limit calling to named contig.
    inputBinding:
      position: 101
      prefix: --contig
  - id: dense_snps
    type:
      - 'null'
      - boolean
    doc: Improves performance where many positions are close together
    inputBinding:
      position: 101
      prefix: --dense-snps
  - id: filtered_flag
    type:
      - 'null'
      - int
    doc: 'Flag value of reads to exclude in allele counting default: [3852].'
    default: 3852
    inputBinding:
      position: 101
      prefix: --filtered-flag
  - id: hts_file
    type: File
    doc: Path to sample HTS file.
    inputBinding:
      position: 101
      prefix: --hts-file
  - id: is_10x
    type:
      - 'null'
      - boolean
    doc: Enables 10X processing mode. In this mode the HTS input file must be a 
      cellranger produced BAM file. Allele counts are then given on a 
      per-cellular barcode basis, with each count representing the consensus 
      base for that UMI. by iterating through bam file rather than using a 
      'fetch' approach.
    inputBinding:
      position: 101
      prefix: --is-10x
  - id: loci_file
    type: File
    doc: Path to loci file.
    inputBinding:
      position: 101
      prefix: --loci-file
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality
    default: 20
    inputBinding:
      position: 101
      prefix: --min-base-qual
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 35
    inputBinding:
      position: 101
      prefix: --min-map-qual
  - id: ref_file
    type:
      - 'null'
      - File
    doc: Path to reference fasta index file. NB. If cram format is supplied via 
      -b and the reference listed in the cram header can't be found 
      alleleCounter may fail to work correctly.
    inputBinding:
      position: 101
      prefix: --ref-file
  - id: required_flag
    type:
      - 'null'
      - int
    doc: 'Flag value of reads to retain in allele counting default: [3]. N.B. if the
      proper-pair flag is are selected, alleleCounter will assume paired-end and filter
      out any proper-pair flagged reads not in F/R orientation.'
    default: 3
    inputBinding:
      position: 101
      prefix: --required-flag
outputs:
  - id: output_file
    type: File
    doc: Path write output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7
