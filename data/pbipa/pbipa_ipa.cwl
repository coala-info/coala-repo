cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipa
label: pbipa_ipa
doc: "Improved Phased Assembly tool for HiFi reads.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: subcommand
    type: string
    doc: 'Sub-command to run: local (Run IPA on your local machine), dist (Distribute
      IPA jobs to your cluster), or validate (Check dependencies).'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbipa:1.8.0--h1104d80_3
stdout: pbipa_ipa.out
