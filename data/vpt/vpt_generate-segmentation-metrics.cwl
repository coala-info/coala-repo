cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - generate-segmentation-metrics
label: vpt_generate-segmentation-metrics
doc: "Computes a number of segmentation metrics and figures to assess the quality
  of cell segmentation\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: blue_stain_name
    type:
      - 'null'
      - string
    doc: The name of the stain that will be used for the blue channel in images.
    default: DAPI
    inputBinding:
      position: 101
      prefix: --blue-stain-name
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: The name of the experiment to be used as the index in the output csv 
      and segmentation report.
    default: Analysis Timestamp
    inputBinding:
      position: 101
      prefix: --experiment-name
  - id: green_stain_name
    type:
      - 'null'
      - string
    doc: The name of the stain that will be used for the red channel in images.
    default: PolyT
    inputBinding:
      position: 101
      prefix: --green-stain-name
  - id: input_boundaries
    type: File
    doc: Path to a micron-space parquet boundary file.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_entity_by_gene
    type: File
    doc: Path to the Entity by gene csv file.
    inputBinding:
      position: 101
      prefix: --input-entity-by-gene
  - id: input_images
    type:
      - 'null'
      - Directory
    doc: 'Input images can be specified in one of three ways: 1. The path to a directory
      of tiff files, if the files are named by the MERSCOPE convention. Example: /path/to/files/
      2. The path to a directory of tiff files including a python formatting string
      specifying the file name. The format string must specify values for "stain"
      and "z". Example: /path/to/files/image_{stain}_z{z}.tif 3. A regular expression
      matching the tiff files to be used, where the regular expression specifies values
      for "stain" and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|-]+)_z(?P<z>[0-9]+).tif
      In all cases, the values for "stain" and "z" must match the stains and z indexes
      specified in the segmentation algorithm.'
    inputBinding:
      position: 101
      prefix: --input-images
  - id: input_metadata
    type: File
    doc: Path to the output csv file where the entity metadata will be stored.
    inputBinding:
      position: 101
      prefix: --input-metadata
  - id: input_micron_to_mosaic
    type: File
    doc: Path to the micron to mosaic pixel transformation matrix.
    inputBinding:
      position: 101
      prefix: --input-micron-to-mosaic
  - id: input_transcripts
    type: File
    doc: Path to an existing transcripts csv file.
    inputBinding:
      position: 101
      prefix: --input-transcripts
  - id: input_z_index
    type:
      - 'null'
      - int
    doc: The Z plane of the mosaic tiff images to use for the patch.
    default: 2
    inputBinding:
      position: 101
      prefix: --input-z-index
  - id: normalization
    type:
      - 'null'
      - string
    doc: The name of the normalization method that will be used on each channel.
    default: CLAHE
    inputBinding:
      position: 101
      prefix: --normalization
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: red_stain_name
    type:
      - 'null'
      - string
    doc: The name of the stain that will be used for the red channel in images.
    default: None
    inputBinding:
      position: 101
      prefix: --red-stain-name
  - id: transcript_count_filter_threshold
    type:
      - 'null'
      - int
    doc: The cell transcript count threshold used for computing metrics and 
      clustering.
    default: 100
    inputBinding:
      position: 101
      prefix: --transcript-count-filter-threshold
  - id: volume_filter_threshold
    type:
      - 'null'
      - int
    doc: The cell volume threshold used for computing metrics and clustering.
    default: 200
    inputBinding:
      position: 101
      prefix: --volume-filter-threshold
outputs:
  - id: output_csv
    type: File
    doc: Path to the csv file where segmentation metrics will be stored.
    outputBinding:
      glob: $(inputs.output_csv)
  - id: output_report
    type:
      - 'null'
      - File
    doc: Path to the output HTML file, will append .html to the end if not 
      included in file name.
    outputBinding:
      glob: $(inputs.output_report)
  - id: output_clustering
    type:
      - 'null'
      - Directory
    doc: Path where the Cell categories Parquet files with clustering results 
      will be saved.
    outputBinding:
      glob: $(inputs.output_clustering)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
