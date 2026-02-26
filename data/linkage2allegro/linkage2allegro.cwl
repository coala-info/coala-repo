cwlVersion: v1.2
class: CommandLineTool
baseCommand: linkage2allegro
label: linkage2allegro
doc: "Converts linkage format files to other formats.\n\nTool homepage: https://github.com/BioTools-Tek/linkage-converter"
inputs:
  - id: pedin
    type: File
    doc: Input pedigree file (.ped)
    inputBinding:
      position: 1
  - id: mapin
    type: File
    doc: Input map file (.map)
    inputBinding:
      position: 2
  - id: program
    type: string
    doc: Target program (genehunter, merlin, simwalk, swiftlink)
    inputBinding:
      position: 3
  - id: descentfile
    type:
      - 'null'
      - File
    doc: Output descent file
    inputBinding:
      position: 104
      prefix: -d
  - id: haplofile
    type:
      - 'null'
      - File
    doc: Output haplotype file
    inputBinding:
      position: 104
      prefix: -h
  - id: lodfile
    type:
      - 'null'
      - File
    doc: Output LOD file
    inputBinding:
      position: 104
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkage2allegro:2017.3--py35_0
stdout: linkage2allegro.out
