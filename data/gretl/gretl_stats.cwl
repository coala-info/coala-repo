cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl-stats
label: gretl_stats
doc: "Basic graph statistics for a single graph\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs:
  - id: bins
    type:
      - 'null'
      - string
    doc: 'Size of bins. Example: Format 10,20,30 -> (0-10, 11-20, 30+)'
    default: 1,50,100,1000
    inputBinding:
      position: 101
      prefix: --bins
  - id: gfa
    type: File
    doc: Input GFA file
    inputBinding:
      position: 101
      prefix: --gfa
  - id: haplotype
    type:
      - 'null'
      - boolean
    doc: Make stats for each haplotype (not sample, not path). Only in 
      combination with Pan-SN
    inputBinding:
      position: 101
      prefix: --haplo
  - id: pansn
    type:
      - 'null'
      - string
    doc: Separator for Pan-SN spec
    default: \n
    inputBinding:
      position: 101
      prefix: --pansn
  - id: path_statistics
    type:
      - 'null'
      - boolean
    doc: Report path statistics (default:off -> report graph stats)
    inputBinding:
      position: 101
      prefix: --path
  - id: report_yaml
    type:
      - 'null'
      - boolean
    doc: Report output in YAML format (default:off -> report in tsv)
    inputBinding:
      position: 101
      prefix: -y
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
