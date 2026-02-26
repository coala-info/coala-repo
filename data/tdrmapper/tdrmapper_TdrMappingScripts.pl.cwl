cwlVersion: v1.2
class: CommandLineTool
baseCommand: TdrMappingScripts.pl
label: tdrmapper_TdrMappingScripts.pl
doc: "Map tRNA sequences to a reference tRNA database.\n\nTool homepage: https://github.com/sararselitsky/tDRmapper"
inputs:
  - id: reference_trna
    type: File
    doc: Reference tRNA FASTA file
    inputBinding:
      position: 1
  - id: sample_fa
    type: File
    doc: Sample FASTA file containing tRNA sequences to map
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tdrmapper:1.1--pl526_3
stdout: tdrmapper_TdrMappingScripts.pl.out
