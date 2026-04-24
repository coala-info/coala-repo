cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slow5tools
  - s2f
label: slow5tools_s2f
doc: "Convert SLOW5/BLOW5 files to FAST5 format.\n\nTool homepage: https://github.com/hasindu2008/slow5tools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: SLOW5_FILE/DIR
    inputBinding:
      position: 1
  - id: iop
    type:
      - 'null'
      - int
    doc: number of I/O processes [8]
    inputBinding:
      position: 102
      prefix: --iop
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output to directory
    inputBinding:
      position: 102
      prefix: --out-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to FILE [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
