cwlVersion: v1.2
class: CommandLineTool
baseCommand: visualize_instance
label: mimsi_visualize_instance
doc: "MiMSI Site Visualization Utility. Draws tumor/normal read vectors of selected\
  \ microsatellite sites to a PDF file.\n\nTool homepage: https://github.com/mskcc/mimsi"
inputs:
  - id: vector
    type: File
    doc: Vector .npy for the case you'd like to visualize
    inputBinding:
      position: 101
      prefix: --vector
  - id: locations
    type: File
    doc: Locations .npy for the case you'd like to visualize
    inputBinding:
      position: 101
      prefix: --locations
  - id: site
    type:
      - 'null'
      - string
    doc: Site to visualize (chrom,start,end), must be present in locations file for
      the image to generate properly
    inputBinding:
      position: 101
      prefix: --site
  - id: site_list
    type:
      - 'null'
      - File
    doc: File indicating the site(s) to visualize
    inputBinding:
      position: 101
      prefix: --site-list
  - id: coverage
    type:
      - 'null'
      - int
    doc: Required coverage for both the tumor and the normal. Any coverage in excess
      of this limit will be randomly downsampled (default 100)
    inputBinding:
      position: 101
      prefix: --coverage
  - id: output
    type: string
    doc: Name of the output filename (the tool appends .pdf)
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: figure
    type: File
    doc: PDF figure
    outputBinding:
      glob: $(inputs.output).pdf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
