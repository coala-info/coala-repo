cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - compute-cn
label: hatchet_compute_cn
doc: "Infer allele-specific copy numbers, clone proportions and tumor purity/ploidy from the clustered bins (seg and bbc files) with the HATCHet solver.

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: solver
    type:
      - 'null'
      - string
    doc: Path to the executable solver
    inputBinding:
      position: 100
  - id: input
    type: string
    doc: Prefix of the seg and bbc input files, written without a directory (the files PREFIX.seg and PREFIX.bbc are read from the working directory)
    inputBinding:
      position: 10
      prefix: -i
  - id: input_files
    type:
      type: array
      items: File
    doc: The seg and bbc files named by the prefix (staged in the working directory)
  - id: runningdir
    type: string
    doc: Running directory (created in the working directory)
    inputBinding:
      position: 10
      prefix: -x
    default: results
  - id: clones
    type:
      - 'null'
      - string
    doc: "Either an estimated number of clones or an interval LOWER,UPPER (default: 2,8)"
    inputBinding:
      position: 10
      prefix: -n
  - id: noampdel
    type:
      - 'null'
      - boolean
    doc: Remove amp-del assumption
    inputBinding:
      position: 10
      prefix: -f
  - id: clonal
    type:
      - 'null'
      - string
    doc: "Clonal clusters to fix for tetraploid (default: automatically inferred)"
    inputBinding:
      position: 10
      prefix: -c
  - id: cnstates
    type:
      - 'null'
      - int
    doc: "Maximum number of distinct copy-number states for each segment (default: no limit)"
    inputBinding:
      position: 10
      prefix: -d
  - id: diploidcmax
    type:
      - 'null'
      - int
    doc: "Maximum copy-number value overall segments (default: 6)"
    inputBinding:
      position: 10
      prefix: -eD
  - id: tetraploidcmax
    type:
      - 'null'
      - int
    doc: "Maximum copy-number value overall segments (default: 12)"
    inputBinding:
      position: 10
      prefix: -eT
  - id: minsize
    type:
      - 'null'
      - float
    doc: "The minimum proportion of covered genome for potential clonal clusters (default: 0.008)"
    inputBinding:
      position: 10
      prefix: -ts
  - id: minchrs
    type:
      - 'null'
      - int
    doc: "The minimum number of covered chromosomes for potential clonal clusters (default: 1)"
    inputBinding:
      position: 10
      prefix: -tc
  - id: maxneutralshift
    type:
      - 'null'
      - float
    doc: "Maximum BAF shift for neutral cluster used to automatically infer the diploid/tetraploid cluster (default: 0.1)"
    inputBinding:
      position: 10
      prefix: -td
  - id: merge
    type:
      - 'null'
      - boolean
    doc: "Merge the clusters (default: false)"
    inputBinding:
      position: 10
      prefix: --merge
  - id: mergerdr
    type:
      - 'null'
      - float
    doc: "RDR tolerance used for finding the clonal copy numbers (default: 0.08)"
    inputBinding:
      position: 10
      prefix: -mR
  - id: mergebaf
    type:
      - 'null'
      - float
    doc: "BAF tolerance used for finding the clonal copy numbers (default: 0.04)"
    inputBinding:
      position: 10
      prefix: -mB
  - id: limitinc
    type:
      - 'null'
      - float
    doc: Upper bound to the relative increase of objective function
    inputBinding:
      position: 10
      prefix: -l
  - id: ghostprop
    type:
      - 'null'
      - float
    doc: "Increasing proportion used to compute the value of the first ghost point added in the solution selection (default: 0.3)"
    inputBinding:
      position: 10
      prefix: -g
  - id: tolerancerdr
    type:
      - 'null'
      - float
    doc: "RDR tolerance used for finding the clonal copy numbers (default: 0.08)"
    inputBinding:
      position: 10
      prefix: -tR
  - id: tolerancebaf
    type:
      - 'null'
      - float
    doc: "BAF tolerance used for finding the clonal copy numbers (default: 0.04)"
    inputBinding:
      position: 10
      prefix: -tB
  - id: seeds
    type:
      - 'null'
      - int
    doc: "Number of seeds for coordinate-descent method (default: 400)"
    inputBinding:
      position: 10
      prefix: -p
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of parallel jobs (default: maximum available on the machine)"
    inputBinding:
      position: 10
      prefix: -j
  - id: randomseed
    type:
      - 'null'
      - int
    doc: "Random seed (default: None)"
    inputBinding:
      position: 10
      prefix: -r
  - id: timelimit
    type:
      - 'null'
      - int
    doc: "Time limit for each ILP run (default: None)"
    inputBinding:
      position: 10
      prefix: -s
  - id: memlimit
    type:
      - 'null'
      - int
    doc: "Memory limit for each ILP run (default: None)"
    inputBinding:
      position: 10
      prefix: -m
  - id: minprop
    type:
      - 'null'
      - float
    doc: "Minimum clone proporion in each sample (default: 0.03)"
    inputBinding:
      position: 10
      prefix: -u
  - id: maxiterations
    type:
      - 'null'
      - int
    doc: "Maximum number of iterations composed of C-step/U-step for each seed (default: 10)"
    inputBinding:
      position: 10
      prefix: --maxiterations
  - id: mode
    type:
      - 'null'
      - int
    doc: "Solving mode among: Coordinate Descent + exact ILP (0), exact ILP only (1), and Coordinate-descent only (2) (default: 2)"
    inputBinding:
      position: 10
      prefix: --mode
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: "Force the tumor clones to be diploid without WGD (default: false)"
    inputBinding:
      position: 10
      prefix: --diploid
  - id: tetraploid
    type:
      - 'null'
      - boolean
    doc: "Force the tumor clones to be tetraploid with an occured WGD (default: false)"
    inputBinding:
      position: 10
      prefix: --tetraploid
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity among: none (0), essential (1), verbose (2), and debug (3) (default: 1)"
    inputBinding:
      position: 10
      prefix: -v
  - id: binwise
    type:
      - 'null'
      - boolean
    doc: Use bin-wise objective function which requires more variables and constraints but accounts for cluster variances (default False)
    inputBinding:
      position: 10
      prefix: -b
  - id: purities
    type:
      - 'null'
      - string
    doc: "To fix purities for each sample, pass a space-separated list of purities"
    inputBinding:
      position: 10
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_dir
    type: Directory
    doc: "Directory with the copy-number results (best.bbc.ucn, best.seg.ucn, ...)"
    outputBinding:
      glob: $(inputs.runningdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
      - entryname: $(inputs.runningdir)
        entry: '$({"class": "Directory", "basename": inputs.runningdir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_compute_cn.out
