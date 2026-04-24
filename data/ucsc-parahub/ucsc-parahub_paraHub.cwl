cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHub
label: ucsc-parahub_paraHub
doc: "parasol hub server\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: machine_list
    type: File
    doc: 'file with the following columns: name - Network name, cpus - Number of CPUs
      we can use, ramSize - Megabytes of memory, tempDir - Location of (local) temp
      dir, localDir - Location of local data dir, localSize - Megabytes of local disk,
      switchName - Name of switch this is on'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Don't daemonize
    inputBinding:
      position: 102
      prefix: -debug
  - id: default_job_ram
    type:
      - 'null'
      - int
    doc: Number of ram units in a job has no specified ram usage.
    inputBinding:
      position: 102
      prefix: -defaultJobRam
  - id: job_check_period
    type:
      - 'null'
      - int
    doc: Minutes between checking on job
    inputBinding:
      position: 102
      prefix: -jobCheckPeriod
  - id: log_facility
    type:
      - 'null'
      - string
    doc: Log to the specified syslog facility
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
  - id: machine_check_period
    type:
      - 'null'
      - int
    doc: Minutes between checking on machine
    inputBinding:
      position: 102
      prefix: -machineCheckPeriod
  - id: next_job_id
    type:
      - 'null'
      - int
    doc: Starting job ID number.
    inputBinding:
      position: 102
      prefix: -nextJobId
  - id: no_resume
    type:
      - 'null'
      - boolean
    doc: Don't try to reconnect with jobs running on nodes.
    inputBinding:
      position: 102
      prefix: -noResume
  - id: ram_unit
    type:
      - 'null'
      - string
    doc: Number of bytes of RAM in the base unit used by the jobs. Default is 
      RAM on node divided by number of cpus on node. Shorthand expressions allow
      t,g,m,k for tera, giga, mega, kilo. e.g. 4g = 4 Gigabytes.
    inputBinding:
      position: 102
      prefix: -ramUnit
  - id: spokes
    type:
      - 'null'
      - int
    doc: Number of processes that feed jobs to nodes
    inputBinding:
      position: 102
      prefix: -spokes
  - id: subnet
    type:
      - 'null'
      - string
    doc: Only accept connections from subnet (example 192.168). Or CIDR notation
      (example 192.168.1.2/24). Supports comma-separated list of IPv4 or IPv6 
      subnets in CIDR notation.
    inputBinding:
      position: 102
      prefix: -subnet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraHub.out
