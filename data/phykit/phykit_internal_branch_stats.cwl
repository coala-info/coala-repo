cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - internal_branch_stats
label: phykit_internal_branch_stats
doc: Calculate summary statistics for internal branch lengths in a phylogeny. 
  Internal branch lengths can be useful for phylogeny diagnostics. To obtain all
  internal branch lengths, use the -v/--verbose option.
inputs:
  - id: tree
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_internal_branch_stats.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
