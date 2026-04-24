cwlVersion: v1.2
class: CommandLineTool
baseCommand: mokapot
label: mokapot
doc: "mokapot version 0.10.0.\nWritten by William E. Fondrie (wfondrie@talus.bio)
  while in the\nDepartment of Genome Sciences at the University of Washington.\n\n\
  Official code website: https://github.com/wfondrie/mokapot\n\nMore documentation
  and examples: https://mokapot.readthedocs.io\n\nTool homepage: https://github.com/wfondrie/mokapot"
inputs:
  - id: psm_files
    type:
      type: array
      items: File
    doc: "A collection of PSMs in the Percolator tab-delimited\nor PepXML format."
    inputBinding:
      position: 1
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: "If used, PSMs from multiple PIN files will be\naggregated and analyzed together.
      Otherwise, a joint\nmodel will be trained, but confidence estimates will\nbe
      calculated separately for each PIN file. This flag\nonly has an effect when
      multiple PIN files are\nprovided."
    inputBinding:
      position: 102
      prefix: --aggregate
  - id: clip_nterm_methionine
    type:
      - 'null'
      - boolean
    doc: "Remove methionine residues that occur at the protein\nN-terminus."
    inputBinding:
      position: 102
      prefix: --clip_nterm_methionine
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: "The prefix used to indicate a decoy protein in the\nFASTA file. For mokapot
      to provide accurate confidence\nestimates, decoy proteins should have same description\n\
      as the target proteins they were generated from, but\nthis string prepended."
    inputBinding:
      position: 102
      prefix: --decoy_prefix
  - id: dest_dir
    type:
      - 'null'
      - Directory
    doc: "The directory in which to write the result files.\nDefaults to the current
      working directory"
    inputBinding:
      position: 102
      prefix: --dest_dir
  - id: direction
    type:
      - 'null'
      - string
    doc: "The name of the feature to use as the initial\ndirection for ranking PSMs.
      The default automatically\nselects the feature that finds the most PSMs below
      the\n`train_fdr`."
    inputBinding:
      position: 102
      prefix: --direction
  - id: enzyme
    type:
      - 'null'
      - string
    doc: "A regular expression defining the enzyme specificity.\nThe cleavage site
      is interpreted as the end of the\nmatch. The default is trypsin, without proline\n\
      suppression: [KR]"
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: file_root
    type:
      - 'null'
      - string
    doc: The prefix added to all file names.
    inputBinding:
      position: 102
      prefix: --file_root
  - id: folds
    type:
      - 'null'
      - int
    doc: "The number of cross-validation folds to use. PSMs\noriginating from the
      same mass spectrum are always in\nthe same fold."
    inputBinding:
      position: 102
      prefix: --folds
  - id: keep_decoys
    type:
      - 'null'
      - boolean
    doc: Keep the decoys in the output .txt files
    inputBinding:
      position: 102
      prefix: --keep_decoys
  - id: load_models
    type:
      - 'null'
      - type: array
        items: File
    doc: "Load previously saved models and skip model\ntraining.Note that the number
      of models must match the\nvalue of --folds."
    inputBinding:
      position: 102
      prefix: --load_models
  - id: max_iter
    type:
      - 'null'
      - int
    doc: The number of iterations to use for training.
    inputBinding:
      position: 102
      prefix: --max_iter
  - id: max_length
    type:
      - 'null'
      - int
    doc: The maximum peptide length to consider.
    inputBinding:
      position: 102
      prefix: --max_length
  - id: max_workers
    type:
      - 'null'
      - int
    doc: "The number of processes to use for model training.\nNote that using more
      than one worker will result in\ngarbled logging messages."
    inputBinding:
      position: 102
      prefix: --max_workers
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum peptide length to consider.
    inputBinding:
      position: 102
      prefix: --min_length
  - id: missed_cleavages
    type:
      - 'null'
      - int
    doc: The allowed number of missed cleavages
    inputBinding:
      position: 102
      prefix: --missed_cleavages
  - id: open_modification_bin_size
    type:
      - 'null'
      - float
    doc: "This parameter only affect reading PSMs from PepXML\nfiles. If specified,
      modification masses are binned\naccording to the value. The binned mass difference
      is\nappended to the end of the peptide and will be used\nwhen grouping peptides
      for peptide-level confidence\nestimation. Using this option for open modification\n\
      search results. We recommend 0.01 as a good starting\npoint."
    inputBinding:
      position: 102
      prefix: --open_modification_bin_size
  - id: override
    type:
      - 'null'
      - boolean
    doc: "Use the learned model even if it performs worse than\nthe best feature."
    inputBinding:
      position: 102
      prefix: --override
  - id: plugin
    type:
      - 'null'
      - type: array
        items: string
    doc: The names of the plugins to use.
    inputBinding:
      position: 102
      prefix: --plugin
  - id: proteins
    type:
      - 'null'
      - File
    doc: "The FASTA file used for the database search. Using\nthis option enable protein-level
      confidence estimates\nusing the 'picked-protein' approach. Note that the\nFASTA
      file must contain both target and decoy\nsequences. Additionally, verify that
      the '--enzyme',\n'--missed_cleavages, '--min_length', '--max_length',\n'--semi',
      '--clip_nterm_methionine', and '--\ndecoy_prefix' parameters match your search
      engine\nconditions."
    inputBinding:
      position: 102
      prefix: --proteins
  - id: save_models
    type:
      - 'null'
      - boolean
    doc: "Save the models learned by mokapot as pickled Python\nobjects."
    inputBinding:
      position: 102
      prefix: --save_models
  - id: seed
    type:
      - 'null'
      - int
    doc: An integer to use as the random seed.
    inputBinding:
      position: 102
      prefix: --seed
  - id: semi
    type:
      - 'null'
      - boolean
    doc: "Was a semi-enzymatic digest used to assign PSMs? If\nso, the protein database
      will likely contain shared\npeptides and yield unhelpful protein-level confidence\n\
      estimates. We do not recommend using this option."
    inputBinding:
      position: 102
      prefix: --semi
  - id: subset_max_train
    type:
      - 'null'
      - int
    doc: "Maximum number of PSMs to use during the training of\neach of the cross
      validation folds in the model. This\nis useful for very large datasets and will
      be ignored\nif less PSMS are available."
    inputBinding:
      position: 102
      prefix: --subset_max_train
  - id: test_fdr
    type:
      - 'null'
      - float
    doc: "The false-discovery rate threshold at which to\nevaluate the learned models."
    inputBinding:
      position: 102
      prefix: --test_fdr
  - id: train_fdr
    type:
      - 'null'
      - float
    doc: "The maximum false discovery rate at which to consider\na target PSM as a
      positive example during model\ntraining."
    inputBinding:
      position: 102
      prefix: --train_fdr
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Specify the verbosity of the current process. Each\nlevel prints the following
      messages, including all\nthose at a lower verbosity: 0-errors, 1-warnings,\n\
      2-messages, 3-debug info."
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mokapot:0.10.0--pyhdfd78af_0
stdout: mokapot.out
