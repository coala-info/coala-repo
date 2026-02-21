cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mldbm-sync
label: perl-mldbm-sync
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system log showing a failed execution attempt where
  the executable was not found in the environment.\n\nTool homepage: https://github.com/pld-linux/perl-MLDBM-Sync"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mldbm-sync:0.30--0
stdout: perl-mldbm-sync.out
