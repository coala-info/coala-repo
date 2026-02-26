cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_likelihood
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Generate all possible haplotypes
    inputBinding:
      position: 101
      prefix: --all
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: Allele Frequencies (a|e|f|m|file)
    default: a
    inputBinding:
      position: 101
      prefix: -f
  - id: ascertainment
    type:
      - 'null'
      - boolean
    doc: Account for ascertainment in VC analysis
    inputBinding:
      position: 101
      prefix: --ascertainment
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: Perform standard association analysis
    inputBinding:
      position: 101
      prefix: --assoc
  - id: best
    type:
      - 'null'
      - boolean
    doc: Find the best haplotype
    inputBinding:
      position: 101
      prefix: --best
  - id: bits
    type:
      - 'null'
      - int
    doc: Number of bits for limits
    default: 24
    inputBinding:
      position: 101
      prefix: --bits
  - id: cfreq
    type:
      - 'null'
      - float
    doc: Conditional frequency for LD clusters
    inputBinding:
      position: 101
      prefix: --cfreq
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: LD clusters
    inputBinding:
      position: 101
      prefix: --clusters
  - id: custom
    type:
      - 'null'
      - File
    doc: Custom association analysis with covariates
    inputBinding:
      position: 101
      prefix: --custom
  - id: data_file
    type: File
    doc: Data File
    inputBinding:
      position: 101
      prefix: -dname
  - id: deviates
    type:
      - 'null'
      - boolean
    doc: Calculate NPL deviates
    inputBinding:
      position: 101
      prefix: --deviates
  - id: distance
    type:
      - 'null'
      - float
    doc: Distance for LD clusters
    inputBinding:
      position: 101
      prefix: --distance
  - id: error
    type:
      - 'null'
      - boolean
    doc: General error reporting
    inputBinding:
      position: 101
      prefix: --error
  - id: exp
    type:
      - 'null'
      - boolean
    doc: Calculate expected NPL scores
    inputBinding:
      position: 101
      prefix: --exp
  - id: extended
    type:
      - 'null'
      - boolean
    doc: Extended IBD calculations
    inputBinding:
      position: 101
      prefix: --extended
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: Perform fast association analysis
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Filter markers for association analysis
    inputBinding:
      position: 101
      prefix: --filter
  - id: founders
    type:
      - 'null'
      - boolean
    doc: Haplotype analysis considering only founders
    inputBinding:
      position: 101
      prefix: --founders
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: Output allele frequencies
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: grid
    type:
      - 'null'
      - boolean
    doc: Analyze positions on a grid
    inputBinding:
      position: 101
      prefix: --grid
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: Horizontal haplotyping output
    inputBinding:
      position: 101
      prefix: --horizontal
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: Calculate IBD states
    inputBinding:
      position: 101
      prefix: --ibd
  - id: infer
    type:
      - 'null'
      - boolean
    doc: Infer allele frequencies for association analysis
    inputBinding:
      position: 101
      prefix: --infer
  - id: information
    type:
      - 'null'
      - boolean
    doc: General information reporting
    inputBinding:
      position: 101
      prefix: --information
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: Calculate kinship coefficients
    inputBinding:
      position: 101
      prefix: --kinship
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: Calculate likelihoods
    inputBinding:
      position: 101
      prefix: --likelihood
  - id: map_file
    type: File
    doc: Map File
    inputBinding:
      position: 101
      prefix: -mname
  - id: marker_names
    type:
      - 'null'
      - boolean
    doc: Use marker names in output
    inputBinding:
      position: 101
      prefix: --markerNames
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: Output IBD matrices
    inputBinding:
      position: 101
      prefix: --matrices
  - id: max_step
    type:
      - 'null'
      - float
    doc: Maximum step size for positions
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: Memory limit in megabytes
    inputBinding:
      position: 101
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - float
    doc: Minimum step size for positions
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: Time limit in minutes
    inputBinding:
      position: 101
      prefix: --minutes
  - id: missing_value_code
    type:
      - 'null'
      - float
    doc: Missing Value Code
    default: -99.999
    inputBinding:
      position: 101
      prefix: -xname
  - id: model
    type:
      - 'null'
      - File
    doc: Model parameter table
    inputBinding:
      position: 101
      prefix: --model
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: Disable couple bits for performance
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: Perform NPL linkage analysis
    inputBinding:
      position: 101
      prefix: --npl
  - id: one
    type:
      - 'null'
      - boolean
    doc: Recombination rate of one
    inputBinding:
      position: 101
      prefix: --one
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Analyze pairs of relatives
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output results in PDF format
    inputBinding:
      position: 101
      prefix: --pdf
  - id: pedigree_file
    type: File
    doc: Pedigree File
    inputBinding:
      position: 101
      prefix: -pname
  - id: per_family
    type:
      - 'null'
      - boolean
    doc: Output results per family
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: merlin
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: Perform QTL linkage analysis
    inputBinding:
      position: 101
      prefix: --qtl
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random Seed
    default: 123456
    inputBinding:
      position: 101
      prefix: -r9999
  - id: reruns
    type:
      - 'null'
      - int
    doc: Number of simulation reruns
    inputBinding:
      position: 101
      prefix: --reruns
  - id: rsq
    type:
      - 'null'
      - float
    doc: R-squared threshold for LD clusters
    inputBinding:
      position: 101
      prefix: --rsq
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Sample haplotypes
    inputBinding:
      position: 101
      prefix: --sample
  - id: save
    type:
      - 'null'
      - boolean
    doc: Save simulation results
    inputBinding:
      position: 101
      prefix: --save
  - id: select
    type:
      - 'null'
      - boolean
    doc: Select individuals for IBD calculation
    inputBinding:
      position: 101
      prefix: --select
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Perform simulation
    inputBinding:
      position: 101
      prefix: --simulate
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: Single point recombination analysis
    inputBinding:
      position: 101
      prefix: --singlepoint
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: Use small swap for performance
    inputBinding:
      position: 101
      prefix: --smallSwap
  - id: start
    type:
      - 'null'
      - float
    doc: Starting position for analysis
    inputBinding:
      position: 101
      prefix: --start
  - id: steps
    type:
      - 'null'
      - boolean
    doc: Analyze positions in steps
    inputBinding:
      position: 101
      prefix: --steps
  - id: stop
    type:
      - 'null'
      - float
    doc: Stopping position for analysis
    inputBinding:
      position: 101
      prefix: --stop
  - id: swap
    type:
      - 'null'
      - boolean
    doc: Swap data for performance
    inputBinding:
      position: 101
      prefix: --swap
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Tabulate output
    inputBinding:
      position: 101
      prefix: --tabulate
  - id: three
    type:
      - 'null'
      - boolean
    doc: Recombination rate of three
    inputBinding:
      position: 101
      prefix: --three
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Trait(s) for simulation
    inputBinding:
      position: 101
      prefix: --trait
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim data for performance
    inputBinding:
      position: 101
      prefix: --trim
  - id: two
    type:
      - 'null'
      - boolean
    doc: Recombination rate of two
    inputBinding:
      position: 101
      prefix: --two
  - id: unlinked
    type:
      - 'null'
      - float
    doc: Unlinked marker proportion for VC analysis
    default: 0.0
    inputBinding:
      position: 101
      prefix: --unlinked
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: Include covariates in VC analysis
    inputBinding:
      position: 101
      prefix: --useCovariates
  - id: vc
    type:
      - 'null'
      - boolean
    doc: Perform variance component linkage analysis
    inputBinding:
      position: 101
      prefix: --vc
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Recombination rate of zero
    inputBinding:
      position: 101
      prefix: --zero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_likelihood.out
