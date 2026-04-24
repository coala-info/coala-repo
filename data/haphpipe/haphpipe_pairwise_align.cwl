cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe pairwise_align
label: haphpipe_pairwise_align
doc: "Perform pairwise alignment of assembled amplicons to a reference genome.\n\n\
  Tool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: amplicons_fa
    type: File
    doc: Assembled amplicons (fasta)
    inputBinding:
      position: 101
      prefix: --amplicons_fa
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    inputBinding:
      position: 101
      prefix: --debug
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary directory
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref_fa
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: ref_gtf
    type: File
    doc: GTF format file containing amplicon regions. Primary and alternate 
      coding regions should be provided in the attribute field (for amino acid 
      alignment).
    inputBinding:
      position: 101
      prefix: --ref_gtf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_pairwise_align.out
