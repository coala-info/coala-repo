cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, split-reads-molecules]
label: physlr_split-reads-molecules
doc: "Given the molecule to minimizers table and the reads, partition the reads into molecules by adding the molecule number to the BX tag.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: molecules_bx_only
    type: ['null', int]
    doc: "only print reads with barcodes that have been split to molecules (0 or 1) [1]"
    inputBinding:
      position: 1
      prefix: --molecules-bx-only
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: molecule_minimizers
    type: File
    doc: "Molecule to minimizers table in TSV format (as written by physlr split-minimizers)"
    inputBinding:
      position: 100
  - id: barcode_minimizers
    type: File
    doc: "Minimizers of every read, one line per read in the order of the reads file (as written by physlr-indexlr)"
    inputBinding:
      position: 101
  - id: reads
    type: File[]
    doc: "Interleaved linked reads in FASTQ format with BX tags"
    inputBinding:
      position: 102
outputs:
  - id: result
    type: File
    doc: "Reads in FASTQ format with the molecule number appended to the barcode of the BX tag"
    outputBinding:
      glob: physlr_split-reads-molecules.fq
stdout: physlr_split-reads-molecules.fq
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
