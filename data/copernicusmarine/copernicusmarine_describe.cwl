cwlVersion: v1.2
class: CommandLineTool
baseCommand: copernicusmarine describe
label: copernicusmarine_describe
doc: "Retrieve and parse the metadata information from the Copernicus Marine catalogue.\n\
  \nTool homepage: https://github.com/pepijn-devries/CopernicusMarine"
inputs:
  - id: contains
    type:
      - 'null'
      - string
    doc: Filter catalogue output. Returns products with attributes matching a 
      string token.
    inputBinding:
      position: 101
      prefix: --contains
  - id: dataset_id
    type:
      - 'null'
      - string
    doc: Force the datasetID to be used for the describe command. Will not parse
      the whole catalogue, but only the dataset with the given datasetID.
    inputBinding:
      position: 101
      prefix: --dataset-id
  - id: disable_progress_bar
    type:
      - 'null'
      - boolean
    doc: Flag to hide progress bar.
    inputBinding:
      position: 101
      prefix: --disable-progress-bar
  - id: exclude_fields
    type:
      - 'null'
      - string
    doc: Option to specify the fields to exclude from the output. The fields are
      separated by a comma.
    inputBinding:
      position: 101
      prefix: --exclude-fields
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the details printed to console by the command (based on standard 
      logging library).
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_concurrent_requests
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent requests (>=1). Default 15. The command 
      uses a thread pool executor to manage concurrent requests.
    inputBinding:
      position: 101
      prefix: --max-concurrent-requests
  - id: product_id
    type:
      - 'null'
      - string
    doc: Force the productID to be used for the describe command. Will not parse
      the whole catalogue, but only the product with the given productID.
    inputBinding:
      position: 101
      prefix: --product-id
  - id: raise_on_error
    type:
      - 'null'
      - boolean
    doc: If set to True, the function will raise at the first error encountered 
      during the parsing and fetching of the catalogue. Default, False.
    inputBinding:
      position: 101
      prefix: --raise-on-error
  - id: return_fields
    type:
      - 'null'
      - string
    doc: Option to specify the fields to return in the output. The fields are 
      separated by a comma. You can use 'all' to return all fields.
    inputBinding:
      position: 101
      prefix: --return-fields
  - id: show_all_versions
    type:
      - 'null'
      - boolean
    doc: Include dataset versions in output. By default, shows only the default 
      version.
    inputBinding:
      position: 101
      prefix: --show-all-versions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/copernicusmarine:2.3.0
stdout: copernicusmarine_describe.out
