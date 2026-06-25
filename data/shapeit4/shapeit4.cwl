cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit4
label: shapeit4
doc: "SHAPEIT4 is a fast and accurate method for estimation of haplotypes (phasing)
  from genotype data.\n\nTool homepage: https://odelaneau.github.io/shapeit4/"
inputs:
  - id: input
    type: File
    doc: Input genotypes to be phased in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --input
  - id: map
    type: File
    doc: Genetic map in the format used by SHAPEIT
    inputBinding:
      position: 101
      prefix: --map
  - id: mcmc_iterations
    type:
      - 'null'
      - string
    doc: MCMC strategy to be used
    inputBinding:
      position: 101
      prefix: --mcmc-iterations
  - id: pbwt_depth
    type:
      - 'null'
      - int
    doc: Number of neighbors to store in the PBWT
    inputBinding:
      position: 101
      prefix: --pbwt-depth
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference panel of haplotypes in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --reference
  - id: region
    type: string
    doc: Target region to be phased (e.g. chr20:1000000-2000000)
    inputBinding:
      position: 101
      prefix: --region
  - id: scaffold
    type:
      - 'null'
      - File
    doc: Scaffold of haplotypes (e.g. from SNP array) in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --scaffold
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --thread
  - id: window
    type:
      - 'null'
      - float
    doc: Size of the window in Mb in which conditioning haplotypes are selected
    inputBinding:
      position: 101
      prefix: --window
  - id: log_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `log_path`
    inputBinding:
      position: 102
      prefix: --log
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Phased haplotypes in VCF/BCF format
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit4:4.2.2--h6959450_5
