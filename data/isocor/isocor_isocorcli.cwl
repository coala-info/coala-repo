cwlVersion: v1.2
class: CommandLineTool
baseCommand: isocorcli
label: isocor_isocorcli
doc: "Correction of mass spectrometry data for naturally occurring isotopes.\n\nTool
  homepage: https://github.com/MetaSys-LISBP/IsoCor/"
inputs:
  - id: inputdata
    type: File
    doc: Measurements file to process.
    inputBinding:
      position: 100
  - id: metabolites_db
    type: ['null', File]
    doc: Path to the metabolites database (default Metabolites.dat in the working directory).
    inputBinding:
      position: 1
      prefix: -M
  - id: derivatives_db
    type: ['null', File]
    doc: Path to the derivatives database (default Derivatives.dat in the working directory).
    inputBinding:
      position: 2
      prefix: -D
  - id: isotopes_db
    type: ['null', File]
    doc: Path to the isotopes database (default Isotopes.dat in the working directory).
    inputBinding:
      position: 3
      prefix: -I
  - id: tracer
    type: string
    doc: The isotopic tracer (e.g. "13C").
    inputBinding:
      position: 4
      prefix: --tracer
  - id: resolution
    type: ['null', float]
    doc: 'High resolution only: resolution of the mass spectrometer (e.g. 1e4).'
    inputBinding:
      position: 5
      prefix: --resolution
  - id: mz_of_resolution
    type: ['null', float]
    doc: 'High resolution only: mz at which the resolution is given (e.g. 400).'
    inputBinding:
      position: 6
      prefix: --mz_of_resolution
  - id: resolution_formula_code
    type:
      - 'null'
      - type: enum
        symbols:
          - orbitrap
          - ft-icr
          - constant
          - datafile
    doc: 'High resolution only: spectrometer formula code.'
    inputBinding:
      position: 7
      prefix: --resolution_formula_code
  - id: tracer_purity
    type: ['null', string]
    doc: Purity vector of the tracer, comma separated (e.g. "0.01,0.99").
    inputBinding:
      position: 8
      prefix: --tracer_purity
  - id: correct_na_tracer
    type: ['null', boolean]
    doc: Correct the natural abundance of the tracer.
    inputBinding:
      position: 9
      prefix: --correct_NA_tracer
  - id: verbose
    type: ['null', boolean]
    doc: Enable verbose logs.
    inputBinding:
      position: 10
      prefix: --verbose
outputs:
  - id: corrected_table
    type: stdout
    doc: Tab-separated table of corrected isotopologue data (written to standard output).
stdout: isocor_corrected.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isocor:2.2.2--pyhdfd78af_0
