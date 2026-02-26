cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - motifscan
  - scan
label: motifscan_scan
doc: "Scan input regions to detect motif occurrences.\n\nThis main command invokes
  to scan the sequences of user specified input \ngenomic regions and detect the occurrences
  for a set of known motifs. \nAfter scanning the input regions, an optional motif
  enrichment analysis \nis performed to check whether these motifs are over/under-represented\
  \ \ncompared to control regions (can be random generated or user specified).\n\n\
  Tool homepage: https://github.com/shao-lab/MotifScan"
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: "Use custom control regions for the enrichment\nanalysis."
    inputBinding:
      position: 101
      prefix: -c
  - id: control_file_format
    type:
      - 'null'
      - string
    doc: Format of the control file.
    default: bed
    inputBinding:
      position: 101
      prefix: --cf
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
  - id: input_file
    type: File
    doc: Input genomic regions (peaks) to be scanned.
    inputBinding:
      position: 101
      prefix: -i
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of the input file.
    default: bed
    inputBinding:
      position: 101
      prefix: -f
  - id: location
    type:
      - 'null'
      - string
    doc: If specified, only scan promoter or distal regions.
    inputBinding:
      position: 101
      prefix: --loc
  - id: motif_name
    type: string
    doc: Motif set name to scan for.
    inputBinding:
      position: 101
      prefix: --motif
  - id: n_random
    type:
      - 'null'
      - int
    doc: "Generate N random control regions for each input\nregion."
    default: 5
    inputBinding:
      position: 101
      prefix: --n-random
  - id: no_enrich
    type:
      - 'null'
      - boolean
    doc: Disable the enrichment analysis.
    inputBinding:
      position: 101
      prefix: --no-enrich
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: P value cutoff for motif scores.
    default: '1e-4'
    inputBinding:
      position: 101
      prefix: -p
  - id: plot_distributions
    type:
      - 'null'
      - boolean
    doc: "If set, plot the distributions of detected motif\nsites."
    inputBinding:
      position: 101
      prefix: --plot
  - id: report_site
    type:
      - 'null'
      - boolean
    doc: "If set, report the position for each detected motif\nsite."
    inputBinding:
      position: 101
      prefix: --site
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed used to generate control regions.
    inputBinding:
      position: 101
      prefix: --seed
  - id: strand
    type:
      - 'null'
      - string
    doc: "Enable strand-specific scanning, defaults to scan both\nstrands."
    default: both
    inputBinding:
      position: 101
      prefix: --strand
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Window size for scanning. In most cases, motifs occur\nclosely around the
      centers or summits of genomic\npeaks. Scanning a fixed-size window is often\n\
      sufficient to detect motif sites and unbiased for the\nenrichment analysis.
      If set to 0, the whole input\nregions are included for scanning."
    default: 1000
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to write output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
