cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe assemble_scaffold
label: haphpipe_assemble_scaffold
doc: "Assemble and scaffold contigs using a reference genome.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
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
    inputBinding:
      position: 101
      prefix: --debug
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Additional options
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
    doc: Fasta file with reference genome to scaffold against
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: seqname
    type:
      - 'null'
      - string
    doc: Name to append to scaffold sequence.
    inputBinding:
      position: 101
      prefix: --seqname
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_assemble_scaffold.out
