cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkqc
label: checkqc
doc: "checkQC is a command line utility designed to quickly gather and assess quality
  control metrics from an Illumina sequencing run. It is highly customizable and which
  quality controls modules should be run for a particular run type should be specified
  in the provided configuration file.\n\nTool homepage: https://www.github.com/Molmed/checkQC"
inputs:
  - id: runfolder
    type: Directory
    doc: The run folder to process
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the checkQC configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: downgrade_errors
    type:
      - 'null'
      - type: array
        items: string
    doc: Downgrade errors to warnings for a specific handler, can be used 
      multiple times
    inputBinding:
      position: 102
      prefix: --downgrade-errors
  - id: json
    type:
      - 'null'
      - boolean
    doc: Print the results of the run as json to stdout
    inputBinding:
      position: 102
      prefix: --json
  - id: use_closest_read_length
    type:
      - 'null'
      - boolean
    doc: Use the closest read length if the read length used isn't specified in 
      the config
    inputBinding:
      position: 102
      prefix: --use-closest-read-length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkqc:4.0.7--pyhdfd78af_0
stdout: checkqc.out
