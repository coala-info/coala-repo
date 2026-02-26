cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimeo-self
label: mimeo_self
doc: "Internal repeat finder. Mimeo-self aligns a genome to itself and extracts high-identity
  segments above an coverage threshold.\n\nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs:
  - id: alignment_directory
    type:
      - 'null'
      - Directory
    doc: Name of directory containing sequences from genome. Write split files 
      here if providing genome as multifasta.
    inputBinding:
      position: 101
      prefix: --adir
  - id: alignment_fasta
    type:
      - 'null'
      - File
    doc: Genome as multifasta.
    inputBinding:
      position: 101
      prefix: --afasta
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: Custom path to bedtools executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --bedtools
  - id: gff_output_file
    type:
      - 'null'
      - File
    doc: Name of GFF3 annotation file.
    inputBinding:
      position: 101
      prefix: --gffout
  - id: hsp_threshold
    type:
      - 'null'
      - float
    doc: Set HSP min score threshold for LASTZ.
    inputBinding:
      position: 101
      prefix: --hspthresh
  - id: intra_coverage
    type:
      - 'null'
      - float
    doc: Minimum depth of aligned segments from same scaffold to report feature.
      Used if "--strictSelf" mode is selected.
    inputBinding:
      position: 101
      prefix: --intraCov
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: If set do not remove temp files.
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: label
    type:
      - 'null'
      - string
    doc: Set annotation TYPE field in gff.
    inputBinding:
      position: 101
      prefix: --label
  - id: lastz_path
    type:
      - 'null'
      - string
    doc: Custom path to LASTZ executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --lzpath
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum depth of aligned segments to report repeat feature.
    inputBinding:
      position: 101
      prefix: --minCov
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity to report.
    inputBinding:
      position: 101
      prefix: --minIdt
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length to report.
    inputBinding:
      position: 101
      prefix: --minLen
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Write output files to this directory.
    default: cwd
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of alignment result file.
    inputBinding:
      position: 101
      prefix: --outfile
  - id: prefix
    type:
      - 'null'
      - string
    doc: ID prefix for internal repeats.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: recycle
    type:
      - 'null'
      - boolean
    doc: Use existing alignment "--outfile" if found.
    inputBinding:
      position: 101
      prefix: --recycle
  - id: strict_self
    type:
      - 'null'
      - boolean
    doc: If set process same-scaffold alignments separately with option to use 
      higher "--intraCov" threshold. Sometime useful to avoid false repeat calls
      from staggered alignments over SSRs or short tandem duplication.
    inputBinding:
      position: 101
      prefix: --strictSelf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If set report LASTZ progress.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
stdout: mimeo_self.out
