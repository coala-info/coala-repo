cwlVersion: v1.2
class: CommandLineTool
baseCommand: msweep
label: msweep
doc: "mSWEEP is a tool for estimating abundances of bacterial lineages from metagenomic
  sequencing data. (Note: The provided help text was a system error message; arguments
  listed here are based on standard tool documentation).\n\nTool homepage: https://github.com/PROBIC/mSWEEP"
inputs:
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s).
    inputBinding:
      position: 101
      prefix: --fastq
  - id: input
    type:
      - 'null'
      - File
    doc: Input pseudoalignment file (e.g., from Kallisto or Themisto).
    inputBinding:
      position: 101
      prefix: --input
  - id: iters
    type:
      - 'null'
      - int
    doc: Number of iterations for the estimation algorithm.
    inputBinding:
      position: 101
      prefix: --iters
  - id: reflist
    type:
      - 'null'
      - File
    doc: List of reference sequences.
    inputBinding:
      position: 101
      prefix: --reflist
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output files.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msweep:2.2.1--h503566f_1
