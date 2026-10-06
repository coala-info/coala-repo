cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bayesTyperTools, makeBloom]
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.kmc_table)
label: bayestyper_bayesTyperTools_makeBloom
doc: "BayesTyperTools makeBloom: create kmer bloom filter\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs:
  - id: kmc_table
    type: File
    doc: KMC3 kmer table (<prefix>.kmc_pre, with <prefix>.kmc_suf beside it). Output is written as <prefix>.bloomMeta
      and <prefix>.bloomData.
    secondaryFiles:
      - ^.kmc_suf
    inputBinding:
      position: 1
      prefix: -k
      valueFrom: $(self.nameroot)
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'number of threads used (+= 1 I/O thread) (default: 1)'
    inputBinding:
      position: 1
      prefix: -p
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: 'bloom filter false positive rate (default: 0.001)'
    inputBinding:
      position: 1
      prefix: --false-positive-rate
outputs:
  - id: bloom_meta
    type: File
    doc: Bloom filter metadata
    outputBinding:
      glob: $(inputs.kmc_table.nameroot).bloomMeta
  - id: bloom_data
    type: File
    doc: Bloom filter data
    outputBinding:
      glob: $(inputs.kmc_table.nameroot).bloomData
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--h077b44d_4
