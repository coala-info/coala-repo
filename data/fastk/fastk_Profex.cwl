cwlVersion: v1.2
class: CommandLineTool
baseCommand: Profex
label: fastk_Profex
doc: "Shows the k-mer count profiles of reads from a profile made by FastK.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
arguments:
  - position: 100
    valueFrom: $(inputs.profile.basename)
inputs:
  - id: profile
    type: File
    doc: Profile stub file (.prof) made by FastK.
  - id: profile_parts
    type: File[]
    doc: 'Hidden profile part files (.<name>.prof.N and .<name>.pidx.N) made by FastK.'
  - id: reads
    type:
      - 'null'
      - string[]
    doc: 'Reads to show: <read:int>[-(<read:int>|#)].'
    inputBinding:
      position: 101
  - id: one_code
    type:
      - 'null'
      - boolean
    doc: Produce 1-code as output.
    inputBinding:
      position: 50
      prefix: '-1'
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Tab-delimited ASCII as output.
    inputBinding:
      position: 50
      prefix: '-A'
  - id: compress_runs
    type:
      - 'null'
      - boolean
    doc: Compress runs and ignore zeros.
    inputBinding:
      position: 50
      prefix: '-z'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.profile)
      - $(inputs.profile_parts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Profex.out
