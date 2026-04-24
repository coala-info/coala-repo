cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - archer
  - process
label: archer_process
doc: "Add a sample to the processing queue. The processing request is collected via
  STDIN and should be in JSON. The request will be validated prior to submitting it
  to the Archer service.\n\nTool homepage: https://github.com/will-rowe/archer"
inputs:
  - id: grpc_address
    type:
      - 'null'
      - string
    doc: address of the server hosting the Archer service
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/archer:0.1.1--he881be0_0
stdout: archer_process.out
