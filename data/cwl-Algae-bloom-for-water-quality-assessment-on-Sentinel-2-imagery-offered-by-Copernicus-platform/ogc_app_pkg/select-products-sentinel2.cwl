#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: select-products-sentinel2
label: Searches the specified catalog for Sentinel-2 products matching filtering criteria.
doc: |
  Searches a catalog for Sentinel-2 products using filtering parameters and returns all matched locations.
  Returned matches will be either S3 or direct HTTPS references depending on the catalog.

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
  - search

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/select-products-sentinel2:1.1.0
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true  # allow requesting the collection

inputs:
  date:
    label: Central date
    doc: Date around which ±delta-days will be applied for search. If omitted, 'toi' input must be provided instead.
    type: string?
    inputBinding:
      prefix: --date
  delta:
    type: int?
    inputBinding:
      prefix: --delta
  toi:
    label: Time of interest
    doc: Start and end date-time strings. Must be provided if 'date' input is omitted.
    type: string[]?
    inputBinding:
      prefix: --toi
  aoi:
    type: File
    label: Area of interest
    doc: Polygon defining the area of interest.
    format: "iana:application/geo+json"
    inputBinding:
      prefix: --aoi
  collection:
    type: string
    inputBinding:
      prefix: --collection
  product_level:
    type:
      - 'null'
      - type: enum
        symbols:
          - L1C
          - L2A
    inputBinding:
      prefix: --product-level
  catalog:
    type:
      type: enum
      symbols: ["copernicus", "earth-search"]
    inputBinding:
      prefix: --catalog
  cloud_cover:
    type: double?
    inputBinding:
      prefix: --cloud-cover

outputs:
  urls:
    type: string[]
    outputBinding:
      # trick to collect stdout as JSON, requires that the tool does a 'json.dumps()' of the string[]
      # https://www.biostars.org/p/282785/
      glob: collection-urls.json
      loadContents: true
      outputEval: "${ return JSON.parse(self[0].contents); }"

stdout: collection-urls.json

$namespaces:
  s: "https://schema.org/"
  iana: "https://www.iana.org/assignments/media-types/"
