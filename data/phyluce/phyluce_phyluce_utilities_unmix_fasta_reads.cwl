cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_utilities_unmix_fasta_reads
label: phyluce_phyluce_utilities_unmix_fasta_reads
doc: "Turn a mixed file of fasta reads into R1, R2, and singleton reads\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: mixed_reads
    type: File
    doc: "The file containing mixed fasta reads with /1 and /2 designators for reads."
    inputBinding:
      position: 1
      prefix: --mixed-reads
  - id: singleton_reads
    type:
      - 'null'
      - File
    doc: "The file containing singleton fasta reads."
    inputBinding:
      position: 1
      prefix: --singleton-reads
  - id: out_r1
    type: string
    doc: "The output fasta for R1."
    inputBinding:
      position: 1
      prefix: --out-r1
  - id: out_r2
    type: string
    doc: "The output fasta for R2."
    inputBinding:
      position: 1
      prefix: --out-r2
  - id: out_r_singleton
    type: string
    doc: "The output fasta for singleton reads (RS)."
    inputBinding:
      position: 1
      prefix: --out-r-singleton
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use (INFO, WARN or CRITICAL)."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory must already exist."
    inputBinding:
      position: 1
      prefix: --log-path
  - id: new_style
    type:
      - 'null'
      - boolean
    doc: "The reads use new-style Illumina headers (the tool needs this option to run to the end)."
    inputBinding:
      position: 1
      prefix: --new-style
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: r1
    type: File
    doc: "The R1 fasta"
    outputBinding:
      glob: $(inputs.out_r1)
  - id: r2
    type: File
    doc: "The R2 fasta"
    outputBinding:
      glob: $(inputs.out_r2)
  - id: r_singleton
    type: File
    doc: "The singleton fasta"
    outputBinding:
      glob: $(inputs.out_r_singleton)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_utilities_unmix_fasta_reads.out
