cwlVersion: v1.2
class: CommandLineTool
baseCommand: sopa convert
label: sopa_convert
doc: "Read any technology data as a SpatialData object and save it as a `.zarr` directory.\n\
  \nTool homepage: https://gustaveroussy.github.io/sopa"
inputs:
  - id: data_path
    type: string
    doc: Path to one data sample (most of the time, this corresponds to a 
      directory with images files and eventually a transcript file)
    inputBinding:
      position: 1
  - id: config_path
    type:
      - 'null'
      - string
    doc: Path to the snakemake config. This can be useful in order not to 
      provide the `--technology` and the `--kwargs` arguments
    inputBinding:
      position: 102
      prefix: --config-path
  - id: kwargs
    type:
      - 'null'
      - string
    doc: Dictionary provided to the reader function as kwargs
    default: '{}'
    inputBinding:
      position: 102
      prefix: --kwargs
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Whether to overwrite the existing SpatialData object if already 
      existing
    default: true
    inputBinding:
      position: 102
      prefix: --no-overwrite
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Whether to overwrite the existing SpatialData object if already 
      existing
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: technology
    type:
      - 'null'
      - string
    doc: Name of the technology used to collected the data 
      (`xenium`/`merfish`/`cosmx`/`pheno…`
    inputBinding:
      position: 102
      prefix: --technology
outputs:
  - id: sdata_path
    type:
      - 'null'
      - File
    doc: Optional path to write the SpatialData object. If not provided, will 
      write to the `{data_path}.zarr` directory
    outputBinding:
      glob: $(inputs.sdata_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
