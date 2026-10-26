cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pirsr
label: unifire_pirsr
doc: "PIRSR: runs hmmalign of the PIRSR site rule HMMs on the proteins of an InterProScan
  XML (or fact XML) file and writes an enhanced facts XML for unifire.\n\nTool homepage:
  https://github.com/cmatKhan/unifire/"
inputs:
  - id: pirsr_data_dir
    type: Directory
    doc: Directory for PIRSR data
    inputBinding:
      position: 1
      prefix: --pirsr_data_dir
  - id: input_file
    type: File
    doc: Input file (path) containing the proteins to annotate and required data
      in InterProScan Output XML format.
    inputBinding:
      position: 2
      prefix: --input_file
  - id: output_dir
    type: string
    doc: Directory for SRHMM hmmalign result and enhanced IPRScan Facts XML file.
    inputBinding:
      position: 3
      prefix: --output_dir
  - id: hmmalign
    type: ['null', string]
    doc: Path to hmmalign command (not needed; hmmalign is provided in the image).
    inputBinding:
      position: 4
      prefix: --hmmalign
  - id: input_type
    type: ['null', string]
    doc: "Type of the input file: InterProScan (InterProScan Output XML) or XML (Input
      Fact XML) (default: InterProScan)"
    inputBinding:
      position: 5
      prefix: --input_type
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the hmmalign results and the enhanced facts XML
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifire:1.0.1--hdfd78af_0
