cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - allhic
  - pipeline
label: allhic_pipeline
doc: "A pipeline for Hi-C scaffolding using the ALLHIC algorithm.\n\nTool homepage:
  https://github.com/tanghaibao/allhic"
inputs:
  - id: bamfile
    type: File
    doc: Input BAM file containing Hi-C alignments
    inputBinding:
      position: 1
  - id: fastafile
    type: File
    doc: Input FASTA file containing contigs
    inputBinding:
      position: 2
  - id: k
    type: int
    doc: Number of clusters (chromosomes)
    inputBinding:
      position: 3
  - id: max_link_density
    type:
      - 'null'
      - int
    doc: Density threshold before marking contig as repetive (CLUSTER_MAX_LINK_DENSITY
      in LACHESIS)
    default: 2
    inputBinding:
      position: 104
      prefix: --maxLinkDensity
  - id: min_links
    type:
      - 'null'
      - int
    doc: Minimum number of links for contig pair
    default: 3
    inputBinding:
      position: 104
      prefix: --minLinks
  - id: min_res
    type:
      - 'null'
      - int
    doc: Minimum number of RE sites in a contig to be clustered (CLUSTER_MIN_RE_SITES
      in LACHESIS)
    default: 10
    inputBinding:
      position: 104
      prefix: --minREs
  - id: mutapb
    type:
      - 'null'
      - float
    doc: Mutation prob in GA
    default: 0.2
    inputBinding:
      position: 104
      prefix: --mutapb
  - id: ngen
    type:
      - 'null'
      - int
    doc: Number of generations for convergence
    default: 5000
    inputBinding:
      position: 104
      prefix: --ngen
  - id: non_informative_ratio
    type:
      - 'null'
      - int
    doc: cutoff for recovering skipped contigs back into the clusters (CLUSTER_NON-INFORMATIVE_RATIO
      in LACHESIS)
    default: 3
    inputBinding:
      position: 104
      prefix: --nonInformativeRatio
  - id: npop
    type:
      - 'null'
      - int
    doc: Population size
    default: 100
    inputBinding:
      position: 104
      prefix: --npop
  - id: re_site
    type:
      - 'null'
      - string
    doc: Restriction site pattern, use comma to separate multiple patterns (N is considered
      as [ACGT]), e.g. 'GATCGATC,GANTGATC,GANTANTC,GATCANTC'
    default: GATC
    inputBinding:
      position: 104
      prefix: --RE
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume from existing tour file
    inputBinding:
      position: 104
      prefix: --resume
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed
    default: 42
    inputBinding:
      position: 104
      prefix: --seed
  - id: skip_ga
    type:
      - 'null'
      - boolean
    doc: Skip GA step
    inputBinding:
      position: 104
      prefix: --skipGA
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allhic:0.9.14--he881be0_0
stdout: allhic_pipeline.out
