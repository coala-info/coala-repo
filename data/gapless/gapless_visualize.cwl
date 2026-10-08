cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gapless.py
  - visualize
label: gapless_visualize
doc: "Visualizes specified regions to manually inspect breaks or joins.\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: mapping
    type: File
    doc: "Mapping of the long reads to the assembly ({mapping}.paf)"
    inputBinding:
      position: 2
  - id: regions
    type:
      type: array
      items: string
    doc: "Regions to visualize in the form {scaffold}:{start}-{end}"
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "Output file for visualization (mandatory)"
    inputBinding:
      position: 1
      prefix: --output
  - id: keep_all_subreads
    type:
      - 'null'
      - boolean
    doc: "Shows all subreads instead of only the best"
    inputBinding:
      position: 1
      prefix: --keepAllSubreads
  - id: min_len_break
    type:
      - 'null'
      - int
    doc: "Minimum length for a read to diverge from a contig to consider a contig break (600)"
    inputBinding:
      position: 1
      prefix: --minLenBreak
  - id: min_map_length
    type:
      - 'null'
      - int
    doc: "Minimum length of individual mappings of reads (400)"
    inputBinding:
      position: 1
      prefix: --minMapLength
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality of reads (20)"
    inputBinding:
      position: 1
      prefix: --minMapQ
outputs:
  - id: visualization
    type: File
    doc: PDF with the visualization of the regions
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
