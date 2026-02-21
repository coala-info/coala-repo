cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trgt
  - genotype
label: trgt_genotype
doc: "Tandem Repeat Genotyper\n\nTool homepage: https://github.com/PacificBiosciences/trgt"
inputs:
  - id: color
    type:
      - 'null'
      - string
    doc: 'Enable or disable color output in logging [possible values: always, auto,
      never]'
    default: auto
    inputBinding:
      position: 101
      prefix: --color
  - id: disable_bam_output
    type:
      - 'null'
      - boolean
    doc: Disable BAM output
    inputBinding:
      position: 101
      prefix: --disable-bam-output
  - id: fetcher_threads
    type:
      - 'null'
      - int
    doc: Number of threads for querying input BAM files. Defaults to half the number
      of analysis threads, with a max of 8
    inputBinding:
      position: 101
      prefix: --fetcher-threads
  - id: flank_len
    type:
      - 'null'
      - int
    doc: Minimum length of the flanking sequence
    default: 250
    inputBinding:
      position: 101
      prefix: --flank-len
  - id: genome
    type: File
    doc: Path to reference genome FASTA
    inputBinding:
      position: 101
      prefix: --genome
  - id: genotyper
    type:
      - 'null'
      - string
    doc: Genotyping algorithm (size or cluster)
    default: size
    inputBinding:
      position: 101
      prefix: --genotyper
  - id: karyotype
    type:
      - 'null'
      - string
    doc: Sample karyotype (XX or XY or file name)
    default: XX
    inputBinding:
      position: 101
      prefix: --karyotype
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum locus depth
    default: 250
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: output_flank_len
    type:
      - 'null'
      - int
    doc: Length of flanking sequence to report on output
    default: 50
    inputBinding:
      position: 101
      prefix: --output-flank-len
  - id: preset
    type:
      - 'null'
      - string
    doc: Parameter preset (wgs or targeted)
    default: wgs
    inputBinding:
      position: 101
      prefix: --preset
  - id: reads
    type: File
    doc: BAM file with aligned HiFi reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: repeats
    type: File
    doc: BED file with repeat coordinates
    inputBinding:
      position: 101
      prefix: --repeats
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Specify multiple times to increase verbosity level (e.g., -vv for more verbosity)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files (.vcf.gz and .spanning.bam)
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trgt:5.0.0--h9ee0642_0
