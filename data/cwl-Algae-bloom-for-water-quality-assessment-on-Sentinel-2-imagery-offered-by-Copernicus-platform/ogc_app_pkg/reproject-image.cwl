#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: reproject-image
label: Performs image reprojection.
doc: Performs a reprojection over image bands and returns the resulting GeoTiff.

s:softwareVersion: "1.0.0"

s:author:
  - class: s:Person
    s:identifier: "http://orcid.org/0000-0003-4862-3349"
    s:email: francis.charette-migneault@crim.ca
    s:name: Francis Charette-Migneault

s:keywords:
  - OSPD
  - demo
  - reprojection

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/reproject-image

baseCommand: ["gdalwarp"]
arguments: ["-ot", "Float32", "-of", "GTiff"]

inputs:
  input_image:
    type: File
    inputBinding:
      position: 1
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"

  output_dimensions:
    doc: Output dimensions for (width, height) of the output image.
    type: int[]?
    inputBinding:
      prefix: -ts

  output_resolution:
    doc: Output resolution for (width, height) of the output image.
    type: int[]?
    inputBinding:
      prefix: -tr

  output_name:
    label: Output file name
    doc: Name to apply for the output GeoTiff file.
    type: string
    inputBinding:
      valueFrom: "${ return self + '.tiff'; }"
      position: 2

outputs:
  result:
    type: File
    format: "ogc:geotiff"
    outputBinding:
      glob: "*.tiff"

$namespaces:
  s: "https://schema.org/"
  iana: "https://www.iana.org/assignments/media-types/"
  ogc: "http://www.opengis.net/def/media-type/ogc/1.0/"
