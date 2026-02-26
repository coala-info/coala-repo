cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch splitperco
label: msstitch_splitperco
doc: "Split peptides based on protein headers.\n\nTool homepage: https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: protheaders
    type:
      type: array
      items: string
    doc: Specify protein FASTA headers to split on. Multiple headers of the same
      split-type can be grouped with semicolons. E.g. --protheaders 'ENSP;sp 
      PSEUDOGEN;ncRNA' would split into ENSP/swissprot peptides and 
      pseudogenes/non-coding RNA peptides.
    inputBinding:
      position: 101
      prefix: --protheaders
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
