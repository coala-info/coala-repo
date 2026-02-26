cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - copernicusmarine
  - subset
label: copernicusmarine_subset
doc: "Extract a subset of data from a specified dataset using given parameters.\n\n\
  Tool homepage: https://github.com/pepijn-devries/CopernicusMarine"
inputs:
  - id: chunk_size_limit
    type:
      - 'null'
      - int
    doc: Limit the size of the chunks in the dask array. Default is set to -1 
      which behaves similarly to 'chunks=auto' from ``xarray``. Positive integer
      values and '-1' are accepted. This is an experimental feature.  [x>=-1]
    inputBinding:
      position: 101
      prefix: --chunk-size-limit
  - id: coordinates_selection_method
    type:
      - 'null'
      - string
    doc: If ``inside``, the selection retrieved will be inside the requested 
      range. If ``strict-inside``, the selection retrieved will be inside the 
      requested range, and an error will be raised if the values don't exist. If
      ``nearest``, the extremes closest to the requested values will be 
      returned. If ``outside``, the extremes will be taken to contain all the 
      requested interval. The methods ``inside``, ``nearest`` and ``outside`` 
      will display a warning if the request is out of bounds.
    inputBinding:
      position: 101
      prefix: --coordinates-selection-method
  - id: create_template
    type:
      - 'null'
      - boolean
    doc: Option to create a file <argument>_template.json in your current 
      directory containing the arguments. If specified, no other action will be 
      performed.
    inputBinding:
      position: 101
      prefix: --create-template
  - id: credentials_file
    type:
      - 'null'
      - File
    doc: Path to a credentials file if not in its default directory 
      (``$HOME/.copernicusmarine``). Accepts .copernicusmarine-credentials / 
      .netrc or _netrc / motuclient-python.ini files.
    inputBinding:
      position: 101
      prefix: --credentials-file
  - id: dataset_id
    type: string
    doc: The datasetID, required either as an argument or in the request_file 
      option.
    inputBinding:
      position: 101
      prefix: --dataset-id
  - id: dataset_part
    type:
      - 'null'
      - string
    doc: Force the selection of a specific dataset part.
    inputBinding:
      position: 101
      prefix: --dataset-part
  - id: dataset_version
    type:
      - 'null'
      - string
    doc: Force the selection of a specific dataset version.
    inputBinding:
      position: 101
      prefix: --dataset-version
  - id: disable_progress_bar
    type:
      - 'null'
      - boolean
    doc: Flag to hide progress bar.
    inputBinding:
      position: 101
      prefix: --disable-progress-bar
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: If True, runs query without downloading data.
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: end_datetime
    type:
      - 'null'
      - string
    doc: 'The end datetime of the temporal subset. Supports common format parsed by
      dateutil (https://dateutil.readthedocs.io/en/stable/parser.html). Caution: encapsulate
      date with “ “ to ensure valid expression for format “%Y-%m-%d %H:%M:%S”.'
    inputBinding:
      position: 101
      prefix: --end-datetime
  - id: file_format
    type:
      - 'null'
      - string
    doc: Format of the downloaded dataset. If not set or set to ``None``, 
      defaults to NetCDF '.nc' for gridded datasets and to CSV '.csv' for sparse
      datasets.
    inputBinding:
      position: 101
      prefix: --file-format
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the details printed to console by the command (based on standard 
      logging library).
    inputBinding:
      position: 101
      prefix: --log-level
  - id: maximum_depth
    type:
      - 'null'
      - float
    doc: Maximum depth for the subset.
    inputBinding:
      position: 101
      prefix: --maximum-depth
  - id: maximum_latitude
    type:
      - 'null'
      - float
    doc: Maximum latitude for the subset. Requires a float from -90 degrees to 
      +90.  [-90<=x<=90]
    inputBinding:
      position: 101
      prefix: --maximum-latitude
  - id: maximum_longitude
    type:
      - 'null'
      - float
    doc: Maximum longitude for the subset. The value will be transposed to the 
      interval [-180; 360[.
    inputBinding:
      position: 101
      prefix: --maximum-longitude
  - id: maximum_x
    type:
      - 'null'
      - float
    doc: Maximum x-axis value for the subset. The units are considered in length
      (m, 100km...).
    inputBinding:
      position: 101
      prefix: --maximum-x
  - id: maximum_x_alias
    type:
      - 'null'
      - float
    doc: Alias for ``--maximum-longitude`` and ``--maximum-x``.
    inputBinding:
      position: 101
      prefix: --maximum-x
  - id: maximum_y
    type:
      - 'null'
      - float
    doc: Maximum y-axis value for the subset. The units are considered in length
      (m, 100km...).
    inputBinding:
      position: 101
      prefix: --maximum-y
  - id: maximum_y_alias
    type:
      - 'null'
      - float
    doc: Alias for ``--maximum-latitude`` and ``--maximum-y``.
    inputBinding:
      position: 101
      prefix: --maximum-y
  - id: minimum_depth
    type:
      - 'null'
      - float
    doc: Minimum depth for the subset.
    inputBinding:
      position: 101
      prefix: --minimum-depth
  - id: minimum_latitude
    type:
      - 'null'
      - float
    doc: Minimum latitude for the subset. Requires a float from -90 degrees to 
      +90.  [-90<=x<=90]
    inputBinding:
      position: 101
      prefix: --minimum-latitude
  - id: minimum_longitude
    type:
      - 'null'
      - float
    doc: Minimum longitude for the subset. The value will be transposed to the 
      interval [-180; 360[.
    inputBinding:
      position: 101
      prefix: --minimum-longitude
  - id: minimum_x
    type:
      - 'null'
      - float
    doc: Minimum x-axis value for the subset. The units are considered in length
      (m, 100km...).
    inputBinding:
      position: 101
      prefix: --minimum-x
  - id: minimum_x_alias
    type:
      - 'null'
      - float
    doc: Alias for ``--minimum-longitude`` and ``--minimum-x``.
    inputBinding:
      position: 101
      prefix: --minimum-x
  - id: minimum_y
    type:
      - 'null'
      - float
    doc: Minimum y-axis value for the subset. The units are considered in length
      (m, 100km...).
    inputBinding:
      position: 101
      prefix: --minimum-y
  - id: minimum_y_alias
    type:
      - 'null'
      - float
    doc: Alias for ``--minimum-latitude`` and ``--minimum-y``.
    inputBinding:
      position: 101
      prefix: --minimum-y
  - id: motu_api_request
    type:
      - 'null'
      - string
    doc: Option to pass a complete MOTU API request as a string. Caution, user 
      has to replace double quotes " with single quotes ' in the request.
    inputBinding:
      position: 101
      prefix: --motu-api-request
  - id: netcdf3_compatible
    type:
      - 'null'
      - boolean
    doc: Enable downloading the dataset in a netCDF3 compatible format.
    inputBinding:
      position: 101
      prefix: --netcdf3-compatible
  - id: netcdf_compression_level
    type:
      - 'null'
      - int
    doc: Specify a compression level to apply on the NetCDF output file. A value
      of 0 means no compression, and 9 is the highest level of compression 
      available. If used as a flag, the assigned value will be 1.  [0<=x<=9]
    inputBinding:
      position: 101
      prefix: --netcdf-compression-level
  - id: output_filename
    type:
      - 'null'
      - string
    doc: Save the downloaded data with the given file name (under the output 
      directory).
    inputBinding:
      position: 101
      prefix: --output-filename
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "If specified and if the file already exists on destination, then it will
      be overwritten. By default, the toolbox creates a new file with a new index
      (eg 'filename_(1).nc'). NOTE: This argument is mutually exclusive with arguments:
      [skip-existing]."
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: password
    type:
      - 'null'
      - string
    doc: If not set, search for environment variable 
      COPERNICUSMARINE_SERVICE_PASSWORD, then search for a credentials file, 
      else ask for user input.
    inputBinding:
      position: 101
      prefix: --password
  - id: platform_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify platform ID. Can be used multiple times. Only available for 
      platform chunked datasets.
    inputBinding:
      position: 101
      prefix: --platform-id
  - id: raise_if_updating
    type:
      - 'null'
      - boolean
    doc: If set, raises a :class:`copernicusmarine.DatasetUpdating` error if the
      dataset is being updated and the subset interval requested overpasses the 
      updating start date of the dataset. Otherwise, a simple warning is 
      displayed.
    inputBinding:
      position: 101
      prefix: --raise-if-updating
  - id: request_file
    type:
      - 'null'
      - File
    doc: Option to pass a file containing the arguments. For more information 
      please refer to the documentation or use option ``--create-template`` from
      the command line interface for an example template.
    inputBinding:
      position: 101
      prefix: --request-file
  - id: response_fields
    type:
      - 'null'
      - string
    doc: List of fields to include in the query metadata. The fields are 
      separated by a comma. To return all fields, use 'all'.
    inputBinding:
      position: 101
      prefix: --response-fields
  - id: service
    type:
      - 'null'
      - string
    doc: Force download through one of the available services using the service 
      name among ['arco-geo-series', 'arco-time-series', 'omi-arco', 
      'static-arco', 'arco-platform-series'] or its short name among 
      ['geoseries', 'timeseries', 'omi-arco', 'static-arco', 'platformseries'].
    inputBinding:
      position: 101
      prefix: --service
  - id: skip_existing
    type:
      - 'null'
      - boolean
    doc: "If the files already exists where it would be downloaded, then the download
      is skipped for this file. By default, the toolbox creates a new file with a
      new index (eg 'filename_(1).nc'). NOTE: This argument is mutually exclusive
      with arguments: [overwrite]."
    inputBinding:
      position: 101
      prefix: --skip-existing
  - id: start_datetime
    type:
      - 'null'
      - string
    doc: 'The start datetime of the temporal subset. Supports common format parsed
      by dateutil (https://dateutil.readthedocs.io/en/stable/parser.html). Caution:
      encapsulate date with “ “ to ensure valid expression for format “%Y-%m-%d %H:%M:%S”.'
    inputBinding:
      position: 101
      prefix: --start-datetime
  - id: username
    type:
      - 'null'
      - string
    doc: If not set, search for environment variable 
      COPERNICUSMARINE_SERVICE_USERNAME, then search for a credentials file, 
      else ask for user input.
    inputBinding:
      position: 101
      prefix: --username
  - id: variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify dataset variable. Can be used multiple times.
    inputBinding:
      position: 101
      prefix: --variable
  - id: vertical_axis
    type:
      - 'null'
      - string
    doc: 'Consolidate the vertical dimension (the z-axis) as requested: depth with
      descending positive values, elevation with ascending positive values. Default
      is depth.'
    inputBinding:
      position: 101
      prefix: --vertical-axis
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The destination folder for the downloaded files. Default is the current
      directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/copernicusmarine:2.3.0
