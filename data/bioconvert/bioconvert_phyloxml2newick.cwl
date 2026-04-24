cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioconvert
  - phyloxml2newick
label: bioconvert_phyloxml2newick
doc: "Convert file from '('PHYLOXML',)' to '('NEWICK',)' format. See bioconvert.readthedocs.io
  for details\n\nTool homepage: http://bioconvert.readthedocs.io/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The path to the file to convert.
    inputBinding:
      position: 1
  - id: allow_indirect_conversion
    type:
      - 'null'
      - boolean
    doc: Allow to chain converter when direct conversion is absent
    inputBinding:
      position: 102
      prefix: --allow-indirect-conversion
  - id: batch
    type:
      - 'null'
      - boolean
    doc: "Allow conversion of a set of files using wildcards. You must use quotes
      to escape the wildcards. For instance: --batch 'test*fastq'"
    inputBinding:
      position: 102
      prefix: --batch
  - id: benchmark
    type:
      - 'null'
      - boolean
    doc: Running all available methods
    inputBinding:
      position: 102
      prefix: --benchmark
  - id: benchmark_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Methods to include. Provide list as space-separated method names. Use 
      -s to get the full list.
    inputBinding:
      position: 102
      prefix: --benchmark-methods
  - id: benchmark_mode
    type:
      - 'null'
      - string
    doc: Set the mode of the benchmark, which can be time, CPU or memory. 
      Defaults to time)
    inputBinding:
      position: 102
      prefix: --benchmark-mode
  - id: benchmark_n
    type:
      - 'null'
      - int
    doc: Number of trials for each methods
    inputBinding:
      position: 102
      prefix: --benchmark-N
  - id: benchmark_save_image
    type:
      - 'null'
      - boolean
    doc: Save results as an image (using the same tag as from --benchmark-tag)
    inputBinding:
      position: 102
      prefix: --benchmark-save-image
  - id: benchmark_tag
    type:
      - 'null'
      - string
    doc: Save results (json and image) named after this tag. You may include sub
      directories
    inputBinding:
      position: 102
      prefix: --benchmark-tag
  - id: extra_arguments
    type:
      - 'null'
      - string
    doc: Any arguments accepted by the method's tool
    inputBinding:
      position: 102
      prefix: --extra-arguments
  - id: force
    type:
      - 'null'
      - boolean
    doc: if outfile exists, it is overwritten with this option
    inputBinding:
      position: 102
      prefix: --force
  - id: method
    type:
      - 'null'
      - string
    doc: The method to use to do the conversion.
    inputBinding:
      position: 102
      prefix: --method
  - id: raise_exception
    type:
      - 'null'
      - boolean
    doc: Let exception ending the execution be raised and displayed
    inputBinding:
      position: 102
      prefix: --raise-exception
  - id: show_methods
    type:
      - 'null'
      - boolean
    doc: A converter may have several methods
    inputBinding:
      position: 102
      prefix: --show-methods
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set the outpout verbosity.
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The path where the result will be stored.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconvert:1.1.1--pyhdfd78af_3
