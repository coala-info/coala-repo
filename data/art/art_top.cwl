cwlVersion: v1.2
class: CommandLineTool
baseCommand: top
label: art_top
doc: "Show a view of process activity in real time. Read the status of all processes
  from /proc each SECONDS and show a screenful of them.\n\nTool homepage: https://github.com/jlevy/the-art-of-command-line"
inputs:
  - id: batch_mode
    type:
      - 'null'
      - boolean
    doc: Batch mode
    inputBinding:
      position: 101
      prefix: -b
  - id: delay
    type:
      - 'null'
      - float
    doc: Delay between updates
    inputBinding:
      position: 101
      prefix: -d
  - id: iterations
    type:
      - 'null'
      - int
    doc: Exit after N iterations
    inputBinding:
      position: 101
      prefix: -n
  - id: show_memory
    type:
      - 'null'
      - boolean
    doc: Same as 's' key (show memory)
    inputBinding:
      position: 101
      prefix: -m
  - id: show_threads
    type:
      - 'null'
      - boolean
    doc: Show threads
    inputBinding:
      position: 101
      prefix: -H
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art:2016.06.05--h0704011_13
stdout: art_top.out
