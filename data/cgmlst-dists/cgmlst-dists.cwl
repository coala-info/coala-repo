cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgmlst-dists
label: cgmlst-dists
doc: "Pairwise CG-MLST distance matrix from allele call tables\n\nTool homepage: https://github.com/tseemann/cgmlst-dists"
inputs:
  - id: input_allele_table
    type: File
    doc: Allele call table (e.g., chewbbaca.tab)
    inputBinding:
      position: 1
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Stop calculating beyond this distance
    inputBinding:
      position: 102
      prefix: -x
  - id: output_mode
    type:
      - 'null'
      - int
    doc: 'Output: 1=lower-tri 2=upper-tri 3=full'
    inputBinding:
      position: 102
      prefix: -m
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode; do not print progress information
    inputBinding:
      position: 102
      prefix: -q
  - id: use_comma
    type:
      - 'null'
      - boolean
    doc: Use comma instead of tab in output
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgmlst-dists:0.4.0--h7b50bb2_5
stdout: cgmlst-dists.out
