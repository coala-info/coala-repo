cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportRDPComparison
label: krona_ktImportRDPComparison
doc: "Creates a Krona chart from an RDP library comparison.\n\nTool homepage: https://github.com/marbl/Krona"
inputs:
  - id: rdp_comparison
    type: File
    doc: RDP comparison result downloaded as text.
    inputBinding:
      position: 1
  - id: library_names
    type:
      - 'null'
      - type: array
        items: string
    doc: A name for each library to appear in the chart (two names). The default
      is "Library [1/2]".
    inputBinding:
      position: 2
  - id: bad_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "bad" scores.
    inputBinding:
      position: 102
      prefix: -x
  - id: good_score_hue
    type:
      - 'null'
      - int
    doc: Hue (0-360) for "good" scores.
    inputBinding:
      position: 102
      prefix: -y
  - id: highest_level_name
    type:
      - 'null'
      - string
    doc: Name of the highest level.
    inputBinding:
      position: 102
      prefix: -n
  - id: max_wedge_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of wedges to include in the chart.
    inputBinding:
      position: 102
      prefix: -d
  - id: krona_resources_url
    type:
      - 'null'
      - string
    doc: URL of Krona resources to use instead of bundling them with the chart (e.g. "http://krona.sourceforge.net"). Reduces size of charts and allows updates, though charts will not work without access to this URL.
    inputBinding:
      position: 102
      prefix: -u
  - id: output_file_path
    type: string
    default: rdp.comp.krona.html
    doc: Output file name
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
