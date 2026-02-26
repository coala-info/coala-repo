cwlVersion: v1.2
class: CommandLineTool
baseCommand: pynteny parse
label: pynteny_parse
doc: "Translate synteny structure with gene symbols into one with\nHMM groups, according
  to provided HMM database.\n\nTool homepage: http://github.com/robaina/Pynteny"
inputs:
  - id: hmm_meta
    type:
      - 'null'
      - string
    doc: "path to hmm database metadata file. If already donwloaded with \npynteny
      downloaded, hmm meta file is retrieved from default location."
    inputBinding:
      position: 101
      prefix: --hmm_meta
  - id: log
    type:
      - 'null'
      - string
    doc: path to log file. Log not written by default.
    inputBinding:
      position: 101
      prefix: --log
  - id: synteny_struc
    type: string
    doc: synteny structure containing gene symbols instead of HMMs
    inputBinding:
      position: 101
      prefix: --synteny_struc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
stdout: pynteny_parse.out
