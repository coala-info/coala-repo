cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RNAparconv
label: viennarna_RNAparconv
doc: |-
  Convert energy parameter files from ViennaRNA 1.8.4 to 2.0 format.

  Tool homepage: https://www.tbi.univie.ac.at/RNA/
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 10
      prefix: --verbose
  - id: input
    type:
      - 'null'
      - File
    doc: Specify an input file name. If argument is missing the energy parameter input can be supplied
      via 'stdin'.
    inputBinding:
      position: 10
      prefix: --input=
      separate: false
  - id: output
    type:
      - 'null'
      - string
    doc: Specify an output file name. If argument is missing the converted energy parameters are printed
      to 'stdout'.
    inputBinding:
      position: 10
      prefix: --output=
      separate: false
  - id: vanilla
    type:
      - 'null'
      - boolean
    doc: Print just as much as needed to represent the given energy parameters data set. This option overrides
      all other output settings!
    inputBinding:
      position: 10
      prefix: --vanilla
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Just dump Vienna 1.8.4 energy parameters in format used since 2.0. This option skips any energy
      parameter input!
    inputBinding:
      position: 10
      prefix: --dump
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print just energy parameters and appropriate comment lines but suppress all other output
    inputBinding:
      position: 10
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output of the program
  - id: converted_parameters
    type:
      - 'null'
      - File
    doc: Converted energy parameter file written with --output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viennarna:2.7.2--py310pl5321haba5358_0
stdout: RNAparconv.out
s:url: https://www.tbi.univie.ac.at/RNA/
$namespaces:
  s: https://schema.org/
