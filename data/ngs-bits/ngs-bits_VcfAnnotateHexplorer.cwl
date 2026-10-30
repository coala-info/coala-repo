cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateHexplorer
label: ngs-bits_VcfAnnotateHexplorer
doc: "Annotates a VCF with Hexplorer and HBond scores.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input VCF file. If unset, reads from STDIN."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_path
    type: string
    doc: "Output VCF file containing HEXplorer and HBOND scores in the INFO column."
    inputBinding:
      position: 2
      prefix: -out
  - id: ref
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA file. If unset 'reference_genome' from the 'settings.ini' file is used."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 3
      prefix: -ref
  - id: settings_file
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 4
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output VCF file containing HEXplorer and HBOND scores in the INFO column."
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
