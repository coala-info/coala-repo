cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimeo-map
label: mimeo_map
doc: "Find all high-identity segments shared between genomes.\n\nTool homepage: https://github.com/Adamtaranto/mimeo"
inputs:
  - id: TRFpath
    type:
      - 'null'
      - File
    doc: Custom path to TRF executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --TRFpath
  - id: adir
    type:
      - 'null'
      - Directory
    doc: Name of directory containing sequences from A genome.
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
    doc: Name of directory containing sequences from B genome.
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
  - id: hspthresh
    type:
      - 'null'
      - int
    doc: Set HSP min score threshold for LASTZ.
    inputBinding:
      position: 101
      prefix: --hspthresh
  - id: keeptemp
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
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the logging level.
    default: INFO
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: lzpath
    type:
      - 'null'
      - File
    doc: Custom path to LASTZ executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --lzpath
  - id: maxtandem
    type:
      - 'null'
      - float
    doc: Max percentage of an A-genome alignment which may be masked by TRF. If 
      exceeded, alignment will be discarded.
    inputBinding:
      position: 101
      prefix: --maxtandem
  - id: minIdt
    type:
      - 'null'
      - float
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
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Write output files to this directory.
    default: cwd
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outfile
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
    doc: ID prefix for B-genome hits annotated in A-genome.
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
  - id: tPI
    type:
      - 'null'
      - float
    doc: TRF indel probability
    inputBinding:
      position: 101
      prefix: --tPI
  - id: tPM
    type:
      - 'null'
      - float
    doc: TRF match probability
    inputBinding:
      position: 101
      prefix: --tPM
  - id: tdelta
    type:
      - 'null'
      - int
    doc: TRF indel penalty
    inputBinding:
      position: 101
      prefix: --tdelta
  - id: tmatch
    type:
      - 'null'
      - int
    doc: TRF matching weight
    inputBinding:
      position: 101
      prefix: --tmatch
  - id: tmaxperiod
    type:
      - 'null'
      - int
    doc: TRF maximum period size to report
    inputBinding:
      position: 101
      prefix: --tmaxperiod
  - id: tminscore
    type:
      - 'null'
      - int
    doc: TRF minimum alignment score to report
    inputBinding:
      position: 101
      prefix: --tminscore
  - id: tmismatch
    type:
      - 'null'
      - int
    doc: TRF mismatching penalty
    inputBinding:
      position: 101
      prefix: --tmismatch
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If set report LASTZ progress.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: writeTRF
    type:
      - 'null'
      - boolean
    doc: If set write TRF filtered alignment file for use with other mimeo 
      modules.
    inputBinding:
      position: 101
      prefix: --writeTRF
outputs:
  - id: gffout
    type:
      - 'null'
      - File
    doc: Name of GFF3 annotation file. If not set, suppress output.
    outputBinding:
      glob: $(inputs.gffout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
