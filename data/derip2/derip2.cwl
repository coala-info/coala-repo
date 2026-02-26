cwlVersion: v1.2
class: CommandLineTool
baseCommand: derip2
label: derip2
doc: "Predict ancestral sequence of fungal repeat elements by correcting for RIP-like
  mutations or cytosine deamination in multi-sequence DNA alignments. Optionally,
  mask mutated positions in alignment.\n\nTool homepage: https://github.com/Adamtaranto/deRIP2"
inputs:
  - id: fill_index
    type:
      - 'null'
      - int
    doc: "Force selection of alignment row to fill uncorrected positions from by row
      index number (indexed from 0). Note: Will override '--fill-max-gc' option."
    inputBinding:
      position: 101
      prefix: --fill-index
  - id: fill_max_gc
    type:
      - 'null'
      - boolean
    doc: By default uncorrected positions in the output sequence are filled from
      the sequence with the lowest RIP count. If this option is set remaining 
      positions are filled from the sequence with the highest G/C content.
    inputBinding:
      position: 101
      prefix: --fill-max-gc
  - id: input_alignment
    type: File
    doc: Multiple sequence alignment.
    inputBinding:
      position: 101
      prefix: --input
  - id: logfile
    type:
      - 'null'
      - string
    doc: Log file path.
    inputBinding:
      position: 101
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level.
    default: INFO
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Mask corrected positions in alignment with degenerate IUPAC codes.
    inputBinding:
      position: 101
      prefix: --mask
  - id: max_gaps
    type:
      - 'null'
      - float
    doc: Maximum proportion of gapped positions in column to be tolerated before
      forcing a gap in final deRIP sequence.
    default: 0.7
    inputBinding:
      position: 101
      prefix: --max-gaps
  - id: max_snp_noise
    type:
      - 'null'
      - float
    doc: Maximum proportion of conflicting SNPs permitted before excluding 
      column from RIP/deamination assessment. i.e. By default a column with >= 
      0.5 'C/T' bases will have 'TpA' positions logged as RIP events.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --max-snp-noise
  - id: min_rip_like
    type:
      - 'null'
      - float
    doc: "Minimum proportion of deamination events in RIP context (5' CpA 3' --> 5'
      TpA 3') required for column to deRIP'd in final sequence. Note: If 'reaminate'
      option is set all deamination events will be corrected."
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-rip-like
  - id: no_append
    type:
      - 'null'
      - boolean
    doc: If set, do not append deRIP'd sequence to output alignment.
    inputBinding:
      position: 101
      prefix: --no-append
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory for deRIP'd sequence files to be written to.
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Create a visualization of the alignment with RIP markup.
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_rip_type
    type:
      - 'null'
      - string
    doc: Specify the type of RIP events to be displayed in the alignment 
      visualization.
    default: both
    inputBinding:
      position: 101
      prefix: --plot-rip-type
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files. Output files will be named prefix.fasta, 
      prefix_alignment.fasta, etc.
    default: deRIPseq
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reaminate
    type:
      - 'null'
      - boolean
    doc: Correct all deamination events independent of RIP context.
    inputBinding:
      position: 101
      prefix: --reaminate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/derip2:0.4.1--pyhdfd78af_0
stdout: derip2.out
