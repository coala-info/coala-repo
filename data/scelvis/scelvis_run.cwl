cwlVersion: v1.2
class: CommandLineTool
baseCommand: scelvis_run
label: scelvis_run
doc: "Run the scelvis server.\n\nTool homepage: https://github.com/bihealth/scelvis"
inputs:
  - id: cache_default_timeout
    type:
      - 'null'
      - int
    doc: Default timeout for cache
    inputBinding:
      position: 101
      prefix: --cache-default-timeout
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Path to cache directory, default is to autocreate one.
    inputBinding:
      position: 101
      prefix: --cache-dir
  - id: cache_preload_data
    type:
      - 'null'
      - boolean
    doc: whether to preload data at startup
    inputBinding:
      position: 101
      prefix: --cache-preload-data
  - id: cache_redis_url
    type:
      - 'null'
      - string
    doc: Redis URL to use for caching, enables Redis cache
    inputBinding:
      position: 101
      prefix: --cache-redis-url
  - id: custom_home_md
    type:
      - 'null'
      - File
    doc: Use custom markdown file for home screen
    inputBinding:
      position: 101
      prefix: --custom-home-md
  - id: custom_static_folder
    type:
      - 'null'
      - Directory
    doc: Use custom static folder for files included in home screen markdown 
      file
    inputBinding:
      position: 101
      prefix: --custom-static-folder
  - id: data_source
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to data source(s)
    inputBinding:
      position: 101
      prefix: --data-source
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_conversion
    type:
      - 'null'
      - boolean
    doc: Directory for visualization uploads, default is to create temporary 
      directory
    inputBinding:
      position: 101
      prefix: --disable-conversion
  - id: disable_upload
    type:
      - 'null'
      - boolean
    doc: Whether or not to disable visualization uploads
    inputBinding:
      position: 101
      prefix: --disable-upload
  - id: fake_data
    type:
      - 'null'
      - boolean
    doc: Enable display of fake data set (for demo purposes).
    inputBinding:
      position: 101
      prefix: --fake-data
  - id: host
    type:
      - 'null'
      - string
    doc: Server host
    inputBinding:
      position: 101
      prefix: --host
  - id: irods_client_server_negotiation
    type:
      - 'null'
      - string
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-client-server-negotiation
  - id: irods_client_server_policy
    type:
      - 'null'
      - string
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-client-server-policy
  - id: irods_encryption_algorithm
    type:
      - 'null'
      - string
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-encryption-algorithm
  - id: irods_encryption_key_size
    type:
      - 'null'
      - int
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-encryption-key-size
  - id: irods_encryption_num_hash_rounds
    type:
      - 'null'
      - int
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-encryption-num-hash-rounds
  - id: irods_encryption_salt_size
    type:
      - 'null'
      - int
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-encryption-salt-size
  - id: irods_ssl_verify_server
    type:
      - 'null'
      - boolean
    doc: IRODS setting
    inputBinding:
      position: 101
      prefix: --irods-ssl-verify-server
  - id: max_upload_data_size
    type:
      - 'null'
      - int
    doc: Maximal size for data upload in bytes
    inputBinding:
      position: 101
      prefix: --max-upload-data-size
  - id: port
    type:
      - 'null'
      - int
    doc: Server port
    inputBinding:
      position: 101
      prefix: --port
  - id: public_url_prefix
    type:
      - 'null'
      - string
    doc: The prefix that this app will be served under (e.g., if behind a 
      reverse proxy.)
    inputBinding:
      position: 101
      prefix: --public-url-prefix
  - id: upload_dir
    type:
      - 'null'
      - Directory
    doc: Directory for visualization uploads, default is to create temporary 
      directory
    inputBinding:
      position: 101
      prefix: --upload-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scelvis:0.8.9--pyhdfd78af_0
stdout: scelvis_run.out
