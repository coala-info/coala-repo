#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: calculate-band
label: Performs a calculation with bands.
doc: Performs a calculation over JPEG bands and returns the resulting GeoTiff.

s:softwareVersion: "1.1.0"

s:author:
  - class: s:Person
    s:identifier: "http://orcid.org/0000-0003-4862-3349"
    s:email: francis.charette-migneault@crim.ca
    s:name: Francis Charette-Migneault

s:keywords:
  - Sentinel-2
  - OSPD
  - demo
  - calculation

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/calculate-band:1.1.0

baseCommand: []
arguments: ["--co", "TILED=YES", "--overwrite", "--type", "Float32"]

inputs:
  name:
    label: Output file name
    doc: Name to apply for the output GeoTiff file.
    type: string
    inputBinding:
      valueFrom: "${ return self + '.tiff'; }"
      prefix: --outfile
  calc:
    label: Calculation
    doc: Calculation to perform with band references.
    type: string
    inputBinding:
      prefix: --calc
  band_a:
    type: File?
    inputBinding:
      prefix: -A
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_b:
    type: File?
    inputBinding:
      prefix: -B
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_c:
    type: File?
    inputBinding:
      prefix: -C
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_d:
    type: File?
    inputBinding:
      prefix: -D
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_e:
    type: File?
    inputBinding:
      prefix: -E
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_f:
    type: File?
    inputBinding:
      prefix: -F
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_g:
    type: File?
    inputBinding:
      prefix: -G
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_h:
    type: File?
    inputBinding:
      prefix: -H
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_i:
    type: File?
    inputBinding:
      prefix: -I
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_j:
    type: File?
    inputBinding:
      prefix: -J
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_k:
    type: File?
    inputBinding:
      prefix: -K
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_l:
    type: File?
    inputBinding:
      prefix: -L
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_m:
    type: File?
    inputBinding:
      prefix: -M
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_n:
    type: File?
    inputBinding:
      prefix: -N
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_o:
    type: File?
    inputBinding:
      prefix: -O
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_p:
    type: File?
    inputBinding:
      prefix: -P
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_q:
    type: File?
    inputBinding:
      prefix: -Q
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_r:
    type: File?
    inputBinding:
      prefix: -R
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_s:
    type: File?
    inputBinding:
      prefix: -S
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_t:
    type: File?
    inputBinding:
      prefix: -T
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_u:
    type: File?
    inputBinding:
      prefix: -U
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_v:
    type: File?
    inputBinding:
      prefix: -V
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_w:
    type: File?
    inputBinding:
      prefix: -W
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_x:
    type: File?
    inputBinding:
      prefix: -X
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_y:
    type: File?
    inputBinding:
      prefix: -Y
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"
  band_z:
    type: File?
    inputBinding:
      prefix: -Z
    format:
      - "ogc:geotiff"
      - "iana:image/tiff"
      - "iana:image/jp2"

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
