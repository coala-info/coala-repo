cwlVersion: v1.2
class: CommandLineTool
baseCommand: muspinsim
label: muspinsim
doc: MuSpinSim - A program designed to carry out spin dynamics calculations for 
  muon science experiments
inputs:
  - id: input_file
    type: File
    doc: Path to file specifying simulation input parameters. For formatting and
      keywords, see 
      https://muon-spectroscopy-computational-project.github.io/muspinsim/input/.
    inputBinding:
      position: 1
  - id: fit_report_path
    type:
      - 'null'
      - string
    doc: Filepath to store fit report if fitting parameters given
    inputBinding:
      position: 102
      prefix: --fit-report-path
  - id: log_path
    type:
      - 'null'
      - string
    doc: Filepath to store simulation logs
    inputBinding:
      position: 102
      prefix: --log-path
  - id: out_dir
    type:
      - 'null'
      - string
    doc: Folder to store the output .dat files
    inputBinding:
      position: 102
      prefix: --out-dir
outputs:
  - id: output_fit_report_path
    type:
      - 'null'
      - File
    doc: Filepath to store fit report if fitting parameters given
    outputBinding:
      glob: $(inputs.fit_report_path)
  - id: output_log_path
    type:
      - 'null'
      - File
    doc: Filepath to store simulation logs
    outputBinding:
      glob: $(inputs.log_path)
  - id: output_out_dir
    type:
      - 'null'
      - Directory
    doc: Folder to store the output .dat files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muspinsim:2.3.0
s:url: https://github.com/muon-spectroscopy-computational-project/muspinsim
$namespaces:
  s: https://schema.org/
