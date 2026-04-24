cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtdbtk infer
label: gtdbtk_infer
doc: "Infer phylogenetic trees for GTDB-Tk\n\nTool homepage: http://pypi.python.org/pypi/gtdbtk/"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create intermediate files for debugging purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: rescale branch lengths to optimize the Gamma20 likelihood
    inputBinding:
      position: 101
      prefix: --gamma
  - id: msa_file
    type: File
    doc: multiple sequence alignment in FASTA format
    inputBinding:
      position: 101
      prefix: --msa_file
  - id: no_support
    type:
      - 'null'
      - boolean
    doc: do not compute local support values using the Shimodaira-Hasegawa test
    inputBinding:
      position: 101
      prefix: --no_support
  - id: out_dir
    type: Directory
    doc: directory to output files
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: prot_model
    type:
      - 'null'
      - string
    doc: protein substitution model for tree inference
    inputBinding:
      position: 101
      prefix: --prot_model
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify alternative directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtdbtk:2.6.1--pyh1f0d9b5_2
stdout: gtdbtk_infer.out
