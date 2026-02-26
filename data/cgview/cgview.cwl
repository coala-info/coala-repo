cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar cgview.jar
label: cgview
doc: "Generates graphical representations of circular genomes.\n\nTool homepage: http://wishart.biology.ualberta.ca/cgview/"
inputs:
  - id: center_base
    type:
      - 'null'
      - int
    doc: Specifies the base to center on when zooming.
    inputBinding:
      position: 101
      prefix: -c
  - id: draw_inside_labels
    type:
      - 'null'
      - boolean
    doc: Whether or not to draw labels on the inside of the backbone circle.
    inputBinding:
      position: 101
      prefix: -I
  - id: embed_vector_text
    type:
      - 'null'
      - boolean
    doc: Whether or not to embed vector-based text in SVG output.
    inputBinding:
      position: 101
      prefix: -E
  - id: exclude_svg_from_series
    type:
      - 'null'
      - boolean
    doc: Whether or not to exclude SVG output from image series.
    inputBinding:
      position: 101
      prefix: -e
  - id: external_legend_width
    type:
      - 'null'
      - int
    doc: The width of an external legend.
    inputBinding:
      position: 101
      prefix: -L
  - id: html_image_path
    type:
      - 'null'
      - string
    doc: The path to the image file in the HTML file created using the -h 
      option.
    inputBinding:
      position: 101
      prefix: -p
  - id: image_series_directory
    type:
      - 'null'
      - Directory
    doc: Directory to receive an image series.
    inputBinding:
      position: 101
      prefix: -s
  - id: input_file
    type: File
    doc: The input file to parse.
    inputBinding:
      position: 101
      prefix: -i
  - id: label_font_size
    type:
      - 'null'
      - int
    doc: Specifies a label font size.
    inputBinding:
      position: 101
      prefix: -A
  - id: legend_font_size
    type:
      - 'null'
      - int
    doc: Specifies a legend font size.
    inputBinding:
      position: 101
      prefix: -D
  - id: map_height
    type:
      - 'null'
      - int
    doc: The height of the map.
    inputBinding:
      position: 101
      prefix: -H
  - id: map_width
    type:
      - 'null'
      - int
    doc: The width of the map.
    inputBinding:
      position: 101
      prefix: -W
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'The format of the output: PNG, JPG, SVG, or SVGZ.'
    inputBinding:
      position: 101
      prefix: -f
  - id: reference_overlib_js
    type:
      - 'null'
      - boolean
    doc: Whether or not to reference overlib.js in HTML output.
    inputBinding:
      position: 101
      prefix: -u
  - id: reference_stylesheet
    type:
      - 'null'
      - boolean
    doc: Whether or not to reference external stylesheet in HTML output.
    inputBinding:
      position: 101
      prefix: -S
  - id: remove_labels
    type:
      - 'null'
      - boolean
    doc: Whether or not to remove labels.
    inputBinding:
      position: 101
      prefix: -R
  - id: remove_legends
    type:
      - 'null'
      - boolean
    doc: Whether or not to remove legends.
    inputBinding:
      position: 101
      prefix: -r
  - id: ruler_font_size
    type:
      - 'null'
      - int
    doc: Specifies a sequence ruler font size.
    inputBinding:
      position: 101
      prefix: -U
  - id: tick_density
    type:
      - 'null'
      - float
    doc: Specifies tick density, between 0 and 1.0.
    default: 1.0
    inputBinding:
      position: 101
      prefix: -d
  - id: zoom_factor
    type:
      - 'null'
      - float
    doc: The factor to zoom in by.
    inputBinding:
      position: 101
      prefix: -z
  - id: zoom_values
    type:
      - 'null'
      - string
    doc: Comma separated zoom values for image series.
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: html_file
    type:
      - 'null'
      - File
    doc: HTML file to create.
    outputBinding:
      glob: $(inputs.html_file)
  - id: output_image_file
    type:
      - 'null'
      - File
    doc: The image file to create.
    outputBinding:
      glob: $(inputs.output_image_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgview:1.0--py35pl5.22.0_1
