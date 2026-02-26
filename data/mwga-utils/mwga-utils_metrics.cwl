cwlVersion: v1.2
class: CommandLineTool
baseCommand: metrics
label: mwga-utils_metrics
doc: "Generate wig files with base metrics from a MAF file.\n\nTool homepage: https://github.com/RomainFeron/mgwa_utils"
inputs:
  - id: maf_file
    type: File
    doc: Path to a MAF file.
    inputBinding:
      position: 1
  - id: assemblies
    type:
      - 'null'
      - int
    doc: Manually specify the number of assemblies in the alignment; if not, it 
      is computed from the MAF
    default: 0
    inputBinding:
      position: 102
      prefix: -n
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output wig files
    default: no prefix
    inputBinding:
      position: 102
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mwga-utils:0.1.6--h9948957_3
stdout: mwga-utils_metrics.out
