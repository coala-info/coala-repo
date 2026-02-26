cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastreeR.py
label: fastreer_fastreeR
doc: "fastreeR CLI: Calculate distance matrices and phylogenetic trees from VCF or
  FASTA files\n\nTool homepage: https://github.com/gkanogiannis/fastreeR"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to execute: VCF2DIST, VCF2TREE, DIST2TREE, FASTA2DIST, VCF2EMB'
    inputBinding:
      position: 1
  - id: dist2tree_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for DIST2TREE subcommand
    inputBinding:
      position: 2
  - id: fasta2dist_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for FASTA2DIST subcommand
    inputBinding:
      position: 3
  - id: vcf2dist_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for VCF2DIST subcommand
    inputBinding:
      position: 4
  - id: vcf2emb_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for VCF2EMB subcommand
    inputBinding:
      position: 5
  - id: vcf2tree_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for VCF2TREE subcommand
    inputBinding:
      position: 6
  - id: check
    type:
      - 'null'
      - boolean
    doc: Test Java and backend availability
    inputBinding:
      position: 107
      prefix: --check
  - id: extra_verbose
    type:
      - 'null'
      - boolean
    doc: Print extra messages on stderr
    default: false
    inputBinding:
      position: 107
      prefix: --extraVerbose
  - id: lib
    type:
      - 'null'
      - Directory
    doc: Path to JAR library folder
    default: /usr/local/share/fastreer-2.1.3-0
    inputBinding:
      position: 107
      prefix: --lib
  - id: mem
    type:
      - 'null'
      - int
    doc: Max RAM for JVM in MB
    default: 256
    inputBinding:
      position: 107
      prefix: --mem
  - id: pipe_stderr
    type:
      - 'null'
      - boolean
    doc: Pipe Java stderr to CLI
    default: false
    inputBinding:
      position: 107
      prefix: --pipe-stderr
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
stdout: fastreer_fastreeR.out
