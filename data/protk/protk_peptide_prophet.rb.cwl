cwlVersion: v1.2
class: CommandLineTool
baseCommand: peptide_prophet.rb
label: protk_peptide_prophet.rb
doc: "Run PeptideProphet on a set of pep.xml input files.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input pep.xml files
    inputBinding:
      position: 1
  - id: accurate_mass
    type:
      - 'null'
      - boolean
    doc: Use accurate mass binning
    default: false
    inputBinding:
      position: 102
      prefix: --accurate-mass
  - id: allow_alt_instruments
    type:
      - 'null'
      - boolean
    doc: Warning instead of exit with error if instrument types between runs is 
      different
    default: false
    inputBinding:
      position: 102
      prefix: --allow-alt-instruments
  - id: database
    type:
      - 'null'
      - string
    doc: Specify the database to use for this search. Can be a named protk 
      database or the path to a fasta file
    default: sphuman
    inputBinding:
      position: 102
      prefix: --database
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Prefix for decoy sequences
    default: decoy
    inputBinding:
      position: 102
      prefix: --decoy-prefix
  - id: experiment_label
    type:
      - 'null'
      - string
    doc: used to commonly label all spectra belonging to one experiment 
      (required by iProphet)
    inputBinding:
      position: 102
      prefix: --experiment-label
  - id: force_fit
    type:
      - 'null'
      - boolean
    doc: Force fitting of mixture model and bypass checks
    default: false
    inputBinding:
      position: 102
      prefix: --force-fit
  - id: glyco
    type:
      - 'null'
      - boolean
    doc: Expect N-Glycosylation modifications as variable mod in a search or as 
      a parameter when building statistical models
    default: false
    inputBinding:
      position: 102
      prefix: --glyco
  - id: maldi
    type:
      - 'null'
      - boolean
    doc: Run a search on MALDI data
    default: false
    inputBinding:
      position: 102
      prefix: --maldi
  - id: no_decoy
    type:
      - 'null'
      - boolean
    doc: Don't use decoy sequences to pin down the negative distribution
    default: false
    inputBinding:
      position: 102
      prefix: --no-decoy
  - id: no_nmc
    type:
      - 'null'
      - boolean
    doc: Don't use NMC model
    default: false
    inputBinding:
      position: 102
      prefix: --no-nmc
  - id: no_ntt
    type:
      - 'null'
      - boolean
    doc: Don't use NTT model
    default: false
    inputBinding:
      position: 102
      prefix: --no-ntt
  - id: one_at_a_time
    type:
      - 'null'
      - boolean
    doc: Create a separate pproph output file for each analysis
    default: false
    inputBinding:
      position: 102
      prefix: --one-ata-time
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: A string to prepend to the name of output files
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: p_thresh
    type:
      - 'null'
      - float
    doc: Probability threshold below which PSMs are discarded
    default: 0.05
    inputBinding:
      position: 102
      prefix: --p-thresh
  - id: phospho
    type:
      - 'null'
      - boolean
    doc: Use phospho information
    default: false
    inputBinding:
      position: 102
      prefix: --phospho
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    default: false
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processing threads to use. Set to 0 to autodetect an 
      appropriate value
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_non_parametric_model
    type:
      - 'null'
      - boolean
    doc: Use Non-parametric model, can only be used with decoy option
    default: false
    inputBinding:
      position: 102
      prefix: --use-non-parametric-model
  - id: use_only_expect
    type:
      - 'null'
      - boolean
    doc: Only use Expect Score as the discriminant
    default: false
    inputBinding:
      position: 102
      prefix: --use-only-expect
  - id: usegamma
    type:
      - 'null'
      - boolean
    doc: Use Gamma distribution to model the negatives
    default: false
    inputBinding:
      position: 102
      prefix: --usegamma
  - id: useicat
    type:
      - 'null'
      - boolean
    doc: Use icat information
    default: false
    inputBinding:
      position: 102
      prefix: --useicat
  - id: usepi
    type:
      - 'null'
      - boolean
    doc: Use pI information
    default: false
    inputBinding:
      position: 102
      prefix: --usepi
  - id: usert
    type:
      - 'null'
      - boolean
    doc: Use hydrophobicity / RT information
    default: false
    inputBinding:
      position: 102
      prefix: --usert
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
