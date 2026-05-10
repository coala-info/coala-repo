cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - fasta-qc
label: virprof_fasta-qc
doc: "Calculates contig QC values\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: entropy_k_sizes
    type:
      - 'null'
      - string
    doc: Lengths of k-mers to use for entropy calculation. Comma separated
    inputBinding:
      position: 101
      prefix: --ek
  - id: homopolymer_min_size
    type:
      - 'null'
      - int
    doc: Minimum length for a repeat to be considered long homopolymer.Set to 0 
      to disable.
    inputBinding:
      position: 101
      prefix: --hmin
  - id: in_fasta
    type: File
    doc: FASTA file containing contigs
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: out_csv_path
    type: string
    doc: Output or path parameter `out_csv_path`
    inputBinding:
      position: 102
      prefix: --out-csv
outputs:
  - id: out_csv
    type: File
    doc: Output CSV file for scores
    outputBinding:
      glob: $(inputs.out_csv_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
