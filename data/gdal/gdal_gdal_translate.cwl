cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal_translate
label: gdal_gdal_translate
doc: "Translate a raster file to another format, with optional resampling, scaling,
  etc.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: src_dataset
    type: File
    doc: Source dataset
    inputBinding:
      position: 1
  - id: a_nodata
    type:
      - 'null'
      - string
    doc: Assign a nodata value to the output dataset.
    inputBinding:
      position: 102
      prefix: -a_nodata
  - id: a_offset
    type:
      - 'null'
      - float
    doc: Assign an offset value to the output dataset.
    inputBinding:
      position: 102
      prefix: -a_offset
  - id: a_scale
    type:
      - 'null'
      - float
    doc: Assign a scale value to the output dataset.
    inputBinding:
      position: 102
      prefix: -a_scale
  - id: a_srs
    type:
      - 'null'
      - string
    doc: Assign a new SRS to the output dataset.
    inputBinding:
      position: 102
      prefix: -a_srs
  - id: a_ullr
    type:
      - 'null'
      - type: array
        items: float
    doc: Assign the georeferenced bounding box in the output SRS.
    inputBinding:
      position: 102
      prefix: -a_ullr
  - id: band
    type:
      - 'null'
      - int
    doc: Select the band to convert. Defaults to all bands.
    inputBinding:
      position: 102
      prefix: -b
  - id: co
    type:
      - 'null'
      - type: array
        items: string
    doc: Format specific creation options to be used.
    inputBinding:
      position: 102
      prefix: -co
  - id: colorinterp_band
    type:
      - 'null'
      - string
    doc: Set the color interpretation of a band.
    inputBinding:
      position: 102
      prefix: -colorinterp
  - id: colorinterp_list
    type:
      - 'null'
      - string
    doc: Set the color interpretation of bands.
    inputBinding:
      position: 102
      prefix: -colorinterp
  - id: eco
    type:
      - 'null'
      - boolean
    doc: Enable "epsilon" processing for the output coordinates.
    inputBinding:
      position: 102
      prefix: --eco
  - id: epo
    type:
      - 'null'
      - boolean
    doc: Enable "epsilon" processing for the source window.
    inputBinding:
      position: 102
      prefix: --epo
  - id: expand
    type:
      - 'null'
      - string
    doc: Expand color palette to RGB/RGBA or Grayscale.
    inputBinding:
      position: 102
      prefix: -expand
  - id: exponent
    type:
      - 'null'
      - type: array
        items: float
    doc: Apply an exponent to the bands.
    inputBinding:
      position: 102
      prefix: --exponent
  - id: format
    type:
      - 'null'
      - string
    doc: Select the output format. If not specified, the format is guessed from 
      the output filename extension.
    inputBinding:
      position: 102
      prefix: -of
  - id: gcp
    type:
      - 'null'
      - type: array
        items: float
    doc: Add a Ground Control Point.
    inputBinding:
      position: 102
      prefix: -gcp
  - id: mask_band
    type:
      - 'null'
      - int
    doc: Select the band to use as a mask.
    inputBinding:
      position: 102
      prefix: -mask
  - id: mo
    type:
      - 'null'
      - type: array
        items: string
    doc: Set a metadata item.
    inputBinding:
      position: 102
      prefix: -mo
  - id: norat
    type:
      - 'null'
      - boolean
    doc: Do not copy raster attribute table.
    inputBinding:
      position: 102
      prefix: --norat
  - id: oo
    type:
      - 'null'
      - type: array
        items: string
    doc: Open options for the source dataset.
    inputBinding:
      position: 102
      prefix: -oo
  - id: output_type
    type:
      - 'null'
      - string
    doc: Forces the output data type. If not specified, the default is the one 
      of the source dataset.
    inputBinding:
      position: 102
      prefix: -ot
  - id: outsize
    type:
      - 'null'
      - string
    doc: Set the output file size in pixels. Can be xsize[%] or ysize[%].
    inputBinding:
      position: 102
      prefix: -outsize
  - id: projwin
    type:
      - 'null'
      - type: array
        items: float
    doc: Select which part of the projection to convert.
    inputBinding:
      position: 102
      prefix: -projwin
  - id: projwin_srs
    type:
      - 'null'
      - string
    doc: Specify the SRS of the projwin.
    inputBinding:
      position: 102
      prefix: -projwin_srs
  - id: q
    type:
      - 'null'
      - boolean
    doc: Quiet mode.
    inputBinding:
      position: 102
      prefix: -q
  - id: r
    type:
      - 'null'
      - string
    doc: Select the resampling algorithm.
    inputBinding:
      position: 102
      prefix: -r
  - id: scale
    type:
      - 'null'
      - type: array
        items: float
    doc: Scale the bands to the given range.
    inputBinding:
      position: 102
      prefix: --scale
  - id: sds
    type:
      - 'null'
      - boolean
    doc: Copy subdatasets.
    inputBinding:
      position: 102
      prefix: -sds
  - id: srcwin
    type:
      - 'null'
      - type: array
        items: int
    doc: Select which part of the source data to read.
    inputBinding:
      position: 102
      prefix: -srcwin
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Compute statistics for the output bands.
    inputBinding:
      position: 102
      prefix: --stats
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Enable strict mode. If the output driver doesn't support a feature, it 
      will be an error.
    inputBinding:
      position: 102
      prefix: --strict
  - id: tr
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the output file resolution in map units per pixel.
    inputBinding:
      position: 102
      prefix: -tr
  - id: unscale
    type:
      - 'null'
      - boolean
    doc: Disable the application of the scale/offset and the "unscale" metadata 
      item.
    inputBinding:
      position: 102
      prefix: --unscale
outputs:
  - id: dst_dataset
    type: File
    doc: Destination dataset
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
