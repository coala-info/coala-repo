cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - alleleFreq
label: atlas_allelefreq
doc: "Estimating population allele frequencies from a multi-sample VCF of bi-allelic sites (e.g. made by ATLAS majorMinor).\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: vcf
    type: File
    doc: "Input multi-sample VCF file (e.g. from ATLAS majorMinor)."
    inputBinding:
      position: 1
      prefix: --vcf
  - id: samples
    type:
      - 'null'
      - File
    doc: "Text file with samples to use and their population (columns SAMPLE POPULATION)."
    inputBinding:
      position: 1
      prefix: --samples
  - id: likelihoods
    type:
      - 'null'
      - boolean
    doc: "Write the sample allele frequency likelihoods instead of the allele frequency table."
    inputBinding:
      position: 1
      prefix: --likelihoods
  - id: eps_f
    type:
      - 'null'
      - float
    doc: "Epsilon for the estimation algorithm."
    inputBinding:
      position: 1
      prefix: --epsF
  - id: iterations
    type:
      - 'null'
      - int
    doc: "Maximal number of iterations."
    inputBinding:
      position: 1
      prefix: --iterations
  - id: proposal_frac
    type:
      - 'null'
      - float
    doc: "Proposal width."
    inputBinding:
      position: 1
      prefix: --proposalFrac
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_alleleFreq"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: allele_freq
    type:
      - 'null'
      - File
    doc: "Allele frequencies for all positions and populations."
    outputBinding:
      glob: $(inputs.out_prefix)_alleleFreq.txt.gz
  - id: allele_freq_likelihoods
    type:
      - 'null'
      - File
    doc: "Allele frequency log likelihoods (with --likelihoods)."
    outputBinding:
      glob: $(inputs.out_prefix)_alleleFreqLikelihoods.txt.gz
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_allelefreq.log
