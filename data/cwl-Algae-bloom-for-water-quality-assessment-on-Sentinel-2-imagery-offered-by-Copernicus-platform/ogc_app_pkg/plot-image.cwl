#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: plot-image
label: Plots an image with colors.
doc: Applies the specified color mapping with scaled bins to a geospatial image.

s:softwareVersion: "1.0.0"

s:author:
  - class: s:Person
    s:identifier: "http://orcid.org/0000-0003-4862-3349"
    s:email: francis.charette-migneault@crim.ca
    s:name: Francis Charette-Migneault

s:keywords:
  - geospatial
  - imagery
  - rendering
  - visualization
  - OSPD
  - demo

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/plot-image:1.0.0

inputs:

  input_image:
    type: File
    doc: Image to map with the colors bins.
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
    inputBinding:
      prefix: --input-image

  color_scale:
    label: Color mappings to bin scales to apply to the image.
    doc: |
      JSON-like array with each item being an array of 2 elements, 
      the first for the bin scale value and the second for the RGB color.
      Each RGB value can be either a [0-1] floating point or a [0-255] integer.
      
      Example: '[ [0, [0,0,0]], [20, [0,0,255]], [50, [255,100,0]] ]'
    type: string
    inputBinding:
      prefix: --color-scale

  output_name:
    type: string?
    inputBinding:
      prefix: --output-name

  plot_name:
    type: string?
    inputBinding:
      prefix: --plot-name

  plot_title:
    type: string?
    inputBinding:
      prefix: --plot-title

  clip_min:
    doc: Clip values below this threshold for color mapping.
    type: float?
    inputBinding:
      prefix: --clip-min

  clip_max:
    doc: Clip values above this threshold for color mapping.
    type: float?
    inputBinding:
      prefix: --clip-max

outputs:

  output_file:
    type: File
    format: "ogc:geotiff"
    outputBinding:
      glob: "$(runtime.outdir)/*.tif"

  output_plot:
    type: File
    format: "iana:image/png"
    outputBinding:
      glob: "$(runtime.outdir)/*.png"

$namespaces:
  s: "https://schema.org/"
  ogc: "http://www.opengis.net/def/media-type/ogc/1.0/"
  iana: "https://www.iana.org/assignments/media-types/"
