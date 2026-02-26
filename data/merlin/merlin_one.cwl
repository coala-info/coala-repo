cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_one
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
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
    doc: 'VC Linkage: ascertainment'
    inputBinding:
      position: 101
      prefix: --ascertainment
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: 'Association: association'
    inputBinding:
      position: 101
      prefix: --assoc
  - id: bits
    type:
      - 'null'
      - int
    doc: 'Limits: bits'
    default: 24
    inputBinding:
      position: 101
      prefix: --bits
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'LD Clusters: clusters'
    inputBinding:
      position: 101
      prefix: --clusters
  - id: custom_assoc
    type:
      - 'null'
      - File
    doc: 'Association: custom covariate table'
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
    doc: 'NPL Linkage: deviates'
    inputBinding:
      position: 101
      prefix: --deviates
  - id: error
    type:
      - 'null'
      - boolean
    doc: 'General: error'
    inputBinding:
      position: 101
      prefix: --error
  - id: exp_npl
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: expected'
    inputBinding:
      position: 101
      prefix: --exp
  - id: extended_ibd
    type:
      - 'null'
      - boolean
    doc: 'IBD States: extended'
    inputBinding:
      position: 101
      prefix: --extended
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: 'Association: fast association'
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter_assoc
    type:
      - 'null'
      - boolean
    doc: 'Association: filter'
    inputBinding:
      position: 101
      prefix: --filter
  - id: frequencies_output
    type:
      - 'null'
      - boolean
    doc: 'Output: frequencies'
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: grid
    type:
      - 'null'
      - boolean
    doc: 'Positions: grid'
    inputBinding:
      position: 101
      prefix: --grid
  - id: haplotype_all
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: all'
    inputBinding:
      position: 101
      prefix: --all
  - id: haplotype_best
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: best'
    inputBinding:
      position: 101
      prefix: --best
  - id: haplotype_founders
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: founders'
    inputBinding:
      position: 101
      prefix: --founders
  - id: haplotype_horizontal
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: horizontal'
    inputBinding:
      position: 101
      prefix: --horizontal
  - id: haplotype_sample
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: sample'
    inputBinding:
      position: 101
      prefix: --sample
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: 'IBD States: IBD'
    inputBinding:
      position: 101
      prefix: --ibd
  - id: infer
    type:
      - 'null'
      - boolean
    doc: 'Association: infer'
    inputBinding:
      position: 101
      prefix: --infer
  - id: information
    type:
      - 'null'
      - boolean
    doc: 'General: information'
    inputBinding:
      position: 101
      prefix: --information
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: 'IBD States: kinship'
    inputBinding:
      position: 101
      prefix: --kinship
  - id: ld_cfreq
    type:
      - 'null'
      - float
    doc: 'LD Clusters: cfreq'
    inputBinding:
      position: 101
      prefix: --cfreq
  - id: ld_distance
    type:
      - 'null'
      - int
    doc: 'LD Clusters: distance'
    inputBinding:
      position: 101
      prefix: --distance
  - id: ld_rsq
    type:
      - 'null'
      - float
    doc: 'LD Clusters: rsq'
    inputBinding:
      position: 101
      prefix: --rsq
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: 'General: likelihood'
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
    doc: 'Output: marker names'
    inputBinding:
      position: 101
      prefix: --markerNames
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: 'IBD States: matrices'
    inputBinding:
      position: 101
      prefix: --matrices
  - id: max_step
    type:
      - 'null'
      - int
    doc: 'Positions: max step'
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: 'Limits: megabytes'
    inputBinding:
      position: 101
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - int
    doc: 'Positions: min step'
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: 'Limits: minutes'
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
    doc: 'General: model parameter table'
    inputBinding:
      position: 101
      prefix: --model
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: 'Performance: no couple bits'
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: NPL'
    inputBinding:
      position: 101
      prefix: --npl
  - id: npl_qtl
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: QTL'
    inputBinding:
      position: 101
      prefix: --qtl
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'Output: prefix'
    default: merlin
    inputBinding:
      position: 101
      prefix: --prefix
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: pairs'
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pdf_output
    type:
      - 'null'
      - boolean
    doc: 'Output: PDF'
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
    doc: 'Output: per family'
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Output: quiet'
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
  - id: recomb_one
    type:
      - 'null'
      - boolean
    doc: 'Recombination: one'
    inputBinding:
      position: 101
      prefix: --one
  - id: recomb_singlepoint
    type:
      - 'null'
      - boolean
    doc: 'Recombination: singlepoint'
    inputBinding:
      position: 101
      prefix: --singlepoint
  - id: recomb_three
    type:
      - 'null'
      - boolean
    doc: 'Recombination: three'
    inputBinding:
      position: 101
      prefix: --three
  - id: recomb_two
    type:
      - 'null'
      - boolean
    doc: 'Recombination: two'
    inputBinding:
      position: 101
      prefix: --two
  - id: recomb_zero
    type:
      - 'null'
      - boolean
    doc: 'Recombination: zero'
    inputBinding:
      position: 101
      prefix: --zero
  - id: reruns
    type:
      - 'null'
      - int
    doc: 'Simulation: reruns'
    inputBinding:
      position: 101
      prefix: --reruns
  - id: save_simulation
    type:
      - 'null'
      - boolean
    doc: 'Simulation: save'
    inputBinding:
      position: 101
      prefix: --save
  - id: select_ibd
    type:
      - 'null'
      - boolean
    doc: 'IBD States: select'
    inputBinding:
      position: 101
      prefix: --select
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: 'Simulation: simulate'
    inputBinding:
      position: 101
      prefix: --simulate
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: 'Performance: small swap'
    inputBinding:
      position: 101
      prefix: --smallSwap
  - id: start_pos
    type:
      - 'null'
      - int
    doc: 'Positions: start'
    inputBinding:
      position: 101
      prefix: --start
  - id: steps
    type:
      - 'null'
      - boolean
    doc: 'Positions: steps'
    inputBinding:
      position: 101
      prefix: --steps
  - id: stop_pos
    type:
      - 'null'
      - int
    doc: 'Positions: stop'
    inputBinding:
      position: 101
      prefix: --stop
  - id: swap
    type:
      - 'null'
      - boolean
    doc: 'Performance: swap'
    inputBinding:
      position: 101
      prefix: --swap
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: 'Output: tabulate'
    inputBinding:
      position: 101
      prefix: --tabulate
  - id: trait_simulation
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Simulation: trait'
    inputBinding:
      position: 101
      prefix: --trait
  - id: trim
    type:
      - 'null'
      - boolean
    doc: 'Performance: trim'
    inputBinding:
      position: 101
      prefix: --trim
  - id: unlinked
    type:
      - 'null'
      - float
    doc: 'VC Linkage: unlinked'
    default: 0.0
    inputBinding:
      position: 101
      prefix: --unlinked
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: 'VC Linkage: use covariates'
    inputBinding:
      position: 101
      prefix: --useCovariates
  - id: vc
    type:
      - 'null'
      - boolean
    doc: 'VC Linkage: VC'
    inputBinding:
      position: 101
      prefix: --vc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_one.out
