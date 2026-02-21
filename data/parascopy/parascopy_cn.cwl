cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - cn
label: parascopy_cn
doc: "Find aggregate and paralog-specific copy number for given unique and duplicated
  regions.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: agcn_jump
    type:
      - 'null'
      - int
    doc: Maximal jump in the aggregate copy number between two consecutive windows
    default: 6
    inputBinding:
      position: 101
      prefix: --agcn-jump
  - id: agcn_range
    type:
      - 'null'
      - type: array
        items: int
    doc: Detect aggregate copy number in a range around the reference copy number
    default: 5 7
    inputBinding:
      position: 101
      prefix: --agcn-range
  - id: clean
    type:
      - 'null'
      - string
    doc: 'Which temporary files to remove (multi-letter code: e, p).'
    inputBinding:
      position: 101
      prefix: --clean
  - id: depth
    type:
      type: array
      items: File
    doc: Input files / directories with background read depth.
    inputBinding:
      position: 101
      prefix: --depth
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude duplications for which the expression is true
    default: length < 500 && seq_sim < 0.97
    inputBinding:
      position: 101
      prefix: --exclude
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: force_agcn
    type:
      - 'null'
      - File
    doc: Instead of calculating aggregate copy numbers, use provided bed file.
    inputBinding:
      position: 101
      prefix: --force-agcn
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
  - id: max_ref_cn
    type:
      - 'null'
      - int
    doc: Skip regions with reference copy number higher than <int>
    default: 10
    inputBinding:
      position: 101
      prefix: --max-ref-cn
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Use multi-sample information if there are at least <int> samples present
    default: 50
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: min_windows
    type:
      - 'null'
      - int
    doc: Predict aggregate and paralog copy number only in regions with at least <int>
      windows
    default: 5
    inputBinding:
      position: 101
      prefix: --min-windows
  - id: modify_ref
    type:
      - 'null'
      - File
    doc: Modify reference copy number using bed file with the same format as `--force-agcn`.
    inputBinding:
      position: 101
      prefix: --modify-ref
  - id: no_multipliers
    type:
      - 'null'
      - boolean
    doc: Do not estimate or use read depth multipliers.
    inputBinding:
      position: 101
      prefix: --no-multipliers
  - id: pool_cram
    type:
      - 'null'
      - boolean
    doc: Pool reads into CRAM files (currently, BAM by default).
    inputBinding:
      position: 101
      prefix: --pool-cram
  - id: pscn_bound
    type:
      - 'null'
      - type: array
        items: int
    doc: Do not estimate paralog-specific copy number if aggregate CN or psCN tuples
      exceed thresholds.
    default: 8 500
    inputBinding:
      position: 101
      prefix: --pscn-bound
  - id: region_dist
    type:
      - 'null'
      - int
    doc: Jointly calculate copy number for nearby duplications with equal reference
      copy number
    default: 1000
    inputBinding:
      position: 101
      prefix: --region-dist
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) in format "chr" or "chr:start-end".
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bed[.gz] file(s) containing regions.
    inputBinding:
      position: 101
      prefix: --regions-file
  - id: regions_subset
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Additionally filter input regions: only use regions with names that are
      in this list.'
    inputBinding:
      position: 101
      prefix: --regions-subset
  - id: reliable_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: PSV-reliability thresholds (reliable PSV has all f-values over the threshold).
    default: 0.80 0.95
    inputBinding:
      position: 101
      prefix: --reliable-threshold
  - id: rerun
    type:
      - 'null'
      - string
    doc: 'Rerun CN analysis for all loci: full, partial, or none.'
    default: none
    inputBinding:
      position: 101
      prefix: --rerun
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools executable
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: short
    type:
      - 'null'
      - int
    doc: Skip regions with short duplications (shorter than <int> bp)
    default: 500
    inputBinding:
      position: 101
      prefix: --short
  - id: skip_cn
    type:
      - 'null'
      - boolean
    doc: Do not calculate agCN and psCN profiles.
    inputBinding:
      position: 101
      prefix: --skip-cn
  - id: skip_pscn
    type:
      - 'null'
      - boolean
    doc: Do not calculate psCN profiles.
    inputBinding:
      position: 101
      prefix: --skip-pscn
  - id: skip_unique
    type:
      - 'null'
      - boolean
    doc: Skip regions without any duplications in the reference genome.
    inputBinding:
      position: 101
      prefix: --skip-unique
  - id: strict_agcn_range
    type:
      - 'null'
      - boolean
    doc: Detect aggregate copy number strictly within the --agcn-range
    inputBinding:
      position: 101
      prefix: --strict-agcn-range
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path to "tabix" executable
    default: tabix
    inputBinding:
      position: 101
      prefix: --tabix
  - id: table
    type: File
    doc: Input indexed bed table with information about segmental duplications.
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: transition_prob
    type:
      - 'null'
      - float
    doc: Log10 transition probability for the aggregate copy number HMM
    default: -5
    inputBinding:
      position: 101
      prefix: --transition-prob
  - id: uniform_initial
    type:
      - 'null'
      - boolean
    doc: 'Copy number HMM: use uniform initial distribution and do not update initial
      probabilities.'
    inputBinding:
      position: 101
      prefix: --uniform-initial
  - id: unknown_seq
    type:
      - 'null'
      - float
    doc: At most this fraction of region sequence can be unknown (N)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --unknown-seq
  - id: update_agcn
    type:
      - 'null'
      - float
    doc: Update agCN using psCN probabilities when agCN quality is less than <float>
    default: 40
    inputBinding:
      position: 101
      prefix: --update-agcn
  - id: vmr
    type:
      - 'null'
      - string
    doc: Sort samples by variance-mean ratio, and only use samples with smallest values.
    inputBinding:
      position: 101
      prefix: --vmr
  - id: window_filtering
    type:
      - 'null'
      - float
    doc: Modify window filtering
    default: 1
    inputBinding:
      position: 101
      prefix: --window-filtering
outputs:
  - id: output
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
