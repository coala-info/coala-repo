cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi2.pl
  - utglog
label: fermikit_fermi2.pl_utglog
doc: "Summarise the log files written by a fermi2.pl unitig assembly into one tab-separated\
  \ line per prefix.\n\nTool homepage: https://github.com/lh3/fermikit"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.log_files)
inputs:
  - id: prefix
    type: string
    doc: Assembly prefix; the logs PREFIX.raw.fmd.log, PREFIX.ec.fq.gz.log,
      PREFIX.ec.fmd.log and PREFIX.mag.gz.log must exist in the working directory
    inputBinding:
      position: 1
  - id: log_files
    type:
      type: array
      items: File
    doc: Log files of the assembly, staged so that the prefix names resolve
outputs:
  - id: summary
    type: stdout
    doc: Tab-separated summary
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_fermi2.pl_utglog.out
