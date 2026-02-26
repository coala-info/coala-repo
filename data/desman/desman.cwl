cwlVersion: v1.2
class: CommandLineTool
baseCommand: desman
label: desman
doc: "DESMAN (Diploid Evolutionary Signature Model ANalysis) is a tool for inferring
  haplotype frequencies from SNP data.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: variant_file
    type: File
    doc: input SNP frequencies
    inputBinding:
      position: 1
  - id: assign_file
    type:
      - 'null'
      - File
    doc: calculates haplotype profiles for these SNPs using fitted gamma, eta 
      values
    inputBinding:
      position: 102
      prefix: --assign_file
  - id: eta_file
    type:
      - 'null'
      - File
    doc: reads initial eta matrix from file
    inputBinding:
      position: 102
      prefix: --eta_file
  - id: filter_variants
    type:
      - 'null'
      - float
    doc: filters variants by negative binomial loge likelihood
    default: 3.84
    inputBinding:
      position: 102
      prefix: --filter_variants
  - id: genomes
    type: string
    doc: specify the haplotype number
    inputBinding:
      position: 102
      prefix: --genomes
  - id: max_qvalue
    type:
      - 'null'
      - float
    doc: specifies q value cut-off for variant detection
    default: '1.0e-3'
    inputBinding:
      position: 102
      prefix: --max_qvalue
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage for sample to be included
    inputBinding:
      position: 102
      prefix: --min_coverage
  - id: min_variant_freq
    type:
      - 'null'
      - float
    doc: specifies minimum variant frequency
    default: 0.01
    inputBinding:
      position: 102
      prefix: --min_variant_freq
  - id: no_iter
    type:
      - 'null'
      - int
    doc: Number of iterations of Gibbs sampler
    inputBinding:
      position: 102
      prefix: --no_iter
  - id: optimiseP
    type:
      - 'null'
      - string
    doc: optimise proportions in likelihood ratio test
    inputBinding:
      position: 102
      prefix: --optimiseP
  - id: random_seed
    type:
      - 'null'
      - int
    doc: specifies seed for numpy random number generator
    default: 23724839 applied after random filtering
    inputBinding:
      position: 102
      prefix: --random_seed
  - id: random_select
    type:
      - 'null'
      - string
    doc: selects subset of variants passing filter to build model and assigns 
      others
    inputBinding:
      position: 102
      prefix: --random_select
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: string specifying output directory and file stubs
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
