cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - gc_content
label: phykit_gc_content
doc: Calculate GC content of a fasta file. GC content is negatively correlated 
  with phylogenetic signal. If there are multiple entries, use the -v/--verbose 
  option to determine the GC content of each fasta entry separately.
inputs:
  - id: fasta
    type: File
    doc: first argument after function name should be a fasta file
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
stdout: phykit_gc_content.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
