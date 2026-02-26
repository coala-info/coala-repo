cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - node
label: funnel_node
doc: "Funnel node subcommands.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
  - id: amazon_s3_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 102
      prefix: --AmazonS3.Disabled
  - id: amazon_s3_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 102
      prefix: --AmazonS3.MaxRetries
  - id: boltdb_path
    type:
      - 'null'
      - string
    doc: Path to BoltDB database
    inputBinding:
      position: 102
      prefix: --BoltDB.Path
  - id: compute
    type:
      - 'null'
      - string
    doc: Name of compute backed to use
    inputBinding:
      position: 102
      prefix: --Compute
  - id: config
    type:
      - 'null'
      - File
    doc: Config File
    inputBinding:
      position: 102
      prefix: --config
  - id: database
    type:
      - 'null'
      - string
    doc: Name of database backed to use
    inputBinding:
      position: 102
      prefix: --Database
  - id: datastore_project
    type:
      - 'null'
      - string
    doc: Google project for Datastore
    inputBinding:
      position: 102
      prefix: --Datastore.Project
  - id: dynamodb_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 102
      prefix: --DynamoDB.MaxRetries
  - id: dynamodb_region
    type:
      - 'null'
      - string
    doc: AWS region of DynamoDB tables
    inputBinding:
      position: 102
      prefix: --DynamoDB.Region
  - id: dynamodb_table_basename
    type:
      - 'null'
      - string
    doc: Basename of DynamoDB tables
    inputBinding:
      position: 102
      prefix: --DynamoDB.TableBasename
  - id: elastic_index_prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for Elasticsearch indices
    inputBinding:
      position: 102
      prefix: --Elastic.IndexPrefix
  - id: elastic_url
    type:
      - 'null'
      - string
    doc: Elasticsearch URL
    inputBinding:
      position: 102
      prefix: --Elastic.URL
  - id: event_writers
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of an event writer backend to use. This flag can be used multiple 
      times
    inputBinding:
      position: 102
      prefix: --EventWriters
  - id: google_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 102
      prefix: --GoogleStorage.Disabled
  - id: http_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 102
      prefix: --HTTPStorage.Disabled
  - id: http_storage_timeout
    type:
      - 'null'
      - string
    doc: Timeout in seconds for request
    default: 0s
    inputBinding:
      position: 102
      prefix: --HTTPStorage.Timeout
  - id: kafka_servers
    type:
      - 'null'
      - type: array
        items: string
    doc: Address of a Kafka server. This flag can be used multiple times
    inputBinding:
      position: 102
      prefix: --Kafka.Servers
  - id: kafka_topic
    type:
      - 'null'
      - string
    doc: Kafka topic to write events to
    inputBinding:
      position: 102
      prefix: --Kafka.Topic
  - id: local_storage_allowed_dirs
    type:
      - 'null'
      - type: array
        items: string
    doc: Directories Funnel is allowed to access. This flag can be used multiple
      times
    inputBinding:
      position: 102
      prefix: --LocalStorage.AllowedDirs
  - id: local_storage_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 102
      prefix: --LocalStorage.Disabled
  - id: logger_formatter
    type:
      - 'null'
      - string
    doc: Logs formatter. One of ['text', 'json']
    inputBinding:
      position: 102
      prefix: --Logger.Formatter
  - id: logger_level
    type:
      - 'null'
      - string
    doc: Level of logging
    inputBinding:
      position: 102
      prefix: --Logger.Level
  - id: logger_output_file
    type:
      - 'null'
      - File
    doc: File path to write logs to
    inputBinding:
      position: 102
      prefix: --Logger.OutputFile
  - id: mongo_db_addrs
    type:
      - 'null'
      - type: array
        items: string
    doc: Address of a MongoDB seed server. This flag can be used multiple times
    inputBinding:
      position: 102
      prefix: --MongoDB.Addrs
  - id: mongo_db_database
    type:
      - 'null'
      - string
    doc: Database name in MongoDB
    inputBinding:
      position: 102
      prefix: --MongoDB.Database
  - id: mongo_db_timeout
    type:
      - 'null'
      - string
    doc: Timeout in seconds for initial connection and follow up operations
    default: 0s
    inputBinding:
      position: 102
      prefix: --MongoDB.Timeout
  - id: node_resources_cpus
    type:
      - 'null'
      - string
    doc: Cpus available to Node
    inputBinding:
      position: 102
      prefix: --Node.Resources.Cpus
  - id: node_resources_disk_gb
    type:
      - 'null'
      - float
    doc: Free disk (GB) available to Node
    inputBinding:
      position: 102
      prefix: --Node.Resources.DiskGb
  - id: node_resources_ram_gb
    type:
      - 'null'
      - float
    doc: Ram (GB) available to Node
    inputBinding:
      position: 102
      prefix: --Node.Resources.RamGb
  - id: node_timeout
    type:
      - 'null'
      - string
    doc: Node timeout in seconds
    default: 0s
    inputBinding:
      position: 102
      prefix: --Node.Timeout
  - id: node_update_rate
    type:
      - 'null'
      - string
    doc: Node update rate
    default: 0s
    inputBinding:
      position: 102
      prefix: --Node.UpdateRate
  - id: rpcc_client_max_retries
    type:
      - 'null'
      - string
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 102
      prefix: --RPCClient.MaxRetries
  - id: rpcc_client_server_address
    type:
      - 'null'
      - string
    doc: RPC server address
    inputBinding:
      position: 102
      prefix: --RPCClient.ServerAddress
  - id: rpcc_client_timeout
    type:
      - 'null'
      - string
    doc: Request timeout for RPC client connections
    default: 0s
    inputBinding:
      position: 102
      prefix: --RPCClient.Timeout
  - id: server_host_name
    type:
      - 'null'
      - string
    doc: Host name or IP
    inputBinding:
      position: 102
      prefix: --Server.HostName
  - id: server_http_port
    type:
      - 'null'
      - string
    doc: HTTP Port
    inputBinding:
      position: 102
      prefix: --Server.HTTPPort
  - id: server_rpc_port
    type:
      - 'null'
      - string
    doc: RPC Port
    inputBinding:
      position: 102
      prefix: --Server.RPCPort
  - id: server_service_name
    type:
      - 'null'
      - string
    doc: Host name or IP
    inputBinding:
      position: 102
      prefix: --Server.ServiceName
  - id: swift_chunk_byte_size
    type:
      - 'null'
      - int
    doc: Size of chunks to use for large object creation
    inputBinding:
      position: 102
      prefix: --Swift.ChunkSizeBytes
  - id: swift_disabled
    type:
      - 'null'
      - boolean
    doc: Disable storage backend
    inputBinding:
      position: 102
      prefix: --Swift.Disabled
  - id: swift_max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of times that a request will be retried for failures
    inputBinding:
      position: 102
      prefix: --Swift.MaxRetries
  - id: worker_leave_work_dir
    type:
      - 'null'
      - boolean
    doc: Leave working directory after execution
    inputBinding:
      position: 102
      prefix: --Worker.LeaveWorkDir
  - id: worker_log_tail_size
    type:
      - 'null'
      - int
    doc: Max bytes to store for stdout/stderr
    inputBinding:
      position: 102
      prefix: --Worker.LogTailSize
  - id: worker_log_update_rate
    type:
      - 'null'
      - string
    doc: How often to send stdout/stderr log updates
    default: 0s
    inputBinding:
      position: 102
      prefix: --Worker.LogUpdateRate
  - id: worker_polling_rate
    type:
      - 'null'
      - string
    doc: How often to poll for cancel signals
    default: 0s
    inputBinding:
      position: 102
      prefix: --Worker.PollingRate
  - id: worker_work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 102
      prefix: --Worker.WorkDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_node.out
