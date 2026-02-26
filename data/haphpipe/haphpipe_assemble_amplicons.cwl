cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe assemble_amplicons
label: haphpipe_assemble_amplicons
doc: "Assemble amplicons using HAPHPipe.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: contigs_fa
    type: File
    doc: Fasta file with assembled contigs
    inputBinding:
      position: 101
      prefix: --contigs_fa
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Additional options
    default: false
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
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum contig length for tiling path
    default: 200
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: padding
    type:
      - 'null'
      - int
    doc: Bases to include outside reference annotation.
    default: 50
    inputBinding:
      position: 101
      prefix: --padding
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref_fa
    type: File
    doc: Fasta file with reference genome to scaffold against
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: ref_gtf
    type: File
    doc: GTF format file containing amplicon regions
    inputBinding:
      position: 101
      prefix: --ref_gtf
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample ID.
    default: sampleXX
    inputBinding:
      position: 101
      prefix: --sample_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_assemble_amplicons.out
