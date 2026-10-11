cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, collapse]
label: isoseq_collapse
doc: "Collapse transcripts based on genomic mapping

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: alignments
    type: File
    doc: "Alignments mapping transcripts to the reference genome (BAM or XML)"
    inputBinding:
      position: 1
  - id: flnc_bam
    type: File
    doc: "FLNC BAM, optional input in the tool (needs its .pbi index)"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 2
  - id: gff_output
    type: string
    doc: "Collapsed transcripts GFF"
    inputBinding:
      position: 3
  - id: min_aln_coverage
    type: ['null', float]
    doc: "Ignore alignments with less than minimum query read coverage. [0.99]"
    inputBinding:
      position: 100
      prefix: --min-aln-coverage
  - id: min_aln_identity
    type: ['null', float]
    doc: "Ignore alignments with less than minimum alignment identity. [0.95]"
    inputBinding:
      position: 100
      prefix: --min-aln-identity
  - id: max_fuzzy_junction
    type: ['null', int]
    doc: "Ignore mismatches or indels shorter than or equal to N. [5]"
    inputBinding:
      position: 100
      prefix: --max-fuzzy-junction
  - id: max_5p_diff
    type: ['null', int]
    doc: "Maximum allowed 5' difference if on same exon. [50]"
    inputBinding:
      position: 100
      prefix: --max-5p-diff
  - id: max_3p_diff
    type: ['null', int]
    doc: "Maximum allowed 3' difference if on same exon. [100]"
    inputBinding:
      position: 100
      prefix: --max-3p-diff
  - id: do_not_collapse_extra_5exons
    type: ['null', boolean]
    doc: "Do not collapse 5' shorter transcripts which miss one or multiple 5' exons to a longer transcript."
    inputBinding:
      position: 100
      prefix: --do-not-collapse-extra-5exons
  - id: max_batch_mem
    type: ['null', float]
    doc: "Maximum memory for batch loading, in megabytes (MB). [4096]"
    inputBinding:
      position: 100
      prefix: --max-batch-mem
  - id: split_group_size
    type: ['null', int]
    doc: "Groups larger than this will be linearly split for parallel processing. [100]"
    inputBinding:
      position: 100
      prefix: --split-group-size
  - id: keep_non_real_cells
    type: ['null', boolean]
    doc: "Do not skip reads with non-real cells."
    inputBinding:
      position: 100
      prefix: --keep-non-real-cells
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]"
    inputBinding:
      position: 100
      prefix: --log-level
  - id: log_file
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 100
      prefix: --log-file
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection. [0]"
    inputBinding:
      position: 100
      prefix: --num-threads
outputs:
  - id: collapsed_gff
    type: File
    doc: "Collapsed transcripts GFF"
    outputBinding:
      glob: $(inputs.gff_output)
  - id: abundance_txt
    type: ['null', File]
    doc: "Abundance table"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).abundance.txt
  - id: fasta
    type: ['null', File]
    doc: "Collapsed transcripts FASTA"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).fasta
  - id: fastq
    type: ['null', File]
    doc: "Collapsed transcripts FASTQ"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).fastq
  - id: flnc_count_txt
    type: ['null', File]
    doc: "FLNC read counts"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).flnc_count.txt
  - id: group_txt
    type: ['null', File]
    doc: "Collapsed transcript groups"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).group.txt
  - id: read_stat_txt
    type: ['null', File]
    doc: "Per-read statistics"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).read_stat.txt
  - id: report_json
    type: ['null', File]
    doc: "Collapse report"
    outputBinding:
      glob: $(inputs.gff_output.replace(/\.gff$/, '')).report.json
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
