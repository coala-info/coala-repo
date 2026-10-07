cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - JoinProfiles
label: chewbbaca_JoinProfiles
doc: "Join allele calling results from different runs.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: profiles
    type:
      type: array
      items: File
    doc: "Paths to the files containing allelic profiles determined by the AlleleCall module."
    inputBinding:
      position: 1
      prefix: --profiles
  - id: output_file
    type: string
    doc: "Path to the output file."
    default: "joined_profiles.tsv"
    inputBinding:
      position: 1
      prefix: --output-file
  - id: common
    type:
      - 'null'
      - boolean
    doc: "Merge the results based on the subset of loci shared between all files."
    inputBinding:
      position: 1
      prefix: --common
outputs:
  - id: output
    type: File
    doc: "Joined allelic profiles."
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0
