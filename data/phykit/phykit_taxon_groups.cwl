cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - taxon_groups
label: phykit_taxon_groups
doc: Determine which tree or FASTA files share the same set of taxa. Reads a 
  file listing paths to gene trees or alignments and groups them by their taxon 
  set (exact match). Reports groups sorted by size (largest first), with the 
  taxa present in each group.
inputs:
  - id: list
    type: File
    doc: 'file listing paths to gene trees or FASTA files (one per line). Blank lines
      and lines starting with # are skipped.'
    inputBinding:
      position: 101
      prefix: --list
  - id: format
    type:
      - 'null'
      - string
    doc: 'input format: trees (Newick) or fasta (FASTA alignment).'
    inputBinding:
      position: 101
      prefix: --format
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_taxon_groups.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
