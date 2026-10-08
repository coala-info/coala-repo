cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pedwipe
label: merlin_pedwipe
doc: "PedWipe: automatically wipe out genotypes listed in a MERLIN error file from a pedigree file.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: data_file
    type: File
    doc: "Data file (-d)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file
    type: File
    doc: "Pedigree file (-p)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: errors_file
    type:
      - 'null'
      - File
    doc: "Errors file listing family, person and marker to wipe, as written by merlin --error (-e, default merlin.err)"
    inputBinding:
      position: 1
      prefix: '-e'
  - id: show_tallies
    type:
      - 'null'
      - boolean
    doc: "Show tallies of errors per marker, family and person"
    inputBinding:
      position: 1
      prefix: '-t'
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: wiped_data
    type: File
    doc: "Data file after wiping"
    outputBinding:
      glob: "wiped.dat"
  - id: wiped_pedigree
    type: File
    doc: "Pedigree file with the listed genotypes removed"
    outputBinding:
      glob: "wiped.ped"
  - id: wiped_map
    type:
      - 'null'
      - File
    doc: "Map file (written when marker information is present)"
    outputBinding:
      glob: "wiped.map"
  - id: wiped_freq
    type:
      - 'null'
      - File
    doc: "Frequency file (written when marker information is present)"
    outputBinding:
      glob: "wiped.freq"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_pedwipe.out
