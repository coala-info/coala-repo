cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coverage_from_fastx
label: pomoxis_coverage_from_fastx
doc: "Estimate coverage from summed basecall and reference lengths.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: basecalls
    type: File
    doc: Input fastx file.
    inputBinding:
      position: 1
  - id: ref_len
    type:
      - string
      - File
    doc: Reference length (for example 4.8kb, mb or gb) or a reference fastx file from which the length is calculated.
    inputBinding:
      position: 2
  - id: coverage
    type:
      - 'null'
      - float
    doc: Calculate the fraction of reads required for this coverage.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Use the longest reads when calculating the fraction of reads required for a given coverage.
    inputBinding:
      position: 102
      prefix: --longest
outputs:
  - id: coverage_txt
    type: stdout
    doc: Coverage estimate printed by the tool.
stdout: coverage_from_fastx.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
