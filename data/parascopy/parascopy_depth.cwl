cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - depth
label: parascopy_depth
doc: "Calculate read depth and variance in given genomic windows.\n\nTool homepage:
  https://github.com/tprodanov/parascopy"
inputs:
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: Input bed[.gz] file containing windows (tab-separated, 0-based semi-exclusive),
      which will be used to calculate read depth.
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: clipped_perc
    type:
      - 'null'
      - float
    doc: Skip windows that have more than <float>% reads with soft/hard clipping
    default: 10.0
    inputBinding:
      position: 101
      prefix: --clipped-perc
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Use predefined windows for the human genome, possible values are: GRCh37,
      GRCh38, CHM13; with an optional suffix `-fast`.'
    inputBinding:
      position: 101
      prefix: --genome
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input indexed BAM/CRAM files. All entries should follow the format "filename[::sample]"
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input BAM/CRAM files.
    inputBinding:
      position: 101
      prefix: --input-list
  - id: loess_frac
    type:
      - 'null'
      - float
    doc: 'Loess parameter: use <float> closest windows to estimate average read depth
      for each GC-percentage'
    default: 0.2
    inputBinding:
      position: 101
      prefix: --loess-frac
  - id: long
    type:
      - 'null'
      - boolean
    doc: Prepare read depth for long reads. Implies --no-gc.
    inputBinding:
      position: 101
      prefix: --long
  - id: low_mapq
    type:
      - 'null'
      - int
    doc: Read mapping quality under <int> is considered as low
    default: 10
    inputBinding:
      position: 101
      prefix: --low-mapq
  - id: low_mapq_perc
    type:
      - 'null'
      - float
    doc: Skip windows that have more than <float>% reads with MAPQ < 10
    default: 10.0
    inputBinding:
      position: 101
      prefix: --low-mapq-perc
  - id: mate_dist
    type:
      - 'null'
      - int
    doc: Insert size (~ distance between read mates) is expected to be under <int>
    default: 5000
    inputBinding:
      position: 101
      prefix: --mate-dist
  - id: neighbours
    type:
      - 'null'
      - int
    doc: Discard <int> neighbouring windows to the left and to the right of a skipped
      window
    default: 1
    inputBinding:
      position: 101
      prefix: --neighbours
  - id: no_gc
    type:
      - 'null'
      - boolean
    doc: Do not stratify by GC-content. Useful for long reads.
    inputBinding:
      position: 101
      prefix: --no-gc
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Genome ploidy.
    default: 2
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: tail_windows
    type:
      - 'null'
      - int
    doc: Do not use GC-content if it lies in the left or right tail with less than
      <int> windows
    default: 1000
    inputBinding:
      position: 101
      prefix: --tail-windows
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: unpaired_perc
    type:
      - 'null'
      - float
    doc: Skip windows that have more than <float>% reads without proper pair
    default: 10.0
    inputBinding:
      position: 101
      prefix: --unpaired-perc
outputs:
  - id: output
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
