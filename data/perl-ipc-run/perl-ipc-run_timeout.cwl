cwlVersion: v1.2
class: CommandLineTool
baseCommand: timeout
label: perl-ipc-run_timeout
doc: "Run PROG. Send SIG to it if it is not gone in SECS seconds. Default SIG: TERM.If
  it still exists in KILL_SECS seconds, send KILL.\n\nTool homepage: https://metacpan.org/pod/IPC::Run"
inputs:
  - id: secs
    type: int
    doc: Seconds to wait before sending signal
    inputBinding:
      position: 1
  - id: program
    type: string
    doc: Program to run
    inputBinding:
      position: 2
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to the program
    inputBinding:
      position: 3
  - id: kill_secs
    type:
      - 'null'
      - int
    doc: Seconds to wait before sending KILL signal after initial signal
    inputBinding:
      position: 104
      prefix: -k
  - id: signal
    type:
      - 'null'
      - string
    doc: Signal to send to PROG if it times out
    inputBinding:
      position: 104
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ipc-run:20250809.0--pl5321hdfd78af_0
stdout: perl-ipc-run_timeout.out
