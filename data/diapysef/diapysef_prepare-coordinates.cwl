cwlVersion: v1.2
class: CommandLineTool
baseCommand: diapysef prepare-coordinates
label: diapysef_prepare-coordinates
doc: "Generate peptide coordinates for targeted extraction of DIA-PASEF data\n\nTool
  homepage: https://github.com/Roestlab/dia-pasef"
inputs:
  - id: in_file
    type: File
    doc: An OSW file post Pyprophet statiscal validation.
    inputBinding:
      position: 101
      prefix: --in
  - id: log_file
    type:
      - 'null'
      - string
    doc: Log file to save console messages.
    default: mobidik_peptide_coordinate_generation.log
    inputBinding:
      position: 101
      prefix: --log_file
  - id: m_score
    type:
      - 'null'
      - float
    doc: QValue to filter for peptides below QValue, generate coordinates for 
      these peptides.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --m_score
  - id: no_use_only_detecting_transitions
    type:
      - 'null'
      - boolean
    doc: Only include product m/z of detecting transitions. i.e do not use 
      identifying transitions.
    inputBinding:
      position: 101
      prefix: --no-use_only_detecting_transitions
  - id: no_use_transition_peptide_mapping
    type:
      - 'null'
      - boolean
    doc: Use the TRANSITION_PEPTIDE_MAPPING when getting PRODUCT MZ, instead of 
      joining on TRANSITION_PRECURSOR_MAPPING.
    default: true
    inputBinding:
      position: 101
      prefix: --no-use_transition_peptide_mapping
  - id: run_id
    type:
      - 'null'
      - int
    doc: Run id in OSW file corresponding to DIA-PASEF run. Required if your OSW
      file is a merged OSW file.
    inputBinding:
      position: 101
      prefix: --run_id
  - id: target_peptides
    type:
      - 'null'
      - string
    doc: list of peptides (ModifiedPeptideSequence) to generate coordinates for.
      i.e. ["T(UniMod:21)ELISVSEVHPSR", "TELIS(UniMod:21)VSEVHPSR"]. You can 
      alternatively pass a text file containing comma separate peptide 
      sequences.
    inputBinding:
      position: 101
      prefix: --target_peptides
  - id: use_only_detecting_transitions
    type:
      - 'null'
      - boolean
    doc: Only include product m/z of detecting transitions. i.e do not use 
      identifying transitions.
    default: true
    inputBinding:
      position: 101
      prefix: --use_only_detecting_transitions
  - id: use_transition_peptide_mapping
    type:
      - 'null'
      - boolean
    doc: Use the TRANSITION_PEPTIDE_MAPPING when getting PRODUCT MZ, instead of 
      joining on TRANSITION_PRECURSOR_MAPPING.
    inputBinding:
      position: 101
      prefix: --use_transition_peptide_mapping
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level of verbosity. 0 - just displays info, 1 - display some debug 
      info, 10 displays a lot of debug info.
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Filename to save pickle of peptide coordinates.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
