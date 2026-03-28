# easypqp CWL Generation Report

## easypqp_convert

### Tool Description
Convert pepXML files for EasyPQP

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Total Downloads**: 77.5K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/grosenberger/easypqp
- **Stars**: N/A
### Original Help Text
```text
Usage: easypqp convert [OPTIONS]

  Convert pepXML files for EasyPQP

Options:
  --pepxml PATH                   The input interact-*.pep.xml file or a list
                                  of interact-*.pep.xml files.  [required]
  --spectra PATH                  The input mzXML or MGF (timsTOF only) file.
                                  [required]
  --unimod PATH                   The input UniMod XML file.
  --psms PATH                     Output PSMs file.
  --peaks PATH                    Output peaks file.
  --exclude-range TEXT            massdiff in this range will not be mapped to
                                  UniMod.  [default: -1.5,3.5]
  --max_delta_unimod FLOAT        Maximum delta mass (Dalton) for UniMod
                                  annotation.  [default: 0.02]
  --max_delta_ppm FLOAT           Maximum delta mass (PPM) for annotation.
                                  [default: 15]
  --enable_unannotated / --no-enable_unannotated
                                  Enable mapping of unannotated delta masses.
                                  [default: no-enable_unannotated]
  --enable_massdiff / --no-enable_massdiff
                                  Enable mapping of mass differences reported
                                  by legacy search engines.  [default: no-
                                  enable_massdiff]
  --fragment_types TEXT           Allowed fragment ion types (a,b,c,x,y,z).
                                  [default: ['b','y']]
  --fragment_charges TEXT         Allowed fragment ion charges.  [default:
                                  [1,2,3,4]]
  --enable_specific_losses / --no-enable_specific_losses
                                  Enable specific fragment ion losses.
                                  [default: no-enable_specific_losses]
  --enable_unspecific_losses / --no-enable_unspecific_losses
                                  Enable unspecific fragment ion losses.
                                  [default: no-enable_unspecific_losses]
  --max_psm_pep FLOAT             Maximum posterior error probability (PEP)
                                  for a PSM  [default: 0.5]
  --precision_digits INTEGER      Precision (number of digits) for the product
                                  m/z reported by the theoretical library
                                  generation step. This should match the
                                  precision of the downstream consumer of the
                                  spectral library. Lowering this number will
                                  collapse (more) identical fragment ions of
                                  the same precursor to a single value.
                                  [default: 6]
  --help                          Show this message and exit.
```


## easypqp_convertpsm

### Tool Description
Convert psm.tsv files for EasyPQP

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp convertpsm [OPTIONS]

  Convert psm.tsv files for EasyPQP

Options:
  --psm PATH                      The input psm.tsv file or a list of psm.tsv
                                  files.  [required]
  --spectra PATH                  The input mzXML or MGF (timsTOF only) file.
                                  [required]
  --unimod PATH                   The input UniMod XML file.
  --psms PATH                     Output PSMs file.
  --peaks PATH                    Output peaks file.
  --exclude-range TEXT            massdiff in this range will not be mapped to
                                  UniMod.  [default: -1.5,3.5]
  --max_delta_unimod FLOAT        Maximum delta mass (Dalton) for UniMod
                                  annotation.  [default: 0.02]
  --max_delta_ppm FLOAT           Maximum delta mass (PPM) for annotation.
                                  [default: 15]
  --enable_unannotated / --no-enable_unannotated
                                  Enable mapping of unannotated delta masses.
                                  [default: no-enable_unannotated]
  --ignore_unannotated / --no-ignore_unannotated
                                  Remove PSMs with unannotated delta masses
                                  but proceed with all other PSMs.  [default:
                                  no-ignore_unannotated]
  --enable_massdiff / --no-enable_massdiff
                                  Enable mapping of mass differences reported
                                  by legacy search engines.  [default: no-
                                  enable_massdiff]
  --fragment_types TEXT           Allowed fragment ion types (a,b,c,x,y,z).
                                  [default: ['b','y']]
  --fragment_charges TEXT         Allowed fragment ion charges.  [default:
                                  [1,2,3,4]]
  --enable_specific_losses / --no-enable_specific_losses
                                  Enable specific fragment ion losses.
                                  [default: no-enable_specific_losses]
  --enable_unspecific_losses / --no-enable_unspecific_losses
                                  Enable unspecific fragment ion losses.
                                  [default: no-enable_unspecific_losses]
  --max_psm_pep FLOAT             Maximum posterior error probability (PEP)
                                  for a PSM  [default: 1]
  --decoy_prefix TEXT             Database decoy prefix (required)  [default:
                                  rev_; required]
  --precision_digits INTEGER      Precision (number of digits) for the product
                                  m/z reported by the theoretical library
                                  generation step. This should match the
                                  precision of the downstream consumer of the
                                  spectral library. Lowering this number will
                                  collapse (more) identical fragment ions of
                                  the same precursor to a single value.
                                  [default: 6]
  --labile_mods TEXT              Adjust fragment masses of labile
                                  modifications. Supported options: oglyc,
                                  nglyc, nglyc+ (includes HexNAc remainder
                                  ions)  [default: ""]
  --max_glycan_q FLOAT            Maximum glycan q-value to include a PSM in
                                  the library  [default: 1]
  --help                          Show this message and exit.
```


## easypqp_convertsage

### Tool Description
Convert Sage Search results for EasyPQP

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp convertsage [OPTIONS]

  Convert Sage Search results for EasyPQP

Options:
  --sage_psm PATH                 Path to Sage results.sage.tsv/parquet.
                                  [required]
  --sage_fragments PATH           Path to Sage
                                  matched_fragments.sage.tsv/parquet.
                                  [required]
  --unimod PATH                   UniMod XML (used to map numeric deltas to
                                  UniMod IDs).
  --max_delta_unimod FLOAT        Maximum delta mass (Dalton) for UniMod
                                  annotation.  [default: 0.02]
  --precision_digits INTEGER      Precision (number of digits) for the product
                                  m/z reported by the theoretical library
                                  generation step. This should match the
                                  precision of the downstream consumer of the
                                  spectral library. Lowering this number will
                                  collapse (more) identical fragment ions of
                                  the same precursor to a single value.
                                  [default: 6]
  --streaming                     Force streaming conversion (process runs
                                  one-by-one). If omitted, auto-detect by
                                  input size.
  --streaming-threshold-bytes INTEGER
                                  Auto-switch to streaming when combined input
                                  size (bytes) >= this threshold. Default:
                                  2GB.  [default: 2000000000]
  --help                          Show this message and exit.
```


## easypqp_filter-unimod

### Tool Description
Filter unimodified peptides from a PQP file.

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/easypqp", line 10, in <module>
    sys.exit(cli())
             ^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1485, in __call__
    return self.main(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1406, in main
    rv = self.invoke(ctx)
         ^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1891, in invoke
    sub_ctx = cmd.make_context(
              ^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1216, in make_context
    self.parse_args(ctx, args)
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 1227, in parse_args
    _, args = param.handle_parse_result(ctx, opts, args)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 2578, in handle_parse_result
    value = self.process_value(ctx, value)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 3313, in process_value
    return super().process_value(ctx, value)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/click/core.py", line 2448, in process_value
    value = self.callback(ctx, self, value)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: transform_comma_string_to_list() takes from 0 to 1 positional arguments but 3 were given
```


## easypqp_insilico-library

### Tool Description
Generate In-Silico Predicted Library

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp insilico-library [OPTIONS]

  Generate In-Silico Predicted Library

  For more information on the JSON configuration file, see:
  https://github.com/singjc/easypqp-rs?tab=readme-ov-file#configuration-
  reference

Options:
  --fasta PATH                    FASTA file with protein sequences. Overrides
                                  the FASTA file specified in the config.
  --output_file PATH              Output file for the generated library.
                                  Overrides the output directory specified in
                                  the
  --generate_decoys / --no-generate_decoys
                                  Generate decoy library.  [default: no-
                                  generate_decoys]
  --decoy_tag TEXT                Decoy tag to be used for decoy generation.
                                  [default: rev_]
  --precursor_charge TEXT         Precursor charge states to be used for
                                  library generation.  [default: 2,3]
  --max_fragment_charge INTEGER   Maximum fragment charge state.  [default: 2]
  --min_transitions INTEGER       Minimum number of transitions per peptide.
                                  [default: 6]
  --max_transitions INTEGER       Maximum number of transitions per peptide.
                                  [default: 6]
  --fragmentation_model TEXT      Fragmentation model to be used for
                                  theoretical fragmentaton generation. Options
                                  are (etd/td_etd/ethcd/etcad/eacid/ead/hcd/ci
                                  d/all/none). See: `[FragmentationModel](http
                                  s://docs.rs/rustyms/latest/rustyms/model/str
                                  uct.FragmentationModel.html#method.etd)` for
                                  more details.  [default: hcd]
  --allowed_fragment_types TEXT   Allowed fragment types. Current MS2
                                  prediction model only supports b and y ions.
                                  [default: b,y]
  --fine_tune / --no-fine_tune    Fine-tune the predictions models using the
                                  provided training data.  [default: no-
                                  fine_tune]
  --train_data_path PATH          Path to the training data for fine-tuning.
                                  This should be a TSV file with columns:
                                  "sequence", "precursor_charge", "intensity",
                                  "retention_time", "ion_mobility" (Optional).
  --save_model / --no-save_model  Save the fine-tuned model to the specified
                                  path.  [default: no-save_model]
  --instrument TEXT               Instrument type. Options are (QE).
                                  [default:
                                  QE/Lumos/timsTOF/SciexTOF/ThermoTOF]
  --nce INTEGER                   Normalized collision energy (NCE) to be used
                                  for MS2 intensity prediction.  [default: 20]
  --batch_size INTEGER            Batch size used for peptide property
                                  inferece.  [default: 10]
  --rt_scale FLOAT                RT output scaling factor (e.g., 100.0 to
                                  convert 0-1 range to 0-100).  [default:
                                  100.0]
  --write_report / --no-write_report
                                  Generate HTML quality report.  [default:
                                  write_report]
  --parquet_output / --no-parquet_output
                                  Output library in Parquet format instead of
                                  TSV.  [default: no-parquet_output]
  --threads INTEGER               Number of threads for parallel processing.
                                  If not specified, uses all available cores.
  --unimod_annotation / --no-unimod_annotation
                                  Re-annotate mass bracket modifications
                                  (e.g., [+57.0215]) to UniMod notation (e.g.,
                                  (UniMod:4)).  [default: unimod_annotation]
  --unimod PATH                   Custom UniMod XML database file for
                                  modification annotation.  [default:
                                  /usr/local/lib/python3.12/site-
                                  packages/easypqp/data/unimod.xml]
  --max_delta_unimod FLOAT        Maximum delta mass tolerance (in Da) for
                                  matching modifications to UniMod entries.
                                  [default: 0.02]
  --enable_unannotated / --no-enable_unannotated
                                  Keep mass brackets for modifications that
                                  cannot be matched to UniMod. If disabled,
                                  raises an error for unmatched modifications.
                                  [default: enable_unannotated]
  --config PATH                   JSON configuration file.
  --help                          Show this message and exit.
```


## easypqp_library

### Tool Description
Generate EasyPQP library

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp library [OPTIONS] [INFILES]...

  Generate EasyPQP library

  INFILES: Input PSM and Peak pickle files generated from an `easypqp
  convert[psm|sage]` command.

Options:
  --out PATH                      Output TSV peptide query parameter file.
                                  [required]
  --psmtsv PATH                   psm.tsv file from Philosopher.
  --peptidetsv PATH               peptide.tsv file from Philosopher.
  --perform_rt_calibration BOOLEAN
                                  Whether to perform RT calibration  [default:
                                  True]
  --rt_reference PATH             Optional iRT/CiRT reference file.
  --rt_reference_run_path PATH    Writes reference run RT file, if RT
                                  reference file is not provided.  [default:
                                  easypqp_rt_reference_run.tsv]
  --rt_filter TEXT                Optional tag to filter candidate RT
                                  reference runs.
  --perform_im_calibration BOOLEAN
                                  Whether to perform IM calibration  [default:
                                  True]
  --im_reference PATH             Optional IM reference file.
  --im_reference_run_path PATH    Writes reference run IM file, if IM
                                  reference file is not provided.  [default:
                                  easypqp_im_reference_run.tsv]
  --im_filter TEXT                Optional tag to filter candidate IM
                                  reference runs.
  --psm_fdr_threshold FLOAT       PSM FDR threshold.  [default: 0.01]
  --peptide_fdr_threshold FLOAT   Peptide FDR threshold.  [default: 0.01]
  --protein_fdr_threshold FLOAT   Protein FDR threshold.  [default: 0.01]
  --rt_lowess_fraction FLOAT      Fraction of data points to use for RT lowess
                                  regression. If set to 0, cross validation is
                                  used.  [default: 0.05]
  --rt_psm_fdr_threshold FLOAT    PSM FDR threshold used for RT alignment.
                                  [default: 0.001]
  --im_lowess_fraction FLOAT      Fraction of data points to use for IM lowess
                                  regression. If set to 0, cross validation is
                                  used.  [default: 0.05]
  --im_psm_fdr_threshold FLOAT    PSM FDR threshold used for IM alignment.
                                  [default: 0.001]
  --pi0_lambda <FLOAT FLOAT FLOAT>...
                                  Use non-parametric estimation of p-values.
                                  Either use <START END STEPS>, e.g. 0.1, 1.0,
                                  0.1 or set to fixed value, e.g. 0.4, 0, 0.
                                  [default: 0.1, 0.5, 0.05]
  --peptide_plot PATH             Output peptide-level PDF report.  [default:
                                  easypqp_peptide_report.pdf; required]
  --protein_plot PATH             Output protein-level PDF report.  [default:
                                  easypqp_protein_report.pdf; required]
  --min_peptides INTEGER          Minimum peptides required for successful
                                  alignment.  [default: 5]
  --proteotypic / --no-proteotypic
                                  Use only proteotypic, unique, non-shared
                                  peptides.  [default: proteotypic]
  --consensus / --no-consensus    Generate consensus instead of best replicate
                                  spectra.  [default: consensus]
  --nofdr / --no-fdr-filtering    Do not reassess or filter by FDR, as library
                                  was already provided using customized FDR
                                  filtering.  [default: no-fdr-filtering]
  --diannpqp / --no-diann-pqp     Generate DIA-NN2-compatible PQP library.
                                  [default: no-diann-pqp]
  --help                          Show this message and exit.
```


## easypqp_openswath-assay-generator

### Tool Description
Generates filtered and optimized assays for OpenSwathWorflow

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp openswath-assay-generator [OPTIONS]

  Generates filtered and optimized assays for OpenSwathWorflow

Options:
  --in PATH                       Input file (valid formats: 'tsv', 'mrm',
                                  'pqp', 'TraML')  [required]
  --in_type TEXT                  Input file type. Default: None, will be
                                  determined from file extension or content.
                                  Valid formats: ["tsv", "mrm" ,"pqp",
                                  "TraML"]
  --out PATH                      Output file (valid formats: 'tsv', 'pqp',
                                  'TraML')  [required]
  --out_type TEXT                 Output file type. Default: None, will be
                                  determined from file extension or content.
                                  Valid formats: ["tsv", "mrm" ,"pqp",
                                  "TraML"]
  --min_transitions INTEGER       Minimal number of transitions  [default: 6]
  --max_transitions INTEGER       Maximal number of transitions  [default: 6]
  --allowed_fragment_types TEXT   Allowed fragment types  [default: b,y]
  --allowed_fragment_charges TEXT
                                  Allowed fragment charge states  [default:
                                  1,2,3,4]
  --enable_detection_specific_losses BOOLEAN
                                  Set this flag if specific neutral losses for
                                  detection fragment ions should be allowed
  --enable_detection_unspecific_losses BOOLEAN
                                  Set this flag if unspecific neutral losses
                                  (H2O1, H3N1, C1H2N2, C1H2N1O1) for detection
                                  fragment ions should be allowed
  --precursor_mz_threshold FLOAT  MZ threshold in Thomson for precursor ion
                                  selection  [default: 0.025]
  --precursor_lower_mz_limit FLOAT
                                  Lower MZ limit for precursor ions  [default:
                                  400.0]
  --precursor_upper_mz_limit FLOAT
                                  Upper MZ limit for precursor ions  [default:
                                  1200.0]
  --product_mz_threshold FLOAT    MZ threshold in Thomson for fragment ion
                                  annotation  [default: 0.025]
  --product_lower_mz_limit FLOAT  Lower MZ limit for fragment ions  [default:
                                  350.0]
  --product_upper_mz_limit FLOAT  Upper MZ limit for fragment ions  [default:
                                  2000.0]
  --swath_windows_file PATH       Tab separated file containing the SWATH
                                  windows for exclusion of fragment ions
                                  falling into the precursor isolation window:
                                  lower_offset upper_offset  ewline400 425
                                  ewline ... Note that the first line is a
                                  header and will be skipped. (valid formats:
                                  'txt')
  --unimod_file PATH              (Modified) Unimod XML file
                                  (http://www.unimod.org/xml/unimod.xml)
                                  describing residue modifiability (valid
                                  formats: 'xml')
  --enable_ipf BOOLEAN            IPF: set this flag if identification
                                  transitions should be generated for IPF.
                                  Note: Requires setting 'unimod_file
  --max_num_alternative_localizations INTEGER
                                  IPF: maximum number of site-localization
                                  permutations  [default: 10000]
  --disable_identification_ms2_precursors BOOLEAN
                                  IPF: set this flag if MS2-level precursor
                                  ions for identification should not be
                                  allowed for extraction of the precursor
                                  signal from the fragment ion data
                                  (MS2-level).
  --disable_identification_specific_losses BOOLEAN
                                  IPF: set this flag if specific neutral
                                  losses for identification fragment ions
                                  should not be allowed
  --enable_identification_unspecific_losses BOOLEAN
                                  IPF: set this flag if unspecific neutral
                                  losses (H2O1, H3N1, C1H2N2, C1H2N1O1) for
                                  identification fragment ions should be
                                  allowed
  --enable_swath_specifity BOOLEAN
                                  IPF: set this flag if identification
                                  transitions without precursor specificity
                                  (i.e. across whole precursor isolation
                                  window instead of precursor MZ) should be
                                  generated.
  --help                          Show this message and exit.
```


## easypqp_openswath-decoy-generator

### Tool Description
Generate decoys for spectral libraries / transition files for targeted proteomics and metabolomics analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp openswath-decoy-generator [OPTIONS]

  Generate decoys for spectral libraries / transition files for targeted
  proteomics and metabolomics analysis.

  Can generate decoys for multiple formats. The following formats are
  supported:

      - @ref OpenMS::TraMLFile "TraML" 

      - @ref OpenMS::TransitionTSVFile "OpenSWATH TSV transition lists" 

      - @ref OpenMS::TransitionPQPFile "OpenSWATH PQP SQLite files" 

Options:
  --in PATH                       Input file to generate decoys for.
                                  [required]
  --in_type TEXT                  Input file type. Default: None, will be
                                  determined from input file. Valid formats:
                                  ["tsv", "mrm" ,"pqp", "TraML"]
  --out PATH                      Output file to be converted to.  [default:
                                  library.pqp]
  --out_type TEXT                 Output file type. Default: None, will be
                                  determined from output file. Valid formats:
                                  ["tsv", "pqp", "TraML"]
  --method TEXT                   Decoy generation method. Valid methods:
                                  "shuffle", "pseudo-reverse", "reverse",
                                  "shift  [default: shuffle]
  --decoy_tag TEXT                Decoy tag.  [default: DECOY_]
  --min_decoy_fraction FLOAT      Minimum fraction of decoy / target peptides
                                  and proteins
  --aim_decoy_fraction FLOAT      Number of decoys the algorithm should
                                  generate (if unequal to 1, the algorithm
                                  will randomly select N peptides for decoy
                                  generation)
  --shuffle_max_attempts INTEGER  shuffle: maximum attempts to lower the amino
                                  acid sequence identity between target and
                                  decoy for the shuffle algorithm
  --shuffle_sequence_identity_threshold FLOAT
                                  shuffle: target-decoy amino acid sequence
                                  identity threshold for the shuffle algorithm
  --shift_precursor_mz_shift FLOAT
                                  shift: precursor ion MZ shift in Thomson for
                                  shift decoy method
  --shift_product_mz_shift FLOAT  shift: fragment ion MZ shift in Thomson for
                                  shift decoy method
  --product_mz_threshold FLOAT    MZ threshold in Thomson for fragment ion
                                  annotation
  --allowed_fragment_types TEXT   allowed fragment types
  --allowed_fragment_charges TEXT
                                  allowed fragment charge states
  --switchKR / --no_switchKR      Whether to switch terminal K and R (to
                                  achieve different precursor mass)
  --enable_detection_specific_losses / --disable_detection_specific_losses
                                  set this flag if specific neutral losses for
                                  detection fragment ions should be allowed
  --enable_detection_unspecific_losses / --disable_detection_unspecific_losses
                                  set this flag if unspecific neutral losses
                                  (H2O1, H3N1, C1H2N2, C1H2N1O1) for detection
                                  fragment ions should be allowed
  --separate / --no_separate      set this flag if decoys should not be
                                  appended to targets.
  --help                          Show this message and exit.
```


## easypqp_reduce

### Tool Description
Reduce PQP files for OpenSWATH linear and non-linear alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp reduce [OPTIONS]

  Reduce PQP files for OpenSWATH linear and non-linear alignment

Options:
  --in PATH           Input PQP file.  [required]
  --out PATH          Output PQP file.  [required]
  --bins INTEGER      Number of bins to fill along gradient.  [default: 10]
  --peptides INTEGER  Number of peptides to sample.  [default: 5]
  --help              Show this message and exit.
```


## easypqp_targeted-file-converter

### Tool Description
Convert different spectral libraries / transition files for targeted
proteomics and metabolomics analysis.

Can convert multiple formats to and from TraML (standardized transition
format). The following formats are supported: 

    - @ref OpenMS::TraMLFile "TraML"  

    - @ref OpenMS::TransitionTSVFile "OpenSWATH TSV transition lists"  

    - @ref OpenMS::TransitionPQPFile "OpenSWATH PQP SQLite files"  

    - SpectraST MRM transition lists  

    - Skyline transition lists  

    - Spectronaut transition lists  

    - Parquet transition lists  

### Metadata
- **Docker Image**: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
- **Homepage**: https://github.com/grosenberger/easypqp
- **Package**: https://anaconda.org/channels/bioconda/packages/easypqp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: easypqp targeted-file-converter [OPTIONS]

  Convert different spectral libraries / transition files for targeted
  proteomics and metabolomics analysis.

  Can convert multiple formats to and from TraML (standardized transition
  format). The following formats are supported:

      - @ref OpenMS::TraMLFile "TraML" 

      - @ref OpenMS::TransitionTSVFile "OpenSWATH TSV transition lists" 

      - @ref OpenMS::TransitionPQPFile "OpenSWATH PQP SQLite files" 

      - SpectraST MRM transition lists 

      - Skyline transition lists 

      - Spectronaut transition lists 

      - Parquet transition lists 

Options:
  --in PATH                       Transition list to convert.  [required]
  --in_type TEXT                  Input file type. Default: None, will be
                                  determined from input file. Valid formats:
                                  ["tsv", "mrm" ,"pqp", "TraML", "parquet"]
  --out PATH                      Output file to be converted to.  [default:
                                  library.pqp]
  --out_type TEXT                 Output file type. Default: None, will be
                                  determined from output file. Valid formats:
                                  ["tsv", "pqp", "TraML"]
  --legacy_traml_id / --no-legacy_traml_id
                                  PQP to TraML: Should legacy TraML IDs be
                                  used?  [default: legacy_traml_id]
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated
