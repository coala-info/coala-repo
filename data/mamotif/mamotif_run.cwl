cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mamotif
  - run
label: mamotif_run
doc: "Run complete workflow (MAnorm + MotifScan + Integration).\n\nRun the complete
  MAmotif workflow with basic MAnorm/MotifScan options.\nIf you want to control other
  advanced options (MAnorm normalization \noptions or MotifScan scanning options),
  please run them independently and\ncall MAmotif integration module with the `mamotif
  integrate` sub-command.\n\nTool homepage: https://github.com/shao-lab/MAmotif"
inputs:
  - id: correction
    type:
      - 'null'
      - string
    doc: Method for multiple testing correction.
    default: benjamin
    inputBinding:
      position: 101
      prefix: --correction
  - id: downstream_distance
    type:
      - 'null'
      - int
    doc: TSS downstream distance for promoters.
    default: 2000
    inputBinding:
      position: 101
      prefix: --downstream
  - id: genome
    type: string
    doc: Genome assembly name.
    inputBinding:
      position: 101
      prefix: --genome
  - id: mode
    type:
      - 'null'
      - string
    doc: Which sample to perform MAmotif on.
    default: both
    inputBinding:
      position: 101
      prefix: --mode
  - id: motif
    type: string
    doc: Motif set name to scan for.
    inputBinding:
      position: 101
      prefix: --motif
  - id: name1
    type:
      - 'null'
      - string
    doc: "Name of sample A. If not specified, the peak file name\n               \
      \         will be used."
    inputBinding:
      position: 101
      prefix: --name1
  - id: name2
    type:
      - 'null'
      - string
    doc: "Name of sample B. If not specified, the peak file name\n               \
      \         will be used."
    inputBinding:
      position: 101
      prefix: --name2
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: P value cutoff for motif scores.
    default: '1e-4'
    inputBinding:
      position: 101
      prefix: -p
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Paired-end mode. The middle point of each read pair is\n               \
      \         used to represent the genomic locus of the DNA\n                 \
      \       fragment. If specified, `--s1` and `--s2` will be\n                \
      \        ignored."
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: peak1
    type: File
    doc: Peak file of sample A.
    inputBinding:
      position: 101
      prefix: --peak1
  - id: peak2
    type: File
    doc: Peak file of sample B.
    inputBinding:
      position: 101
      prefix: --peak2
  - id: peak_format
    type:
      - 'null'
      - string
    doc: "Format of the peak files. Support ['bed',\n                        'bed3-summit',
      'macs', 'macs2', 'narrowpeak',\n                        'broadpeak']."
    default: bed
    inputBinding:
      position: 101
      prefix: --peak-format
  - id: read1
    type: File
    doc: Read file of sample A.
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Read file of sample B.
    inputBinding:
      position: 101
      prefix: --read2
  - id: read_format
    type:
      - 'null'
      - string
    doc: "Format of the read files. Support ['bed', 'bedpe',\n                   \
      \     'sam', 'bam']."
    default: bed
    inputBinding:
      position: 101
      prefix: --read-format
  - id: shiftsize1
    type:
      - 'null'
      - int
    doc: "Single-end reads shift size for sample A. Reads are\n                  \
      \      shifted by `N` bp towards 3' direction and the 5' end\n             \
      \           of each shifted read is used to represent the genomic\n        \
      \                locus of the DNA fragment. Set to 0.5 * fragment size\n   \
      \                     of the ChIP-seq library."
    default: 100
    inputBinding:
      position: 101
      prefix: --shiftsize1
  - id: shiftsize2
    type:
      - 'null'
      - int
    doc: Single-end reads shift size for sample B.
    default: 100
    inputBinding:
      position: 101
      prefix: --shiftsize2
  - id: split
    type:
      - 'null'
      - boolean
    doc: "Split genomic regions into promoter/distal regions and\n               \
      \         run separately."
    inputBinding:
      position: 101
      prefix: --split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes used to run in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: upstream_distance
    type:
      - 'null'
      - int
    doc: TSS upstream distance for promoters.
    default: 4000
    inputBinding:
      position: 101
      prefix: --upstream
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mamotif:1.1.0--py_0
