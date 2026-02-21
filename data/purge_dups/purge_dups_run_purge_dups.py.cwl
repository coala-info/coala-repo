cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups_run_purge_dups.py
label: purge_dups_run_purge_dups.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/fetch operation. No arguments or descriptions could
  be extracted from the input text.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_run_purge_dups.py.out
