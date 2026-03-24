class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Workflow
  constructed from history ''EODIE Sentinel'''
inputs:
  S2B_MSIL2A_20200626T095029_N0214_R079_T34VFN_20200626T123234_tar:
    doc: Sentinel2 input data. This input dataset corresponds to the data itself while
      sentinel2_tiles_world would be the corresponding shapefile for the tile.
    format: data
    type: File
  sentinel2_tiles_world:
    doc: This input dataset corresponds to the Sentinel-2 tile shapefile, originally
      provided by https://fromgistors.blogspot.com/2016/10/how-to-identify-sentinel-2-granule.html,
    format: data
    type: File
  test_parcels_32635:
    doc: This input dataset is a shapefile corresponding the the area of interest
      e.g. on which statistics such as NDVI will be computed.
    format: data
    type: File
outputs: {}
steps:
  3_EODIE:
    in:
      input: test_parcels_32635
      input_type|input_file: S2B_MSIL2A_20200626T095029_N0214_R079_T34VFN_20200626T123234_tar
      input_type|s2_shp: sentinel2_tiles_world
    out:
    - csv_files
    - logfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_climate_eodie_eodie_1_0_2
      inputs:
        input:
          format: Any
          type: File
        input_type|input_file:
          format: Any
          type: File
        input_type|s2_shp:
          format: Any
          type: File
      outputs:
        csv_files:
          doc: input
          type: File
        logfile:
          doc: txt
          type: File

