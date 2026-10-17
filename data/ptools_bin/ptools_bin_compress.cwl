cwlVersion: v1.2
class: CommandLineTool
baseCommand: compress
label: ptools_bin_compress
doc: "Compress a raw file (for example a diff text from createDiff) with zlib level 9.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs:
  - id: raw_file
    type: File
    doc: Raw file to compress
    inputBinding:
      position: 1
  - id: out_name
    type: string
    doc: Name of the compressed output file
    inputBinding:
      position: 2
outputs:
  - id: compressed_file
    type: File
    doc: Compressed file
    outputBinding:
      glob: $(inputs.out_name)
  - id: size_log
    type: stdout
    doc: Raw and compressed sizes printed by the tool
stdout: compress.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
