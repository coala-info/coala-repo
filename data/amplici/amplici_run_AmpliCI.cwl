cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_AmpliCI
label: amplici_run_AmpliCI
doc: "Cluster amplicon sequences in a fastq file with or without UMIs.\n\nTool homepage:
  https://github.com/DormanLab/AmpliCI"
inputs:
  - id: command
    type: string
    doc: 'The command to execute: cluster, daumi, error, assignment, or histogram'
    inputBinding:
      position: 1
  - id: abundance
    type:
      - 'null'
      - float
    doc: Lower bound for estimated scaled true abundance
    inputBinding:
      position: 102
      prefix: --abundance
  - id: fastq
    type:
      - 'null'
      - File
    doc: Input FASTQ file
    inputBinding:
      position: 102
      prefix: --fastq
  - id: haplotype
    type:
      - 'null'
      - File
    doc: FASTA file containing candidate set of true haplotypes
    inputBinding:
      position: 102
      prefix: --haplotype
  - id: partition
    type:
      - 'null'
      - File
    doc: Partition file for error estimation
    inputBinding:
      position: 102
      prefix: --partition
  - id: profile
    type:
      - 'null'
      - File
    doc: Estimated error profile file
    inputBinding:
      position: 102
      prefix: --profile
  - id: rho
    type:
      - 'null'
      - float
    doc: Rho parameter for DAUMI clustering
    inputBinding:
      position: 102
      prefix: --rho
  - id: trim
    type:
      - 'null'
      - int
    doc: Length of UMI to trim from the 5' end
    inputBinding:
      position: 102
      prefix: --trim
  - id: umi
    type:
      - 'null'
      - boolean
    doc: Indicate that input contains UMIs
    inputBinding:
      position: 102
      prefix: --umi
  - id: umifile
    type:
      - 'null'
      - File
    doc: FASTA file containing candidate set of true UMIs
    inputBinding:
      position: 102
      prefix: --umifile
  - id: umilen
    type:
      - 'null'
      - int
    doc: Length of the UMI
    inputBinding:
      position: 102
      prefix: --umilen
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity level; set to 8+ for debugging.
    default: 1
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file or base name for results
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplici:2.2--h2555670_1
