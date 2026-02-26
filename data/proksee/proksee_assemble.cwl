cwlVersion: v1.2
class: CommandLineTool
baseCommand: proksee assemble
label: proksee_assemble
doc: "Assemble reads into a genome.\n\nTool homepage: https://github.com/proksee-project/proksee-cmd"
inputs:
  - id: forward_reads
    type: File
    doc: Forward reads file
    inputBinding:
      position: 1
  - id: reverse_reads
    type:
      - 'null'
      - File
    doc: Reverse reads file
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: This will force the assembler to proceed when the assembly appears to 
      be poor.
    inputBinding:
      position: 103
      prefix: --force
  - id: platform
    type:
      - 'null'
      - string
    doc: The sequencing platform used to generate the reads. 'Illumina', 'Ion 
      Torrent', or 'Pac Bio'.
    inputBinding:
      position: 103
      prefix: --platform
  - id: species
    type:
      - 'null'
      - string
    doc: The species to assemble. This will override species estimation. Must be
      spelled correctly.
    inputBinding:
      position: 103
      prefix: --species
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
