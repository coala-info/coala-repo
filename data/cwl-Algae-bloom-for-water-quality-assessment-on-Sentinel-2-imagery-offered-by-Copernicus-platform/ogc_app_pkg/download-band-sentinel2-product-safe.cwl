#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: CommandLineTool

id: download-band-sentinel2-product-safe
label: Downloads Copernicus products.
doc: Downloads the Copernicus product from S3 using the Sentinel-2 SAFE manifest.

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
  InlineJavascriptRequirement: {}
  DockerRequirement:
    # NOTE:
    #   assume the locally built dockers for demo
    #   for deployment to a server, they should be pushed and tagged to an appropriate container registry
    #   the following reference would then point at this corresponding container registry image
    dockerPull: ogc-ospd/algae-usecase/download-band-sentinel2-product-safe:1.1.0
  NetworkAccess:
    networkAccess: true  # allow download of resolved bands

hints:
  cwltool:Secrets:
    secrets:
      - s3_access_key
      - s3_secret_key

inputs:
  product_url:
    type: string
    label: S3 URL to a Sentinel-2 product in SAFE format.
    inputBinding:
      prefix: --s3-product-url
  s3_access_key:
    label: S3 access key required to retrieve products hosted on a protected S3 location.
    doc: |
      Access key to Copernicus data provider.
      See https://documentation.dataspace.copernicus.eu/Registration.html 
      and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.
    type: string
    inputBinding:
      prefix: --s3-access-key
  s3_secret_key:
    label: S3 secret key required to retrieve products hosted on a protected S3 location.
    doc: |
      Secret key to Copernicus data provider.
      See https://documentation.dataspace.copernicus.eu/Registration.html 
      and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.
    type: string
    inputBinding:
      prefix: --s3-secret-key
  resolution:
    type:
      - "null"
      - type: enum
        symbols: ["10m", "20m", "60m"]
    inputBinding:
      prefix: --resolution
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
  debug:
    # use with 'cwltool --leave-tmp-dir' to inspect temp file contents
    type: boolean?
    default: false
    inputBinding:
      prefix: -d

outputs:
  product:
    type: File
    format: "iana:image/jp2"
    outputBinding:
      glob: "*.jp2"

$namespaces:
  s: "https://schema.org/"
  cwltool: "http://commonwl.org/cwltool#"
  iana: "https://www.iana.org/assignments/media-types/"
