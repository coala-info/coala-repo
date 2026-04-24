cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe call_variants
label: haphpipe_call_variants
doc: "Call variants using HaplotypeCaller.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: aln_bam
    type: File
    doc: Alignment file.
    inputBinding:
      position: 101
      prefix: --aln_bam
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    inputBinding:
      position: 101
      prefix: --debug
  - id: emit_all
    type:
      - 'null'
      - boolean
    doc: Output calls for all sites.
    inputBinding:
      position: 101
      prefix: --emit_all
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
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality required to consider a base for calling.
    inputBinding:
      position: 101
      prefix: --min_base_qual
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    inputBinding:
      position: 101
      prefix: --ncpu
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
    doc: Reference fasta file.
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: xmx
    type:
      - 'null'
      - string
    doc: Maximum heap size for Java VM, in GB.
    inputBinding:
      position: 101
      prefix: --xmx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_call_variants.out
