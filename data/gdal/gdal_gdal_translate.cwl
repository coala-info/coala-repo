cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdal_translate
label: gdal_gdal_translate
doc: "Converts raster data between different formats, with optional subsetting, resampling and scaling.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: src_dataset
    type: File
    doc: "Source raster dataset."
    inputBinding:
      position: 1
  - id: dst_name
    type: string
    doc: "Name of the output dataset to create."
    inputBinding:
      position: 999
  - id: output_type
    type:
      - 'null'
      - string
    doc: "Force the output image bands to have a specific data type: Byte, Int16, UInt16, UInt32, Int32, Float32, Float64, CInt16, CInt32, CFloat32 or CFloat64."
    inputBinding:
      position: 102
      prefix: -ot
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Don't be forgiving of mismatches and lost data when translating to the output format."
    inputBinding:
      position: 102
      prefix: -strict
  - id: format
    type:
      - 'null'
      - string
    doc: "Select the output format (GDAL driver short name, e.g. GTiff, PNG, VRT)."
    inputBinding:
      position: 102
      prefix: -of
  - id: band
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -b
    doc: "Select an input band to write to the output file; repeat for several bands (band number, or 'mask' / 'mask,n')."
    inputBinding:
      position: 102
  - id: mask_band
    type:
      - 'null'
      - string
    doc: "Select an input band to create output dataset mask band (band number, 'none', 'auto' or 'mask[,n]')."
    inputBinding:
      position: 102
      prefix: -mask
  - id: expand
    type:
      - 'null'
      - string
    doc: "Expand the input file to RGB or RGBA output: gray, rgb or rgba."
    inputBinding:
      position: 102
      prefix: -expand
  - id: outsize
    type:
      - 'null'
      - type: array
        items: string
    doc: "Set the size of the output file as two values: xsize[%] ysize[%] (0 keeps the aspect ratio)."
    inputBinding:
      position: 102
      prefix: -outsize
  - id: tr
    type:
      - 'null'
      - type: array
        items: float
    doc: "Set the target resolution as two values: xres yres."
    inputBinding:
      position: 102
      prefix: -tr
  - id: r
    type:
      - 'null'
      - string
    doc: "Resampling algorithm: nearest, bilinear, cubic, cubicspline, lanczos, average or mode."
    inputBinding:
      position: 102
      prefix: -r
  - id: unscale
    type:
      - 'null'
      - boolean
    doc: "Apply the scale/offset metadata for the bands to convert scaled values to unscaled values."
    inputBinding:
      position: 102
      prefix: -unscale
  - id: scale
    type:
      - 'null'
      - type: array
        items: float
    doc: "Rescale the input pixels values: src_min src_max [dst_min dst_max]."
    inputBinding:
      position: 102
      prefix: -scale
  - id: exponent
    type:
      - 'null'
      - type: array
        items: float
    doc: "Apply non-linear scaling with a power function; the exponent value."
    inputBinding:
      position: 102
      prefix: -exponent
  - id: srcwin
    type:
      - 'null'
      - type: array
        items: int
    doc: "Source window in pixels: xoff yoff xsize ysize."
    inputBinding:
      position: 102
      prefix: -srcwin
  - id: epo
    type:
      - 'null'
      - boolean
    doc: "Error when the source window falls outside the dataset (-epo)."
    inputBinding:
      position: 102
      prefix: -epo
  - id: eco
    type:
      - 'null'
      - boolean
    doc: "Error when the source window is partly outside the dataset (-eco)."
    inputBinding:
      position: 102
      prefix: -eco
  - id: projwin
    type:
      - 'null'
      - type: array
        items: float
    doc: "Source window in georeferenced coordinates: ulx uly lrx lry."
    inputBinding:
      position: 102
      prefix: -projwin
  - id: projwin_srs
    type:
      - 'null'
      - string
    doc: "Specifies the SRS in which to interpret the coordinates given with -projwin."
    inputBinding:
      position: 102
      prefix: -projwin_srs
  - id: a_srs
    type:
      - 'null'
      - string
    doc: "Override the projection for the output file (any form accepted by SetFromUserInput)."
    inputBinding:
      position: 102
      prefix: -a_srs
  - id: a_ullr
    type:
      - 'null'
      - type: array
        items: float
    doc: "Assign/override the georeferenced bounds of the output file: ulx uly lrx lry."
    inputBinding:
      position: 102
      prefix: -a_ullr
  - id: a_nodata
    type:
      - 'null'
      - string
    doc: "Assign a specified nodata value to output bands (or 'none')."
    inputBinding:
      position: 102
      prefix: -a_nodata
  - id: a_scale
    type:
      - 'null'
      - float
    doc: "Set band scaling value."
    inputBinding:
      position: 102
      prefix: -a_scale
  - id: a_offset
    type:
      - 'null'
      - float
    doc: "Set band offset value."
    inputBinding:
      position: 102
      prefix: -a_offset
  - id: gcp
    type:
      - 'null'
      - type: array
        items: float
    doc: "Add a ground control point: pixel line easting northing [elevation]. Can be repeated in the command line by hand only once here."
    inputBinding:
      position: 102
      prefix: -gcp
  - id: colorinterp
    type:
      - 'null'
      - string
    doc: "Override the color interpretation of all bands: red, green, blue, alpha, gray or undefined, comma separated."
    inputBinding:
      position: 102
      prefix: -colorinterp
  - id: mo
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -mo
    doc: "Passes a metadata key and value to set on the output dataset (META-TAG=VALUE). Repeat as needed."
    inputBinding:
      position: 102
  - id: q
    type:
      - 'null'
      - boolean
    doc: "Suppress progress monitor and other non-error output."
    inputBinding:
      position: 102
      prefix: -q
  - id: sds
    type:
      - 'null'
      - boolean
    doc: "Copy all subdatasets of this file to individual output files."
    inputBinding:
      position: 102
      prefix: -sds
  - id: co
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -co
    doc: "Creation option for the output format (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
  - id: stats
    type:
      - 'null'
      - boolean
    doc: "Force (re)computation of statistics."
    inputBinding:
      position: 102
      prefix: -stats
  - id: norat
    type:
      - 'null'
      - boolean
    doc: "Do not copy source RAT into destination dataset."
    inputBinding:
      position: 102
      prefix: -norat
  - id: oo
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Open option for the input dataset (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
outputs:
  - id: dst_dataset
    type:
      - 'null'
      - File
    doc: "The output dataset."
    outputBinding:
      glob: $(inputs.dst_name)
  - id: aux_xml
    type:
      - 'null'
      - File
    doc: "Auxiliary statistics file, when written."
    outputBinding:
      glob: $(inputs.dst_name).aux.xml
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
