cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis-msi2
label: mantis-msi2
doc: "Microsatellite Analysis for Normal-Tumor InStability (v2.0.0)\n\nTool homepage:
  https://github.com/nh13/MANTIS2/"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Input BED file.
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: difference_threshold
    type:
      - 'null'
      - float
    doc: "Default difference threshold value for calling a\nsample unstable."
    inputBinding:
      position: 101
      prefix: --difference-threshold
  - id: dissimilarity_threshold
    type:
      - 'null'
      - float
    doc: "Default dissimilarity threshold value for calling a\nsample unstable."
    inputBinding:
      position: 101
      prefix: --dissimilarity-threshold
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: "Default distance threshold value for calling a sample\nunstable."
    inputBinding:
      position: 101
      prefix: --distance-threshold
  - id: genome
    type:
      - 'null'
      - File
    doc: Path to reference genome (FASTA).
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_locus_coverage
    type:
      - 'null'
      - int
    doc: "Minimum coverage required for each of the normal and\ntumor results."
    inputBinding:
      position: 101
      prefix: --min-locus-coverage
  - id: min_locus_quality
    type:
      - 'null'
      - float
    doc: Minimum average locus quality.
    inputBinding:
      position: 101
      prefix: --min-locus-quality
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum (unclipped/unmasked) read length.
    inputBinding:
      position: 101
      prefix: --min-read-length
  - id: min_read_quality
    type:
      - 'null'
      - float
    doc: Minimum average read quality.
    inputBinding:
      position: 101
      prefix: --min-read-quality
  - id: min_repeat_reads
    type:
      - 'null'
      - int
    doc: Minimum reads supporting a specific repeat count.
    inputBinding:
      position: 101
      prefix: --min-repeat-reads
  - id: normal
    type: File
    doc: Normal input BAM file.
    inputBinding:
      position: 101
      prefix: --normal
  - id: standard_deviations
    type:
      - 'null'
      - float
    doc: "Standard deviations from mean before repeat count is\nconsidered an outlier"
    inputBinding:
      position: 101
      prefix: --standard-deviations
  - id: threads
    type:
      - 'null'
      - int
    doc: How many threads (processes) to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tumor
    type: File
    doc: Tumor input BAM file.
    inputBinding:
      position: 101
      prefix: --tumor
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis-msi2:2.0.0--h9948957_3
