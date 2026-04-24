cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - solvebio
  - queue
label: solvebio_queue
doc: "Show the status of tasks in the queue.\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Show all tasks, regardless of status.
    inputBinding:
      position: 101
      prefix: --all
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit the number of tasks to display.
    inputBinding:
      position: 101
      prefix: --limit
  - id: offset
    type:
      - 'null'
      - int
    doc: Offset the task list by a specified number.
    inputBinding:
      position: 101
      prefix: --offset
  - id: sort
    type:
      - 'null'
      - string
    doc: Sort tasks by a specified field and direction (e.g., 'created_at:asc').
    inputBinding:
      position: 101
      prefix: --sort
  - id: statuses
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter tasks by status (e.g., pending, running, completed, failed). 
      Multiple statuses can be provided as a comma-separated string or by 
      repeating the flag.
    inputBinding:
      position: 101
      prefix: --statuses
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output, including task details.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_queue.out
