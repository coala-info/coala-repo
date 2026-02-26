cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - haptools
  - simphenotype
label: haptools_simphenotype
doc: "Haplotype-aware phenotype simulation. Create a set of simulated phenotypes from
  a set of haplotypes.\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: genotypes
    type: File
    doc: GENOTYPES must be formatted as a VCF or PGEN file and HAPLOTYPES must 
      be formatted according to the .hap format spec
    inputBinding:
      position: 1
  - id: haplotypes
    type: File
    doc: GENOTYPES must be formatted as a VCF or PGEN file and HAPLOTYPES must 
      be formatted according to the .hap format spec
    inputBinding:
      position: 2
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: If using a PGEN file, read genotypes in chunks of X variants; reduces 
      memory
    inputBinding:
      position: 103
      prefix: --chunk-size
  - id: environment
    type:
      - 'null'
      - float
    doc: Variance of environmental term; inferred if not specified
    inputBinding:
      position: 103
      prefix: --environment
  - id: heritability
    type:
      - 'null'
      - float
    doc: Trait heritability
    default: 0.5
    inputBinding:
      position: 103
      prefix: --heritability
  - id: id
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the haplotype IDs from the .hap file to use as causal variables
      (ex: '-i H1 -i H2')"
    inputBinding:
      position: 103
      prefix: --id
  - id: ids_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the haplotype IDs (one 
      per line) to subset from the .hap file
    inputBinding:
      position: 103
      prefix: --ids-file
  - id: no_normalize
    type:
      - 'null'
      - boolean
    doc: Whether to normalize the genotypes before using them for simulation
    inputBinding:
      position: 103
      prefix: --no-normalize
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Whether to normalize the genotypes before using them for simulation
    default: true
    inputBinding:
      position: 103
      prefix: --normalize
  - id: prevalence
    type:
      - 'null'
      - float
    doc: Disease prevalence if simulating a case- control trait
    inputBinding:
      position: 103
      prefix: --prevalence
  - id: region
    type:
      - 'null'
      - string
    doc: "The region from which to extract haplotypes; ex: 'chr1:1234-34566' or 'chr7'.
      For this to work, the VCF and .hap file must be indexed and the seqname provided
      must correspond with one in the files"
    inputBinding:
      position: 103
      prefix: --region
  - id: repeats
    type:
      - 'null'
      - File
    doc: Path to a genotypes file containing tandem repeats. This is only 
      necessary when simulating both haplotypes *and* repeats as causal effects
    inputBinding:
      position: 103
      prefix: --repeats
  - id: replications
    type:
      - 'null'
      - int
    doc: Number of rounds of simulation to perform
    default: 1
    inputBinding:
      position: 103
      prefix: --replications
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: "A list of the samples to subset from the genotypes file (ex: '-s sample1
      -s sample2')"
    inputBinding:
      position: 103
      prefix: --sample
  - id: samples_file
    type:
      - 'null'
      - File
    doc: A single column txt file containing a list of the samples (one per 
      line) to subset from the genotypes file
    inputBinding:
      position: 103
      prefix: --samples-file
  - id: seed
    type:
      - 'null'
      - int
    doc: Use this option across executions to make the output reproducible
    inputBinding:
      position: 103
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    default: INFO
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: A TSV file containing simulated phenotypes
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
