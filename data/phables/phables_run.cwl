cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phables
  - run
label: phables_run
doc: "Run Phables\n\nTool homepage: https://github.com/Vini2/phables"
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
    default: 1.2
    inputBinding:
      position: 102
      prefix: --alpha
  - id: compcount
    type:
      - 'null'
      - int
    doc: maximum unitig count to consider a component
    default: 200
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
    default: (outputDir)/config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: covtol
    type:
      - 'null'
      - int
    doc: coverage tolerance for extending subpaths
    default: 100
    inputBinding:
      position: 102
      prefix: --covtol
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value for phrog annotations
    default: '1e-10'
    inputBinding:
      position: 102
      prefix: --evalue
  - id: input_assembly_graph
    type: File
    doc: Path to assembly graph file in .GFA format
    inputBinding:
      position: 102
      prefix: --input
  - id: longreads
    type:
      - 'null'
      - boolean
    doc: provide long reads as input (else defaults to short reads)
    inputBinding:
      position: 102
      prefix: --longreads
  - id: maxpaths
    type:
      - 'null'
      - int
    doc: maximum number of paths to resolve for a component
    default: 10
    inputBinding:
      position: 102
      prefix: --maxpaths
  - id: mgfrac
    type:
      - 'null'
      - float
    doc: length threshold to consider single copy marker genes
    default: 0.2
    inputBinding:
      position: 102
      prefix: --mgfrac
  - id: mincov
    type:
      - 'null'
      - int
    doc: minimum coverage of paths to output
    default: 10
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minlength
    type:
      - 'null'
      - int
    doc: minimum length of circular unitigs to consider
    default: 2000
    inputBinding:
      position: 102
      prefix: --minlength
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: false
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: phables.out
    inputBinding:
      position: 102
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for genome identifier
    inputBinding:
      position: 102
      prefix: --prefix
  - id: profile
    type:
      - 'null'
      - string
    doc: Snakemake profile
    inputBinding:
      position: 102
      prefix: --profile
  - id: reads_dir
    type: Directory
    doc: Path to directory containing paired-end reads
    inputBinding:
      position: 102
      prefix: --reads
  - id: seqidentity
    type:
      - 'null'
      - float
    doc: minimum sequence identity for phrog annotations
    default: 0.3
    inputBinding:
      position: 102
      prefix: --seqidentity
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    default: --rerun-incomplete, --printshellcmds, --nolock, --show-failed-logs
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-conda
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phables:1.5.0--pyhdfd78af_0
stdout: phables_run.out
