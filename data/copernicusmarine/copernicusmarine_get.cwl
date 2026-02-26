cwlVersion: v1.2
class: CommandLineTool
baseCommand: copernicusmarine_get
label: copernicusmarine_get
doc: "Download originally produced data files.\n\nTool homepage: https://github.com/pepijn-devries/CopernicusMarine"
inputs:
  - id: create_file_list
    type:
      - 'null'
      - string
    doc: Option to only create a file containing the names of the targeted files
      instead of downloading them. It writes the file to the specified output 
      directory (default to current directory). The file name specified should 
      end with '.txt' or '.csv'. If specified, no other action will be 
      performed.
    inputBinding:
      position: 101
      prefix: --create-file-list
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
      ($HOME/.copernicusmarine). Accepts .copernicusmarine-credentials / .netrc 
      or _netrc / motuclient-python.ini files.
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
  - id: file_list
    type:
      - 'null'
      - File
    doc: Path to a '.txt' file containing a list of file paths, line by line, 
      that will be downloaded directly. These files must be from the same 
      dataset as the one specified dataset with the datasetID option. If no 
      files can be found, the Toolbox will list all files on the remote server 
      and attempt to find a match.
    inputBinding:
      position: 101
      prefix: --file-list
  - id: filter
    type:
      - 'null'
      - string
    doc: A pattern that must match the absolute paths of the files to download.
    inputBinding:
      position: 101
      prefix: --filter
  - id: filter_with_globbing_pattern
    type:
      - 'null'
      - string
    doc: A pattern that must match the absolute paths of the files to download.
    inputBinding:
      position: 101
      prefix: --filter-with-globbing-pattern
  - id: filter_with_regular_expression
    type:
      - 'null'
      - string
    doc: The regular expression that must match the absolute paths of the files 
      to download.
    inputBinding:
      position: 101
      prefix: --filter-with-regular-expression
  - id: index_parts
    type:
      - 'null'
      - boolean
    doc: Option to get the index files of an INSITU dataset.
    inputBinding:
      position: 101
      prefix: --index-parts
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
    doc: Maximum number of concurrent requests. Default 15. The command uses a 
      thread pool executor to manage concurrent requests. If set to 0, no 
      parallel executions are used.
    default: 15
    inputBinding:
      position: 101
      prefix: --max-concurrent-requests
  - id: no_directories
    type:
      - 'null'
      - boolean
    doc: 'If True, downloaded files will not be organized into directories. NOTE:
      This argument is mutually exclusive with arguments: [sync-delete].'
    inputBinding:
      position: 101
      prefix: --no-directories
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: The destination folder for the downloaded files. Default is the current
      directory.
    default: current directory
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "If specified and if the file already exists on destination, then it will
      be overwritten. By default, the toolbox creates a new file with a new index
      (eg 'filename_(1).nc'). NOTE: This argument is mutually exclusive with arguments:
      [skip-existing, sync, sync-delete]."
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
  - id: regex
    type:
      - 'null'
      - string
    doc: The regular expression that must match the absolute paths of the files 
      to download.
    inputBinding:
      position: 101
      prefix: --regex
  - id: request_file
    type:
      - 'null'
      - File
    doc: Option to pass a file containing the arguments. For more information 
      please refer to the documentation or use option "--create-template" from 
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
  - id: skip_existing
    type:
      - 'null'
      - boolean
    doc: "If the files already exists where it would be downloaded, then the download
      is skipped for this file. By default, the toolbox creates a new file with a
      new index (eg 'filename_(1).nc'). NOTE: This argument is mutually exclusive
      with arguments: [overwrite, sync, sync-delete]."
    inputBinding:
      position: 101
      prefix: --skip-existing
  - id: sync
    type:
      - 'null'
      - boolean
    doc: 'Option to synchronize the local directory with the remote directory. See
      the documentation for more details. Requires to set "--dataset-version". NOTE:
      This argument is mutually exclusive with arguments: [overwrite, skip-existing].'
    inputBinding:
      position: 101
      prefix: --sync
  - id: sync_delete
    type:
      - 'null'
      - boolean
    doc: 'Option to delete local files that are not present on the remote server while
      applying sync. Requires to set "--dataset-version". NOTE: This argument is mutually
      exclusive with arguments: [no-directories, overwrite, skip-existing].'
    inputBinding:
      position: 101
      prefix: --sync-delete
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/copernicusmarine:2.3.0
stdout: copernicusmarine_get.out
