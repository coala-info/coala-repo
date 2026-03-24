#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: download-band-sentinel2-stac-item
label: Downloads Sentinel-2 GeoTiff from STAC Item.
doc: |
  Downloads the GeoTiff band from the Sentinel-2 product STAC Item
  using the requested band selection criteria. It is assumed that
  the referenced STAC Item contains the desired GeoTiff Asset with
  the 'common band name' associated to the band 
  (see https://github.com/stac-extensions/eo#common-band-names).

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

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/download-band-sentinel2-stac-item:1.1.0
  NetworkAccess:
    networkAccess: true  # allow download of resolved bands

inputs:
  product_url:
    type: string
    label: HTTPS URL to a Sentinel-2 product in STAC Item format.
    inputBinding:
      prefix: --stac-item-url
  band:
    type:
      type: enum
      symbols:
        - "B01"
        - "B02"
        - "B03"
        - "B04"
        - "B05"
        - "B06"
        - "B07"
        - "B08"
        - "B8A"
        - "B09"
        - "B11"
        - "B12"
        - "AOT"
        - "SCL"
        - "TCI"
        - "WVP"
    inputBinding:
      prefix: --band

outputs:
  product:
    type: File
    format: "ogc:geotiff"
    outputBinding:
      glob: "*.tif"

$namespaces:
  s: "https://schema.org/"
  ogc: "http://www.opengis.net/def/media-type/ogc/1.0/"
