cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfaffix
label: gfaffix
doc: "Discover and collapse walk-preserving shared affixes of a given variation graph.\n\
  \nTool homepage: https://github.com/marschall-lab/GFAffix"
inputs:
  - id: graph
    type: File
    doc: graph in GFA1 format, supports compressed (.gz) input
    inputBinding:
      position: 1
  - id: check_transformation
    type:
      - 'null'
      - boolean
    doc: Verifies that the transformed parts of the graphs spell out the 
      identical sequence as in the original graph
    inputBinding:
      position: 102
      prefix: --check_transformation
  - id: dont_collapse
    type:
      - 'null'
      - string
    doc: Do not collapse nodes on a given paths/walks ("P"/"W" lines) that match
      given regular expression
    inputBinding:
      position: 102
      prefix: --dont_collapse
  - id: threads
    type:
      - 'null'
      - int
    doc: Run in parallel on N threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Sets log level to debug
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_refined
    type:
      - 'null'
      - File
    doc: Write refined graph output (GFA1 format) to supplied file instead of 
      stdout; if file name ends with .gz, output will be compressed
    outputBinding:
      glob: $(inputs.output_refined)
  - id: output_transformation
    type:
      - 'null'
      - File
    doc: Report original nodes and their corresponding walks in refined graph to
      supplied file
    outputBinding:
      glob: $(inputs.output_transformation)
  - id: output_affixes
    type:
      - 'null'
      - File
    doc: Report identified affixes
    outputBinding:
      glob: $(inputs.output_affixes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfaffix:0.2.1--hc1c3326_0
