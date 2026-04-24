cwlVersion: v1.2
class: CommandLineTool
baseCommand: pileuppy
label: pileuppy
doc: "Pileups reads in a specified region.\n\nTool homepage: https://gitlab.com/tprodanov/pileuppy"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Required: Input indexed BAM/CRAM files. Allows format name=path, in that
      case name will be displayed in pileup instead of filename.'
    inputBinding:
      position: 1
  - id: display
    type:
      - 'null'
      - int
    doc: Display additional INT positions around the region. Only displays reads that
      cover <region>.
    inputBinding:
      position: 102
      prefix: --display
  - id: fasta_ref
    type:
      - 'null'
      - File
    doc: 'Optional: Input reference indexed FASTA file.'
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: filt_flags
    type:
      - 'null'
      - int
    doc: 'Filter flags: skip reads with mask bits set [1796].'
    inputBinding:
      position: 102
      prefix: --filt-flags
  - id: header
    type:
      - 'null'
      - string
    doc: How to write headers (skip|comment|plain). If comment, every header line
      will start with '#'.
    inputBinding:
      position: 102
      prefix: --header
  - id: join_samples
    type:
      - 'null'
      - boolean
    doc: Do not split single BAM/CRAM file into multiple columns with different samples.
    inputBinding:
      position: 102
      prefix: --join-samples
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Print ? instead of base pairs with quality less than INT [0].
    inputBinding:
      position: 102
      prefix: --min-bq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Skip alignments with mapQ less than INT [0].
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_columns
    type:
      - 'null'
      - boolean
    doc: Do not highlight columns with a different color.
    inputBinding:
      position: 102
      prefix: --no-columns
  - id: no_logo
    type:
      - 'null'
      - boolean
    doc: Do not use logo colors for nucleotides.
    inputBinding:
      position: 102
      prefix: --no-logo
  - id: region
    type: string
    doc: 'Required: pileup region in one of the following formats: chrom:pos, chrom:start-end,
      or chrom:pos^size.'
    inputBinding:
      position: 102
      prefix: --region
  - id: req_flags
    type:
      - 'null'
      - int
    doc: 'Required flags: skip reads with mask bits unset [0].'
    inputBinding:
      position: 102
      prefix: --req-flags
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Only use reads with matching samples. You can use multiple regex patterns
      or exact sample names.
    inputBinding:
      position: 102
      prefix: --samples
  - id: scheme
    type:
      - 'null'
      - string
    doc: 'Possible color schemes: none, ansi, white, black.'
    inputBinding:
      position: 102
      prefix: --scheme
  - id: show_names
    type:
      - 'null'
      - boolean
    doc: Print read names in the header.
    inputBinding:
      position: 102
      prefix: --show-names
  - id: size
    type:
      - 'null'
      - int
    doc: Split region longer than INT [150].
    inputBinding:
      position: 102
      prefix: --size
  - id: skip_bq
    type:
      - 'null'
      - boolean
    doc: Do not print base qualities.
    inputBinding:
      position: 102
      prefix: --skip-bq
  - id: skip_chrom
    type:
      - 'null'
      - boolean
    doc: Do not show chromosome name
    inputBinding:
      position: 102
      prefix: --skip-chrom
  - id: skip_empty
    type:
      - 'null'
      - boolean
    doc: Skip lines with zero coverage
    inputBinding:
      position: 102
      prefix: --skip-empty
  - id: skip_legend
    type:
      - 'null'
      - boolean
    doc: Do not write legend.
    inputBinding:
      position: 102
      prefix: --skip-legend
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Optional: Output file [stdout]. Disables colors.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pileuppy:1.2.0--pyhdfd78af_0
