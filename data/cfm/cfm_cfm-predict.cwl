cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm_predict.exe
label: cfm_cfm-predict
doc: "Predicts mass spectra for a given chemical structure.\n\nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs:
  - id: input_smiles_or_inchi_or_file
    type: string
    doc: The smiles or inchi string of the structure whose spectra you want to 
      predict, or a .txt file containing a list of <id smiles> pairs, one per 
      line.
    inputBinding:
      position: 1
  - id: prob_thresh_for_prune
    type: float
    doc: The probability below which to prune unlikely fragmentations
    inputBinding:
      position: 2
  - id: param_filename
    type: string
    doc: The filename where the parameters of a trained cfm model can be found 
      (if not given, assumes param_output.log in current directory)
    inputBinding:
      position: 3
  - id: config_filename
    type: string
    doc: The filename where the configuration parameters of the cfm model can be
      found (if not given, assumes param_config.txt in current directory)
    inputBinding:
      position: 4
  - id: include_annotations
    type: boolean
    doc: 'Whether to include fragment information in the output spectra (0 = NO (default),
      1 = YES ). Note: ignored for msp/mgf output.'
    inputBinding:
      position: 5
  - id: output_filename_or_dir
    type: string
    doc: The filename of the output spectra file to write to (if not given, 
      prints to stdout), OR directory if multiple smiles inputs are given (else 
      current directory) OR msp or mgf file.
    inputBinding:
      position: 6
  - id: apply_postprocessing
    type: boolean
    doc: Whether or not to post-process predicted spectra to take the top 80% of
      energy (at least 5 peaks), or the highest 30 peaks (whichever comes first)
      (0 = OFF, 1 = ON (default) ).
    inputBinding:
      position: 7
  - id: suppress_exception
    type:
      - 'null'
      - boolean
    doc: Suppress exceptions so that the program returns normally even when it 
      fails to produce a result (0 = OFF (default), 1 = ON).
    inputBinding:
      position: 108
      prefix: --suppress_exception
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
stdout: cfm_cfm-predict.out
