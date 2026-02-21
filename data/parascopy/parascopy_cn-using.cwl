cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - cn-using
label: parascopy_cn-using
doc: "Find aggregate and paralog-specific copy number for given unique and duplicated
  regions.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: model
    type:
      type: array
      items: File
    doc: 'Use model parameters from an independent "parascopy cn" run. Allows multiple
      arguments: model/<region>.gz, file with paths to *.gz files, or directory.'
    inputBinding:
      position: 1
  - id: clean
    type:
      - 'null'
      - string
    doc: 'Which temporary files to remove (multi-letter code: e - extra subdirectories,
      p - pooled reads BAM/CRAM files).'
    inputBinding:
      position: 102
      prefix: --clean
  - id: depth
    type:
      type: array
      items: File
    doc: Input files / directories with background read depth. Should be created using
      "parascopy depth".
    inputBinding:
      position: 102
      prefix: --depth
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: force_agcn
    type:
      - 'null'
      - File
    doc: Instead of calculating aggregate copy numbers, use provided bed file.
    inputBinding:
      position: 102
      prefix: --force-agcn
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input indexed BAM/CRAM files. All entries should follow the format "filename[::sample]".
      Mutually exclusive with --input-list.
    inputBinding:
      position: 102
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input BAM/CRAM files. Mutually exclusive with
      --input.
    inputBinding:
      position: 102
      prefix: --input-list
  - id: no_multipliers
    type:
      - 'null'
      - boolean
    doc: Do not estimate or use read depth multipliers.
    inputBinding:
      position: 102
      prefix: --no-multipliers
  - id: pool_cram
    type:
      - 'null'
      - boolean
    doc: Pool reads into CRAM files (currently, BAM by default).
    inputBinding:
      position: 102
      prefix: --pool-cram
  - id: regions_subset
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Additionally filter input regions: only use regions with names that are
      in this list. If the first argument is "!", only use regions not in this list.'
    inputBinding:
      position: 102
      prefix: --regions-subset
  - id: reliable_threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: PSV-reliability thresholds (reliable PSV has all f-values over the threshold).
      First value is used for gene conversion detection, second value is used to estimate
      paralog-specific CN.
    inputBinding:
      position: 102
      prefix: --reliable-threshold
  - id: rerun
    type:
      - 'null'
      - string
    doc: 'Rerun CN analysis for all loci: full, partial, or none.'
    default: none
    inputBinding:
      position: 102
      prefix: --rerun
  - id: samtools
    type:
      - 'null'
      - string
    doc: Path to samtools executable. Use python wrapper if "none".
    default: samtools
    inputBinding:
      position: 102
      prefix: --samtools
  - id: skip_cn
    type:
      - 'null'
      - boolean
    doc: Do not calculate agCN and psCN profiles. If this option is set, Parascopy
      still calculates read depth for duplicated windows and PSV-allelic read depth.
    inputBinding:
      position: 102
      prefix: --skip-cn
  - id: skip_pscn
    type:
      - 'null'
      - boolean
    doc: Do not calculate psCN profiles.
    inputBinding:
      position: 102
      prefix: --skip-pscn
  - id: skip_unique
    type:
      - 'null'
      - boolean
    doc: Skip regions without any duplications in the reference genome.
    inputBinding:
      position: 102
      prefix: --skip-unique
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path to "tabix" executable. Use "none" to skip indexing output files.
    default: tabix
    inputBinding:
      position: 102
      prefix: --tabix
  - id: table
    type: File
    doc: Input indexed bed table with information about segmental duplications.
    inputBinding:
      position: 102
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads.
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: uniform_initial
    type:
      - 'null'
      - boolean
    doc: 'Copy number HMM: use uniform initial distribution and do not update initial
      probabilities.'
    inputBinding:
      position: 102
      prefix: --uniform-initial
  - id: unknown_seq
    type:
      - 'null'
      - float
    doc: At most this fraction of region sequence can be unknown (N).
    default: 0.1
    inputBinding:
      position: 102
      prefix: --unknown-seq
  - id: update_agcn
    type:
      - 'null'
      - float
    doc: Update agCN using psCN probabilities when agCN quality is less than <float>.
    default: 40
    inputBinding:
      position: 102
      prefix: --update-agcn
  - id: vmr
    type:
      - 'null'
      - string
    doc: Sort samples by variance-mean ratio, and only use samples with smallest values.
      Value should be either <float> (ratio threshold), or <float>% (use this percentile).
    inputBinding:
      position: 102
      prefix: --vmr
outputs:
  - id: output
    type: Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
