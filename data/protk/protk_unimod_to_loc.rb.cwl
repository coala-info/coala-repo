cwlVersion: v1.2
class: CommandLineTool
baseCommand: unimod_to_loc.rb
label: protk_unimod_to_loc.rb
doc: 'Reads a unimod xml file (eg from a Mascot installation) and produces a loc file with names of allowable
  chemical modifications.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: unimod_file
    type: File
    doc: Unimod xml file
    inputBinding:
      position: 1
outputs:
  - id: mods_loc
    type:
      - 'null'
      - File
    doc: Loc file of chemical modification names (mascot_mods.loc)
    outputBinding:
      glob: mascot_mods.loc
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
