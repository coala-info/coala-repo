cwlVersion: v1.2
class: CommandLineTool
baseCommand: funnel worker
label: funnel_worker
doc: "Funnel worker commands.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: amazon_s3_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 101
      prefix: --AmazonS3.Disabled
  - id: amazon_s3_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 101
      prefix: --AmazonS3.MaxRetries
  - id: bolt_db_path
    type:
      - 'null'
      - string
    doc: Path to BoltDB database
    inputBinding:
      position: 101
      prefix: --BoltDB.Path
  - id: compute
    type:
      - 'null'
      - string
    doc: Name of compute backed to use
    inputBinding:
      position: 101
      prefix: --Compute
  - id: config
    type:
      - 'null'
      - string
    doc: Config File
    inputBinding:
      position: 101
      prefix: --config
  - id: database
    type:
      - 'null'
      - string
    doc: Name of database backed to use
    inputBinding:
      position: 101
      prefix: --Database
  - id: datastore_project
    type:
      - 'null'
      - string
    doc: Google project for Datastore
    inputBinding:
      position: 101
      prefix: --Datastore.Project
  - id: dynamo_db_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 101
      prefix: --DynamoDB.MaxRetries
  - id: dynamo_db_region
    type:
      - 'null'
      - string
    doc: AWS region of DynamoDB tables
    inputBinding:
      position: 101
      prefix: --DynamoDB.Region
  - id: dynamo_db_table_basename
    type:
      - 'null'
      - string
    doc: Basename of DynamoDB tables
    inputBinding:
      position: 101
      prefix: --DynamoDB.TableBasename
  - id: elastic_index_prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for Elasticsearch indices
    inputBinding:
      position: 101
      prefix: --Elastic.IndexPrefix
  - id: elastic_url
    type:
      - 'null'
      - string
    doc: Elasticsearch URL
    inputBinding:
      position: 101
      prefix: --Elastic.URL
  - id: event_writers
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of an event writer backend to use. This flag can be used multiple 
      times
    inputBinding:
      position: 101
      prefix: --EventWriters
  - id: google_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 101
      prefix: --GoogleStorage.Disabled
  - id: http_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 101
      prefix: --HTTPStorage.Disabled
  - id: http_storage_timeout
    type:
      - 'null'
      - string
    doc: Timeout in seconds for request
    default: 0s
    inputBinding:
      position: 101
      prefix: --HTTPStorage.Timeout
  - id: kafka_servers
    type:
      - 'null'
      - type: array
        items: string
    doc: Address of a Kafka server. This flag can be used multiple times
    inputBinding:
      position: 101
      prefix: --Kafka.Servers
  - id: kafka_topic
    type:
      - 'null'
      - string
    doc: Kafka topic to write events to
    inputBinding:
      position: 101
      prefix: --Kafka.Topic
  - id: local_storage_allowed_dirs
    type:
      - 'null'
      - type: array
        items: string
    doc: Directories Funnel is allowed to access. This flag can be used multiple
      times
    inputBinding:
      position: 101
      prefix: --LocalStorage.AllowedDirs
  - id: local_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 101
      prefix: --LocalStorage.Disabled
  - id: logger_formatter
    type:
      - 'null'
      - string
    doc: Logs formatter. One of ['text', 'json']
    inputBinding:
      position: 101
      prefix: --Logger.Formatter
  - id: logger_level
    type:
      - 'null'
      - string
    doc: Level of logging
    inputBinding:
      position: 101
      prefix: --Logger.Level
  - id: logger_output_file
    type:
      - 'null'
      - File
    doc: File path to write logs to
    inputBinding:
      position: 101
      prefix: --Logger.OutputFile
  - id: mongo_db_addrs
    type:
      - 'null'
      - type: array
        items: string
    doc: Address of a MongoDB seed server. This flag can be used multiple times
    inputBinding:
      position: 101
      prefix: --MongoDB.Addrs
  - id: mongo_db_database
    type:
      - 'null'
      - string
    doc: Database name in MongoDB
    inputBinding:
      position: 101
      prefix: --MongoDB.Database
  - id: mongo_db_timeout
    type:
      - 'null'
      - string
    doc: Timeout in seconds for initial connection and follow up operations
    default: 0s
    inputBinding:
      position: 101
      prefix: --MongoDB.Timeout
  - id: node_resources_cpus
    type:
      - 'null'
      - int
    doc: Cpus available to Node
    inputBinding:
      position: 101
      prefix: --Node.Resources.Cpus
  - id: node_resources_disk_gb
    type:
      - 'null'
      - float
    doc: Free disk (GB) available to Node
    inputBinding:
      position: 101
      prefix: --Node.Resources.DiskGb
  - id: node_resources_ram_gb
    type:
      - 'null'
      - float
    doc: Ram (GB) available to Node
    inputBinding:
      position: 101
      prefix: --Node.Resources.RamGb
  - id: node_timeout
    type:
      - 'null'
      - string
    doc: Node timeout in seconds
    default: 0s
    inputBinding:
      position: 101
      prefix: --Node.Timeout
  - id: node_update_rate
    type:
      - 'null'
      - string
    doc: Node update rate
    default: 0s
    inputBinding:
      position: 101
      prefix: --Node.UpdateRate
  - id: rpc_client_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 101
      prefix: --RPCClient.MaxRetries
  - id: rpc_client_server_address
    type:
      - 'null'
      - string
    doc: RPC server address
    inputBinding:
      position: 101
      prefix: --RPCClient.ServerAddress
  - id: rpc_client_timeout
    type:
      - 'null'
      - string
    doc: Request timeout for RPC client connections
    default: 0s
    inputBinding:
      position: 101
      prefix: --RPCClient.Timeout
  - id: server_host_name
    type:
      - 'null'
      - string
    doc: Host name or IP
    inputBinding:
      position: 101
      prefix: --Server.HostName
  - id: server_http_port
    type:
      - 'null'
      - string
    doc: HTTP Port
    inputBinding:
      position: 101
      prefix: --Server.HTTPPort
  - id: server_rpc_port
    type:
      - 'null'
      - string
    doc: RPC Port
    inputBinding:
      position: 101
      prefix: --Server.RPCPort
  - id: server_service_name
    type:
      - 'null'
      - string
    doc: Host name or IP
    inputBinding:
      position: 101
      prefix: --Server.ServiceName
  - id: swift_chunk_byte_size
    type:
      - 'null'
      - int
    doc: Size of chunks to use for large object creation
    inputBinding:
      position: 101
      prefix: --Swift.ChunkSizeBytes
  - id: swift_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 101
      prefix: --Swift.Disabled
  - id: swift_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 101
      prefix: --Swift.MaxRetries
  - id: worker_leave_work_dir
    type:
      - 'null'
      - boolean
    doc: Leave working directory after execution
    inputBinding:
      position: 101
      prefix: --Worker.LeaveWorkDir
  - id: worker_log_tail_size
    type:
      - 'null'
      - int
    doc: Max bytes to store for stdout/stderr
    inputBinding:
      position: 101
      prefix: --Worker.LogTailSize
  - id: worker_log_update_rate
    type:
      - 'null'
      - string
    doc: How often to send stdout/stderr log updates
    default: 0s
    inputBinding:
      position: 101
      prefix: --Worker.LogUpdateRate
  - id: worker_polling_rate
    type:
      - 'null'
      - string
    doc: How often to poll for cancel signals
    default: 0s
    inputBinding:
      position: 101
      prefix: --Worker.PollingRate
  - id: worker_work_dir
    type:
      - 'null'
      - string
    doc: Working directory
    inputBinding:
      position: 101
      prefix: --Worker.WorkDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_worker.out
