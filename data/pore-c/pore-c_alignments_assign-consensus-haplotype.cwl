cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, assign-consensus-haplotype]
label: pore-c_alignments_assign-consensus-haplotype
doc: "Calculate a per-read consensus haplotype for each phase set in the pore-C table and write the result to a new table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Major:minor haplotype fraction must be greater than this value to assign a consensus. Default: 0.8"
    inputBinding:
      position: 1
      prefix: --threshold
  - id: pore_c_table
    type: File
    doc: "Pore-C table (parquet)"
    inputBinding:
      position: 10
  - id: output_pore_c_table
    type: string
    doc: "Output pore-C table (parquet)"
    inputBinding:
      position: 11
outputs:
  - id: output_table
    type: File
    doc: "Pore-C table with consensus haplotypes (parquet)"
    outputBinding:
      glob: "$(inputs.output_pore_c_table)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
