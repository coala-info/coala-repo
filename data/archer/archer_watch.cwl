cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - archer
  - watch
label: archer_watch
doc: "Watch a running Archer service. This command will start a gRPC message stream
  and print samples that have completed processing. It will include sample name, amplicon
  coverage, S3 location and processing time.\n\nTool homepage: https://github.com/will-rowe/archer"
inputs:
  - id: grpc_address
    type:
      - 'null'
      - string
    doc: address of the server hosting the Archer service
    default: localhost
    inputBinding:
      position: 101
      prefix: --grpcAddress
  - id: grpc_port
    type:
      - 'null'
      - string
    doc: TCP port to listen to by the gRPC server
    default: '9090'
    inputBinding:
      position: 101
      prefix: --grpcPort
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/archer:0.1.1--he881be0_0
stdout: archer_watch.out
