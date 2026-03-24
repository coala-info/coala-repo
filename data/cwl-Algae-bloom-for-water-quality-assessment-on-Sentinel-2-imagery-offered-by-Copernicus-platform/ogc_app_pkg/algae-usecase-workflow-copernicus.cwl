#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: Workflow

id: algae-usecase-workflow-copernicus
label: |
  Algae bloom for water quality assessment on Sentinel-2 imagery offered by Copernicus platform.
doc: |
  Finds Sentinel-2 products on Copernicus using filtering parameters
  and performs band calculation on retrieved Sentinel-2 products
  to evaluate algae bloom for water quality assessment.

s:softwareVersion: "2.0.0"

s:author:
  - class: s:Person
    s:identifier: "http://orcid.org/0000-0003-4862-3349"
    s:email: francis.charette-migneault@crim.ca
    s:name: Francis Charette-Migneault

s:keywords:
  - water-quality
  - algae-bloom
  - Copernicus
  - OSPD
  - demo

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}

hints:
  cwltool:Secrets:
    secrets:
      - s3_access_key
      - s3_secret_key

inputs:
  date:
    type: string
  delta:
    type: int?
    default: 4
  aoi:
    type: File
    format: "iana:application/geo+json"
  collection:
    type: string
  cloud_cover:
    type: double?
  s3_access_key:
    label: S3 access key required to retrieve products hosted on a protected S3 location.
    doc: |
      Access key to Copernicus data provider.
      See https://documentation.dataspace.copernicus.eu/Registration.html 
      and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.
    type: string
  s3_secret_key:
    label: S3 secret key required to retrieve products hosted on a protected S3 location.
    doc: |
      Access key to Copernicus data provider.
      See https://documentation.dataspace.copernicus.eu/Registration.html 
      and https://documentation.dataspace.copernicus.eu/APIs/S3.html#generate-secrets for details.
    type: string

outputs:
  chlorophyll_a:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/chlorophyll_a
  chlorophyll_a_color:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/chlorophyll_a_color
  chlorophyll_a_plot:
    type: File[]
    format: "iana:image/png"
    outputSource: process/chlorophyll_a_plot

  cyanobacteria:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/cyanobacteria
  cyanobacteria_color:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/cyanobacteria_color
  cyanobacteria_plot:
    type: File[]
    format: "iana:image/png"
    outputSource: process/cyanobacteria_plot

  turbidity:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/turbidity
  turbidity_color:
    type: File[]
    format: "ogc:geotiff"
    outputSource: process/turbidity_color
  turbidity_plot:
    type: File[]
    format: "iana:image/png"
    outputSource: process/turbidity_plot

steps:
  select_products:
    run: select-products-sentinel2.cwl
    in:
      date: date
      delta: delta
      aoi: aoi
      collection: collection
      product_level:
        $comment: |
          Because the 'turbidity' calculation needs both B01 and B03 at 60m resolution to align image band dimensions,
          only L2A level can be employed, since L1C only provides B03 at 10m instead of both 10m and 60m.
        valueFrom: L2A
      catalog:
        valueFrom: copernicus
      cloud_cover: cloud_cover
    out: [urls]  # SAFE products

  process:
    run: algae-usecase-workflow-copernicus-process.cwl
    scatter: [product_url]
    in:
      product_url: select_products/urls
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out:
      - chlorophyll_a
      - chlorophyll_a_color
      - chlorophyll_a_plot
      - cyanobacteria
      - cyanobacteria_color
      - cyanobacteria_plot
      - turbidity
      - turbidity_color
      - turbidity_plot

$namespaces:
  s: "https://schema.org/"
  ogc: "http://www.opengis.net/def/media-type/ogc/1.0/"
  iana: "https://www.iana.org/assignments/media-types/"
  cwltool: "http://commonwl.org/cwltool#"
