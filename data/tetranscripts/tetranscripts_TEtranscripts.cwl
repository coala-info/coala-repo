cwlVersion: v1.2
class: CommandLineTool
baseCommand: TEtranscripts
label: tetranscripts_TEtranscripts
doc: "Identifying differential transcription of gene and transposable elements.\n\n\
  Tool homepage: http://hammelllab.labsites.cshl.edu/software#TEToolkit"
inputs:
  - id: treatment_samples
    type:
      type: array
      items: File
    doc: Sample files in group 1 (e.g. treatment/mutant)
    inputBinding:
      position: 1
  - id: control_samples
    type:
      type: array
      items: File
    doc: Sample files in group 2 (e.g. control/wildtype)
    inputBinding:
      position: 2
  - id: foldchange
    type:
      - 'null'
      - float
    doc: "Fold-change ratio (absolute) cutoff for differential\n                 \
      \       expression."
    default: 1
    inputBinding:
      position: 103
      prefix: --foldchange
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: "average fragment length for single end reads. For\n                    \
      \    paired-end, estimated from the input alignment file."
    default: for paired-end, estimate from the input alignment file; for 
      single-end, ignored by default.
    inputBinding:
      position: 103
      prefix: --fragmentLength
  - id: genic_gtf_file
    type: File
    doc: GTF file for gene annotations
    inputBinding:
      position: 103
      prefix: --GTF
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input file format: BAM or SAM.'
    default: BAM
    inputBinding:
      position: 103
      prefix: --format
  - id: iteration
    type:
      - 'null'
      - int
    doc: number of iteration to run the optimization.
    default: 100
    inputBinding:
      position: 103
      prefix: --iteration
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: maximum fragment length.
    default: 500
    inputBinding:
      position: 103
      prefix: --maxL
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: minimum fragment length.
    default: 0
    inputBinding:
      position: 103
      prefix: --minL
  - id: min_read
    type:
      - 'null'
      - int
    doc: "read count cutoff. genes/TEs with reads less than the\n                \
      \        cutoff will not be considered."
    default: 1
    inputBinding:
      position: 103
      prefix: --minread
  - id: normalization
    type:
      - 'null'
      - string
    doc: "Normalization method : DESeq_default (DESeq default\n                  \
      \      normalization method), TC (total annotated counts),\n               \
      \         quant (quantile normalization). Only applicable if\n             \
      \           DESeq is used instead of DESeq2."
    default: DESeq_default
    inputBinding:
      position: 103
      prefix: --norm
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory for output files.
    default: current directory
    inputBinding:
      position: 103
      prefix: --outdir
  - id: padj
    type:
      - 'null'
      - float
    doc: FDR cutoff for significance.
    default: 0.05
    inputBinding:
      position: 103
      prefix: --padj
  - id: project_name
    type:
      - 'null'
      - string
    doc: Name of this project.
    default: TEtranscripts_out
    inputBinding:
      position: 103
      prefix: --project
  - id: sort_by_pos
    type:
      - 'null'
      - boolean
    doc: Alignment files are sorted by chromosome position.
    inputBinding:
      position: 103
      prefix: --sortByPos
  - id: stranded
    type:
      - 'null'
      - string
    doc: "Is this a stranded library? (no, forward, or reverse).\n               \
      \         For \"first-strand\" cDNA libraries (e.g. TruSeq\n               \
      \         stranded), choose reverse. For \"second-strand\" cDNA\n          \
      \              libraries (e.g. QIAseq stranded), choose forward."
    default: no
    inputBinding:
      position: 103
      prefix: --stranded
  - id: te_counting_mode
    type:
      - 'null'
      - string
    doc: "How to count TE: uniq (unique mappers only), or multi\n                \
      \        (distribute among all alignments)."
    default: multi
    inputBinding:
      position: 103
      prefix: --mode
  - id: te_gtf_file
    type: File
    doc: GTF file for transposable element annotations
    inputBinding:
      position: 103
      prefix: --TE
  - id: use_deseq
    type:
      - 'null'
      - boolean
    doc: "Use DESeq (instead of DESeq2) for differential\n                       \
      \ analysis."
    inputBinding:
      position: 103
      prefix: --DESeq
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level. 0: only show critical message, 1: show additional warning
      message, 2: show process information, 3: show debug messages.'
    default: 2
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetranscripts:2.2.3--pyh7cba7a3_0
stdout: tetranscripts_TEtranscripts.out
