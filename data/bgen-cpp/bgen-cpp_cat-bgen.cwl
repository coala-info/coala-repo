cwlVersion: v1.2
class: CommandLineTool
baseCommand: cat-bgen
label: bgen-cpp_cat-bgen
doc: "Concatenate bgen files.\n\nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs:
  - id: bgen_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path of bgen file(s) to concatenate. These must all be bgen files 
      containing the same s- et of samples (in the same order). They must all be
      the same bgen version and be stored with the same flags.
    inputBinding:
      position: 101
      prefix: -g
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Specify that cat-bgen should overwrite existing output file if it 
      exists.
    inputBinding:
      position: 101
      prefix: -clobber
  - id: omit_sample_identifier_block
    type:
      - 'null'
      - boolean
    doc: Specify that cat-bgen should omit the sample identifier block in the 
      output, even if on- e is present in the first file specified to -og.
    inputBinding:
      position: 101
      prefix: -omit-sample-identifier-block
  - id: set_free_data
    type:
      - 'null'
      - string
    doc: Specify that cat-bgen should set free data in the resulting file to the
      given string va- lue.
    inputBinding:
      position: 101
      prefix: -set-free-data
outputs:
  - id: output_bgen_file
    type:
      - 'null'
      - File
    doc: Path of bgen file to output.
    outputBinding:
      glob: $(inputs.output_bgen_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
