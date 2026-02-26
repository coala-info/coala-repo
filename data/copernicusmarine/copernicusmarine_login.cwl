cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - copernicusmarine
  - login
label: copernicusmarine_login
doc: "Create a configuration file with your Copernicus Marine credentials under the
  ``$HOME/.copernicusmarine`` directory.\n\nTool homepage: https://github.com/pepijn-devries/CopernicusMarine"
inputs:
  - id: check_credentials_valid
    type:
      - 'null'
      - boolean
    doc: 'Flag to check if the credentials are valid. No other action will be performed.
      The validity will be check in this order: 1. Check if the credentials are valid
      with the provided username and password. 2. Check if the credentials are valid
      in the environment variables. 3. Check if the credentials are valid in the configuration
      file. When any is found (valid or not valid), will return immediately.'
    inputBinding:
      position: 101
      prefix: --check-credentials-valid
  - id: configuration_file_directory
    type:
      - 'null'
      - Directory
    doc: Path to the directory where the configuration file will be stored.
    inputBinding:
      position: 101
      prefix: --configuration-file-directory
  - id: credentials_file
    type:
      - 'null'
      - File
    doc: Path to a credentials file if not in its default directory 
      (``$HOME/.copernicusmarine``). Accepts .copernicusmarine-credentials / 
      .netrc or _netrc / motuclient-python.ini files. Will only be taken into 
      account when checking the credentials validity.
    inputBinding:
      position: 101
      prefix: --credentials-file
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Flag to skip confirmation before overwriting configuration file.
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the details printed to console by the command (based on standard 
      logging library).
    inputBinding:
      position: 101
      prefix: --log-level
  - id: password
    type:
      - 'null'
      - string
    doc: If not set, search for environment variable 
      COPERNICUSMARINE_SERVICE_PASSWORD, else ask for user input.
    inputBinding:
      position: 101
      prefix: --password
  - id: username
    type:
      - 'null'
      - string
    doc: If not set, search for environment variable 
      COPERNICUSMARINE_SERVICE_USERNAME, else ask for user input.
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
stdout: copernicusmarine_login.out
