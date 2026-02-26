cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk jk_taxa
label: genometreetk_jk_taxa
doc: "Jackknife ingroup taxa.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree inferred from original data
    inputBinding:
      position: 1
  - id: msa_file
    type: File
    doc: file containing multiple sequence alignment
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 3
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus
    default: 1
    inputBinding:
      position: 104
      prefix: --cpus
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
    doc: number of jackknife replicates to perform
    default: 100
    inputBinding:
      position: 104
      prefix: --num_replicates
  - id: outgroup_ids
    type:
      - 'null'
      - File
    doc: file indicating outgroup taxa
    inputBinding:
      position: 104
      prefix: --outgroup_ids
  - id: perc_taxa
    type:
      - 'null'
      - float
    doc: percentage of taxa to keep
    default: 0.5
    inputBinding:
      position: 104
      prefix: --perc_taxa
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
stdout: genometreetk_jk_taxa.out
