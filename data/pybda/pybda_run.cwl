cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybda
  - run
label: pybda_run
doc: "Execute all tasks defined in a CONFIG in a SPARK session.\n\nTool homepage:
  https://github.com/cbg-ethz/pybda"
inputs:
  - id: config
    type: File
    doc: Configuration file
    inputBinding:
      position: 1
  - id: spark
    type: string
    doc: Spark session identifier (for example local)
    inputBinding:
      position: 2
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data, meta-column and feature-column files named in the config (staged in the working directory, so the config must use their plain file names)
  - id: outfolder
    type: string
    default: results
    doc: Output folder named by outfolder in the config (used to collect the results)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results
    type: Directory
    doc: Results folder written by pybda
    outputBinding:
      glob: $(inputs.outfolder)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybda:0.1.0--pyh5ca1d4c_0
stdout: pybda_run.out
