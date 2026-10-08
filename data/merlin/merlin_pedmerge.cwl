cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pedmerge
label: merlin_pedmerge
doc: "PedMerge: merge a set of paired pedigree (.ped) and data (.dat) files into a single composite pedigree.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: input_files
    type:
      - type: array
        items: File
    doc: "Data (.dat) and pedigree (.ped) files of every input set; staged in the working directory so the prefixes below resolve"
  - id: input_prefixes
    type:
      - type: array
        items: string
    doc: "File name prefixes (without .dat/.ped) of the input sets to merge"
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: "File name prefix of the merged output (.dat and .ped)"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: merged_data
    type: File
    doc: "Merged data file"
    outputBinding:
      glob: "$(inputs.output_prefix).dat"
  - id: merged_pedigree
    type: File
    doc: "Merged pedigree file"
    outputBinding:
      glob: "$(inputs.output_prefix).ped"
  - id: merged_map
    type:
      - 'null'
      - File
    doc: "Merged map file (when markers have map information)"
    outputBinding:
      glob: "$(inputs.output_prefix).map"
  - id: merged_freq
    type:
      - 'null'
      - File
    doc: "Merged frequency file (when markers have map information)"
    outputBinding:
      glob: "$(inputs.output_prefix).freq"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_pedmerge.out
