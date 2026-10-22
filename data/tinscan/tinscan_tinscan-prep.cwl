cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan-prep
label: tinscan_tinscan-prep
doc: "Split multifasta genome files into directories for A and B genomes.\n\nTool
  homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs:
  - id: adir
    type:
      - 'null'
      - string
    doc: A genome sub-directory within outdir
    inputBinding:
      position: 101
      prefix: --adir
  - id: bdir
    type:
      - 'null'
      - string
    doc: B genome sub-directory within outdir
    inputBinding:
      position: 101
      prefix: --bdir
  - id: outdir
    type:
      - 'null'
      - string
    doc: Write split directories within this directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: query
    type: File
    doc: Multifasta containing B genome.
    inputBinding:
      position: 101
      prefix: --query
  - id: target
    type: File
    doc: Multifasta containing A genome.
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: a_genome_dir
    type: Directory
    doc: Directory with one FASTA file per A genome (target) sequence
    outputBinding:
      glob: '$((inputs.outdir ? inputs.outdir + "/" : "") + (inputs.adir || "A_target_split"))'
  - id: b_genome_dir
    type: Directory
    doc: Directory with one FASTA file per B genome (query) sequence
    outputBinding:
      glob: '$((inputs.outdir ? inputs.outdir + "/" : "") + (inputs.bdir || "B_query_split"))'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-prep.out
