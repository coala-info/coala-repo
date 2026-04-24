#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: Workflow

id: algae-usecase-workflow-earth-search
label: |
  Algae bloom for water quality assessment on Sentinel-2 L2A imagery offered by Earth-Search platform.
doc: |
  Searches for Sentinel-2 L2A products on Earth-Search using filtering parameters
  and performs band calculation on matched Sentinel-2 products to evaluate algae bloom
  for water quality assessment. For each match, reference bands are downloaded, processed,
  and returned as output with raw data, color map and plot visualization. Each output file
  will be named with the ID of the original product to distinguish them in case of multiple matches.

s:softwareVersion: "2.0.0"

s:author:
  - class: s:Person
    s:identifier: "http://orcid.org/0000-0003-4862-3349"
    s:email: francis.charette-migneault@crim.ca
    s:name: Francis Charette-Migneault

s:keywords:
  - water-quality
  - algae-bloom
  - earth-search
  - OSPD
  - demo

s:codeRepository: "https://gitlab.ogc.org/ogc/ogc-ospd"
s:license: "https://spdx.org/licenses/CC-BY-NC-SA-4.0"

requirements:
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  date:
    label: Central date
    doc: Date around which ±delta-days will be applied for search. If omitted, 'toi' input must be provided instead.
    type: string?
  delta:
    type: int?
  toi:
    label: Time of interest
    doc: Start and end date-time strings. Must be provided if 'date' input is omitted.
    type: string[]?
  aoi:
    label: Area of interest
    doc: Polygon defining the area of interest.
    type: File
    format: "iana:application/geo+json"
  collection:
    type: string
  cloud_cover:
    type: double?

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
      toi: toi
      aoi: aoi
      collection: collection
      product_level:
        $comment: |
          Because the 'turbidity' calculation needs both B01 and B03 at 60m resolution to align image band dimensions,
          only L2A level can be employed, since L1C only provides B03 at 10m instead of both 10m and 60m.
        valueFrom: L2A  # In the case of Earth-Search, the Collection name also uses this reference, so they must align
      catalog:
        valueFrom: earth-search
      cloud_cover: cloud_cover
    out: [urls]  # STAC Item GeoJSON

  process:
    run: algae-usecase-workflow-earth-search-process.cwl
    scatter: [product_url]
    in:
      product_url: select_products/urls
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
