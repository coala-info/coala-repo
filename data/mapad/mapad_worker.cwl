cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapad
  - worker
label: mapad_worker
doc: "Spawns worker\n\nTool homepage: https://github.com/mpieva/mapAD"
inputs:
  - id: host
    type: string
    doc: Hostname or IP address of the running dispatcher node
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: TCP port to communicate over
    inputBinding:
      position: 101
      prefix: --port
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads. If 0, mapAD will select the number of 
      threads automatically.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Sets the level of verbosity
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1
stdout: mapad_worker.out
