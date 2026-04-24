cwlVersion: v1.2
class: CommandLineTool
baseCommand: poolsnp_PoolSNP.sh
label: poolsnp_PoolSNP.sh
doc: "PoolSNP v. 1.05 - 13/11/2017\n\nTool homepage: https://github.com/capoony/PoolSNP"
inputs:
  - id: base_quality
    type: int
    doc: minimum base quality for every nucleotide
    inputBinding:
      position: 101
      prefix: --base-quality
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of parallel jobs/cores used for the SNP calling
    inputBinding:
      position: 101
      prefix: --jobs
  - id: max_cov
    type: string
    doc: Either the maximum coverage percentile to be computed or an input file
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: min_count
    type: int
    doc: minimum alternative allele count across all populations pooled
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_cov
    type: int
    doc: sample-wise minimum coverage
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: min_freq
    type: float
    doc: minimum alternative allele frequency across all populations pooled
    inputBinding:
      position: 101
      prefix: --min-freq
  - id: miss_frac
    type: float
    doc: maximum allowed fraction of samples not fullfilling all parameters
    inputBinding:
      position: 101
      prefix: --miss-frac
  - id: mpileup
    type: File
    doc: The input mpileup
    inputBinding:
      position: 101
      prefix: --mpileup
  - id: names
    type: string
    doc: A comma separated list of samples names according to the order in the 
      mpileup file
    inputBinding:
      position: 101
      prefix: --names
  - id: output
    type: Directory
    doc: The output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type: File
    doc: The reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poolsnp:1.0.1--py312h7e72e81_0
stdout: poolsnp_PoolSNP.sh.out
