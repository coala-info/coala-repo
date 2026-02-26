cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk bootstrap
label: genometreetk_bootstrap
doc: "Bootstrap multiple sequence alignment.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree inferred from original data
    inputBinding:
      position: 1
  - id: msa_file
    type: File
    doc: file containing multiple sequence alignment (or 'NONE' if '--boot_dir' 
      is given)
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 3
  - id: base_type
    type:
      - 'null'
      - string
    doc: indicates if bases are nucleotides or amino acids
    default: prot
    inputBinding:
      position: 104
      prefix: --base_type
  - id: boot_dir
    type:
      - 'null'
      - Directory
    doc: directory containing pre-computed bootstrap trees (must have '.tree', 
      '.tre', or '.treefile' extension)
    inputBinding:
      position: 104
      prefix: --boot_dir
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus
    default: 1
    inputBinding:
      position: 104
      prefix: --cpus
  - id: fraction
    type:
      - 'null'
      - float
    doc: fraction of alignment to subsample
    default: 1.0
    inputBinding:
      position: 104
      prefix: --fraction
  - id: gamma
    type:
      - 'null'
      - boolean
    doc: indicates that the GAMMA model should be used
    inputBinding:
      position: 104
      prefix: --gamma
  - id: model
    type:
      - 'null'
      - string
    doc: model of evolution to use
    default: wag
    inputBinding:
      position: 104
      prefix: --model
  - id: num_replicates
    type:
      - 'null'
      - int
    doc: number of bootstrap replicates to perform
    default: 100
    inputBinding:
      position: 104
      prefix: --num_replicates
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 104
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_bootstrap.out
