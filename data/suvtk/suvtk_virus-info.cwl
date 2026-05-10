cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suvtk
  - virus-info
label: suvtk_virus-info
doc: "This command provides info on potentially segmented viruses based on the taxonomy
  and also outputs a file with the genome type and genome structure for the MIUVIG
  structured comment.\n\nTool homepage: https://github.com/LanderDC/suvtk"
inputs:
  - id: database
    type: File
    doc: The suvtk database path.
    inputBinding:
      position: 101
      prefix: --database
  - id: taxonomy
    type: File
    doc: Taxonomy file.
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
