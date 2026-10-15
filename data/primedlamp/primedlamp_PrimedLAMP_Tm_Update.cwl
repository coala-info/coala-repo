cwlVersion: v1.2
class: CommandLineTool
baseCommand: PrimedLAMP_Tm_Update
label: primedlamp_PrimedLAMP_Tm_Update
doc: "Recalculate melting temperatures of the oligo sites of a prior PrimedLAMP run with new salt and oligo concentrations.\n\nTool homepage: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA"
inputs:
  - id: run_id
    type: string
    doc: "Desired Run ID"
    inputBinding:
      position: 1
      prefix: --RunID
  - id: prior_oligo_sites
    type: File
    doc: "Path to Prior Generated Oligo Sites"
    inputBinding:
      position: 1
      prefix: --PriorOligoSites
  - id: monovalent_salt_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --MonovalentSaltConc
  - id: divalent_salt_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --DivalentSaltConc
  - id: d_ntp_conc
    type:
      - 'null'
      - float
    doc: "Millimolar Concentration (10^-3)"
    inputBinding:
      position: 1
      prefix: --dNTPConc
  - id: oligo_conc
    type:
      - 'null'
      - string
    doc: "Micromolar Concentration (10^-6)"
    inputBinding:
      position: 1
      prefix: --OligoConc
  - id: oligo_conc_pair
    type:
      - 'null'
      - string
    doc: "Leave as Default"
    inputBinding:
      position: 1
      prefix: --OligoConcPair
  - id: threads
    type:
      - 'null'
      - int
    doc: "Default Set To 1"
    inputBinding:
      position: 1
      prefix: --Threads
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result tables written with the run ID as prefix
    outputBinding:
      glob: $(inputs.run_id)_*.csv
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primedlamp:1.0.1--py_0
stdout: primedlamp_PrimedLAMP_Tm_Update.out
