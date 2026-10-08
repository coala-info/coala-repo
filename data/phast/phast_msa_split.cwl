cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa_split
label: phast_msa_split
doc: "Partitions a multiple sequence alignment either at designated columns, or according
  to specified category labels, and outputs sub-alignments for the partitions. Optionally
  splits an associated annotations file.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file.
    inputBinding:
      position: 2
  - id: windows
    type:
      - 'null'
      - string
    doc: "Split the alignment into windows: <win_size,win_overlap>."
    inputBinding:
      position: 1
      prefix: --windows
  - id: by_category
    type:
      - 'null'
      - boolean
    doc: (Requires --features) Split by category, as defined by annotations file and category map.
    inputBinding:
      position: 1
      prefix: --by-category
  - id: by_group
    type:
      - 'null'
      - string
    doc: (Requires --features) Split by groups in annotation file, as defined by the specified tag.
    inputBinding:
      position: 1
      prefix: --by-group
  - id: for_features
    type:
      - 'null'
      - boolean
    doc: (Requires --features) Extract section of alignment corresponding to every feature.
    inputBinding:
      position: 1
      prefix: --for-features
  - id: by_index
    type:
      - 'null'
      - string
    doc: List of explicit indices at which to split alignment (comma-separated).
    inputBinding:
      position: 1
      prefix: --by-index
  - id: npartitions
    type:
      - 'null'
      - int
    doc: Split alignment equally into specified number of partitions.
    inputBinding:
      position: 1
      prefix: --npartitions
  - id: between_blocks
    type:
      - 'null'
      - int
    doc: Try to partition at sites between alignment blocks, moving indices at most this many sites.
    inputBinding:
      position: 1
      prefix: --between-blocks
  - id: features
    type:
      - 'null'
      - File
    doc: Annotations file (GFF, BED, or genepred).
    inputBinding:
      position: 1
      prefix: --features
  - id: catmap
    type:
      - 'null'
      - string
    doc: Inline category map, e.g. 'NCATS = 3 ; CDS 1-3'.
    inputBinding:
      position: 1
      prefix: --catmap
  - id: catmap_file
    type:
      - 'null'
      - File
    doc: Category map file (use instead of catmap).
    inputBinding:
      position: 1
      prefix: --catmap
  - id: refidx
    type:
      - 'null'
      - int
    doc: Index of frame of reference for split indices (default 1).
    inputBinding:
      position: 1
      prefix: --refidx
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input alignment format: FASTA, PHYLIP, MPM, MAF or SS (default guess)."
    inputBinding:
      position: 1
      prefix: --in-format
  - id: refseq
    type:
      - 'null'
      - File
    doc: (For use with --in-format MAF) Reference sequence in FASTA format.
    inputBinding:
      position: 1
      prefix: --refseq
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Output alignment format: FASTA, PHYLIP, MPM or SS (default FASTA)."
    inputBinding:
      position: 1
      prefix: --out-format
  - id: out_root
    type:
      - 'null'
      - string
    doc: Filename root for output files (default "msa_split").
    default: msa_split
    inputBinding:
      position: 1
      prefix: --out-root
  - id: sub_features
    type:
      - 'null'
      - boolean
    doc: (For use with --features) Output subsets of features corresponding to subalignments.
    inputBinding:
      position: 1
      prefix: --sub-features
  - id: reverse_compl
    type:
      - 'null'
      - boolean
    doc: Reverse complement segments with features only on the reverse strand.
    inputBinding:
      position: 1
      prefix: --reverse-compl
  - id: gap_strip
    type:
      - 'null'
      - string
    doc: "Strip columns with gaps: ALL, ANY, or a sequence number."
    inputBinding:
      position: 1
      prefix: --gap-strip
  - id: seqs
    type:
      - 'null'
      - string
    doc: Include only specified sequences in output (names or numbers).
    inputBinding:
      position: 1
      prefix: --seqs
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude rather than include specified sequences.
    inputBinding:
      position: 1
      prefix: --exclude
  - id: order
    type:
      - 'null'
      - string
    doc: Change order of rows to match this list of sequence names.
    inputBinding:
      position: 1
      prefix: --order
  - id: min_informative
    type:
      - 'null'
      - int
    doc: Only output alignments having at least this many informative sites.
    inputBinding:
      position: 1
      prefix: --min-informative
  - id: do_cats
    type:
      - 'null'
      - string
    doc: (For use with --by-category) Output sub-alignments for only the specified categories.
    inputBinding:
      position: 1
      prefix: --do-cats
  - id: tuple_size
    type:
      - 'null'
      - int
    doc: Size of tuples of columns to consider in downstream analysis.
    inputBinding:
      position: 1
      prefix: --tuple-size
  - id: unordered_ss
    type:
      - 'null'
      - boolean
    doc: (For use with --out-format SS) Suppress the column order part of the sufficient statistics.
    inputBinding:
      position: 1
      prefix: --unordered-ss
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Output summary of each output alignment to a file with suffix .sum.
    inputBinding:
      position: 1
      prefix: --summary
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Proceed quietly.
    inputBinding:
      position: 1
      prefix: --quiet
outputs:
  - id: sub_alignments
    type:
      type: array
      items: File
    doc: Sub-alignments, feature subsets and summaries written with the output root.
    outputBinding:
      glob: $(inputs.out_root).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
