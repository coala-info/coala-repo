cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svclone
  - cluster
label: svclone_cluster
doc: "Run clustering step\n\nTool homepage: https://github.com/mcmero/SVclone"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "Config file."
    inputBinding:
      position: 101
      prefix: -cfg
  - id: input
    type:
      - 'null'
      - File
    doc: "Filtered structural variant input from filter step. Default loc: <outdir>/<sample>_filtered_svs.tsv."
    inputBinding:
      position: 101
      prefix: --input
  - id: sample
    type: string
    doc: "Sample name."
    inputBinding:
      position: 101
      prefix: --sample
  - id: out
    type:
      - 'null'
      - string
    doc: "Output directory. Default: sample name."
    inputBinding:
      position: 101
      prefix: --out
  - id: params
    type:
      - 'null'
      - File
    doc: "Read parameters file containing read length, average insert and insert standard deviation (see README)."
    inputBinding:
      position: 101
      prefix: --params
  - id: purity_ploidy
    type:
      - 'null'
      - File
    doc: "Tumour purity ploidy file. See README for format. If not found, default purity = 1 (100%); default ploidy = 2."
    inputBinding:
      position: 101
      prefix: --purity_ploidy
  - id: snvs
    type:
      - 'null'
      - File
    doc: "To specify filtered SNVs output from Filter Step. Default loc: <outdir>/<sample>_filtered_snvs.tsv."
    inputBinding:
      position: 101
      prefix: --snvs
  - id: subsample
    type:
      - 'null'
      - int
    doc: "Subsample N SNVs from total filtered output to use for clustering."
    inputBinding:
      position: 101
      prefix: --subsample
  - id: ss_seeds
    type:
      - 'null'
      - int
    doc: "Integer seeds to set seeds for replicability of subsampling."
    inputBinding:
      position: 101
      prefix: --ss_seeds
  - id: xx
    type:
      - 'null'
      - boolean
    doc: "Specify XX genotype. (Overwrites config file, sets male to False.)"
    inputBinding:
      position: 101
      prefix: --XX
  - id: xy
    type:
      - 'null'
      - boolean
    doc: "Specify XY genotype. (Overwrites config file, sets male to True.)"
    inputBinding:
      position: 101
      prefix: --XY
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory (the --out value, or the sample name by default).
    outputBinding:
      glob: '$(inputs.out ? inputs.out : inputs.sample)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svclone:1.1.4--pyr44hdfd78af_0
