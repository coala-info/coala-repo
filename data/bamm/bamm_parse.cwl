cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamm_parse
label: bamm_parse
doc: "get bamfile type and/or coverage profiles and/or linking reads\n\nTool homepage:
  https://github.com/Ecogenomics/BamM"
inputs:
  - id: bamfiles
    type:
      type: array
      items: File
    doc: bam files to parse
    inputBinding:
      position: 1
  - id: base_quality
    type:
      - 'null'
      - int
    doc: base quality threshold (Qscore)
    default: 20
    inputBinding:
      position: 102
      prefix: --base_quality
  - id: coverage_mode
    type:
      - 'null'
      - string
    doc: how to calculate coverage (requires --coverages)
    default: pmean
    inputBinding:
      position: 102
      prefix: --coverage_mode
  - id: cutoff_range
    type:
      - 'null'
      - type: array
        items: float
    doc: range used to calculate upper and lower bounds when calculating 
      coverage
    inputBinding:
      position: 102
      prefix: --cutoff_range
  - id: length
    type:
      - 'null'
      - int
    doc: minimum Q length
    default: 50
    inputBinding:
      position: 102
      prefix: --length
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 102
      prefix: --mapping_quality
  - id: max_distance
    type:
      - 'null'
      - int
    doc: maximum allowable edit distance from query to reference
    default: 1000
    inputBinding:
      position: 102
      prefix: --max_distance
  - id: num_types
    type:
      - 'null'
      - type: array
        items: int
    doc: number of insert/orientation types per BAM
    inputBinding:
      position: 102
      prefix: --num_types
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the secondary flag
    inputBinding:
      position: 102
      prefix: --use_secondary
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: use reads marked with the supplementary flag
    inputBinding:
      position: 102
      prefix: --use_supplementary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: coverages
    type:
      - 'null'
      - File
    doc: filename to write coverage profiles to
    outputBinding:
      glob: $(inputs.coverages)
  - id: links
    type:
      - 'null'
      - File
    doc: filename to write pairing links to
    outputBinding:
      glob: $(inputs.links)
  - id: inserts
    type:
      - 'null'
      - File
    doc: filename to write bamfile insert distributions to
    outputBinding:
      glob: $(inputs.inserts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
