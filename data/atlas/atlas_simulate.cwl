cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: atlas_simulate
doc: "Simulate bam- or vcf-file[s]\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: BAM or VCF file(s) to simulate
    inputBinding:
      position: 1
  - id: base_freq
    type:
      - 'null'
      - string
    doc: Base frequencies
    default: 'A: 0.25, C: 0.25, G: 0.25, T: 0.25'
    inputBinding:
      position: 102
  - id: base_n
    type:
      - 'null'
      - float
    doc: Base = N probability for reads
    default: 0.001
    inputBinding:
      position: 102
  - id: base_quality
    type:
      - 'null'
      - string
    doc: Base quality distribution for read groups
    default: normal(30,10)[0,93]
    inputBinding:
      position: 102
  - id: chr_length
    type:
      - 'null'
      - type: array
        items: int
    doc: Chromosome lengths
    default:
      - 10000
    inputBinding:
      position: 102
  - id: depth
    type:
      - 'null'
      - type: array
        items: int
    doc: Sequencing depths
    default:
      - 5
    inputBinding:
      position: 102
  - id: duplication_rate
    type:
      - 'null'
      - float
    doc: Duplication rate for read groups
    default: 0.0
    inputBinding:
      position: 102
  - id: fragment_length
    type:
      - 'null'
      - string
    doc: Fragment length distribution for read groups
    default: gamma(10,0.2)[30,200]
    inputBinding:
      position: 102
  - id: frequency
    type:
      - 'null'
      - float
    doc: Read group frequency
    default: 1.0
    inputBinding:
      position: 102
  - id: mapping_quality
    type:
      - 'null'
      - string
    doc: Mapping quality distribution for read groups
    default: normal(60,10)[1,255]
    inputBinding:
      position: 102
  - id: num_read_groups
    type:
      - 'null'
      - int
    doc: Number of read groups to initialize
    default: 1
    inputBinding:
      position: 102
  - id: out
    type:
      - 'null'
      - string
    doc: Output files tag
    default: ATLAS_simulations
    inputBinding:
      position: 102
  - id: out_qual
    type:
      - 'null'
      - boolean
    doc: Use full range of quality scores when writing alignments
    inputBinding:
      position: 102
  - id: ploidy
    type:
      - 'null'
      - type: array
        items: int
    doc: Ploidys
    default:
      - 2
    inputBinding:
      position: 102
  - id: pmd
    type:
      - 'null'
      - string
    doc: Postmortem damage model for read groups
    default: '-'
    inputBinding:
      position: 102
  - id: recal
    type:
      - 'null'
      - string
    doc: Base quality score recalibration model for read groups
    default: '-'
    inputBinding:
      position: 102
  - id: ref_bias
    type:
      - 'null'
      - float
    doc: Reference bias for reads
    default: 0.5
    inputBinding:
      position: 102
  - id: ref_div
    type:
      - 'null'
      - float
    doc: Reference divergence
    default: 0.01
    inputBinding:
      position: 102
  - id: ref_n
    type:
      - 'null'
      - float
    doc: Reference Ref = N probability
    default: 0.001
    inputBinding:
      position: 102
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator
    inputBinding:
      position: 102
  - id: seq_cycles
    type:
      - 'null'
      - int
    doc: Number of sequencing cycles for read groups
    default: 100
    inputBinding:
      position: 102
  - id: seq_type
    type:
      - 'null'
      - string
    doc: Sequencing type for read groups
    default: single
    inputBinding:
      position: 102
  - id: soft_clipping
    type:
      - 'null'
      - string
    doc: Soft clipping distribution for read groups
    default: poisson(0.5)[0,20]
    inputBinding:
      position: 102
  - id: theta
    type:
      - 'null'
      - float
    doc: Theta for single individual simulation
    default: 0.001
    inputBinding:
      position: 102
  - id: type
    type:
      - 'null'
      - string
    doc: Type of simulation (e.g., 'one' for single individual)
    default: one
    inputBinding:
      position: 102
  - id: write_binned_qualities
    type:
      - 'null'
      - boolean
    doc: Write binned quality scores
    inputBinding:
      position: 102
  - id: write_true_genotypes
    type:
      - 'null'
      - boolean
    doc: Write true genotypes to file
    inputBinding:
      position: 102
  - id: write_variant_bed
    type:
      - 'null'
      - boolean
    doc: Write BED files with variant and invariant positions
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_simulate.out
