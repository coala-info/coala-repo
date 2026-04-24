cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - archer
  - launch
label: archer_launch
doc: "Launch the Archer service. This will start a gRPC server running that will accept
  incoming Process and Watch requests. It will offer the Archer API for filtering,
  compressing and uploading ARTIC reads to an S3 endpoint.\n\nTool homepage: https://github.com/will-rowe/archer"
inputs:
  - id: aws_bucket_name
    type:
      - 'null'
      - string
    doc: the AWS S3 bucket name for data upload
    inputBinding:
      position: 101
      prefix: --awsBucketName
  - id: aws_region
    type:
      - 'null'
      - string
    doc: the AWS region to use
    inputBinding:
      position: 101
      prefix: --awsRegion
  - id: db_path
    type:
      - 'null'
      - Directory
    doc: location to store the Archer database
    inputBinding:
      position: 101
      prefix: --dbPath
  - id: grpc_address
    type:
      - 'null'
      - string
    doc: address to announce on
    inputBinding:
      position: 101
      prefix: --grpcAddress
  - id: grpc_port
    type:
      - 'null'
      - string
    doc: TCP port to listen to by the gRPC server
    inputBinding:
      position: 101
      prefix: --grpcPort
  - id: manifest_url
    type:
      - 'null'
      - string
    doc: the ARTIC primer scheme manifest url
      https://raw.githubusercontent.com/artic-network/primer-schemes/master/schemes_manifest.json
    inputBinding:
      position: 101
      prefix: --manifestURL
  - id: num_processors
    type:
      - 'null'
      - int
    doc: number of processors to use (-1 == all)
    inputBinding:
      position: 101
      prefix: --numProcessors
  - id: num_workers
    type:
      - 'null'
      - int
    doc: number of concurrent request handlers to use
    inputBinding:
      position: 101
      prefix: --numWorkers
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: where to write the server log (if unset, STDERR used)
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/archer:0.1.1--he881be0_0
