cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimeo-filter
label: mimeo_filter
doc: "Filter SSR containing sequences from fasta library of repeats.\n\nTool homepage:
  https://github.com/Adamtaranto/mimeo"
inputs:
  - id: infile
    type: File
    doc: Name of directory containing sequences from A genome.
    inputBinding:
      position: 101
      prefix: --infile
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: If set do not remove temp files.
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging level.
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: maxtandem
    type:
      - 'null'
      - string
    doc: "Max percentage of a sequence which may be masked by\n                  \
      \      TRF. If exceeded, element will be discarded."
    inputBinding:
      position: 101
      prefix: --maxtandem
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Write output files to this directory.
    default: cwd
    inputBinding:
      position: 101
      prefix: --outdir
  - id: tdelta
    type:
      - 'null'
      - string
    doc: TRF indel penalty
    inputBinding:
      position: 101
      prefix: --tdelta
  - id: tmatch
    type:
      - 'null'
      - string
    doc: TRF matching weight
    inputBinding:
      position: 101
      prefix: --tmatch
  - id: tmaxperiod
    type:
      - 'null'
      - string
    doc: "TRF maximum period size to report. Note: Setting this\n                \
      \        score too high may exclude some LTR retrotransposons.\n           \
      \             Optimal len to exclude only SSRs is 10-50bp."
    inputBinding:
      position: 101
      prefix: --tmaxperiod
  - id: tminscore
    type:
      - 'null'
      - string
    doc: TRF minimum alignment score to report
    inputBinding:
      position: 101
      prefix: --tminscore
  - id: tmismatch
    type:
      - 'null'
      - string
    doc: TRF mismatching penalty
    inputBinding:
      position: 101
      prefix: --tmismatch
  - id: tpi
    type:
      - 'null'
      - string
    doc: TRF indel probability
    inputBinding:
      position: 101
      prefix: --tPI
  - id: tpm
    type:
      - 'null'
      - string
    doc: TRF match probability
    inputBinding:
      position: 101
      prefix: --tPM
  - id: trfpath
    type:
      - 'null'
      - string
    doc: Custom path to TRF executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --TRFpath
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If set report LASTZ progress.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Name of alignment result file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
