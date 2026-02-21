cwlVersion: v1.2
class: CommandLineTool
baseCommand: uptime
label: coreutils_uptime
doc: "Print the current time, the length of time the system has been up, the number
  of users on the system, and the average number of jobs in the run queue over the
  last 1, 5 and 15 minutes. Processes in an uninterruptible sleep state also contribute
  to the load average. If FILE is not specified, use /var/run/utmp.\n\nTool homepage:
  https://github.com/uutils/coreutils"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File to read system information from (defaults to /var/run/utmp if not specified;
      /var/log/wtmp is common)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_uptime.out
