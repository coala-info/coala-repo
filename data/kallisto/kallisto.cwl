cwlVersion: v1.2
class: CommandLineTool
baseCommand: kallisto
label: kallisto
doc: "kallisto is a program for quantifying abundances of transcripts from RNA-Seq
  data, or more generally of target sequences using high-throughput mRNA sequencing
  reads.\n\nTool homepage: https://pachterlab.github.io/kallisto"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (index, quant, bus, pseudo, inspect, or version)
    inputBinding:
      position: 1
  - id: bootstrap_samples
    type:
      - 'null'
      - int
    doc: Number of bootstrap samples
    default: 0
    inputBinding:
      position: 102
      prefix: --bootstrap-samples
  - id: fragment_length
    type:
      - 'null'
      - float
    doc: Estimated average fragment length
    inputBinding:
      position: 102
      prefix: --fragment-length
  - id: fusion
    type:
      - 'null'
      - boolean
    doc: Search for fusions for Pizzly
    inputBinding:
      position: 102
      prefix: --fusion
  - id: index
    type:
      - 'null'
      - File
    doc: Filename for the kallisto index to be used for quantification or 
      created by index
    inputBinding:
      position: 102
      prefix: --index
  - id: plaintext
    type:
      - 'null'
      - boolean
    doc: Output abundance estimates in plaintext
    inputBinding:
      position: 102
      prefix: --plaintext
  - id: sd
    type:
      - 'null'
      - float
    doc: Estimated standard deviation of fragment length
    inputBinding:
      position: 102
      prefix: --sd
  - id: single
    type:
      - 'null'
      - boolean
    doc: Quantify single-end reads
    inputBinding:
      position: 102
      prefix: --single
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write output to
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.51.1--h2b92561_2
