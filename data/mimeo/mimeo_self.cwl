cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimeo
  - self
label: mimeo_self
doc: "Internal repeat finder: aligns a genome to itself and extracts high-identity segments above a coverage\
  \ threshold.\n\nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs:
  - id: adir
    type:
      - 'null'
      - Directory
    doc: Directory containing sequences from the genome. Split files are written here if the genome is
      given as multifasta.
    inputBinding:
      position: 101
      prefix: --adir
  - id: afasta
    type:
      - 'null'
      - File
    doc: Genome as multifasta.
    inputBinding:
      position: 101
      prefix: --afasta
  - id: recycle
    type:
      - 'null'
      - boolean
    doc: Use existing alignment "--outfile" if found.
    inputBinding:
      position: 101
      prefix: -r
  - id: outdir
    type:
      - 'null'
      - string
    doc: 'Write output files to this directory (default: working directory).'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: gffout
    type:
      - 'null'
      - string
    doc: Name of GFF3 annotation file.
    inputBinding:
      position: 101
      prefix: --gffout
  - id: outfile
    type:
      - 'null'
      - string
    doc: Name of alignment result file.
    inputBinding:
      position: 101
      prefix: --outfile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report LASTZ progress.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: label
    type:
      - 'null'
      - string
    doc: Set annotation TYPE field in gff.
    inputBinding:
      position: 101
      prefix: --label
  - id: prefix
    type:
      - 'null'
      - string
    doc: ID prefix for the reported features.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: Do not remove temp files.
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: lzpath
    type:
      - 'null'
      - File
    doc: Custom path to LASTZ executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --lzpath
  - id: minIdt
    type:
      - 'null'
      - double
    doc: Minimum alignment identity to report.
    inputBinding:
      position: 101
      prefix: --minIdt
  - id: minLen
    type:
      - 'null'
      - int
    doc: Minimum alignment length to report.
    inputBinding:
      position: 101
      prefix: --minLen
  - id: hspthresh
    type:
      - 'null'
      - int
    doc: Set HSP min score threshold for LASTZ.
    inputBinding:
      position: 101
      prefix: --hspthresh
  - id: loglevel
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL.'
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: bedtools
    type:
      - 'null'
      - File
    doc: Custom path to bedtools executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --bedtools
  - id: minCov
    type:
      - 'null'
      - double
    doc: Minimum depth of aligned segments to report repeat feature.
    inputBinding:
      position: 101
      prefix: --minCov
  - id: intraCov
    type:
      - 'null'
      - double
    doc: Minimum depth of aligned segments from the same scaffold to report a feature (with --strictSelf).
    inputBinding:
      position: 101
      prefix: --intraCov
  - id: strictSelf
    type:
      - 'null'
      - boolean
    doc: Process same-scaffold alignments separately with option to use a higher --intraCov threshold.
    inputBinding:
      position: 101
      prefix: --strictSelf
outputs:
  - id: gff_file
    type:
      - 'null'
      - File
    doc: GFF3 annotation.
    outputBinding:
      glob: '$(inputs.outdir ? inputs.outdir + ''/'' + inputs.gffout : inputs.gffout)'
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Alignment result file.
    outputBinding:
      glob: '$(inputs.outdir ? inputs.outdir + ''/'' + inputs.outfile : inputs.outfile)'
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
