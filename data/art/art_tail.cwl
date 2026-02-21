cwlVersion: v1.2
class: CommandLineTool
baseCommand: tail
label: art_tail
doc: "Print last 10 lines of FILEs (or stdin). With more than one FILE, precede each
  with a filename header.\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to print the last lines of
    inputBinding:
      position: 1
  - id: bytes
    type:
      - 'null'
      - string
    doc: Print last N bytes (suffix b:512, k:1024, m:1024^2)
    inputBinding:
      position: 102
      prefix: -c
  - id: follow
    type:
      - 'null'
      - boolean
    doc: Print data as file grows
    inputBinding:
      position: 102
      prefix: -f
  - id: follow_retry
    type:
      - 'null'
      - boolean
    doc: Same as -f, but keep retrying
    inputBinding:
      position: 102
      prefix: -F
  - id: lines
    type:
      - 'null'
      - string
    doc: Print last N lines, or if +N is used, start on Nth line and print the rest
      (suffix b:512, k:1024, m:1024^2)
    inputBinding:
      position: 102
      prefix: -n
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Never print headers
    inputBinding:
      position: 102
      prefix: -q
  - id: sleep_interval
    type:
      - 'null'
      - float
    doc: Wait SECONDS between reads with -f
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Always print headers
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_tail.out
