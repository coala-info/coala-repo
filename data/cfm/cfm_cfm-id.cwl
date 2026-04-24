cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm-id.exe
label: cfm_cfm-id
doc: "Predicts candidate structures for a given spectrum and list of candidates.\n\
  \nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs:
  - id: spectrum_file
    type: File
    doc: The filename where the input spectra can be found. This can be a .msp 
      file in which the desired spectrum is listed under a corresponding id 
      (next arg). Or it could be a single file with a list of peaks 'mass 
      intensity' delimited by lines, with either 'low','med' and 'high' lines 
      beginning spectra of different energy levels, or 'energy0', 'energy1', 
      etc.
    inputBinding:
      position: 1
  - id: id
    type: string
    doc: An identifier for the target molecule (Used to retrieve input spectrum 
      from msp (if used). Otherwise not used but printed to output, in case of 
      multiple concatenated results)
    inputBinding:
      position: 2
  - id: candidate_file
    type: File
    doc: The filename where the input list of candidate structures can be found 
      - line separated 'id smiles_or_inchi' pairs.
    inputBinding:
      position: 3
  - id: num_highest
    type:
      - 'null'
      - int
    doc: The number of (ranked) candidates to return or -1 for all (if not 
      given, returns all in ranked order)
    inputBinding:
      position: 4
  - id: ppm_mass_tol
    type:
      - 'null'
      - float
    doc: The mass tolerance in ppm to use when matching peaks within the dot 
      product comparison - will use higher resulting tolerance of ppm and abs 
      (if not given defaults to 10ppm)
    inputBinding:
      position: 5
  - id: abs_mass_tol
    type:
      - 'null'
      - float
    doc: The mass tolerance in abs Da to use when matching peaks within the dot 
      product comparison - will use higher resulting tolerance of ppm and abs ( 
      if not given defaults to 0.01Da)
    inputBinding:
      position: 6
  - id: prob_thresh_for_prune
    type:
      - 'null'
      - float
    doc: The probabiltiy threshold at which to prune unlikely fragmnetations 
      (default 0.001)
    inputBinding:
      position: 7
  - id: param_filename
    type:
      - 'null'
      - File
    doc: The filename where the parameters of a trained cfm model can be found 
      (if not given, assumes param_output.log in current directory)
    inputBinding:
      position: 8
  - id: config_filename
    type:
      - 'null'
      - File
    doc: The filename where the configuration parameters of the cfm model can be
      found (if not given, assumes param_config.txt in current directory)
    inputBinding:
      position: 9
  - id: score_type
    type:
      - 'null'
      - string
    doc: 'The type of scoring function to use when comparing spectra. Options: Jaccard
      (default for ESI-MS/MS), DotProduct (default for EI-MS)'
    inputBinding:
      position: 10
  - id: apply_postprocessing
    type:
      - 'null'
      - boolean
    doc: Whether or not to post-process predicted spectra to take the top 80% of
      energy (at least 5 peaks), or the highest 30 peaks (whichever comes first)
      (0 = OFF (default for EI-MS), 1 = ON (default for ESI-MS/MS)).
    inputBinding:
      position: 11
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: The filename of the output file to write to (if not given, prints to 
      stdout)
    outputBinding:
      glob: '*.out'
  - id: output_msp_or_mgf
    type:
      - 'null'
      - File
    doc: The filename for an output msp or mgf file to record predicted 
      candidate spectra (if not given, doesn't save predicted spectra)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
