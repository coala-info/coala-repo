cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - collapse
label: isoseq3_collapse
doc: "Collapse transcripts based on genomic mapping\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: alignments
    type: File
    doc: "Alignments mapping transcripts to the reference genome (BAM)."
    inputBinding:
      position: 1
  - id: flnc
    type: ['null', File]
    doc: "FLNC BAM, optional input."
    inputBinding:
      position: 2
  - id: output_gff
    type: string
    default: collapsed.gff
    doc: "Collapsed transcripts GFF."
    inputBinding:
      position: 3
  - id: min_aln_coverage
    type: ['null', float]
    doc: "Ignore alignments with less than minimum query read coverage."
    inputBinding:
      position: 104
      prefix: --min-aln-coverage
  - id: min_aln_identity
    type: ['null', float]
    doc: "Ignore alignments with less than minimum alignment identity."
    inputBinding:
      position: 104
      prefix: --min-aln-identity
  - id: max_fuzzy_junction
    type: ['null', int]
    doc: "Ignore mismatches or indels shorter than or equal to N."
    inputBinding:
      position: 104
      prefix: --max-fuzzy-junction
  - id: max_5p_diff
    type: ['null', int]
    doc: "Maximum allowed 5' difference if on same exon."
    inputBinding:
      position: 104
      prefix: --max-5p-diff
  - id: max_3p_diff
    type: ['null', int]
    doc: "Maximum allowed 3' difference if on same exon."
    inputBinding:
      position: 104
      prefix: --max-3p-diff
  - id: do_not_collapse_extra_5exons
    type: ['null', boolean]
    doc: "Do not collapse 5' shorter transcripts which miss one or multiple 5' exons to a longer transcript."
    inputBinding:
      position: 104
      prefix: --do-not-collapse-extra-5exons
  - id: max_batch_mem
    type: ['null', float]
    doc: "Maximum memory for batch loading, in megabytes (MB). Batches can be slightly larger than this value. Value <= 0 loads all data in memory at once."
    inputBinding:
      position: 104
      prefix: --max-batch-mem
  - id: split_group_size
    type: ['null', int]
    doc: "Groups larger than this will be linearly split for parallel processing."
    inputBinding:
      position: 104
      prefix: --split-group-size
  - id: keep_non_real_cells
    type: ['null', boolean]
    doc: "Do not skip reads with non-real cells."
    inputBinding:
      position: 104
      prefix: --keep-non-real-cells
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection."
    inputBinding:
      position: 104
      prefix: --num-threads
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL)."
    inputBinding:
      position: 104
      prefix: --log-level
  - id: log_file_path
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 104
      prefix: --log-file
outputs:
  - id: collapsed_gff
    type: File
    doc: "Collapsed transcripts GFF."
    outputBinding:
      glob: $(inputs.output_gff)
  - id: other_outputs
    type:
      type: array
      items: File
    doc: "Other result files with the same prefix (abundance, FASTA, FASTQ, FLNC counts, group and read statistics, JSON report)."
    outputBinding:
      glob: $(inputs.output_gff.replace(/\.gff$/, '')).*
  - id: log_file
    type: ['null', File]
    doc: "Log file, when log_file_path is set."
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TMPDIR
        envValue: "/tmp/"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
