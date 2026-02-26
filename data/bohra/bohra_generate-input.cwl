cwlVersion: v1.2
class: CommandLineTool
baseCommand: bohra_generate-input
label: bohra_generate-input
doc: "Generare input files for the Bohra pipeline.\n\nTool homepage: https://github.com/kristyhoran/bohra"
inputs:
  - id: contigs
    type:
      - 'null'
      - string
    doc: Path to search for assembly files, e.g. *.f*a.gz
    inputBinding:
      position: 101
      prefix: --contigs
  - id: isolate_ids
    type:
      - 'null'
      - string
    doc: Path to a file containing at least one column 'Isolate' with isolate 
      names. Optionally add 'species' and other columns you wish to use for 
      further annotation of trees.
    inputBinding:
      position: 101
      prefix: --isolate_ids
  - id: outname
    type:
      - 'null'
      - string
    doc: Name of the file to write the generated input table to.
    inputBinding:
      position: 101
      prefix: --outname
  - id: reads
    type:
      - 'null'
      - string
    doc: Path to search for reads files, e.g. *.f*q.gz
    inputBinding:
      position: 101
      prefix: --reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
stdout: bohra_generate-input.out
