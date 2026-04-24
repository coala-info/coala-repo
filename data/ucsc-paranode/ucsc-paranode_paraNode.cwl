cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNode
label: ucsc-paranode_paraNode
doc: "Parasol node server.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: start
    type: string
    doc: Start the parasol node server
    inputBinding:
      position: 1
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs to use - default 1.
    inputBinding:
      position: 102
      prefix: -cpu
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Don't daemonize
    inputBinding:
      position: 102
      prefix: -debug
  - id: env
    type:
      - 'null'
      - type: array
        items: string
    doc: add environment variable to jobs.  Maybe repeated.
    inputBinding:
      position: 102
      prefix: -env
  - id: hub
    type:
      - 'null'
      - string
    doc: Restrict access to connections from hub.
    inputBinding:
      position: 102
      prefix: -hub
  - id: log_facility
    type:
      - 'null'
      - string
    doc: Log to the specified syslog facility - default local0.
    inputBinding:
      position: 102
      prefix: -logFacility
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to file instead of syslog.
    inputBinding:
      position: 102
      prefix: -log
  - id: log_min_priority
    type:
      - 'null'
      - string
    doc: minimum syslog priority to log, also filters file logging.
    inputBinding:
      position: 102
      prefix: -logMinPriority
  - id: random_delay
    type:
      - 'null'
      - int
    doc: Up to this many milliseconds of random delay before starting a job. 
      This is mostly to avoid swamping NFS with file opens when loading up an 
      idle cluster. Also it limits the impact on the hub of very short jobs. 
      Default 5000.
    inputBinding:
      position: 102
      prefix: -randomDelay
  - id: sys_path
    type:
      - 'null'
      - string
    doc: System dirs to add to path.
    inputBinding:
      position: 102
      prefix: -sysPath
  - id: umask
    type:
      - 'null'
      - string
    doc: Set umask to run under - default 002.
    inputBinding:
      position: 102
      prefix: -umask
  - id: user_path
    type:
      - 'null'
      - string
    doc: User dirs to add to path.
    inputBinding:
      position: 102
      prefix: -userPath
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraNode.out
