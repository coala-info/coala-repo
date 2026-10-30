cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrast_filter.rb
label: protk_spectrast_filter.rb
doc: 'Manipulate splib files.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: splib_files
    type:
      type: array
      items: File
    doc: Input splib files (their .pepidx and .spidx index files must sit beside them; they are staged
      in the working directory)
    secondaryFiles:
      - pattern: ^.pepidx
        required: false
      - pattern: ^.spidx
        required: false
    inputBinding:
      position: 1
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Produce spectral libraries in binary format rather than ASCII [false]
    inputBinding:
      position: 102
      prefix: --binary-output
  - id: predicate
    type:
      - 'null'
      - string
    doc: Keep only spectra satifying predicate pred. Should be a C-style predicate
    inputBinding:
      position: 102
      prefix: --predicate
  - id: merge
    type:
      - 'null'
      - string
    doc: How to combine multiple splib files (if provided). Options are U (union), S (subtraction), H
      (subtraction of homologs), A (appending) [U]
    inputBinding:
      position: 102
      prefix: --merge
  - id: replicates
    type:
      - 'null'
      - string
    doc: How to derive a single spectrum from replicates. Options are None, C (consensus), B (best replicate)
      [None]
    inputBinding:
      position: 102
      prefix: --replicates
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: library_files
    type:
      type: array
      items: File
    doc: Filtered spectral library files
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.splib_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
