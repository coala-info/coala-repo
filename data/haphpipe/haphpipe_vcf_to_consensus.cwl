cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haphpipe
  - vcf_to_consensus
label: haphpipe_vcf_to_consensus
doc: "Convert VCF to consensus sequence.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary directory
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
  - id: major
    type:
      - 'null'
      - float
    doc: Allele fraction to make unambiguous call
    default: 0.5
    inputBinding:
      position: 101
      prefix: --major
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum depth to call site
    default: 5
    inputBinding:
      position: 101
      prefix: --min_dp
  - id: minor
    type:
      - 'null'
      - float
    doc: Allele fraction to make ambiguous call
    default: 0.2
    inputBinding:
      position: 101
      prefix: --minor
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sampidx
    type:
      - 'null'
      - int
    doc: Index for sample if multi-sample VCF
    default: 0
    inputBinding:
      position: 101
      prefix: --sampidx
  - id: vcf
    type: File
    doc: VCF file (created with all sites).
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_vcf_to_consensus.out
