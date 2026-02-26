cwlVersion: v1.2
class: CommandLineTool
baseCommand: dice
label: dice
doc: "A tool for phylogenetic reconstruction.\n\nTool homepage: https://github.com/samsonweiner/DICE"
inputs:
  - id: breakpoint
    type:
      - 'null'
      - boolean
    doc: Toggle to use breakpoint profiles.
    inputBinding:
      position: 101
      prefix: --breakpoint
  - id: dist_type
    type:
      - 'null'
      - string
    doc: Distance measure type. Options are 'root', 'log', 'manhattan', and 
      'euclidean'. Defaults to root.
    default: root
    inputBinding:
      position: 101
      prefix: --dist-type
  - id: fastme_path
    type:
      - 'null'
      - string
    doc: Path to 'fastme' executable. By default, assumes the fastme executable 
      is added to the user $PATH and is called directly.
    inputBinding:
      position: 101
      prefix: --fastme-path
  - id: input
    type: File
    doc: Path to dataset.
    inputBinding:
      position: 101
      prefix: --input
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rec_method
    type:
      - 'null'
      - string
    doc: Phylogenetic reconstruction algorithm. If not specified, will compute 
      the distance matrix and save to a file. Options are 'NJ', 'uNJ', 'balME', 
      and 'olsME'.
    inputBinding:
      position: 101
      prefix: --rec-method
  - id: save_dm
    type:
      - 'null'
      - boolean
    doc: Toggle to save the distance matrix to a file.
    inputBinding:
      position: 101
      prefix: --save-dm
  - id: seed
    type:
      - 'null'
      - int
    doc: Randomization seed used in fastme.
    inputBinding:
      position: 101
      prefix: --seed
  - id: total_cn
    type:
      - 'null'
      - boolean
    doc: Use total copy numbers instead of allele-specific copy numbers.
    inputBinding:
      position: 101
      prefix: --total-cn
  - id: use_nni
    type:
      - 'null'
      - boolean
    doc: For ME methods, toggle to use NNI tree search. By default, SPR tree 
      search is used.
    inputBinding:
      position: 101
      prefix: --use-NNI
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory. Will create one if it does not exist. Default is 
      current directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dice:1.1.0--pyhdfd78af_0
