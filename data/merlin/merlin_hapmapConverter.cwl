cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hapmapConverter
label: merlin_hapmapConverter
doc: "hapmapConverter: convert genotype files downloaded from the HapMap website into MERLIN format (map, data and pedigree files).\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: template_file
    type: File
    doc: "Pedigree template file (-t)"
    inputBinding:
      position: 1
      prefix: '-t'
  - id: genotype_file
    type: File
    doc: "HapMap genotype file downloaded from the HapMap website (-g)"
    inputBinding:
      position: 1
      prefix: '-g'
  - id: map_file_name
    type:
      - 'null'
      - string
    doc: "Output map file name (-m, default mapfile)"
    inputBinding:
      position: 1
      prefix: '-m'
  - id: data_file_name
    type:
      - 'null'
      - string
    doc: "Output data file name (-d, default datfile)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file_name
    type:
      - 'null'
      - string
    doc: "Output pedigree file name (-p, default pedfile)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: use_coriell_ids
    type:
      - 'null'
      - boolean
    doc: "Use Coriell ids"
    inputBinding:
      position: 1
      prefix: '-c'
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: map_file
    type: File
    doc: "Output map file"
    outputBinding:
      glob: "$(inputs.map_file_name ? inputs.map_file_name : 'mapfile')"
  - id: data_file
    type: File
    doc: "Output data file"
    outputBinding:
      glob: "$(inputs.data_file_name ? inputs.data_file_name : 'datfile')"
  - id: pedigree_file
    type: File
    doc: "Output pedigree file"
    outputBinding:
      glob: "$(inputs.pedigree_file_name ? inputs.pedigree_file_name : 'pedfile')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_hapmapConverter.out
