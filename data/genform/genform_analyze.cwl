cwlVersion: v1.2
class: CommandLineTool
baseCommand: genform
label: genform_analyze
doc: "Formula calculation from MS and MS/MS data as described in Meringer et al (2011)
  MATCH Commun Math Comput Chem 65: 259-290\n\nTool homepage: https://sourceforge.net/projects/genform/"
inputs:
  - id: accuracy_ppm
    type:
      - 'null'
      - float
    doc: 'accuracy of measurement in parts per million (default: 5)'
    default: 5
    inputBinding:
      position: 101
      prefix: ppm
  - id: allow_existing_formulas
    type:
      - 'null'
      - boolean
    doc: allow only molecular formulas for that at least one structural formula 
      exists;overrides vsp, vsm2mv, vsm2ap2; argument mv enables multiple 
      valencies for P and S
    inputBinding:
      position: 101
      prefix: exist
  - id: allow_multiple_valencies
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: exist=mv
  - id: allow_odd_electron_ions
    type:
      - 'null'
      - boolean
    doc: allow odd electron ions for explaining MS/MS peaks
    inputBinding:
      position: 101
      prefix: oei
  - id: analyze_msms_explanations
    type:
      - 'null'
      - boolean
    doc: write explanations for MS/MS peaks to output
    inputBinding:
      position: 101
      prefix: analyze
  - id: analyze_msms_intensities
    type:
      - 'null'
      - boolean
    doc: write intensities of MS/MS peaks to output
    inputBinding:
      position: 101
      prefix: analyze [intens]
  - id: analyze_msms_losses
    type:
      - 'null'
      - boolean
    doc: for analyzing MS/MS peaks write losses instead of fragments
    inputBinding:
      position: 101
      prefix: analyze [loss]
  - id: combined_match_threshold
    type:
      - 'null'
      - float
    doc: threshold for the combined match value
    inputBinding:
      position: 101
      prefix: thcomb
  - id: elements
    type:
      - 'null'
      - string
    doc: 'used chemical elements (default: CHBrClFINOPSSi)'
    default: CHBrClFINOPSSi
    inputBinding:
      position: 101
      prefix: el
  - id: excess_double_bond_equivalent
    type:
      - 'null'
      - float
    doc: excess of double bond equivalent for ions
    inputBinding:
      position: 101
      prefix: dbeexc
  - id: experimental_mass
    type:
      - 'null'
      - float
    doc: 'experimental molecular mass (default: mass of MS basepeak)'
    default: mass of MS basepeak
    inputBinding:
      position: 101
      prefix: m
  - id: exponent_for_log_weighting
    type:
      - 'null'
      - float
    doc: exponent used, when wi is set to log
    inputBinding:
      position: 101
      prefix: exp
  - id: fragment_valency_sum_minus_2_max_valency
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * maximum valency for fragment ions
    inputBinding:
      position: 101
      prefix: ivsm2mv
  - id: fragment_valency_sum_minus_2_num_atoms_plus_2
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * number of atoms + 2 for fragment ions
    inputBinding:
      position: 101
      prefix: ivsm2ap2
  - id: fuzzy_formula
    type:
      - 'null'
      - string
    doc: overwrites el and oc and uses fuzzy formula for limits of element 
      multiplicities
    inputBinding:
      position: 101
      prefix: ff
  - id: heteroatom_formulas
    type:
      - 'null'
      - boolean
    doc: formulas must have at least one hetero atom
    inputBinding:
      position: 101
      prefix: het
  - id: heuerding_clerc_filter
    type:
      - 'null'
      - boolean
    doc: apply Heuerding-Clerc filter
    inputBinding:
      position: 101
      prefix: hcf
  - id: hide_reference_information
    type:
      - 'null'
      - boolean
    doc: hide the reference information
    inputBinding:
      position: 101
      prefix: noref
  - id: intensity_weighting_msms
    type:
      - 'null'
      - string
    doc: intensity weighting for MS/MS match value
    inputBinding:
      position: 101
      prefix: wi
  - id: ion_type
    type:
      - 'null'
      - string
    doc: 'type of ion measured (default: M+H)'
    default: M+H
    inputBinding:
      position: 101
      prefix: ion
  - id: ms_file
    type: File
    doc: filename of MS data (*.txt)
    inputBinding:
      position: 101
      prefix: ms
  - id: ms_match_threshold
    type:
      - 'null'
      - float
    doc: threshold for the MS match value
    inputBinding:
      position: 101
      prefix: thms
  - id: ms_match_value_method
    type:
      - 'null'
      - string
    doc: 'MS match value based on normalized dot product, normalized sum of squared
      or absolute errors (default: nsae)'
    default: nsae
    inputBinding:
      position: 101
      prefix: msmv
  - id: msms_acceptance_deviation_ppm
    type:
      - 'null'
      - float
    doc: 'allowed deviation for full acceptance of MS/MS peak in ppm (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: acc
  - id: msms_file
    type:
      - 'null'
      - File
    doc: filename of MS/MS data (*.txt)
    inputBinding:
      position: 101
      prefix: msms
  - id: msms_match_threshold
    type:
      - 'null'
      - float
    doc: threshold for the MS/MS match value
    inputBinding:
      position: 101
      prefix: thmsms
  - id: msms_rejection_deviation_ppm
    type:
      - 'null'
      - float
    doc: 'allowed deviation for total rejection of MS/MS peak in ppm (default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: rej
  - id: mz_weighting_msms
    type:
      - 'null'
      - string
    doc: m/z weighting for MS/MS match value
    inputBinding:
      position: 101
      prefix: wm
  - id: only_organic_compounds
    type:
      - 'null'
      - boolean
    doc: only organic compounds, i.e. with at least one C atom
    inputBinding:
      position: 101
      prefix: oc
  - id: output_calculated_ion_masses
    type:
      - 'null'
      - boolean
    doc: write calculated ion masses to output
    inputBinding:
      position: 101
      prefix: cm
  - id: output_double_bond_equivalents
    type:
      - 'null'
      - boolean
    doc: write double bond equivalents to output
    inputBinding:
      position: 101
      prefix: dbe
  - id: output_match_values_in_percent
    type:
      - 'null'
      - boolean
    doc: output match values in percent
    inputBinding:
      position: 101
      prefix: pc
  - id: sort_by
    type:
      - 'null'
      - string
    doc: sort generated formulas according to mass deviation in ppm, MS match 
      value, MS/MS match value or combined match value
    inputBinding:
      position: 101
      prefix: sort
  - id: strip_calculated_isotope_distributions
    type:
      - 'null'
      - boolean
    doc: strip calculated isotope distributions
    inputBinding:
      position: 101
      prefix: sc
  - id: valency_sum_minus_2_max_valency
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * maximum valency (>=0 for graphical 
      formulas)
    inputBinding:
      position: 101
      prefix: vsm2mv
  - id: valency_sum_minus_2_num_atoms_plus_2
    type:
      - 'null'
      - float
    doc: lower bound for valency sum - 2 * number of atoms + 2 (>=0 for 
      graphical connected formulas)
    inputBinding:
      position: 101
      prefix: vsm2ap2
  - id: valency_sum_parity
    type:
      - 'null'
      - string
    doc: valency sum parity (even for graphical formulas)
    inputBinding:
      position: 101
      prefix: vsp
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output generated formulas
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_scaled_ms
    type:
      - 'null'
      - File
    doc: write scaled MS peaks to output
    outputBinding:
      glob: $(inputs.output_scaled_ms)
  - id: output_weighted_msms
    type:
      - 'null'
      - File
    doc: write weighted MS/MS peaks to output
    outputBinding:
      glob: $(inputs.output_weighted_msms)
  - id: output_cleaned_msms
    type:
      - 'null'
      - File
    doc: write explained MS/MS peaks to output
    outputBinding:
      glob: $(inputs.output_cleaned_msms)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genform:r8--h9948957_8
