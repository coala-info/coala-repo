cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calitas
  - SearchReference
label: calitas_SearchReference
doc: "Searches a reference sequence for alignments of a guide+PAM.\n\nTool homepage:
  https://github.com/editasmedicine/calitas"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: auxiliary_pams
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional PAM sequences. Must be lower case.
    inputBinding:
      position: 101
      prefix: --auxiliary-pams
  - id: chrom
    type:
      - 'null'
      - string
    doc: Examine only the named chromosome.
    inputBinding:
      position: 101
      prefix: --chrom
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: genome_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the genome.
    inputBinding:
      position: 101
      prefix: --genome-gap-net-cost
  - id: guide
    type: string
    doc: Guide with PAM, PAM must be lower case.
    inputBinding:
      position: 101
      prefix: --guide
  - id: guide_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the guide.
    inputBinding:
      position: 101
      prefix: --guide-gap-net-cost
  - id: guide_id
    type:
      - 'null'
      - string
    doc: ID of the guide.
    inputBinding:
      position: 101
      prefix: --guide-id
  - id: guide_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the guide.
    inputBinding:
      position: 101
      prefix: --guide-mismatch-net-cost
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_gaps_between_guide_and_pam
    type:
      - 'null'
      - int
    doc: Maximum gap bases between guide and PAM
    inputBinding:
      position: 101
      prefix: --max-gaps-between-guide-and-pam
  - id: max_guide_diffs
    type:
      - 'null'
      - int
    doc: Maximum number of differences (mms+gaps) between guide and genome.
    inputBinding:
      position: 101
      prefix: --max-guide-diffs
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap allowed between alignments on the same strand.
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: max_pam_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches in the PAM.
    inputBinding:
      position: 101
      prefix: --max-pam-mismatches
  - id: max_total_diffs
    type:
      - 'null'
      - int
    doc: Maximum total diffs in alignments.
    inputBinding:
      position: 101
      prefix: --max-total-diffs
  - id: max_variants
    type:
      - 'null'
      - int
    doc: Exclude clusters of this more than this many variants.
    inputBinding:
      position: 101
      prefix: --max-variants
  - id: pam_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the PAM.
    inputBinding:
      position: 101
      prefix: --pam-mismatch-net-cost
  - id: ref
    type: File
    doc: Reference genome fasta.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use for alignments.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: variants
    type:
      - 'null'
      - File
    doc: Optional VCF of variants to merge into the genome.
    inputBinding:
      position: 101
      prefix: --variants
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size to align to.
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to write.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calitas:1.0--hdfd78af_1
