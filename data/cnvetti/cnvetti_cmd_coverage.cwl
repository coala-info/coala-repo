cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
  - coverage
label: cnvetti_cmd_coverage
doc: "Record coverage from input BAM file. This command takes a BAM file with aligned reads from a WGS or targeted sequencing experiment and produces a BCF file that describes read depth (base-wise coverage or fragment count) for genome bins or target regions.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .bai
    doc: "Path to BAI-indexed BAM file."
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: "Path to output BCF file with the coverage information. This will also write a corresponding `.csi` file."
    inputBinding:
      position: 101
      prefix: --output
  - id: considered_regions
    type: string
    doc: "The region type to consider. Possible values: GenomeWide, TargetRegions"
    inputBinding:
      position: 101
      prefix: --considered-regions
  - id: count_kind
    type: string
    doc: "Whether to consider alignment coverage or number of aligning fragments. Possible values: Coverage, Fragments"
    inputBinding:
      position: 101
      prefix: --count-kind
  - id: blacklist_bed
    type:
      - 'null'
      - File
    secondaryFiles:
      - .tbi
    doc: "Path to tabix-indexed blacklist BED file."
    inputBinding:
      position: 101
      prefix: --blacklist-bed
  - id: contig_regex
    type:
      - 'null'
      - string
    doc: "Regular expression for contigs considered for coverage. (default ^(chr)?\\d\\d?$)"
    inputBinding:
      position: 101
      prefix: --contig-regex
  - id: genome_region
    type:
      - 'null'
      - string
    doc: "Optional genome region to limit the processing to."
    inputBinding:
      position: 101
      prefix: --genome-region
  - id: mask_piles
    type:
      - 'null'
      - boolean
    doc: "Enable pile-masking algorithm using the other `--pile-*` arguments."
    inputBinding:
      position: 101
      prefix: --mask-piles
  - id: mask_piles_fdr
    type:
      - 'null'
      - float
    doc: "Compute pile depth threshold to get FDR less than or equal to this value. (default 0.001)"
    inputBinding:
      position: 101
      prefix: --mask-piles-fdr
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Alignments with alignment quality less than `MIN_MAPQ` will be ignored. (default 0)"
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_raw_coverage
    type:
      - 'null'
      - int
    doc: "Target regions with lower coverage are ignored. (default 10)"
    inputBinding:
      position: 101
      prefix: --min-raw-coverage
  - id: min_unclipped
    type:
      - 'null'
      - float
    doc: "At least `MIN_UNCLIPPED` percent of the read have to be unclipped for it to be counted. (default 0.6)"
    inputBinding:
      position: 101
      prefix: --min-unclipped
  - id: min_window_remaining
    type:
      - 'null'
      - float
    doc: "Minimal fraction of window that must remain after masking (e.g., for piles). (default 0.5)"
    inputBinding:
      position: 101
      prefix: --min-window-remaining
  - id: model_bcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - .csi
    doc: "Path to WIS or pool-based model BCF file."
    inputBinding:
      position: 101
      prefix: --model-bcf
  - id: output_masked_bed
    type:
      - 'null'
      - string
    doc: "Path to BED file with masked regions."
    inputBinding:
      position: 101
      prefix: --output-masked-bed
  - id: pile_mask_window_size
    type:
      - 'null'
      - int
    doc: "Mask windows of length `SIZE` when a pile occurs. Set to `1` to do no window-based masking. (default 1)"
    inputBinding:
      position: 101
      prefix: --pile-mask-window-size
  - id: pile_max_gap
    type:
      - 'null'
      - int
    doc: "Merge intervals for piles if distance is <= `VAL`. (default 20)"
    inputBinding:
      position: 101
      prefix: --pile-max-gap
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: "Path to FAI-indexed reference FASTA file used for read alignment. Only required if GC-correction is to be performed downstream."
    inputBinding:
      position: 101
      prefix: --reference
  - id: targets_bed
    type:
      - 'null'
      - File
    secondaryFiles:
      - .tbi
    doc: "Path to tabix-indexed BED file with intervals of the targets of WES."
    inputBinding:
      position: 101
      prefix: --targets-bed
  - id: window_length
    type:
      - 'null'
      - int
    doc: "Length of window for binning on coverage computation (needed for GenomeWide)."
    inputBinding:
      position: 101
      prefix: --window-length
  - id: io_threads
    type:
      - 'null'
      - int
    doc: "Number of additional threads to use for (de)compression in I/O."
    inputBinding:
      position: 101
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease verbosity"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Path to output BCF file with the coverage information. This will also write a corresponding `.csi` file."
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - .csi
  - id: output_masked_bed_file
    type:
      - 'null'
      - File
    doc: "Path to BED file with masked regions."
    outputBinding:
      glob: $(inputs.output_masked_bed)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
