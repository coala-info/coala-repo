cwlVersion: v1.2
class: CommandLineTool
baseCommand: [calculate-abundances]
label: madre_calculate-abundances
doc: "MADRe abundance calculation: read counts and estimated abundances per reference strain from the read classification.\n\nTool homepage: https://github.com/lbcb-sci/MADRe"
inputs:
  - id: db
    type:
      - 'null'
      - File
    doc: "Path to the database file (fasta). If DatabaseReduction used - path to the reduced database. WARNING: Required for estimated abundances calculation."
    inputBinding:
      position: 1
      prefix: --db
  - id: reads
    type: File
    doc: Path to the reads file (fastq/fasta, can be gziped).
    inputBinding:
      position: 2
      prefix: --reads
  - id: read_class
    type: File
    doc: Path to the input file with classification labels for reads from read classification step. (default=read_classification.out)
    inputBinding:
      position: 3
      prefix: --read_class
  - id: rc_abundances_out
    type:
      - 'null'
      - string
    doc: Path to the output file with read count. (default=rc_abundances.out)
    inputBinding:
      position: 4
      prefix: --rc_abundances_out
  - id: abundances_out
    type:
      - 'null'
      - string
    doc: "Path to the output file with estimated abundances. If path is not given this file is not going to be generated. WARNING: In case of large sample and large database that can be computationally exhaustive job."
    inputBinding:
      position: 5
      prefix: --abundances_out
  - id: clusters
    type:
      - 'null'
      - Directory
    doc: Path to dir that contains clusters.txt and representatives.txt files. If provided, the abundances in output files will be reported including cluster information.
    inputBinding:
      position: 6
      prefix: --clusters
outputs:
  - id: rc_abundances
    type: File
    doc: File with the read count per reference
    outputBinding:
      glob: '$(inputs.rc_abundances_out ? inputs.rc_abundances_out : "rc_abundances.out")'
  - id: abundances
    type:
      - 'null'
      - File
    doc: File with estimated abundances
    outputBinding:
      glob: '$(inputs.abundances_out ? inputs.abundances_out : null)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
