cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify known-contam
label: magpurify_known-contam
doc: "Find contigs that match a database of known contaminants.\n\nTool homepage:
  https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - File
    doc: "Path to reference database. By default, the IMAGEN_DB\n                \
      \     environmental variable is used"
    inputBinding:
      position: 102
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - float
    doc: Maximum evalue
    inputBinding:
      position: 102
      prefix: --evalue
  - id: pid
    type:
      - 'null'
      - float
    doc: Minimum % identity to reference
    inputBinding:
      position: 102
      prefix: --pid
  - id: qcov
    type:
      - 'null'
      - float
    doc: Minimum percent query coverage
    inputBinding:
      position: 102
      prefix: --qcov
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
