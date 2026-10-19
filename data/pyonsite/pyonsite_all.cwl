cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - onsite
  - all
label: pyonsite_all
doc: "Run all three algorithms (AScore, PhosphoRS, LucXor) and merge results.\n\nTool homepage: https://www.github.com/bigbio/onsite"
inputs:
  - id: in_file
    type: File
    doc: Input mzML file path
    inputBinding:
      position: 1
      prefix: -in
  - id: id_file
    type: File
    doc: Input idXML file path
    inputBinding:
      position: 2
      prefix: -id
  - id: out_file
    type: string
    doc: Output idXML file path
    inputBinding:
      position: 3
      prefix: -out
  - id: fragment_mass_tolerance
    type: ['null', float]
    doc: 'Fragment mass tolerance value (default: 0.05)'
    inputBinding:
      position: 4
      prefix: --fragment-mass-tolerance
  - id: fragment_mass_unit
    type:
      - 'null'
      - type: enum
        symbols: [Da, ppm]
    doc: 'Tolerance unit (default: Da)'
    inputBinding:
      position: 5
      prefix: --fragment-mass-unit
  - id: threads
    type: ['null', int]
    doc: 'Number of parallel threads (default: 1)'
    inputBinding:
      position: 6
      prefix: --threads
  - id: debug
    type: ['null', boolean]
    doc: Enable debug output and write debug log
    inputBinding:
      position: 7
      prefix: --debug
  - id: add_decoys
    type: ['null', boolean]
    doc: Include A (PhosphoDecoy) as potential phosphorylation site
    inputBinding:
      position: 8
      prefix: --add-decoys
outputs:
  - id: output_file
    type: File
    doc: Output idXML file with localization scores
    outputBinding:
      glob: $(inputs.out_file)
  - id: debug_log
    type: ['null', 'File[]']
    doc: Debug log files written when --debug is set
    outputBinding:
      glob: '*.log'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
