cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconvert
  - bplink2plink
label: bioconvert_bplink2plink
doc: "Convert file from '('BPLINK',)' to '('PLINK',)' format. See bioconvert.readthedocs.io
  for details\n\nTool homepage: http://bioconvert.readthedocs.io/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The path to the file to convert.
    default: None
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - File
    doc: The path where the result will be stored.
    default: None
    inputBinding:
      position: 2
  - id: allow_indirect_conversion
    type:
      - 'null'
      - boolean
    doc: Allow to chain converter when direct conversion is absent
    default: false
    inputBinding:
      position: 103
      prefix: --allow-indirect-conversion
  - id: batch
    type:
      - 'null'
      - boolean
    doc: "Allow conversion of a set of files using wildcards. You must use quotes
      to escape the wildcards. For instance: --batch 'test*fastq'"
    default: false
    inputBinding:
      position: 103
      prefix: --batch
  - id: benchmark
    type:
      - 'null'
      - boolean
    doc: Running all available methods
    default: false
    inputBinding:
      position: 103
      prefix: --benchmark
  - id: benchmark_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Methods to include. Provide list as space-separated method names. Use 
      -s to get the full list.
    default: all
    inputBinding:
      position: 103
      prefix: --benchmark-methods
  - id: benchmark_mode
    type:
      - 'null'
      - string
    doc: Set the mode of the benchmark, which can be time, CPU or memory. 
      Defaults to time)
    default: time
    inputBinding:
      position: 103
      prefix: --benchmark-mode
  - id: benchmark_n
    type:
      - 'null'
      - int
    doc: Number of trials for each methods
    default: 5
    inputBinding:
      position: 103
      prefix: --benchmark-N
  - id: benchmark_save_image
    type:
      - 'null'
      - boolean
    doc: Save results as an image (using the same tag as from --benchmark-tag)
    default: false
    inputBinding:
      position: 103
      prefix: --benchmark-save-image
  - id: benchmark_tag
    type:
      - 'null'
      - string
    doc: Save results (json and image) named after this tag. You may include sub
      directories
    default: bioconvert
    inputBinding:
      position: 103
      prefix: --benchmark-tag
  - id: extra_arguments
    type:
      - 'null'
      - string
    doc: Any arguments accepted by the method's tool
    default: ''
    inputBinding:
      position: 103
      prefix: --extra-arguments
  - id: force
    type:
      - 'null'
      - boolean
    doc: if outfile exists, it is overwritten with this option
    default: false
    inputBinding:
      position: 103
      prefix: --force
  - id: method
    type:
      - 'null'
      - string
    doc: The method to use to do the conversion.
    default: plink
    inputBinding:
      position: 103
      prefix: --method
  - id: raise_exception
    type:
      - 'null'
      - boolean
    doc: Let exception ending the execution be raised and displayed
    default: false
    inputBinding:
      position: 103
      prefix: --raise-exception
  - id: show_methods
    type:
      - 'null'
      - boolean
    doc: A converter may have several methods
    default: false
    inputBinding:
      position: 103
      prefix: --show-methods
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set the outpout verbosity.
    default: ERROR
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
stdout: bioconvert_bplink2plink.out
