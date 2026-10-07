cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crisprme.py
  - targets-integration
label: crisprme_targets-integration
doc: "Automated integration process that processes the final result file to generate
  a usable target panel.\n\nTool homepage: https://github.com/samuelecancellieri/CRISPRme"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output, listing: []})'
        writable: true
inputs:
  - id: targets
    type: File
    doc: Final result file to use in the panel creation process
    inputBinding:
      position: 1
      prefix: --targets
  - id: empirical_data
    type:
      - 'null'
      - File
    doc: File that contains empirical data provided by the user to assess 
      in-silico targets
    inputBinding:
      position: 1
      prefix: --empirical_data
  - id: output
    type: string
    doc: Output folder for the results (created in the working directory)
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder with the integrated target panel
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
