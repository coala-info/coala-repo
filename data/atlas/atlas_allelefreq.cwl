cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: atlas_allelefreq
doc: "Estimating population allele frequencies\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: exclude_regions
    type:
      - 'null'
      - File
    doc: BED file with regions to exclude
    inputBinding:
      position: 102
      prefix: --excludeRegions
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth to consider for allele frequency calculation
    inputBinding:
      position: 102
      prefix: --maxDepth
  - id: min_allele_count
    type:
      - 'null'
      - int
    doc: Minimum allele count to consider an allele
    inputBinding:
      position: 102
      prefix: --minAlleleCount
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider an allele
    inputBinding:
      position: 102
      prefix: --minAlleleFreq
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base
    inputBinding:
      position: 102
      prefix: --minBaseQ
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read
    inputBinding:
      position: 102
      prefix: --minMapQ
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 102
      prefix: --ref
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of regions to process (e.g., chr1:100-200)
    inputBinding:
      position: 102
      prefix: --regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
