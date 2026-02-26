cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldhelmet max_lk
label: ldhelmet_max_lk
doc: "Maximum likelihood estimation of recombination rate\n\nTool homepage: http://sourceforge.net/projects/ldhelmet/"
inputs:
  - id: lk_file
    type:
      - 'null'
      - File
    doc: Two-site likelihood table.
    inputBinding:
      position: 101
      prefix: --lk_file
  - id: max_lk_end
    type:
      - 'null'
      - float
    doc: Rho value to end maximum likelihood estimation.
    default: 0.3
    inputBinding:
      position: 101
      prefix: --max_lk_end
  - id: max_lk_resolution
    type:
      - 'null'
      - float
    doc: Amount to increment by for maximum likelihood estimation.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --max_lk_resolution
  - id: max_lk_start
    type:
      - 'null'
      - float
    doc: Rho value to begin maximum likelihood estimation.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --max_lk_start
  - id: mut_mat_file
    type:
      - 'null'
      - File
    doc: Mutation matrix.
    inputBinding:
      position: 101
      prefix: --mut_mat_file
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: pade_file
    type:
      - 'null'
      - File
    doc: Pade coefficients.
    inputBinding:
      position: 101
      prefix: --pade_file
  - id: pade_max_rho
    type:
      - 'null'
      - float
    doc: Maximum Pade grid value.
    default: 1000
    inputBinding:
      position: 101
      prefix: --pade_max_rho
  - id: pade_resolution
    type:
      - 'null'
      - float
    doc: Pade grid increment.
    default: 10
    inputBinding:
      position: 101
      prefix: --pade_resolution
  - id: pos_file
    type:
      - 'null'
      - File
    doc: SNP positions for alternative input format.
    inputBinding:
      position: 101
      prefix: --pos_file
  - id: prior_file
    type:
      - 'null'
      - File
    doc: Prior on ancestral allele for each site.
    inputBinding:
      position: 101
      prefix: --prior_file
  - id: seq_file
    type:
      - 'null'
      - File
    doc: Sequence file.
    inputBinding:
      position: 101
      prefix: --seq_file
  - id: snps_file
    type:
      - 'null'
      - File
    doc: SNPs file for alternative input format.
    inputBinding:
      position: 101
      prefix: --snps_file
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size.
    default: 50
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldhelmet:1.10--h0704011_8
stdout: ldhelmet_max_lk.out
