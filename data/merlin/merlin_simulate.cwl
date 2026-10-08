cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merlin
  - '--simulate'
  - '--save'
label: merlin_simulate
doc: "MERLIN 1.1.2 - Gene dropping simulation; saves the simulated pedigree, data, map and allele frequency files as <prefix>-replicate.*.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: data_file
    type: File
    doc: "Data file, in linkage or QTDT format (-d)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file
    type: File
    doc: "Pedigree file, with genotype, phenotype and family structure information (-p)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: map_file
    type: File
    doc: "Map file with chromosome and centimorgan position for each marker (-m)"
    inputBinding:
      position: 1
      prefix: '-m'
  - id: missing_value_code
    type:
      - 'null'
      - string
    doc: "Missing value code for quantitative phenotypes and covariates (default -99.999)"
    inputBinding:
      position: 1
      prefix: '-x'
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: "Source for allele frequencies: a (all individuals), e (equal), f (founders) or m (maximum likelihood); rendered as -fa, -fe, -ff or -fm"
    inputBinding:
      position: 1
      prefix: '-f'
      separate: false
  - id: allele_frequency_file
    type:
      - 'null'
      - File
    doc: "File with allele frequencies (-f file)"
    inputBinding:
      position: 1
      prefix: '-f'
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed for simulation and haplotype sampling (default 123456)"
    inputBinding:
      position: 1
      prefix: '-r'
  - id: reruns
    type:
      - 'null'
      - int
    doc: "Repeat the simulation this many times"
    inputBinding:
      position: 1
      prefix: '--reruns'
  - id: trait
    type:
      - 'null'
      - string
    doc: "Trait model for simulation, e.g. AFFECTION,FREQ,PEN(+/+),PEN(+/-),PEN(-/-),POSITION or QTLNAME,SNP,VarQTL,VarPoly,VarEnv"
    inputBinding:
      position: 1
      prefix: '--trait'
  - id: steps
    type:
      - 'null'
      - int
    doc: "Analyse at n equally spaced locations between consecutive markers"
    inputBinding:
      position: 1
      prefix: '--steps'
  - id: max_step
    type:
      - 'null'
      - float
    doc: "Maximum distance in cM between consecutive analysis locations"
    inputBinding:
      position: 1
      prefix: '--maxStep'
  - id: min_step
    type:
      - 'null'
      - float
    doc: "Minimum distance in cM between consecutive analysis locations"
    inputBinding:
      position: 1
      prefix: '--minStep'
  - id: grid
    type:
      - 'null'
      - float
    doc: "Analyse along an n-cM grid of equally spaced locations"
    inputBinding:
      position: 1
      prefix: '--grid'
  - id: start
    type:
      - 'null'
      - float
    doc: "Start analyses at this position in cM"
    inputBinding:
      position: 1
      prefix: '--start'
  - id: stop
    type:
      - 'null'
      - float
    doc: "Stop analyses at this position in cM"
    inputBinding:
      position: 1
      prefix: '--stop'
  - id: zero
    type:
      - 'null'
      - boolean
    doc: "Assume no recombination between markers"
    inputBinding:
      position: 1
      prefix: '--zero'
  - id: one
    type:
      - 'null'
      - boolean
    doc: "Allow 1 recombination event between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--one'
  - id: two
    type:
      - 'null'
      - boolean
    doc: "Allow 2 recombination events between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--two'
  - id: three
    type:
      - 'null'
      - boolean
    doc: "Allow 3 recombination events between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--three'
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: "Consider each marker individually"
    inputBinding:
      position: 1
      prefix: '--singlepoint'
  - id: clusters
    type:
      - 'null'
      - File
    doc: "Marker cluster table to model linkage disequilibrium between neighbouring markers"
    inputBinding:
      position: 1
      prefix: '--clusters'
  - id: distance
    type:
      - 'null'
      - float
    doc: "Define clusters of markers less than this many cM apart"
    inputBinding:
      position: 1
      prefix: '--distance'
  - id: rsq
    type:
      - 'null'
      - float
    doc: "Define clusters of SNPs whose pairwise r2 exceeds this threshold"
    inputBinding:
      position: 1
      prefix: '--rsq'
  - id: bits
    type:
      - 'null'
      - int
    doc: "Do not analyse pedigrees of more than this bit complexity (default 24)"
    inputBinding:
      position: 1
      prefix: '--bits'
  - id: megabytes
    type:
      - 'null'
      - int
    doc: "Do not allocate more than this many megabytes of memory"
    inputBinding:
      position: 1
      prefix: '--megabytes'
  - id: minutes
    type:
      - 'null'
      - int
    doc: "Skip families whose calculations need more than this many minutes"
    inputBinding:
      position: 1
      prefix: '--minutes'
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "Trim uninformative individuals from pedigrees"
    inputBinding:
      position: 1
      prefix: '--trim'
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: "Disable founder couple symmetry"
    inputBinding:
      position: 1
      prefix: '--noCoupleBits'
  - id: swap
    type:
      - 'null'
      - boolean
    doc: "Use a swap file to reduce memory usage"
    inputBinding:
      position: 1
      prefix: '--swap'
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: "Use an alternative swap strategy that saves disk space"
    inputBinding:
      position: 1
      prefix: '--smallSwap'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not output progress reports for large families"
    inputBinding:
      position: 1
      prefix: '--quiet'
  - id: marker_names
    type:
      - 'null'
      - boolean
    doc: "Label results with marker names instead of cM positions"
    inputBinding:
      position: 1
      prefix: '--markerNames'
  - id: per_family
    type:
      - 'null'
      - boolean
    doc: "Write per-family results to a file"
    inputBinding:
      position: 1
      prefix: '--perFamily'
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: "Write LOD score plots to <prefix>.pdf"
    inputBinding:
      position: 1
      prefix: '--pdf'
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: "Write tab-delimited tables of key results"
    inputBinding:
      position: 1
      prefix: '--tabulate'
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output file names (default merlin)"
    inputBinding:
      position: 1
      prefix: '--prefix'
outputs:
  - id: stdout
    type: stdout
    doc: "MERLIN report (standard output)"
  - id: replicate_files
    type:
      type: array
      items: File
    doc: "Simulated pedigree, data, map and frequency files"
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix : 'merlin')-replicate*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_simulate.out
