cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sopa, convert]
label: nf-sopa_sopa_convert
doc: "Read any technology data as a SpatialData object and save it as a .zarr directory. Either technology or config_path has to be provided.\n\nTool homepage: https://gustaveroussy.github.io/sopa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: data_path
    type: [File, Directory]
    doc: Path to one data sample (most of the time, a directory with images files and eventually a transcript file)
    inputBinding:
      position: 1
  - id: technology
    type: ['null', string]
    doc: Name of the technology used to collect the data (xenium/merfish/cosmx/phenocycler/macsima/hyperion)
    inputBinding:
      position: 2
      prefix: --technology
  - id: sdata_output
    type: string
    doc: Path to write the SpatialData object (a .zarr directory)
    inputBinding:
      position: 2
      prefix: --sdata-path
  - id: config_path
    type: ['null', File]
    doc: Path to the snakemake config. This can be useful in order not to provide the technology and the kwargs arguments
    inputBinding:
      position: 2
      prefix: --config-path
  - id: overwrite
    type: ['null', boolean]
    doc: Overwrite the existing SpatialData object if already existing
    inputBinding:
      position: 2
      prefix: --overwrite
  - id: no_overwrite
    type: ['null', boolean]
    doc: Do not overwrite the existing SpatialData object (default)
    inputBinding:
      position: 2
      prefix: --no-overwrite
  - id: kwargs
    type: ['null', string]
    doc: Dictionary provided to the reader function as kwargs (default {})
    inputBinding:
      position: 2
      prefix: --kwargs
outputs:
  - id: sdata_out
    type: Directory
    doc: The SpatialData .zarr directory
    outputBinding:
      glob: $(inputs.sdata_output)
  - id: stdout
    type: stdout
    doc: Standard output
stdout: sopa_convert.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
