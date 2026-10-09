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
    doc: Descent (inheritance flow) file written by the linkage program, e.g. merlin.flow
    inputBinding:
      position: 104
      prefix: -d
  - id: haplofile
    type:
      - 'null'
      - File
    doc: Haplotype file written by the linkage program, e.g. merlin.chr
    inputBinding:
      position: 104
      prefix: -h
  - id: lodfile
    type:
      - 'null'
      - File
    doc: LOD score file or output of the linkage program, e.g. the Merlin parametric analysis output
    inputBinding:
      position: 104
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: descentfile_out
    type:
      - 'null'
      - File
    doc: Allegro descent file (linkage.allegro_descent)
    outputBinding:
      glob: linkage.allegro_descent
  - id: haplofile_out
    type:
      - 'null'
      - File
    doc: Allegro haplotype file (linkage.allegro_haplo)
    outputBinding:
      glob: linkage.allegro_haplo
  - id: lodfile_out
    type:
      - 'null'
      - File
    doc: Allegro LOD file (linkage.allegro_lod)
    outputBinding:
      glob: linkage.allegro_lod
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkage2allegro:2017.3--py35_0
stdout: linkage2allegro.out
