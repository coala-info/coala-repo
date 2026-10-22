cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracknado
  - merge
label: tracknado_merge
doc: "Merge multiple TrackNado hubs into one. This command combines the track definitions
  from several sidecar configuration files into a single unified UCSC Track Hub.\n\nTool
  homepage: https://pypi.org/project/tracknado/"
inputs:
  - id: input_configs
    type:
      type: array
      items: File
    doc: A list of 'tracknado_config.json' files from previously generated hubs.
    inputBinding:
      position: 10
  - id: output_path
    type: string
    doc: The directory where the new merged hub will be staged.
    inputBinding:
      position: 1
      prefix: --output
  - id: hub_name
    type:
      - 'null'
      - string
    doc: The name for the combined hub (default MERGED_HUB).
    inputBinding:
      position: 2
      prefix: --hub-name
  - id: genome_name
    type:
      - 'null'
      - string
    doc: The genome assembly for the combined hub (default hg38).
    inputBinding:
      position: 3
      prefix: --genome-name
  - id: hub_email
    type:
      - 'null'
      - string
    doc: Contact email for the merged hub.
    inputBinding:
      position: 4
      prefix: --hub-email
outputs:
  - id: output
    type: Directory
    doc: The directory with the merged hub.
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
stdout: tracknado_merge.out
