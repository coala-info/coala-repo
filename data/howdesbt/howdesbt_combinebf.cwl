cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - combinebf
label: howdesbt_combinebf
doc: "combine several bloom filters into a single file\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: filters
    type:
      type: array
      items: File
    doc: "bloom filter files (usually .bf); one file is created, containing these bloom filters"
    inputBinding:
      position: 101
  - id: out
    type: string
    doc: "name for the combined bloom filter file (by default this is derived from first filter filename)"
    inputBinding:
      position: 102
      prefix: "--out="
      separate: false
  - id: noouttree
    type:
      - 'null'
      - boolean
    doc: "don't write the resulting topology file"
    inputBinding:
      position: 103
      prefix: "--noouttree"
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: "report the files we'd combine, but don't do it"
    inputBinding:
      position: 104
      prefix: "--dryrun"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "don't report what files we're combining"
    inputBinding:
      position: 105
      prefix: "--quiet"
outputs:
  - id: combined_filter
    type: File
    doc: "combined bloom filter file"
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_combinebf.out
