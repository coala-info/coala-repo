cwlVersion: v1.2
class: CommandLineTool
baseCommand: mbuffer
label: mbuffer
doc: "mbuffer is a \"pipe\" like program that supports buffering. It can be used to
  buffer data from a producer to a consumer. It can also be used to buffer data from
  a file to a file, or from a network to a file, or from a file to a network, etc.\n\
  \nTool homepage: https://github.com/ilovezfs/mbuffer-osx"
inputs:
  - id: append_output
    type:
      - 'null'
      - boolean
    doc: append to output file (must be passed before -o)
    inputBinding:
      position: 101
      prefix: --append
  - id: autoloader_command
    type:
      - 'null'
      - string
    doc: issue command <cmd> to request new volume
    inputBinding:
      position: 101
      prefix: -A
  - id: autoloader_time
    type:
      - 'null'
      - int
    doc: autoloader which needs <time> seconds to reload
    inputBinding:
      position: 101
      prefix: -a
  - id: block_size
    type:
      - 'null'
      - int
    doc: use blocks of <size> bytes for processing
    default: 4096
    inputBinding:
      position: 101
      prefix: -s
  - id: blocks
    type:
      - 'null'
      - int
    doc: use <num> blocks for buffer
    default: 39955
    inputBinding:
      position: 101
      prefix: -b
  - id: buffer_file
    type:
      - 'null'
      - File
    doc: as -t but uses <file> as buffer
    inputBinding:
      position: 101
      prefix: -T
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: memory <size> of buffer in b,k,M,G,%
    default: 2% = 156M
    inputBinding:
      position: 101
      prefix: -m
  - id: force_ipv4
    type:
      - 'null'
      - boolean
    doc: force use of IPv4
    inputBinding:
      position: 101
      prefix: '-4'
  - id: force_ipv6
    type:
      - 'null'
      - boolean
    doc: force use of IPv6
    inputBinding:
      position: 101
      prefix: '-6'
  - id: input_file
    type:
      - 'null'
      - File
    doc: use <file> for input
    inputBinding:
      position: 101
      prefix: -i
  - id: ipv4_or_ipv6
    type:
      - 'null'
      - boolean
    doc: use IPv4 or IPv6
    inputBinding:
      position: 101
      prefix: '-0'
  - id: limit_read_rate
    type:
      - 'null'
      - string
    doc: limit read rate to <rate> B/s, where <rate> can be given in b,k,M,G
    inputBinding:
      position: 101
      prefix: -r
  - id: limit_write_rate
    type:
      - 'null'
      - string
    doc: same as -r for writing; use eiter one, if your tape is too fast
    inputBinding:
      position: 101
      prefix: -R
  - id: lock_buffer
    type:
      - 'null'
      - boolean
    doc: lock buffer in memory (unusable with file based buffers)
    inputBinding:
      position: 101
      prefix: -L
  - id: log_file
    type:
      - 'null'
      - File
    doc: use <file> for logging messages
    inputBinding:
      position: 101
      prefix: -l
  - id: network_input
    type:
      - 'null'
      - string
    doc: use network port <port> as input, allow only host <h> to connect or use
      network port <port> as input
    inputBinding:
      position: 101
      prefix: -I
  - id: network_output
    type:
      - 'null'
      - type: array
        items: string
    doc: output data to host <h> and port <p> (MUTLIPLE outputs supported)
    inputBinding:
      position: 101
      prefix: -O
  - id: num_volumes
    type:
      - 'null'
      - string
    doc: <num> volumes for input, '0' to prompt interactively
    inputBinding:
      position: 101
      prefix: -n
  - id: output_device_size
    type:
      - 'null'
      - string
    doc: assumed output device size
    default: infinite/auto-detect
    inputBinding:
      position: 101
      prefix: -D
  - id: overwrite_existing
    type:
      - 'null'
      - boolean
    doc: overwrite existing files
    inputBinding:
      position: 101
      prefix: -f
  - id: pause_after_write
    type:
      - 'null'
      - int
    doc: pause <num> milliseconds after each write
    inputBinding:
      position: 101
      prefix: -u
  - id: quiet_log
    type:
      - 'null'
      - boolean
    doc: quiet - do not log the status
    inputBinding:
      position: 101
      prefix: -Q
  - id: quiet_status
    type:
      - 'null'
      - boolean
    doc: quiet - do not display the status on stderr
    inputBinding:
      position: 101
      prefix: -q
  - id: start_reading_threshold
    type:
      - 'null'
      - int
    doc: start reading after buffer has been filled less than <num>%
    inputBinding:
      position: 101
      prefix: -p
  - id: start_writing_threshold
    type:
      - 'null'
      - int
    doc: start writing after buffer has been filled more than <num>%
    inputBinding:
      position: 101
      prefix: -P
  - id: stop_on_error
    type:
      - 'null'
      - boolean
    doc: stop processing on any kind of error
    inputBinding:
      position: 101
      prefix: -e
  - id: sync_data_integrity
    type:
      - 'null'
      - boolean
    doc: write with synchronous data integrity support
    inputBinding:
      position: 101
      prefix: -c
  - id: tcp_buffer_size
    type:
      - 'null'
      - string
    doc: size for TCP buffer
    inputBinding:
      position: 101
      prefix: --tcpbuffer
  - id: truncate_output
    type:
      - 'null'
      - boolean
    doc: truncate next file (must be passed before -o)
    inputBinding:
      position: 101
      prefix: --truncate
  - id: use_device_blocksize
    type:
      - 'null'
      - boolean
    doc: use blocksize of device for output
    inputBinding:
      position: 101
      prefix: -d
  - id: use_direct_io
    type:
      - 'null'
      - boolean
    doc: open input and output with O_DIRECT
    inputBinding:
      position: 101
      prefix: --direct
  - id: use_memory_mapped_temp_file
    type:
      - 'null'
      - boolean
    doc: use memory mapped temporary file (for huge buffer)
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: set verbose level to <level> (valid values are 0..6)
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: use <file> for output (this option can be passed MULTIPLE times)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbuffer:20160228--h7b50bb2_8
