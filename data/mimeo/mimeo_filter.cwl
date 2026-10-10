cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimeo
  - filter
label: mimeo_filter
doc: "Filter SSR containing sequences from a fasta library of repeats.\n\nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs:
  - id: infile
    type: File
    doc: FASTA library of repeats to filter.
    inputBinding:
      position: 101
      prefix: --infile
  - id: outdir
    type:
      - 'null'
      - string
    doc: 'Write output files to this directory (default: working directory).'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outfile
    type:
      - 'null'
      - string
    doc: Name of the filtered output file.
    inputBinding:
      position: 101
      prefix: --outfile
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: Do not remove temp files.
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Report progress.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: loglevel
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL.'
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: TRFpath
    type:
      - 'null'
      - File
    doc: Custom path to TRF executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --TRFpath
  - id: tmatch
    type:
      - 'null'
      - int
    doc: TRF matching weight.
    inputBinding:
      position: 101
      prefix: --tmatch
  - id: tmismatch
    type:
      - 'null'
      - int
    doc: TRF mismatching penalty.
    inputBinding:
      position: 101
      prefix: --tmismatch
  - id: tdelta
    type:
      - 'null'
      - int
    doc: TRF indel penalty.
    inputBinding:
      position: 101
      prefix: --tdelta
  - id: tPM
    type:
      - 'null'
      - double
    doc: TRF match probability.
    inputBinding:
      position: 101
      prefix: --tPM
  - id: tPI
    type:
      - 'null'
      - double
    doc: TRF indel probability.
    inputBinding:
      position: 101
      prefix: --tPI
  - id: tminscore
    type:
      - 'null'
      - int
    doc: TRF minimum alignment score to report.
    inputBinding:
      position: 101
      prefix: --tminscore
  - id: tmaxperiod
    type:
      - 'null'
      - int
    doc: TRF maximum period size to report.
    inputBinding:
      position: 101
      prefix: --tmaxperiod
  - id: maxtandem
    type:
      - 'null'
      - double
    doc: Max percentage which may be masked by TRF; if exceeded, the element is discarded.
    inputBinding:
      position: 101
      prefix: --maxtandem
outputs:
  - id: filtered
    type:
      - 'null'
      - File
    doc: Filtered FASTA library.
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
