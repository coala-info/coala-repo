cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimeo
  - x
label: mimeo_x
doc: "Cross-species repeat finder: searches for features which are abundant in an external reference genome.\n\
  \nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs:
  - id: adir
    type:
      - 'null'
      - Directory
    doc: Directory containing sequences from the A genome (split files are written here when a multifasta
      is given).
    inputBinding:
      position: 101
      prefix: --adir
  - id: afasta
    type:
      - 'null'
      - File
    doc: A genome as multifasta.
    inputBinding:
      position: 101
      prefix: --afasta
  - id: bdir
    type:
      - 'null'
      - Directory
    doc: Directory containing sequences from the B genome.
    inputBinding:
      position: 101
      prefix: --bdir
  - id: bfasta
    type:
      - 'null'
      - File
    doc: B genome as multifasta.
    inputBinding:
      position: 101
      prefix: --bfasta
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
    doc: Minimum depth of B-genome hits to report feature in A-genome.
    inputBinding:
      position: 101
      prefix: --minCov
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
