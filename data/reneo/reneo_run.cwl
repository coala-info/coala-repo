cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reneo
  - run
label: reneo_run
doc: "Run Reneo\n\nTool homepage: https://github.com/Vini2/phables"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: coverage multiplier for flow interval modelling
    inputBinding:
      position: 102
      prefix: --alpha
  - id: compcount
    type:
      - 'null'
      - int
    doc: maximum unitig count to consider a component
    inputBinding:
      position: 102
      prefix: --compcount
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --configfile
  - id: covtol
    type:
      - 'null'
      - int
    doc: coverage tolerance for extending subpaths
    inputBinding:
      position: 102
      prefix: --covtol
  - id: databases
    type:
      - 'null'
      - string
    doc: Custom DB location
    inputBinding:
      position: 102
      prefix: --databases
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value for vog annotations
    inputBinding:
      position: 102
      prefix: --evalue
  - id: hmmscore
    type:
      - 'null'
      - float
    doc: minimum hmm score for vog annotations
    inputBinding:
      position: 102
      prefix: --hmmscore
  - id: hmmsearch
    type:
      - 'null'
      - boolean
    doc: Perform HMM searches
    inputBinding:
      position: 102
      prefix: --hmmsearch
  - id: input
    type: File
    doc: Path to assembly graph file in .GFA format
    inputBinding:
      position: 102
      prefix: --input
  - id: maxpaths
    type:
      - 'null'
      - int
    doc: maximum number of paths to resolve for a component
    inputBinding:
      position: 102
      prefix: --maxpaths
  - id: mgfrac
    type:
      - 'null'
      - float
    doc: length threshold to consider single copy marker genes
    inputBinding:
      position: 102
      prefix: --mgfrac
  - id: mincov
    type:
      - 'null'
      - int
    doc: minimum coverage of paths to output
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minlength
    type:
      - 'null'
      - int
    doc: minimum length of circular unitigs to consider
    inputBinding:
      position: 102
      prefix: --minlength
  - id: no_hmmsearch
    type:
      - 'null'
      - boolean
    doc: Skip HMM searches
    inputBinding:
      position: 102
      prefix: --no-hmmsearch
  - id: no_split_paths
    type:
      - 'null'
      - boolean
    doc: Do not output fasta file for each path
    inputBinding:
      position: 102
      prefix: --no-split-paths
  - id: no_unitigs
    type:
      - 'null'
      - boolean
    doc: Do not output unitigs file
    inputBinding:
      position: 102
      prefix: --no-unitigs
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: nvogs
    type:
      - 'null'
      - int
    doc: minimum number of vogs to consider a component
    inputBinding:
      position: 102
      prefix: --nvogs
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile to use
    inputBinding:
      position: 102
      prefix: --profile
  - id: reads
    type: Directory
    doc: Path to directory or TSV containing paired-end reads
    inputBinding:
      position: 102
      prefix: --reads
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: split_paths
    type:
      - 'null'
      - boolean
    doc: Output fasta file for each path
    inputBinding:
      position: 102
      prefix: --split-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: unitigs
    type:
      - 'null'
      - boolean
    doc: Output unitigs file
    inputBinding:
      position: 102
      prefix: --unitigs
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reneo:0.5.0--pyhdfd78af_0
