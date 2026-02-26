cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp_insilico-library
label: easypqp_insilico-library
doc: "Generate In-Silico Predicted Library\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: allowed_fragment_types
    type:
      - 'null'
      - string
    doc: Allowed fragment types. Current MS2 prediction model only supports b 
      and y ions.
    default: b,y
    inputBinding:
      position: 101
      prefix: --allowed_fragment_types
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size used for peptide property inferece.
    default: 10
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: config
    type:
      - 'null'
      - File
    doc: JSON configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: decoy_tag
    type:
      - 'null'
      - string
    doc: Decoy tag to be used for decoy generation.
    default: rev_
    inputBinding:
      position: 101
      prefix: --decoy_tag
  - id: enable_unannotated
    type:
      - 'null'
      - boolean
    doc: Keep mass brackets for modifications that cannot be matched to UniMod. 
      If disabled, raises an error for unmatched modifications.
    inputBinding:
      position: 101
      prefix: --enable_unannotated
  - id: fasta
    type:
      - 'null'
      - File
    doc: FASTA file with protein sequences. Overrides the FASTA file specified 
      in the config.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fine_tune
    type:
      - 'null'
      - boolean
    doc: Fine-tune the predictions models using the provided training data.
    inputBinding:
      position: 101
      prefix: --fine_tune
  - id: fragmentation_model
    type:
      - 'null'
      - string
    doc: 'Fragmentation model to be used for theoretical fragmentaton generation.
      Options are (etd/td_etd/ethcd/etcad/eacid/ead/hcd/cid/all/none). See: `[FragmentationModel](https://docs.rs/rustyms/latest/rustyms/model/struct.FragmentationModel.html#method.etd)`
      for more details.'
    default: hcd
    inputBinding:
      position: 101
      prefix: --fragmentation_model
  - id: generate_decoys
    type:
      - 'null'
      - boolean
    doc: Generate decoy library.
    inputBinding:
      position: 101
      prefix: --generate_decoys
  - id: instrument
    type:
      - 'null'
      - string
    doc: Instrument type. Options are (QE).
    default: QE/Lumos/timsTOF/SciexTOF/ThermoTOF
    inputBinding:
      position: 101
      prefix: --instrument
  - id: max_delta_unimod
    type:
      - 'null'
      - float
    doc: Maximum delta mass tolerance (in Da) for matching modifications to 
      UniMod entries.
    default: 0.02
    inputBinding:
      position: 101
      prefix: --max_delta_unimod
  - id: max_fragment_charge
    type:
      - 'null'
      - int
    doc: Maximum fragment charge state.
    default: 2
    inputBinding:
      position: 101
      prefix: --max_fragment_charge
  - id: max_transitions
    type:
      - 'null'
      - int
    doc: Maximum number of transitions per peptide.
    default: 6
    inputBinding:
      position: 101
      prefix: --max_transitions
  - id: min_transitions
    type:
      - 'null'
      - int
    doc: Minimum number of transitions per peptide.
    default: 6
    inputBinding:
      position: 101
      prefix: --min_transitions
  - id: nce
    type:
      - 'null'
      - int
    doc: Normalized collision energy (NCE) to be used for MS2 intensity 
      prediction.
    default: 20
    inputBinding:
      position: 101
      prefix: --nce
  - id: no_enable_unannotated
    type:
      - 'null'
      - boolean
    doc: Keep mass brackets for modifications that cannot be matched to UniMod. 
      If disabled, raises an error for unmatched modifications.
    inputBinding:
      position: 101
      prefix: --no-enable_unannotated
  - id: no_fine_tune
    type:
      - 'null'
      - boolean
    doc: Fine-tune the predictions models using the provided training data.
    inputBinding:
      position: 101
      prefix: --no-fine_tune
  - id: no_generate_decoys
    type:
      - 'null'
      - boolean
    doc: Generate decoy library.
    inputBinding:
      position: 101
      prefix: --no-generate_decoys
  - id: no_parquet_output
    type:
      - 'null'
      - boolean
    doc: Output library in Parquet format instead of TSV.
    inputBinding:
      position: 101
      prefix: --no-parquet_output
  - id: no_save_model
    type:
      - 'null'
      - boolean
    doc: Save the fine-tuned model to the specified path.
    inputBinding:
      position: 101
      prefix: --no-save_model
  - id: no_unimod_annotation
    type:
      - 'null'
      - boolean
    doc: Re-annotate mass bracket modifications (e.g., [+57.0215]) to UniMod 
      notation (e.g., (UniMod:4)).
    inputBinding:
      position: 101
      prefix: --no-unimod_annotation
  - id: no_write_report
    type:
      - 'null'
      - boolean
    doc: Generate HTML quality report.
    inputBinding:
      position: 101
      prefix: --no-write_report
  - id: parquet_output
    type:
      - 'null'
      - boolean
    doc: Output library in Parquet format instead of TSV.
    inputBinding:
      position: 101
      prefix: --parquet_output
  - id: precursor_charge
    type:
      - 'null'
      - string
    doc: Precursor charge states to be used for library generation.
    default: 2,3
    inputBinding:
      position: 101
      prefix: --precursor_charge
  - id: rt_scale
    type:
      - 'null'
      - float
    doc: RT output scaling factor (e.g., 100.0 to convert 0-1 range to 0-100).
    default: 100.0
    inputBinding:
      position: 101
      prefix: --rt_scale
  - id: save_model
    type:
      - 'null'
      - boolean
    doc: Save the fine-tuned model to the specified path.
    inputBinding:
      position: 101
      prefix: --save_model
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing. If not specified, uses all 
      available cores.
    inputBinding:
      position: 101
      prefix: --threads
  - id: train_data_path
    type:
      - 'null'
      - File
    doc: 'Path to the training data for fine-tuning. This should be a TSV file with
      columns: "sequence", "precursor_charge", "intensity", "retention_time", "ion_mobility"
      (Optional).'
    inputBinding:
      position: 101
      prefix: --train_data_path
  - id: unimod
    type:
      - 'null'
      - File
    doc: Custom UniMod XML database file for modification annotation.
    default: /usr/local/lib/python3.12/site-packages/easypqp/data/unimod.xml
    inputBinding:
      position: 101
      prefix: --unimod
  - id: unimod_annotation
    type:
      - 'null'
      - boolean
    doc: Re-annotate mass bracket modifications (e.g., [+57.0215]) to UniMod 
      notation (e.g., (UniMod:4)).
    inputBinding:
      position: 101
      prefix: --unimod_annotation
  - id: write_report
    type:
      - 'null'
      - boolean
    doc: Generate HTML quality report.
    inputBinding:
      position: 101
      prefix: --write_report
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for the generated library. Overrides the output directory 
      specified in the
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
