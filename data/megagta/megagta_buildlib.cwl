cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - buildlib
label: megagta_buildlib
doc: "Build a read library from a read library list file. The list file has one
  name line followed by a line such as 'pe reads_1.fq reads_2.fq', 'se reads.fq'
  or 'interleaved reads.fq' for each library.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.read_files)
inputs:
  - id: read_lib_file
    type: File
    doc: Read library list file
    inputBinding:
      position: 1
  - id: out_prefix
    type: string
    doc: Output prefix; writes <out_prefix>.bin and <out_prefix>.lib_info
    inputBinding:
      position: 2
  - id: read_files
    type:
      type: array
      items: File
    doc: Read files named in the library list file, staged in the working
      directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_prefix_files
    type:
      type: array
      items: File
    doc: Library files written with the prefix given in out_prefix
    outputBinding:
      glob:
        - $(inputs.out_prefix).bin
        - $(inputs.out_prefix).lib_info
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_buildlib.out
