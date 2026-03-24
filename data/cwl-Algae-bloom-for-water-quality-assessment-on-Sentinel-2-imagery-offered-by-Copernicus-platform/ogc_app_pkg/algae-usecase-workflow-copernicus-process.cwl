#!/usr/bin/env cwl-runner
cwlVersion: "v1.2"
class: Workflow

id: algae-usecase-workflow-copernicus-process
label: |
  Processing on Sentinel-2 bands to evaluate algae bloom.
doc: |
  Performs band calculation on Sentinel-2 product bands
  to evaluate algae bloom for water quality assessment.

s:softwareVersion: "2.1.0"

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

s:isBasedOn: "https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/se2waq/"

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement:
    expressionLib:
     - |
       /** 
        * Extracts the product identifier from the URL and prefixes it to the requested file type.
        */
       function prefixProductName(product_url, file_type) {
         var prod_name = product_url.split('/').slice(-1)[0].split('.')[0];
         return prod_name + "_" + file_type;
       }

hints:
  cwltool:Secrets:
    secrets:
      - s3_access_key
      - s3_secret_key

inputs:
  product_url:
    label: Sentinel-2 SAFE product S3 reference
    type: string
  s3_access_key:
    label: S3 access key required if found products are hosted on a protected S3 location.
    type: string
  s3_secret_key:
    label: S3 secret key required if found products are hosted on a protected S3 location.
    type: string

outputs:
  chlorophyll_a:
    type: File
    format: "ogc:geotiff"
    outputSource: calculate_chlorophyll_a/result
  chlorophyll_a_color:
    doc: Pseudo-color representation of chlorophyll-a.
    type: File
    format: "ogc:geotiff"
    outputSource: plot_chlorophyll_a/output_file
  chlorophyll_a_plot:
    doc: Plot representation of chlorophyll-a.
    type: File
    format: "iana:image/png"
    outputSource: plot_chlorophyll_a/output_plot

  cyanobacteria:
    type: File
    format: "ogc:geotiff"
    outputSource: calculate_cyanobacteria/result
  cyanobacteria_color:
    doc: Pseudo-color representation of cyanobacteria.
    type: File
    format: "ogc:geotiff"
    outputSource: plot_cyanobacteria/output_file
  cyanobacteria_plot:
    doc: Plot representation of cyanobacteria.
    type: File
    format: "iana:image/png"
    outputSource: plot_cyanobacteria/output_plot

  turbidity:
    type: File
    format: "ogc:geotiff"
    outputSource: calculate_turbidity/result
  turbidity_color:
    doc: Pseudo-color representation of turbidity.
    type: File
    format: "ogc:geotiff"
    outputSource: plot_turbidity/output_file
  turbidity_plot:
    doc: Plot representation of turbidity.
    type: File
    format: "iana:image/png"
    outputSource: plot_turbidity/output_plot

steps:
  download_b02_10m:
    run: download-band-sentinel2-product-safe.cwl
    in:
      product_url: product_url
      band:
        valueFrom: B02
      resolution:
        valueFrom: 10m
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out: [product]

  download_b03_10m:
    run: download-band-sentinel2-product-safe.cwl
    in:
      product_url: product_url
      band:
        valueFrom: B03
      resolution:
        valueFrom: 10m
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out: [product]

  download_b04_10m:
    run: download-band-sentinel2-product-safe.cwl
    in:
      product_url: product_url
      band:
        valueFrom: B04
      resolution:
        valueFrom: 10m
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out: [product]

  download_b01_60m:
    run: download-band-sentinel2-product-safe.cwl
    in:
      product_url: product_url
      band:
        valueFrom: B01
      resolution:
        valueFrom: 60m
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out: [product]

  download_b03_60m:
    run: download-band-sentinel2-product-safe.cwl
    in:
      product_url: product_url
      band:
        valueFrom: B03
      resolution:
        valueFrom: 60m
      s3_access_key: s3_access_key
      s3_secret_key: s3_secret_key
    out: [product]

  calculate_chlorophyll_a:
    run: calculate-band.cwl
    in:
      band_a: download_b01_60m/product
      band_c: download_b03_60m/product
      calc:
        valueFrom: '4.26*((C/A)**3.94)'
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      name:
        valueFrom: '$( prefixProductName(inputs.product_url, "chlorophyll_a") )'
    out: [result]

  calculate_cyanobacteria:
    run: calculate-band.cwl
    in:
      band_a: download_b02_10m/product
      band_b: download_b03_10m/product
      band_c: download_b04_10m/product
      calc:
        valueFrom: '115530.31*(((B.astype(float)*C.astype(float))/A.astype(float))**2.38)'
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      name:
        valueFrom: '$( prefixProductName(inputs.product_url, "cyanobacteria") )'
    out: [result]

  calculate_turbidity:
    run: calculate-band.cwl
    in:
      band_a: download_b01_60m/product
      band_c: download_b03_60m/product
      calc:
        valueFrom: '(8.93*(C/A))-6.39'
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      name:
        valueFrom: '$( prefixProductName(inputs.product_url, "turbidity") )'
    out: [result]

  plot_chlorophyll_a:
    run: plot-image.cwl
    in:
      input_image: calculate_chlorophyll_a/result
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      output_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "chlorophyll_a_color") )'
      plot_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "chlorophyll_a_plot") )'
      plot_title:
        valueFrom: "Chlorophyll a"
      # note: JSON string
      color_scale:
        valueFrom: |
          [
            [0,  [ 73, 111, 242] ],
            [6,  [130, 211,  95] ],
            [12, [254, 253,   5] ],
            [20, [253,   0,   4] ],
            [30, [142,  32,  38] ],
            [50, [217, 124, 245] ]
          ]
    out:
      - output_file
      - output_plot

  plot_cyanobacteria:
    run: plot-image.cwl
    in:
      input_image: calculate_cyanobacteria/result
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      output_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "cyanobacteria_color") )'
      plot_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "cyanobacteria_plot") )'
      plot_title:
        valueFrom: "Cyanobacteria"
      clip_min:
        valueFrom: "${ return 1E6; }"
      clip_max:
        valueFrom: "${ return 1E14; }"
      # note: JSON string
      color_scale:
        valueFrom: |
          [
            [1E6,  [ 18,  28,  60] ],
            [1E7,  [ 73, 111, 242] ],
            [1E8,  [130, 211,  95] ],
            [1E9,  [254, 253,   5] ],
            [1E10, [253,   0,   4] ],
            [1E11, [142,  32,  38] ],
            [1E12, [111, 63,  125] ],
            [1E13, [ 58,   6,   3] ],
            [1E14, [ 18,  28,  60] ]
          ]
    out:
      - output_file
      - output_plot

  plot_turbidity:
    run: plot-image.cwl
    in:
      input_image: calculate_turbidity/result
      # must chain workflow input to step input for 'name' evaluation
      product_url: product_url
      output_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "turbidity_color") )'
      plot_name:
        valueFrom: '$( prefixProductName(inputs.product_url, "turbidity_plot") )'
      plot_title:
        valueFrom: "Turbidity"
      # note: JSON string
      color_scale:
        valueFrom: |
          [
            [0,  [ 73, 111, 242] ],
            [4,  [130, 211,  95] ],
            [8,  [254, 253,   5] ],
            [12, [253,   0,   4] ],
            [16, [142,  32,  38] ],
            [20, [217, 124, 245] ]
          ]
    out:
      - output_file
      - output_plot

$namespaces:
  s: "https://schema.org/"
  ogc: "http://www.opengis.net/def/media-type/ogc/1.0/"
  iana: "https://www.iana.org/assignments/media-types/"
  cwltool: "http://commonwl.org/cwltool#"
