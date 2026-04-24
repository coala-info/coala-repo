cwlVersion: v1.2
class: CommandLineTool
baseCommand: intersect_assembly_errors
label: pomoxis_intersect_assembly_errors
doc: "Assess errors which occur in the same reference position accross multiple assemblies.\n\
  \nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: fasta_input_assemblies
    type: File
    doc: fasta input assemblies
    inputBinding:
      position: 101
      prefix: -i
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reference
    type: File
    doc: "reference, should be a fasta file. If correspondng bwa indices\ndo not exist
      they will be created."
    inputBinding:
      position: 101
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: alignment threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_intersect_assembly_errors.out
