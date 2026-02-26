cwlVersion: v1.2
class: CommandLineTool
baseCommand: featureBits
label: ucsc-featurebits_featureBits
doc: "Correlate tables via bitmap projections.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: Database to use
    inputBinding:
      position: 1
  - id: tables
    type:
      type: array
      items: string
    doc: Table(s) to correlate
    inputBinding:
      position: 2
  - id: bed_region_in
    type:
      - 'null'
      - File
    doc: Read in a bed file for bin counts in specific regions and write to 
      bedRegionsOut
    inputBinding:
      position: 103
      prefix: -bedRegionIn
  - id: bin_overlap
    type:
      - 'null'
      - int
    doc: Bin overlap for generating counts in bin file
    default: 250000
    inputBinding:
      position: 103
      prefix: -binOverlap
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size for generating counts in bin file
    default: 500000
    inputBinding:
      position: 103
      prefix: -binSize
  - id: bitwise_or
    type:
      - 'null'
      - boolean
    doc: Bitwise OR tables together instead of ANDing them.
    inputBinding:
      position: 103
      prefix: -or
  - id: chrom
    type:
      - 'null'
      - string
    doc: Restrict to one chromosome
    inputBinding:
      position: 103
      prefix: -chrom
  - id: chrom_size_file
    type:
      - 'null'
      - File
    doc: Read chrom sizes from file instead of database. (chromInfo three column
      format)
    inputBinding:
      position: 103
      prefix: -chromSize
  - id: count_blocks
    type:
      - 'null'
      - boolean
    doc: Count blocks in bed12 files rather than entire extent.
    inputBinding:
      position: 103
      prefix: -countBlocks
  - id: count_gaps
    type:
      - 'null'
      - boolean
    doc: Count gaps in denominator
    inputBinding:
      position: 103
      prefix: -countGaps
  - id: dots
    type:
      - 'null'
      - int
    doc: Output dot every N chroms (scaffolds) processed
    inputBinding:
      position: 103
      prefix: -dots
  - id: enrichment
    type:
      - 'null'
      - boolean
    doc: Calculates coverage and enrichment assuming first table is reference 
      gene track and second track something else. Enrichment is the amount of 
      table1 that covers table2 vs. the amount of table1 that covers the genome.
      It's how much denser table1 is in table2 than it is genome-wide.
    inputBinding:
      position: 103
      prefix: -enrichment
  - id: fa_merge
    type:
      - 'null'
      - boolean
    doc: For fa output merge overlapping features.
    inputBinding:
      position: 103
      prefix: -faMerge
  - id: min_feature_size
    type:
      - 'null'
      - int
    doc: Don't include bits of the track that are smaller than minFeatureSize, 
      useful for differentiating between alignment gaps and introns.
    inputBinding:
      position: 103
      prefix: -minFeatureSize
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size to output
    default: 1
    inputBinding:
      position: 103
      prefix: -minSize
  - id: negate_result
    type:
      - 'null'
      - boolean
    doc: Output negation of resulting bit set.
    inputBinding:
      position: 103
      prefix: -not
  - id: no_hap
    type:
      - 'null'
      - boolean
    doc: Don't include _hap|_alt chromosomes
    inputBinding:
      position: 103
      prefix: -noHap
  - id: no_random
    type:
      - 'null'
      - boolean
    doc: Don't include _random (or Un) chromosomes
    inputBinding:
      position: 103
      prefix: -noRandom
  - id: primary_chroms
    type:
      - 'null'
      - boolean
    doc: Primary assembly (chroms without '_' in name)
    inputBinding:
      position: 103
      prefix: -primaryChroms
  - id: where_sql
    type:
      - 'null'
      - string
    doc: Restrict to features matching some sql pattern
    inputBinding:
      position: 103
      prefix: -where
outputs:
  - id: output_bed
    type:
      - 'null'
      - File
    doc: Put intersection into bed format. Can use stdout.
    outputBinding:
      glob: $(inputs.output_bed)
  - id: output_fa
    type:
      - 'null'
      - File
    doc: Put sequence in intersection into .fa file
    outputBinding:
      glob: $(inputs.output_fa)
  - id: bin_output_file
    type:
      - 'null'
      - File
    doc: Put bin counts in output file
    outputBinding:
      glob: $(inputs.bin_output_file)
  - id: bed_region_out
    type:
      - 'null'
      - File
    doc: Write a bed file of bin counts in specific regions from bedRegionIn
    outputBinding:
      glob: $(inputs.bed_region_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-featurebits:482--h0b57e2e_0
