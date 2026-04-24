cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-count
label: htseq_htseq-count
doc: "This script takes one or more alignment files in SAM/BAM format and a feature
  file in GFF format and calculates for each feature the number of reads mapping to
  it.\n\nTool homepage: https://github.com/htseq/htseq"
inputs:
  - id: samfilenames
    type:
      type: array
      items: File
    doc: Path to the SAM/BAM files containing the mapped reads. If '-' is 
      selected, read from standard input
    inputBinding:
      position: 1
  - id: featuresfilename
    type: File
    doc: Path to the GTF file containing the features
    inputBinding:
      position: 2
  - id: add_chromosome_info
    type:
      - 'null'
      - boolean
    doc: Store information about the chromosome of each feature as an additional
      attribute.
    inputBinding:
      position: 103
      prefix: --add-chromosome-info
  - id: additional_attr
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional feature attributes used as annotations in the output.
    inputBinding:
      position: 103
      prefix: --additional-attr
  - id: append_output
    type:
      - 'null'
      - boolean
    doc: Append counts output to an existing file instead of creating a new one.
    inputBinding:
      position: 103
      prefix: --append-output
  - id: counts_output_sparse
    type:
      - 'null'
      - boolean
    doc: Store the counts as a sparse matrix (mtx, h5ad, loom).
    inputBinding:
      position: 103
      prefix: --counts-output-sparse
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Column delimiter in output.
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: feature_query
    type:
      - 'null'
      - string
    doc: Restrict to features described in this expression, e.g. attribute == 
      "one attr".
    inputBinding:
      position: 103
      prefix: --feature-query
  - id: format
    type:
      - 'null'
      - string
    doc: 'Type of <alignment_file> data. DEPRECATED: file format is detected automatically.
      This option is ignored.'
    inputBinding:
      position: 103
      prefix: --format
  - id: idattr
    type:
      - 'null'
      - type: array
        items: string
    doc: GTF attribute to be used as feature ID.
    inputBinding:
      position: 103
      prefix: --idattr
  - id: max_reads_in_buffer
    type:
      - 'null'
      - int
    doc: When <alignment_file> is paired end sorted by position, allow only so 
      many reads to stay in memory until the mates are found.
    inputBinding:
      position: 103
      prefix: --max-reads-in-buffer
  - id: minaqual
    type:
      - 'null'
      - int
    doc: Skip all reads with MAPQ alignment quality lower than the given minimum
      value.
    inputBinding:
      position: 103
      prefix: --minaqual
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode to handle reads overlapping more than one feature.
    inputBinding:
      position: 103
      prefix: --mode
  - id: nonunique
    type:
      - 'null'
      - string
    doc: Whether and how to score reads that are not uniquely aligned or 
      ambiguously assigned to features.
    inputBinding:
      position: 103
      prefix: --nonunique
  - id: nprocesses
    type:
      - 'null'
      - int
    doc: Number of parallel CPU processes to use.
    inputBinding:
      position: 103
      prefix: --nprocesses
  - id: order
    type:
      - 'null'
      - string
    doc: "'pos' or 'name'. Sorting order of <alignment_file>. Paired-end sequencing
      data must be sorted either by position or by read name."
    inputBinding:
      position: 103
      prefix: --order
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress report
    inputBinding:
      position: 103
      prefix: --quiet
  - id: samout_format
    type:
      - 'null'
      - string
    doc: Format to use with the --samout option.
    inputBinding:
      position: 103
      prefix: --samout-format
  - id: secondary_alignments
    type:
      - 'null'
      - string
    doc: Whether to score secondary alignments (0x100 flag)
    inputBinding:
      position: 103
      prefix: --secondary-alignments
  - id: stranded
    type:
      - 'null'
      - string
    doc: Whether the data is from a strand-specific assay. Specify 'yes', 'no', 
      or 'reverse'.
    inputBinding:
      position: 103
      prefix: --stranded
  - id: supplementary_alignments
    type:
      - 'null'
      - string
    doc: Whether to score supplementary alignments (0x800 flag)
    inputBinding:
      position: 103
      prefix: --supplementary-alignments
  - id: type
    type:
      - 'null'
      - type: array
        items: string
    doc: Feature type (3rd column in GTF file) to be used, all features of other
      type are ignored.
    inputBinding:
      position: 103
      prefix: --type
  - id: with_header
    type:
      - 'null'
      - boolean
    doc: Whether to add a column header to the output TSV file indicating which 
      column corresponds to which input BAM file.
    inputBinding:
      position: 103
      prefix: --with-header
outputs:
  - id: samout
    type:
      - 'null'
      - File
    doc: Write out all SAM alignment records into SAM/BAM files (one per input 
      file needed).
    outputBinding:
      glob: $(inputs.samout)
  - id: counts_output
    type:
      - 'null'
      - File
    doc: Filename to output the counts to instead of stdout.
    outputBinding:
      glob: $(inputs.counts_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq:2.1.2--py311hb6b0eea_0
