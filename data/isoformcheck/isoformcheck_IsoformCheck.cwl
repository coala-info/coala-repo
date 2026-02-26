cwlVersion: v1.2
class: CommandLineTool
baseCommand: IsoformCheck
label: isoformcheck_IsoformCheck
doc: "Protein isoform analysis from de novo genome assemblies.\n\nTool homepage: https://github.com/maickrau/IsoformCheck"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to execute. Available commands: initialize, liftover, addsample,
      addsamples, listsamples, addgroup, removegroup, listgroups, rename, stats, validate,
      contingencytable, chisquare, exportallelesets, exportisoforms, comparesamples'
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoformcheck:1.0.0--hdfd78af_0
stdout: isoformcheck_IsoformCheck.out
