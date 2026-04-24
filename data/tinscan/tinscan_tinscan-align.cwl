cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan-align
label: tinscan_tinscan-align
doc: "Align B genome (query) sequences onto A genome (target) using LASTZ.\n\nTool
  homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs:
  - id: adir
    type: Directory
    doc: Name of directory containing sequences from A genome.
    inputBinding:
      position: 101
      prefix: --adir
  - id: bdir
    type: Directory
    doc: Name of directory containing sequences from B genome.
    inputBinding:
      position: 101
      prefix: --bdir
  - id: hspthresh
    type:
      - 'null'
      - float
    doc: LASTZ min HSP threshold. Increase for stricter matches.
    inputBinding:
      position: 101
      prefix: --hspthresh
  - id: lzpath
    type:
      - 'null'
      - string
    doc: Custom path to LASTZ executable if not in $PATH.
    inputBinding:
      position: 101
      prefix: --lzpath
  - id: min_idt
    type:
      - 'null'
      - float
    doc: Minimum alignment identity to report.
    inputBinding:
      position: 101
      prefix: --minIdt
  - id: min_len
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
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pairs
    type:
      - 'null'
      - File
    doc: 'Optional: Tab-delimited 2-col file specifying target:query sequence pairs
      to be aligned'
    inputBinding:
      position: 101
      prefix: --pairs
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
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
