# crux CWL Generation Report

## crux_bullseye

### Tool Description
Bullseye will search for PPIDs in these spectra. Bullseye will assign high-resolution precursor masses to these spectra.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crux/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/redbadger/crux
- **Stars**: N/A
### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux bullseye [options] <MS1 spectra> <MS2 spectra>

REQUIRED ARGUMENTS:

  <MS1 spectra> The name of a file from which to parse high-resolution spectra
  of intact peptides. The file may be in MS1 (.ms1), binary MS1 (.bms1),
  compressed MS1 (.cms1), or mzXML (.mzXML) format. Bullseye will search for
  PPIDs in these spectra.

  <MS2 spectra> The name of a file from which to parse peptide fragmentation
  spectra. The file may be in MS2 (.ms2), binary MS2 (.bms2), compressed MS2
  (.cms2) or mzXML (.mzXML) format. Bullseye will assign high-resolution
  precursor masses to these spectra.

OPTIONAL ARGUMENTS:

  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--max-persist <float>]
     Ignore PPIDs that persist for longer than this length of time in the MS1
     spectra. The unit of time is whatever unit is used in your data file
     (usually minutes). These PPIDs are considered contaminants. Default = 2.
  [--exact-match T|F]
     When true, require an exact match (as defined by --exact-tolerance) between
     the center of the precursor isolation window in the MS2 scan and the base
     isotopic peak of the PPID. If this option is set to false and no exact
     match is observed, then attempt to match using a wider m/z tolerance. This
     wider tolerance is calculated using the PPID's monoisotopic mass and charge
     (the higher the charge, the smaller the window). Default = false.
  [--exact-tolerance <float>]
     Set the tolerance (+/-ppm) for --exact-match. Default = 10.
  [--persist-tolerance <float>]
     Set the mass tolerance (+/-ppm) for finding PPIDs in consecutive MS1 scans.
     Default = 10.
  [--gap-tolerance <integer>]
     Allowed gap size when checking for PPIDs across consecutive MS1 scans.
     Default = 1.
  [--scan-tolerance <integer>]
     Total number of MS1 scans over which a PPID must be observed to be
     considered real. Gaps in persistence are allowed by setting
     --gap-tolerance. Default = 3.
  [--bullseye-max-mass <float>]
     Only consider PPIDs below this maximum mass in daltons. Default = 8000.
  [--bullseye-min-mass <float>]
     Only consider PPIDs above this minimum mass in daltons. Default = 600.
  [--retention-tolerance <float>]
     Set the tolerance (+/-units) around the retention time over which a PPID
     can be matches to the MS2 spectrum. The unit of time is whatever unit is
     used in your data file (usually minutes). Default = 0.5.
  [--spectrum-format |ms2|bms2|cms2|mgf]
     The format to write the output spectra to. If empty, the spectra will be
     output in the same format as the MS2 input. Default = <empty>.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_tide-index

### Tool Description
Create a peptide index for the tide search engine.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux tide-index [options] <protein fasta file> <index name>

REQUIRED ARGUMENTS:

  <protein fasta file> The name of the file in FASTA format from which to
  retrieve proteins.

  <index name> The desired name of the binary index.

OPTIONAL ARGUMENTS:

  [--allow-dups T|F]
     Prevent duplicate peptides between the target and decoy databases. When set
     to "F", the program keeps all target and previously generated decoy
     peptides in memory. A shuffled decoy will be re-shuffled multiple times to
     avoid duplication. If a non-duplicated peptide cannot be generated, the
     decoy is skipped entirely. When set to "T", every decoy is added to the
     database without checking for duplication. This option reduces the memory
     requirements significantly. Default = false.
  [--clip-nterm-methionine T|F]
     When set to T, for each protein that begins with methionine, tide-index
     will put two copies of the leading peptide into the index, with and without
     the N-terminal methionine. Default = false.
  [--cterm-peptide-mods-spec <string>]
     Specifies C-terminal static and variable mass modifications on peptides.
     Specify a comma-separated list of C-terminal modification sequences of the
     form: X+21.9819 Default = <empty>.
  [--custom-enzyme <string>]
     Specify rules for in silico digestion of protein sequences. Overrides the
     enzyme option. Two lists of residues are given enclosed in square brackets
     or curly braces and separated by a |. The first list contains residues
     required/prohibited before the cleavage site and the second list is
     residues after the cleavage site. If the residues are required for
     digestion, they are in square brackets, '[' and ']'. If the residues
     prevent digestion, then they are enclosed in curly braces, '{' and '}'. Use
     X to indicate all residues. For example, trypsin cuts after R or K but not
     before P which is represented as [RK]|{P}. AspN cuts after any residue but
     only before D which is represented as [X]|[D]. To prevent the sequences
     from being digested at all, use [Z]|[Z]. Default = <empty>.
  [--decoy-format none|shuffle|peptide-reverse|protein-reverse]
     Include a decoy version of every peptide by shuffling or reversing the
     target sequence or protein. In shuffle or peptide-reverse mode, each
     peptide is either reversed or shuffled, leaving the N-terminal and
     C-terminal amino acids in place. Note that peptides appear multiple times
     in the target database are only shuffled once. In peptide-reverse mode,
     palindromic peptides are shuffled. Also, if a shuffled peptide produces an
     overlap with the target or decoy database, then the peptide is re-shuffled
     up to 5 times. Note that, despite this repeated shuffling, homopolymers
     will appear in both the target and decoy database. The protein-reverse mode
     reverses the entire protein sequence, irrespective of the composite
     peptides. Default = shuffle.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--digestion full-digest|partial-digest|non-specific-digest]
     Specify whether every peptide in the database must have two enzymatic
     termini (full-digest) or if peptides with only one enzymatic terminus are
     also included (partial-digest). Default = full-digest.
  [--enzyme no-enzyme|trypsin|trypsin/p|chymotrypsin|elastase|clostripain|cyanogen-bromide|iodosobenzoate|proline-endopeptidase|staph-protease|asp-n|lys-c|lys-n|arg-c|glu-c|pepsin-a|elastase-trypsin-chymotrypsin|custom-enzyme]
     Specify the enzyme used to digest the proteins in silico. Available enzymes
     (with the corresponding digestion rules indicated in parentheses) include
     no-enzyme ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin
     ([FWYL]|{P}), elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide
     ([M]|[]), iodosobenzoate ([W]|[]), proline-endopeptidase ([P]|[]),
     staph-protease ([E]|[]), asp-n ([]|[D]), lys-c ([K]|{P}), lys-n ([]|[K]),
     arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a ([FL]|{P}),
     elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
     no-enzyme yields a non-enzymatic digest. Warning: the resulting index may
     be quite large. Default = trypsin.
  [--isotopic-mass average|mono]
     Specify the type of isotopic masses to use when calculating the peptide
     mass. Default = mono.
  [--keep-terminal-aminos N|C|NC|none]
     When creating decoy peptides using decoy-format=shuffle or
     decoy-format=peptide-reverse, this option specifies whether the N-terminal
     and C-terminal amino acids are kept in place or allowed to be shuffled or
     reversed. For a target peptide "EAMPK" with decoy-format=peptide-reverse,
     setting keep-terminal-aminos to "NC" will yield "EPMAK"; setting it to "C"
     will yield "PMAEK"; setting it to "N" will yield "EKPMA"; and setting it to
     "none" will yield "KPMAE". Default = NC.
  [--mass-precision <integer>]
     Set the precision for masses and m/z written to sqt and text files. Default
     = 4.
  [--max-length <integer>]
     The maximum length of peptides to consider. Default = 50.
  [--max-mass <float>]
     The maximum mass (in Da) of peptides to consider. Default = 7200.
  [--max-mods <integer>]
     The maximum number of modifications that can be applied to a single
     peptide. Default = 255.
  [--min-length <integer>]
     The minimum length of peptides to consider. Default = 6.
  [--min-mass <float>]
     The minimum mass (in Da) of peptides to consider. Default = 200.
  [--min-mods <integer>]
     The minimum number of modifications that can be applied to a single
     peptide. Default = 0.
  [--missed-cleavages <integer>]
     Maximum number of missed cleavages per peptide to allow in enzymatic
     digestion. Default = 0.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--mods-spec <string>]
     Expression for static and variable mass modifications to include. Specify a
     comma-separated list of modification sequences of the form:
     C+57.02146,2M+15.9949,1STY+79.966331,... Default = C+57.02146.
  [--nterm-peptide-mods-spec <string>]
     Specifies N-terminal static and variable mass modifications on peptides.
     Specify a comma-separated list of N-terminal modification sequences of the
     form: 1E-18.0106,C-17.0265 Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--peptide-list T|F]
     Create in the output directory a text file listing of all the peptides in
     the database, along with their neutral masses, one per line. If decoys are
     generated, then a second file will be created containing the decoy
     peptides. Decoys that also appear in the target database are marked with an
     asterisk in a third column. Default = false.
  [--seed <string>]
     When given a unsigned integer value seeds the random number generator with
     that value. When given the string "time" seeds the random number generator
     with the system time. Default = 1.
  [--temp-dir <string>]
     The name of the directory where temporary files will be created. If this
     parameter is blank, then the system temporary directory will be used
     Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_for

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find for in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_tide-search

### Tool Description
Search for peptides in mass spectrometry data using the Tide algorithm.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 2 arguments, but found 0

USAGE:

  crux tide-search [options] <tide spectra file>+ <tide database>

REQUIRED ARGUMENTS:

  <tide spectra file>+ The name of one or more files from which to parse the
  fragmentation spectra, in any of the file formats supported by ProteoWizard.
  Alternatively, the argument may be one or more binary spectrum files produced
  by a previous run of crux tide-search using the store-spectra parameter.

  <tide database> Either a FASTA file or a directory containing a database index
  created by a previous run of crux tide-index.

OPTIONAL ARGUMENTS:

  [--auto-mz-bin-width false|warn|fail]
     Automatically estimate optimal value for the mz-bin-width parameter from
     the spectra themselves. false=no estimation, warn=try to estimate but use
     the default value in case of failure, fail=try to estimate and quit in case
     of failure. Default = false.
  [--auto-precursor-window false|warn|fail]
     Automatically estimate optimal value for the precursor-window parameter
     from the spectra themselves. false=no estimation, warn=try to estimate but
     use the default value in case of failure, fail=try to estimate and quit in
     case of failure. Default = false.
  [--compute-sp T|F]
     Compute the preliminary score Sp for all candidate peptides. Report this
     score in the output, along with the corresponding rank, the number of
     matched ions and the total number of ions. This option is recommended if
     results are to be analyzed by Percolator or Barista. If sqt-output is
     enabled, then compute-sp is automatically enabled and cannot be overridden.
     Note that the Sp computation requires re-processing each observed spectrum,
     so turning on this switch involves significant computational overhead.
     Default = false.
  [--concat T|F]
     When set to T, target and decoy search results are reported in a single
     file, and only the top-scoring N matches (as specified via --top-match) are
     reported for each spectrum, irrespective of whether the matches involve
     target or decoy peptides.Note that when used with search-for-xlinks, this
     parameter only has an effect if use-old-xlink=F. Default = false.
  [--deisotope <float>]
     Perform a simple deisotoping operation across each MS2 spectrum. For each
     peak in an MS2 spectrum, consider lower m/z peaks. If the current peak
     occurs where an expected peak would lie for any charge state less than the
     charge state of the precursor, within mass tolerance, and if the current
     peak is of lower abundance, then the peak is removed.  The value of this
     parameter is the mass tolerance, in units of parts-per-million.  If set to
     0, no deisotoping is performed. Default = 0.
  [--exact-p-value T|F]
     Enable the calculation of exact p-values for the XCorr score. Calculation
     of p-values increases the running time but increases the number of
     identifications at a fixed confidence threshold. The p-values will be
     reported in a new column with header "exact p-value", and the "xcorr score"
     column will be replaced with a "refactored xcorr" column. Note that,
     currently, p-values can only be computed when the mz-bin-width parameter is
     set to its default value. Variable and static mods are allowed on
     non-terminal residues in conjunction with p-value computation, but
     currently only static mods are allowed on the N-terminus, and no mods on
     the C-terminus. Default = false.
  [--file-column T|F]
     Include the file column in tab-delimited output. Default = true.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--isotope-error <string>]
     List of positive, non-zero integers. Default = <empty>.
  [--mass-precision <integer>]
     Set the precision for masses and m/z written to sqt and text files. Default
     = 4.
  [--max-precursor-charge <integer>]
     The maximum charge state of a spectra to consider in search. Default = 5.
  [--min-peaks <integer>]
     The minimum number of peaks a spectrum must have for it to be searched.
     Default = 20.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--mz-bin-offset <float>]
     In the discretization of the m/z axes of the observed and theoretical
     spectra, this parameter specifies the location of the left edge of the
     first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
     edge of the first bin will be located at +0.xx Da). Default = 0.4.
  [--mz-bin-width <float>]
     Before calculation of the XCorr score, the m/z axes of the observed and
     theoretical spectra are discretized. This parameter specifies the size of
     each bin. The exact formula for computing the discretized m/z value is
     floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
     value. For low resolution ion trap ms/ms data 1.0005079 and for high
     resolution ms/ms 0.02 is recommended. Default = 1.0005079.
  [--mzid-output T|F]
     Output an mzIdentML results file to the output directory. Default = false.
  [--num-threads <integer>]
     0=poll CPU to set num threads; else specify num threads directly. Default =
     0.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--peptide-centric-search T|F]
     Carries out a peptide-centric search. For each peptide the top-scoring
     spectra are reported, in contrast to the standard spectrum-centric search
     where the top-scoring peptides are reported. Note that in this case the
     "xcorr rank" column will contain the rank of the given spectrum with
     respect to the given candidate peptide, rather than vice versa (which is
     the default). Default = false.
  [--score-function xcorr|residue-evidence|both]
     Function used for scoring PSMs. 'xcorr' is the original scoring function
     used by SEQUEST; 'residue-evidence' is designed to score high-resolution
     MS2 spectra; and 'both' calculates both scores. The latter requires that
     exact-p-value=T. Default = xcorr.
  [--fragment-tolerance <float>]
     Mass tolerance (in Da) for scoring pairs of peaks when creating the residue
     evidence matrix. This parameter only makes sense when score-function is
     'residue-evidence' or 'both'. Default = 0.02.
  [--evidence-granularity <integer>]
     When exact-pvalue=T, this parameter controls the granularity of the entries
     in the dynamic programming matrix.  Smaller values make the program run
     faster but give less exact p-values; larger values make the program run
     more slowly but give more exact p-values. Default = 25.
  [--pepxml-output T|F]
     Output a pepXML results file to the output directory. Default = false.
  [--pin-output T|F]
     Output a Percolator input (PIN) file to the output directory. Default =
     false.
  [--pm-charge <integer>]
     Precursor charge state to consider MS/MS spectra from, in measurement error
     estimation. Ideally, this should be the most frequently occurring charge
     state in the given data. Default = 2.
  [--pm-max-frag-mz <float>]
     Maximum fragment m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-precursor-delta-ppm <float>]
     Maximum ppm distance between precursor m/z values to consider two scans
     potentially generated by the same peptide for measurement error estimation.
     Default = 50.
  [--pm-max-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-scan-separation <integer>]
     Maximum number of scans two spectra can be separated by in order to be
     considered potentially generated by the same peptide, for measurement error
     estimation. Default = 1000.
  [--pm-min-common-frag-peaks <integer>]
     Number of the most-intense peaks that two spectra must share in order to
     potentially be generated by the same peptide, for measurement error
     estimation. Default = 20.
  [--pm-min-frag-mz <float>]
     Minimum fragment m/z value to use in measurement error estimation. Default
     = 150.
  [--pm-min-peak-pairs <integer>]
     Minimum number of peak pairs (for precursor or fragment) that must be
     successfully paired in order to attempt to estimate measurement error
     distribution. Default = 100.
  [--pm-min-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 400.
  [--pm-min-scan-frag-peaks <integer>]
     Minimum fragment peaks an MS/MS scan must contain to be used in measurement
     error estimation. Default = 40.
  [--pm-pair-top-n-frag-peaks <integer>]
     Number of fragment peaks per spectrum pair to be used in fragment error
     estimation. Default = 5.
  [--pm-top-n-frag-peaks <integer>]
     Number of most-intense fragment peaks to consider for measurement error
     estimation, per MS/MS spectrum. Default = 30.
  [--precision <integer>]
     Set the precision for scores written to sqt and text files. Default = 8.
  [--precursor-window <float>]
     Tolerance used for matching peptides to spectra. Peptides must be within
     +/- 'precursor-window' of the spectrum value. The precursor window units
     depend upon precursor-window-type. Default = 3.
  [--precursor-window-type mass|mz|ppm]
     Specify the units for the window that is used to select peptides around the
     precursor mass location (mass, mz, ppm). The magnitude of the window is
     defined by the precursor-window option, and candidate peptides must fall
     within this window. For the mass window-type, the spectrum precursor m+h
     value is converted to mass, and the window is defined as that mass +/-
     precursor-window. If the m+h value is not available, then the mass is
     calculated from the precursor m/z and provided charge. The peptide mass is
     computed as the sum of the average amino acid masses plus 18 Da for the
     terminal OH group. The mz window-type calculates the window as spectrum
     precursor m/z +/- precursor-window and then converts the resulting m/z
     range to the peptide mass range using the precursor charge. For the
     parts-per-million (ppm) window-type, the spectrum mass is calculated as in
     the mass type. The lower bound of the mass window is then defined as the
     spectrum mass / (1.0 + (precursor-window / 1000000)) and the upper bound is
     defined as spectrum mass / (1.0 - (precursor-window / 1000000)). Default =
     mass.
  [--print-search-progress <integer>]
     Show search progress by printing every n spectra searched. Set to 0 to show
     no search progress. Default = 1000.
  [--remove-precursor-peak T|F]
     If true, all peaks around the precursor m/z will be removed, within a range
     specified by the --remove-precursor-tolerance option. Default = false.
  [--remove-precursor-tolerance <float>]
     This parameter specifies the tolerance (in Th) around each precursor m/z
     that is removed when the --remove-precursor-peak option is invoked. Default
     = 1.5.
  [--scan-number <string>]
     A single scan number or a range of numbers to be searched. Range should be
     specified as 'first-last' which will include scans 'first' and 'last'.
     Default = <empty>.
  [--skip-preprocessing T|F]
     Skip preprocessing steps on spectra. Default = F. Default = false.
  [--spectrum-charge 1|2|3|all]
     The spectrum charges to search. With 'all' every spectrum will be searched
     and spectra with multiple charge states will be searched once at each
     charge state. With 1, 2, or 3 only spectra with that charge state will be
     searched. Default = all.
  [--spectrum-max-mz <float>]
     The highest spectrum m/z to search in the ms2 file. Default = 1e+09.
  [--spectrum-min-mz <float>]
     The lowest spectrum m/z to search in the ms2 file. Default = 0.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--sqt-output T|F]
     Outputs an SQT results file to the output directory. Note that if
     sqt-output is enabled, then compute-sp is automatically enabled and cannot
     be overridden. Default = false.
  [--store-index <string>]
     When providing a FASTA file as the index, the generated binary index will
     be stored at the given path. This option has no effect if a binary index is
     provided as the index. Default = <empty>.
  [--store-spectra <string>]
     Specify the name of the file where the binarized fragmentation spectra will
     be stored. Subsequent runs of crux tide-search will execute more quickly if
     provided with the spectra in binary format. The filename is specified
     relative to the current working directory, not the Crux output directory
     (as specified by --output-dir). This option is not valid if multiple input
     spectrum files are given. Default = <empty>.
  [--top-match <integer>]
     Specify the number of matches to report for each spectrum. Default = 5.
  [--txt-output T|F]
     Output a tab-delimited results file to the output directory. Default =
     true.
  [--use-flanking-peaks T|F]
     Include flanking peaks around singly charged b and y theoretical ions. Each
     flanking peak occurs in the adjacent m/z bin and has half the intensity of
     the primary peak. Default = false.
  [--use-neutral-loss-peaks T|F]
     Controls whether neutral loss ions are considered in the search. Two types
     of neutral losses are included and are applied only to singly charged b-
     and y-ions: loss of ammonia (NH3, 17.0086343 Da) and H2O (18.0091422). Each
     neutral loss peak has intensity 1/5 of the primary peak. Default = true.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_peptide-spectrum

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry proteomics data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find peptide-spectrum in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_search

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find search in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_index

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find index in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_comet

### Tool Description
Comet is a widely used open-source tandem mass spectrometry search algorithm.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 2 arguments, but found 0

USAGE:

  crux comet [options] <input spectra>+ <database_name>

REQUIRED ARGUMENTS:

  <input spectra>+ The name of the file from which to parse the spectra. Valid
  formats include mzXML, mzML, mz5, raw, ms2, and cms2. Files in mzML or mzXML
  may be compressed with gzip. RAW files can be parsed only under windows and if
  the appropriate libraries were included at compile time.

  <database_name> A full or relative path to the sequence database, in FASTA
  format, to search. Example databases include RefSeq or UniProt.  The database
  can contain amino acid sequences or nucleic acid sequences. If sequences are
  amino acid sequences, set the parameter "nucleotide_reading_frame = 0". If the
  sequences are nucleic acid sequences, you must instruct Comet to translate
  these to amino acid sequences. Do this by setting nucleotide_reading_frame" to
  a value between 1 and 9.

OPTIONAL ARGUMENTS:

  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--decoy_search <integer>]
     0=no, 1=concatenated search, 2=separate search. Default = 0.
  [--num_threads <integer>]
     0=poll CPU to set num threads; else specify num threads directly. Default =
     0.
  [--peptide_mass_tolerance <float>]
     Controls the mass tolerance value.  The mass tolerance is set at +/- the
     specified number i.e. an entered value of "1.0" applies a -1.0 to +1.0
     tolerance. The units of the mass tolerance is controlled by the parameter
     "peptide_mass_units".  Default = 3.
  [--auto_peptide_mass_tolerance false|warn|fail]
     Automatically estimate optimal value for the peptide_mass_tolerancel
     parameter from the spectra themselves. false=no estimation, warn=try to
     estimate but use the default value in case of failure, fail=try to estimate
     and quit in case of failure. Default = false.
  [--peptide_mass_units <integer>]
     0=amu, 1=mmu, 2=ppm. Default = 0.
  [--mass_type_parent <integer>]
     0=average masses, 1=monoisotopic masses. Default = 1.
  [--mass_type_fragment <integer>]
     0=average masses, 1=monoisotopic masses. Default = 1.
  [--precursor_tolerance_type <integer>]
     0=singly charged peptide mass, 1=precursor m/z. Default = 0.
  [--isotope_error <integer>]
     0=off, 1=on -1/0/1/2/3 (standard C13 error), 2=-8/-4/0/4/8 (for +4/+8
     labeling). Default = 0.
  [--search_enzyme_number <integer>]
     Specify a search enzyme from the end of the parameter file. Default = 1.
  [--num_enzyme_termini <integer>]
     valid values are 1 (semi-digested), 2 (fully digested), 8 N-term, 9 C-term.
     Default = 2.
  [--allowed_missed_cleavage <integer>]
     Maximum value is 5; for enzyme search. Default = 2.
  [--fragment_bin_tol <float>]
     Binning to use on fragment ions. Default = 1.000507.
  [--fragment_bin_offset <float>]
     Offset position to start the binning (0.0 to 1.0). Default = 0.4.
  [--auto_fragment_bin_tol false|warn|fail]
     Automatically estimate optimal value for the fragment_bin_tol parameter
     from the spectra themselves. false=no estimation, warn=try to estimate but
     use the default value in case of failure, fail=try to estimate and quit in
     case of failure. Default = false.
  [--theoretical_fragment_ions <integer>]
     0=default peak shape, 1=M peak only. Default = 1.
  [--use_A_ions <integer>]
     Controls whether or not A-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_B_ions <integer>]
     Controls whether or not B-ions are considered in the search (0 - no, 1 -
     yes). Default = 1.
  [--use_C_ions <integer>]
     Controls whether or not C-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_X_ions <integer>]
     Controls whether or not X-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_Y_ions <integer>]
     Controls whether or not Y-ions are considered in the search (0 - no, 1 -
     yes). Default = 1.
  [--use_Z_ions <integer>]
     Controls whether or not Z-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_NL_ions <integer>]
     0=no, 1= yes to consider NH3/H2O neutral loss peak. Default = 1.
  [--output_sqtfile <integer>]
     0=no, 1=yes  write sqt file. Default = 0.
  [--output_txtfile <integer>]
     0=no, 1=yes  write tab-delimited text file. Default = 1.
  [--output_pepxmlfile <integer>]
     0=no, 1=yes  write pep.xml file. Default = 1.
  [--output_percolatorfile <integer>]
     0=no, 1=yes write percolator file. Default = 0.
  [--output_outfiles <integer>]
     0=no, 1=yes  write .out files. Default = 0.
  [--print_expect_score <integer>]
     0=no, 1=yes to replace Sp with expect in out & sqt. Default = 1.
  [--num_output_lines <integer>]
     num peptide results to show. Default = 5.
  [--show_fragment_ions <integer>]
     0=no, 1=yes for out files only. Default = 0.
  [--sample_enzyme_number <integer>]
     Sample enzyme which is possibly different than the one applied to the
     search. Used to calculate NTT & NMC in pepXML output. Default = 1.
  [--scan_range <string>]
     Start and scan scan range to search; 0 as first entry ignores parameter.
     Default = 0 0.
  [--precursor_charge <string>]
     Precursor charge range to analyze; does not override mzXML charge; 0 as
     first entry ignores parameter. Default = 0 0.
  [--override_charge <integer>]
     Specifies the whether to override existing precursor charge state
     information when present in the files with the charge range specified by
     the "precursor_charge" parameter. Default = 0.
  [--ms_level <integer>]
     MS level to analyze, valid are levels 2 or 3. Default = 2.
  [--activation_method ALL|CID|ECD|ETD|PQD|HCD|IRMPD]
     Specifies which scan types are searched. Default = ALL.
  [--digest_mass_range <string>]
     MH+ peptide mass range to analyze. Default = 600.0 5000.0.
  [--num_results <integer>]
     Number of search hits to store internally. Default = 50.
  [--skip_researching <integer>]
     For '.out' file output only, 0=search everything again, 1=don't search if
     .out exists. Default = 1.
  [--max_fragment_charge <integer>]
     Set maximum fragment charge state to analyze (allowed max 5). Default = 3.
  [--max_precursor_charge <integer>]
     Set maximum precursor charge state to analyze (allowed max 9). Default = 6.
  [--nucleotide_reading_frame <integer>]
     0=proteinDB, 1-6, 7=forward three, 8=reverse three, 9=all six. Default = 0.
  [--clip_nterm_methionine <integer>]
     0=leave sequences as-is; 1=also consider sequence w/o N-term methionine.
     Default = 0.
  [--spectrum_batch_size <integer>]
     Maximum number of spectra to search at a time; 0 to search the entire scan
     range in one loop. Default = 0.
  [--decoy_prefix <string>]
     Specifies the prefix of the protein names that indicates a decoy. Default =
     decoy_.
  [--output_suffix <string>]
     Specifies the suffix string that is appended to the base output name for
     the pep.xml, pin.xml, txt and sqt output files. Default = <empty>.
  [--mass_offsets <string>]
     Specifies one or more mass offsets to apply. This value(s) are effectively
     subtracted from each precursor mass such that peptides that are smaller
     than the precursor mass by the offset value can still be matched to the
     respective spectrum. Default = <empty>.
  [--minimum_peaks <integer>]
     Minimum number of peaks in spectrum to search. Default = 10.
  [--minimum_intensity <float>]
     Minimum intensity value to read in. Default = 0.
  [--remove_precursor_peak <integer>]
     0=no, 1=yes, 2=all charge reduced precursor peaks (for ETD). Default = 0.
  [--remove_precursor_tolerance <float>]
     +- Da tolerance for precursor removal. Default = 1.5.
  [--clear_mz_range <string>]
     For iTRAQ/TMT type data; will clear out all peaks in the specified m/z
     range. Default = 0.0 0.0.
  [--variable_mod01 <string>]
     Up to 9 variable modifications are supported. Each modification is
     specified using seven entries: "<mass> <residues> <type> <max> <terminus>
     <distance> <force>." Type is 0 for static mods and non-zero for variable
     mods. Note that that if you set the same type value on multiple
     modification entries, Comet will treat those variable modifications as a
     binary set. This means that all modifiable residues in the binary set must
     be unmodified or modified. Multiple binary sets can be specified by setting
     a different binary modification value. Max is an integer specifying the
     maximum number of modified residues possible in a peptide for this
     modification entry. Distance specifies the distance the modification is
     applied to from the respective terminus: -1 = no distance contraint; 0 =
     only applies to terminal residue; N = only applies to terminal residue
     through next N residues. Terminus specifies which terminus the distance
     constraint is applied to: 0 = protein N-terminus; 1 = protein C-terminus; 2
     = peptide N-terminus; 3 = peptide C-terminus.Force specifies whether
     peptides must contain this modification: 0 = not forced to be present; 1 =
     modification is required. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod02 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod03 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod04 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod05 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod06 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod07 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod08 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod09 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--max_variable_mods_in_peptide <integer>]
     Specifies the total/maximum number of residues that can be modified in a
     peptide. Default = 5.
  [--require_variable_mod <integer>]
     Controls whether the analyzed peptides must contain at least one variable
     modification. Default = 0.
  [--add_Cterm_peptide <float>]
     Specifiy a static modification to the c-terminus of all peptides. Default =
     0.
  [--add_Nterm_peptide <float>]
     Specify a static modification to the n-terminus of all peptides. Default =
     0.
  [--add_Cterm_protein <float>]
     Specify a static modification to the c-terminal peptide of each protein.
     Default = 0.
  [--add_Nterm_protein <float>]
     Specify a static modification to the n-terminal peptide of each protein.
     Default = 0.
  [--add_A_alanine <float>]
     Specify a static modification to the residue A. Default = 0.
  [--add_B_user_amino_acid <float>]
     Specify a static modification to the residue B. Default = 0.
  [--add_C_cysteine <float>]
     Specify a static modification to the residue C. Default = 57.021464.
  [--add_D_aspartic_acid <float>]
     Specify a static modification to the residue D. Default = 0.
  [--add_E_glutamic_acid <float>]
     Specify a static modification to the residue E. Default = 0.
  [--add_F_phenylalanine <float>]
     Specify a static modification to the residue F. Default = 0.
  [--add_G_glycine <float>]
     Specify a static modification to the residue G. Default = 0.
  [--add_H_histidine <float>]
     Specify a static modification to the residue H. Default = 0.
  [--add_I_isoleucine <float>]
     Specify a static modification to the residue I. Default = 0.
  [--add_J_user_amino_acid <float>]
     Specify a static modification to the residue J. Default = 0.
  [--add_K_lysine <float>]
     Specify a static modification to the residue K. Default = 0.
  [--add_L_leucine <float>]
     Specify a static modification to the residue L. Default = 0.
  [--add_M_methionine <float>]
     Specify a static modification to the residue M. Default = 0.
  [--add_N_asparagine <float>]
     Specify a static modification to the residue N. Default = 0.
  [--add_O_ornithine <float>]
     Specify a static modification to the residue O. Default = 0.
  [--add_P_proline <float>]
     Specify a static modification to the residue P. Default = 0.
  [--add_Q_glutamine <float>]
     Specify a static modification to the residue Q. Default = 0.
  [--add_R_arginine <float>]
     Specify a static modification to the residue R. Default = 0.
  [--add_S_serine <float>]
     Specify a static modification to the residue S. Default = 0.
  [--add_T_threonine <float>]
     Specify a static modification to the residue T. Default = 0.
  [--add_U_selenocysteine <float>]
     Specify a static modification to the residue U. Default = 0.
  [--add_V_valine <float>]
     Specify a static modification to the residue V. Default = 0.
  [--add_W_tryptophan <float>]
     Specify a static modification to the residue W. Default = 0.
  [--add_X_user_amino_acid <float>]
     Specify a static modification to the residue X. Default = 0.
  [--add_Y_tyrosine <float>]
     Specify a static modification to the residue Y. Default = 0.
  [--add_Z_user_amino_acid <float>]
     Specify a static modification to the residue Z. Default = 0.
  [--pm-min-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 400.
  [--pm-max-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-min-frag-mz <float>]
     Minimum fragment m/z value to use in measurement error estimation. Default
     = 150.
  [--pm-max-frag-mz <float>]
     Maximum fragment m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-min-scan-frag-peaks <integer>]
     Minimum fragment peaks an MS/MS scan must contain to be used in measurement
     error estimation. Default = 40.
  [--pm-max-precursor-delta-ppm <float>]
     Maximum ppm distance between precursor m/z values to consider two scans
     potentially generated by the same peptide for measurement error estimation.
     Default = 50.
  [--pm-charge <integer>]
     Precursor charge state to consider MS/MS spectra from, in measurement error
     estimation. Ideally, this should be the most frequently occurring charge
     state in the given data. Default = 2.
  [--pm-top-n-frag-peaks <integer>]
     Number of most-intense fragment peaks to consider for measurement error
     estimation, per MS/MS spectrum. Default = 30.
  [--pm-pair-top-n-frag-peaks <integer>]
     Number of fragment peaks per spectrum pair to be used in fragment error
     estimation. Default = 5.
  [--pm-min-common-frag-peaks <integer>]
     Number of the most-intense peaks that two spectra must share in order to
     potentially be generated by the same peptide, for measurement error
     estimation. Default = 20.
  [--pm-max-scan-separation <integer>]
     Maximum number of scans two spectra can be separated by in order to be
     considered potentially generated by the same peptide, for measurement error
     estimation. Default = 1000.
  [--pm-min-peak-pairs <integer>]
     Minimum number of peak pairs (for precursor or fragment) that must be
     successfully paired in order to attempt to estimate measurement error
     distribution. Default = 100.
```


## crux_in

### Tool Description
Supports a variety of commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find in in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_percolator

### Tool Description
Percolator is a widely used tool for the statistical validation and rescoring of peptide identification results from mass spectrometry.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO: Writing results to output directory 'crux-output'.
INFO: CPU: 8590124cd1c4
INFO: Crux version: 3.2-0d57cff
INFO: Wed Feb 25 02:50:46 UTC 2026
INFO: Beginning percolator.
INFO: Percolator version 3.02.0, Build Date May 30 2018 17:04:51
INFO: Copyright (c) 2006-9 University of Washington. All rights reserved.
INFO: Written by Lukas Käll (lukall@u.washington.edu) in the
INFO: Department of Genome Sciences at the University of Washington.
INFO: 
INFO: Usage:
INFO:    percolator [-X pout.xml] [other options] pin.tsv
INFO: pin.tsv is the tab delimited output file generated by e.g. sqt2pin;
INFO:   The tab delimited fields should be:
INFO:     id <tab> label <tab> scannr <tab> feature1 <tab> ... <tab>
INFO:     featureN <tab> peptide <tab> proteinId1 <tab> .. <tab> proteinIdM
INFO:   Labels are interpreted as 1 -- positive set and test set, -1 -- negative set.
INFO:   When the --doc option the first and second feature should contain
INFO:   the retention time and difference between observed and calculated mass;
INFO: pout.xml is where the output will be written (ensure to have read
INFO: and write access on the file).
INFO: 
INFO: Options:
INFO:  -h
INFO:  --help                                       Display this message
INFO:  -X <filename>
INFO:  --xmloutput <filename>                       Path to xml-output (pout) file.
INFO:  -
INFO:  --stdinput-tab                               Read percolator tab-input format 
INFO:                                               (pin-tab) from standard input
INFO:  -e
INFO:  --stdinput-xml                               Read percolator xml-input format 
INFO:                                               (pin-xml) from standard input
INFO:  -Z
INFO:  --decoy-xml-output                           Include decoys (PSMs, peptides 
INFO:                                               and/or proteins) in the 
INFO:                                               xml-output. Only available if -X 
INFO:                                               is set.
INFO:  -p <value>
INFO:  --Cpos <value>                               Cpos, penalty for mistakes made on 
INFO:                                               positive examples. Set by cross 
INFO:                                               validation if not specified.
INFO:  -n <value>
INFO:  --Cneg <value>                               Cneg, penalty for mistakes made on 
INFO:                                               negative examples. Set by cross 
INFO:                                               validation if not specified or if 
INFO:                                               -p is not specified.
INFO:  -t <value>
INFO:  --testFDR <value>                            False discovery rate threshold for 
INFO:                                               evaluating best cross validation 
INFO:                                               result and reported end result. 
INFO:                                               Default = 0.01.
INFO:  -F <value>
INFO:  --trainFDR <value>                           False discovery rate threshold to 
INFO:                                               define positive examples in 
INFO:                                               training. Set to testFDR if 0. 
INFO:                                               Default = 0.01.
INFO:  -i <number>
INFO:  --maxiter <number>                           Maximal number of iterations. 
INFO:                                               Default = 10.
INFO:  -N <number>
INFO:  --subset-max-train <number>                  Only train an SVM on a subset of 
INFO:                                               <x> PSMs, and use the resulting 
INFO:                                               score vector to evaluate the other 
INFO:                                               PSMs. Recommended when analyzing 
INFO:                                               huge numbers (>1 million) of PSMs. 
INFO:                                               When set to 0, all PSMs are used 
INFO:                                               for training as normal. Default = 
INFO:                                               0.
INFO:  -x
INFO:  --quick-validation                           Quicker execution by reduced 
INFO:                                               internal cross-validation.
INFO:  -J <filename>
INFO:  --tab-out <filename>                         Output computed features to given 
INFO:                                               file in pin-tab format.
INFO:  -j <filename>
INFO:  --tab-in <filename>                          [set by default] Input file given 
INFO:                                               in pin-tab format. This is the 
INFO:                                               default setting, flag only present 
INFO:                                               for backwards compatibility.
INFO:  -k <filename>
INFO:  --xml-in <filename>                          Input file given in deprecated 
INFO:                                               pin-xml format generated by e.g. 
INFO:                                               sqt2pin with the -k option
INFO:  -w <filename>
INFO:  --weights <filename>                         Output final weights to given file
INFO:  -W <filename>
INFO:  --init-weights <filename>                    Read initial weights from given 
INFO:                                               file (one per line)
INFO:  -V <[-]?featureName>
INFO:  --default-direction <[-]?featureName>        Use given feature name as initial 
INFO:                                               search direction, can be negated 
INFO:                                               to indicate that a lower value is 
INFO:                                               better.
INFO:  -v <level>
INFO:  --verbose <level>                            Set verbosity of output: 0=no 
INFO:                                               processing info, 5=all. Default = 
INFO:                                               2
INFO:  -o
INFO:  --no-terminate                               Do not stop execution when 
INFO:                                               encountering questionable SVM 
INFO:                                               inputs or results.
INFO:  -u
INFO:  --unitnorm                                   Use unit normalization [0-1] 
INFO:                                               instead of standard deviation 
INFO:                                               normalization
INFO:  -R
INFO:  --test-each-iteration                        Measure performance on test set 
INFO:                                               each iteration
INFO:  -O
INFO:  --override                                   Override error check and do not 
INFO:                                               fall back on default score vector 
INFO:                                               in case of suspect score vector 
INFO:                                               from SVM.
INFO:  -S <value>
INFO:  --seed <value>                               Set seed of the random number 
INFO:                                               generator. Default = 1
INFO:  -D
INFO:  --doc                                        Include description of correct 
INFO:                                               features, i.e. features describing 
INFO:                                               the difference between the 
INFO:                                               observed and predicted isoelectric 
INFO:                                               point, retention time and 
INFO:                                               precursor mass.
INFO:  -K
INFO:  --klammer                                    Retention time features are 
INFO:                                               calculated as in Klammer et al. 
INFO:                                               Only available if -D is set.
INFO:  -r <filename>
INFO:  --results-peptides <filename>                Output tab delimited results of 
INFO:                                               peptides to a file instead of 
INFO:                                               stdout (will be ignored if used 
INFO:                                               with -U option)
INFO:  -B <filename>
INFO:  --decoy-results-peptides <filename>          Output tab delimited results for 
INFO:                                               decoy peptides into a file (will 
INFO:                                               be ignored if used with -U option)
INFO:  -m <filename>
INFO:  --results-psms <filename>                    Output tab delimited results of 
INFO:                                               PSMs to a file instead of stdout
INFO:  -M <filename>
INFO:  --decoy-results-psms <filename>              Output tab delimited results for 
INFO:                                               decoy PSMs into a file
INFO:  -U
INFO:  --only-psms                                  Do not remove redundant peptides, 
INFO:                                               keep all PSMS and exclude peptide 
INFO:                                               level probabilities.
INFO:  -y
INFO:  --post-processing-mix-max                    Use the mix-max method to assign 
INFO:                                               q-values and PEPs. Note that this 
INFO:                                               option only has an effect if the 
INFO:                                               input PSMs are from separate 
INFO:                                               target and decoy searches. This is 
INFO:                                               the default setting.
INFO:  -Y
INFO:  --post-processing-tdc                        Replace the mix-max method by 
INFO:                                               target-decoy competition for 
INFO:                                               assigning q-values and PEPs. If 
INFO:                                               the input PSMs are from separate 
INFO:                                               target and decoy searches, 
INFO:                                               Percolator's SVM scores will be 
INFO:                                               used to eliminate the lower 
INFO:                                               scoring target or decoy PSM(s) of 
INFO:                                               each scan+expMass combination. If 
INFO:                                               the input PSMs are detected to be 
INFO:                                               coming from a concatenated search, 
INFO:                                               this option will be turned on 
INFO:                                               automatically, as this is 
INFO:                                               incompatible with the mix-max 
INFO:                                               method. In case this detection 
INFO:                                               fails, turn this option on 
INFO:                                               explicitly.
INFO:  -I <value>
INFO:  --search-input <value>                       Specify the type of target-decoy 
INFO:                                               search: "auto" (Percolator 
INFO:                                               attempts to detect the search type 
INFO:                                               automatically), "concatenated" 
INFO:                                               (single search on concatenated 
INFO:                                               target-decoy protein db) or 
INFO:                                               "separate" (two searches, one 
INFO:                                               against target and one against 
INFO:                                               decoy protein db). Default = 
INFO:                                               "auto".
INFO:  -s
INFO:  --no-schema-validation                       Skip validation of input file 
INFO:                                               against xml schema.
INFO:  -f <value>
INFO:  --picked-protein <value>                     Use the picked protein-level FDR 
INFO:                                               to infer protein probabilities. 
INFO:                                               Provide the fasta file as the 
INFO:                                               argument to this flag, which will 
INFO:                                               be used for protein grouping based 
INFO:                                               on an in-silico digest. If no 
INFO:                                               fasta file is available or protein 
INFO:                                               grouping is not desired, set this 
INFO:                                               flag to "auto" to skip protein 
INFO:                                               grouping.
INFO:  -A
INFO:  --fido-protein                               Use the Fido algorithm to infer 
INFO:                                               protein probabilities
INFO:  -l <filename>
INFO:  --results-proteins <filename>                Output tab delimited results of 
INFO:                                               proteins to a file instead of 
INFO:                                               stdout (Only valid if option -A or 
INFO:                                               -f is active)
INFO:  -L <filename>
INFO:  --decoy-results-proteins <filename>          Output tab delimited results for 
INFO:                                               decoy proteins into a file (Only 
INFO:                                               valid if option -A or -f is 
INFO:                                               active)
INFO:  -P <value>
INFO:  --protein-decoy-pattern <value>              Define the text pattern to 
INFO:                                               identify decoy proteins in the 
INFO:                                               database for the picked-protein 
INFO:                                               algorithm. This will have no 
INFO:                                               effect on the target/decoy labels 
INFO:                                               specified in the input file. 
INFO:                                               Default = "random_".
INFO:  -z
INFO:  --protein-enzyme                             Type of enzyme 
INFO:                                               "no_enzyme","elastase","pepsin","p
INFO:                                               roteinasek","thermolysin","trypsin
INFO:                                               p","chymotrypsin","lys-n","lys-c",
INFO:                                               "arg-c","asp-n","glu-c","trypsin". 
INFO:                                               Default="trypsin".
INFO:  -c
INFO:  --protein-report-fragments                   By default, if the peptides 
INFO:                                               associated with protein A are a 
INFO:                                               proper subset of the peptides 
INFO:                                               associated with protein B, then 
INFO:                                               protein A is eliminated and all 
INFO:                                               the peptides are considered as 
INFO:                                               evidence for protein B. Note that 
INFO:                                               this filtering is done based on 
INFO:                                               the complete set of peptides in 
INFO:                                               the database, not based on the 
INFO:                                               identified peptides in the search 
INFO:                                               results. Alternatively, if this 
INFO:                                               option is set and if all of the 
INFO:                                               identified peptides associated 
INFO:                                               with protein B are also associated 
INFO:                                               with protein A, then Percolator 
INFO:                                               will report a comma-separated list 
INFO:                                               of protein IDs, where the 
INFO:                                               full-length protein B is first in 
INFO:                                               the list and the fragment protein 
INFO:                                               A is listed second. Commas inside 
INFO:                                               protein IDs will be replaced by 
INFO:                                               semicolons. Not available for 
INFO:                                               Fido.
INFO:  -g
INFO:  --protein-report-duplicates                  If this option is set and multiple 
INFO:                                               database proteins contain exactly 
INFO:                                               the same set of peptides, then the 
INFO:                                               IDs of these duplicated proteins 
INFO:                                               will be reported as a 
INFO:                                               comma-separated list, instead of 
INFO:                                               the default behavior of randomly 
INFO:                                               discarding all but one of the 
INFO:                                               proteins. Commas inside protein 
INFO:                                               IDs will be replaced by 
INFO:                                               semicolons. Not available for 
INFO:                                               Fido.
INFO:  -a <value>
INFO:  --fido-alpha <value>                         Set Fido's probability with which 
INFO:                                               a present protein emits an 
INFO:                                               associated peptide.        Set by 
INFO:                                               grid search if not specified.
INFO:  -b <value>
INFO:  --fido-beta <value>                          Set Fido's probability of creation 
INFO:                                               of a peptide from noise. Set by 
INFO:                                               grid search if not specified.
INFO:  -G <value>
INFO:  --fido-gamma <value>                         Set Fido's prior probability that 
INFO:                                               a protein is present in the 
INFO:                                               sample. Set by grid search if not 
INFO:                                               specified.
INFO:  -q
INFO:  --fido-empirical-protein-q                   Output empirical p-values and 
INFO:                                               q-values for Fido using 
INFO:                                               target-decoy analysis to XML 
INFO:                                               output (only valid if -X flag is 
INFO:                                               present).
INFO:  -d <value>
INFO:  --fido-gridsearch-depth <value>              Setting the gridsearch-depth to 0 
INFO:                                               (fastest), 1 or 2 (slowest) 
INFO:                                               controls how much computational 
INFO:                                               time is required for the 
INFO:                                               estimation of alpha, beta and 
INFO:                                               gamma parameters for Fido. Default 
INFO:                                               = 0.
INFO:  -T <value>
INFO:  --fido-fast-gridsearch <value>               Apply the specified threshold to 
INFO:                                               PSM, peptide and protein 
INFO:                                               probabilities to obtain a faster 
INFO:                                               estimate of the alpha, beta and 
INFO:                                               gamma parameters. Default = 0; 
INFO:                                               Recommended when set = 0.2.
INFO:  -C
INFO:  --fido-no-split-large-components             Do not approximate the posterior 
INFO:                                               distribution by allowing large 
INFO:                                               graph components to be split into 
INFO:                                               subgraphs. The splitting is done 
INFO:                                               by duplicating peptides with low 
INFO:                                               probabilities. Splitting continues 
INFO:                                               until the number of possible 
INFO:                                               configurations of each subgraph is 
INFO:                                               below 2^18.
INFO:  -E <value>
INFO:  --fido-protein-truncation-threshold <value>  To speed up inference, proteins 
INFO:                                               for which none of the associated 
INFO:                                               peptides has a probability 
INFO:                                               exceeding the specified threshold 
INFO:                                               will be assigned probability = 0. 
INFO:                                               Default = 0.01.
INFO:  -H <value>
INFO:  --fido-gridsearch-mse-threshold <value>      Q-value threshold that will be 
INFO:                                               used in the computation of the MSE 
INFO:                                               and ROC AUC score in the grid 
INFO:                                               search. Recommended 0.05 for 
INFO:                                               normal size datasets and 0.1 for 
INFO:                                               large datasets. Default = 0.1
INFO: [EXPERIMENTAL FEATURE]
INFO:  --nested-xval-bins <value>                   Number of nested cross validation 
INFO:                                               bins within each cross validation 
INFO:                                               bin. This should reduce 
INFO:                                               overfitting of the 
INFO:                                               hyperparameters. Default = 1.
INFO: [EXPERIMENTAL FEATURE]
INFO:  --spectral-counting-fdr <value>              Activates spectral counting on 
INFO:                                               protein level (either 
INFO:                                               --fido-protein or --picked-protein 
INFO:                                               has to be set) at the specified 
INFO:                                               PSM q-value threshold. Adds two 
INFO:                                               columns, "spec_count_unique" and 
INFO:                                               "spec_count_all", to the protein 
INFO:                                               tab separated output, containing 
INFO:                                               the spectral count for the 
INFO:                                               peptides unique to the protein and 
INFO:                                               the spectral count including 
INFO:                                               shared peptides respectively.
INFO: [EXPERIMENTAL FEATURE]
INFO:  --train-best-positive                        Enforce that, for each spectrum, 
INFO:                                               at most one PSM is included in the 
INFO:                                               positive set during each training 
INFO:                                               iteration. If the user only 
INFO:                                               provides one PSM per spectrum, 
INFO:                                               this filter will have no effect.
INFO: [EXPERIMENTAL FEATURE]
INFO:  --train-fdr-initial <value>                  Set the FDR threshold for the 
INFO:                                               first iteration. This is useful in 
INFO:                                               cases where the original features 
INFO:                                               do not display a good separation 
INFO:                                               between targets and decoys. In 
INFO:                                               subsequent iterations, the normal 
INFO:                                               --trainFDR will be used.
INFO: [EXPERIMENTAL FEATURE]
INFO:  --parameter-file <filename>                  Read flags from a parameter file. 
INFO:                                               If flags are specified on the 
INFO:                                               command line as well, these will 
INFO:                                               override the ones in the parameter 
INFO:                                               file.
INFO: 
INFO:
```


## crux_rankings

### Tool Description
A suite of tools for analyzing mass spectrometry data in proteomics.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find rankings in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_q-ranker

### Tool Description
Rank fragmentation spectra using search results.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux q-ranker [options] <fragmentation spectra> <search results>

REQUIRED ARGUMENTS:

  <fragmentation spectra> The fragmentation spectra must be provided in MS2,
  mzXML, or MGF format.

  <search results> Search results in the tab-delimited text format produced by
  Crux or in SQT format. Like the spectra, the search results can be provided as
  a single file, a list of files or a directory of files. Note, however, that
  the input mode for spectra and for search results must be the same; i.e., if
  you provide a list of files for the spectra, then you must also provide a list
  of files containing your search results. When the MS2 files and tab-delimited
  text files are provided via a file listing, it is assumed that the order of
  the MS2 files matches the order of the tab-delimited files. Alternatively,
  when the MS2 files and tab-delimited files are provided via directories, the
  program will search for pairs of files with the same root name but different
  extensions (".ms2" and ".txt").

OPTIONAL ARGUMENTS:

  [--enzyme no-enzyme|trypsin|trypsin/p|chymotrypsin|elastase|clostripain|cyanogen-bromide|iodosobenzoate|proline-endopeptidase|staph-protease|asp-n|lys-c|lys-n|arg-c|glu-c|pepsin-a|elastase-trypsin-chymotrypsin|custom-enzyme]
     Specify the enzyme used to digest the proteins in silico. Available enzymes
     (with the corresponding digestion rules indicated in parentheses) include
     no-enzyme ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin
     ([FWYL]|{P}), elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide
     ([M]|[]), iodosobenzoate ([W]|[]), proline-endopeptidase ([P]|[]),
     staph-protease ([E]|[]), asp-n ([]|[D]), lys-c ([K]|{P}), lys-n ([]|[K]),
     arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a ([FL]|{P}),
     elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
     no-enzyme yields a non-enzymatic digest. Warning: the resulting index may
     be quite large. Default = trypsin.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--separate-searches <string>]
     If the target and decoy searches were run separately, rather than using a
     concatenated database, then the program will assume that the database
     search results provided as a required argument are from the target database
     search. This option then allows the user to specify the location of the
     decoy search results. Like the required arguments, these search results can
     be provided as a single file, a list of files or a directory. However, the
     choice (file, list or directory) must be consistent for the MS2 files and
     the target and decoy tab-delimited files. Also, if the MS2 and
     tab-delimited files are provided in directories, then Q-ranker will use the
     MS2 filename (foo.ms2) to identify corresponding target and decoy
     tab-delimited files with names like foo*.target.txt and foo*.decoy.txt.
     This naming convention allows the target and decoy txt files to reside in
     the same directory. Default = <empty>.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--pepxml-output T|F]
     Output a pepXML results file to the output directory. Default = false.
  [--txt-output T|F]
     Output a tab-delimited results file to the output directory. Default =
     true.
  [--skip-cleanup T|F]
     Analysis begins with a pre-processsing step that creates a set of lookup
     tables which are then used during training. Normally, these lookup tables
     are deleted at the end of the analysis, but setting this option to T
     prevents the deletion of these tables. Subsequently, analyses can be
     repeated more efficiently by specifying the --re-run option. Default =
     false.
  [--re-run <string>]
     Re-run a previous analysis using a previously computed set of lookup
     tables. For this option to work, the --skip-cleanup option must have been
     set to true when the program was run the first time. Default = <empty>.
  [--use-spec-features T|F]
     Use an enriched feature set, including separate features for each ion type.
     Default = true.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--list-of-files T|F]
     Specify that the search results are provided as lists of files, rather than
     as individual files. Default = false.
  [--feature-file-out T|F]
     Output the computed features in tab-delimited Percolator input (.pin)
     format. The features will be normalized, using either unit norm or standard
     deviation normalization (depending upon the value of the unit-norm option).
     Default = false.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
```


## crux_barista

### Tool Description
Barista is a tool for identifying peptides from tandem mass spectra.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 3 arguments, but found 0

USAGE:

  crux barista [options] <database> <fragmentation spectra> <search results>

REQUIRED ARGUMENTS:

  <database> The program requires the FASTA format protein database files
  against which the search was performed. The protein database input may be a
  concatenated database or separate target and decoy databases; the latter is
  supported with the --separate-searches option, described below. In either
  case, Barista distinguishes between target and decoy proteins based on the
  presence of a decoy prefix on the sequence identifiers (see the --decoy-prefix
  option, below). The database can be provided in three different ways: (1) as a
  a single FASTA file with suffix ".fa", ".fsa" or ".fasta", (2) as a text file
  containing a list of FASTA files, one per line, or (3) as a directory
  containing multiple FASTA files (identified via the filename suffixes ".fa",
  ".fsa" or ".fasta").

  <fragmentation spectra> The fragmentation spectra must be provided in MS2,
  mzXML, or MGF format.

  <search results> Search results in the tab-delimited text format produced by
  Crux or in SQT format. Like the spectra, the search results can be provided as
  a single file, a list of files or a directory of files. Note, however, that
  the input mode for spectra and for search results must be the same; i.e., if
  you provide a list of files for the spectra, then you must also provide a list
  of files containing your search results. When the MS2 files and tab-delimited
  text files are provided via a file listing, it is assumed that the order of
  the MS2 files matches the order of the tab-delimited files. Alternatively,
  when the MS2 files and tab-delimited files are provided via directories, the
  program will search for pairs of files with the same root name but different
  extensions (".ms2" and ".txt").

OPTIONAL ARGUMENTS:

  [--enzyme no-enzyme|trypsin|trypsin/p|chymotrypsin|elastase|clostripain|cyanogen-bromide|iodosobenzoate|proline-endopeptidase|staph-protease|asp-n|lys-c|lys-n|arg-c|glu-c|pepsin-a|elastase-trypsin-chymotrypsin|custom-enzyme]
     Specify the enzyme used to digest the proteins in silico. Available enzymes
     (with the corresponding digestion rules indicated in parentheses) include
     no-enzyme ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin
     ([FWYL]|{P}), elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide
     ([M]|[]), iodosobenzoate ([W]|[]), proline-endopeptidase ([P]|[]),
     staph-protease ([E]|[]), asp-n ([]|[D]), lys-c ([K]|{P}), lys-n ([]|[K]),
     arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a ([FL]|{P}),
     elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
     no-enzyme yields a non-enzymatic digest. Warning: the resulting index may
     be quite large. Default = trypsin.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--separate-searches <string>]
     If the target and decoy searches were run separately, rather than using a
     concatenated database, then the program will assume that the database
     search results provided as a required argument are from the target database
     search. This option then allows the user to specify the location of the
     decoy search results. Like the required arguments, these search results can
     be provided as a single file, a list of files or a directory. However, the
     choice (file, list or directory) must be consistent for the MS2 files and
     the target and decoy tab-delimited files. Also, if the MS2 and
     tab-delimited files are provided in directories, then Q-ranker will use the
     MS2 filename (foo.ms2) to identify corresponding target and decoy
     tab-delimited files with names like foo*.target.txt and foo*.decoy.txt.
     This naming convention allows the target and decoy txt files to reside in
     the same directory. Default = <empty>.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--pepxml-output T|F]
     Output a pepXML results file to the output directory. Default = false.
  [--txt-output T|F]
     Output a tab-delimited results file to the output directory. Default =
     true.
  [--skip-cleanup T|F]
     Analysis begins with a pre-processsing step that creates a set of lookup
     tables which are then used during training. Normally, these lookup tables
     are deleted at the end of the analysis, but setting this option to T
     prevents the deletion of these tables. Subsequently, analyses can be
     repeated more efficiently by specifying the --re-run option. Default =
     false.
  [--re-run <string>]
     Re-run a previous analysis using a previously computed set of lookup
     tables. For this option to work, the --skip-cleanup option must have been
     set to true when the program was run the first time. Default = <empty>.
  [--use-spec-features T|F]
     Use an enriched feature set, including separate features for each ion type.
     Default = true.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--list-of-files T|F]
     Specify that the search results are provided as lists of files, rather than
     as individual files. Default = false.
  [--feature-file-out T|F]
     Output the computed features in tab-delimited Percolator input (.pin)
     format. The features will be normalized, using either unit norm or standard
     deviation normalization (depending upon the value of the unit-norm option).
     Default = false.
  [--optimization protein|peptide|psm]
     Specifies whether to do optimization at the protein, peptide or psm level.
     Default = protein.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
```


## crux_confidence

### Tool Description
Crux supports the following primary commands and utility commands.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find confidence in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_search-for-xlinks

### Tool Description
Search for cross-linked peptides in MS2 and FASTA files.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 4 arguments, but found 0

USAGE:

  crux search-for-xlinks [options] <ms2 file>+ <protein fasta file> <link sites> <link mass>

REQUIRED ARGUMENTS:

  <ms2 file>+ The name of one or more files from which to parse the
  fragmentation spectra, in any of the file formats supported by ProteoWizard.

  <protein fasta file> The name of the file in FASTA format from which to
  retrieve proteins.

  <link sites> Specification of the the two sets of amino acids that the
  cross-linker can connect. These are specified as two comma-separated sets of
  amino acids, with the two sets separated by a colon. Cross-links involving the
  terminus of a protein can be specified by using "nterm" or "cterm". For
  example, "K,nterm:Q" means that the cross linker can attach K to Q or the
  protein N-terminus to Q. Note that the vast majority of cross-linkers will
  operate on the following reactive groups: amine (K,nterm), carboxyl
  (D,E,cterm), sulfhydrl (C), acyl (Q) or amine+ (K,S,T,Y,nterm).

  <link mass> The mass modification of the linker when attached to a peptide.

OPTIONAL ARGUMENTS:

  [--use-old-xlink T|F]
     Use the old version of xlink-searching algorithm. When false, a new version
     of the code is run. The new version supports variable modifications and can
     handle more complex databases. This new code is still in development and
     should be considered a beta release. Default = true.
  [--xlink-include-linears T|F]
     Include linear peptides in the search. Default = true.
  [--xlink-include-deadends T|F]
     Include dead-end peptides in the search. Default = true.
  [--xlink-include-selfloops T|F]
     Include self-loop peptides in the search. Default = true.
  [--xlink-include-inter T|F]
     Include inter-protein cross-link candidates within the search. Default =
     true.
  [--xlink-include-intra T|F]
     Include intra-protein cross-link candiates within the search. Default =
     true.
  [--xlink-include-inter-intra T|F]
     Include crosslink candidates that are both inter and intra. Default = true.
  [--xlink-prevents-cleavage <string>]
     List of amino acids for which the cross-linker can prevent cleavage. This
     option is only available when use-old-xlink=F. Default = K.
  [--require-xlink-candidate T|F]
     If there is no cross-link candidate found, then don't bother looking for
     linear, self-loop, and dead-link candidates. Default = false.
  [--xlink-top-n <integer>]
     Specify the number of open-mod peptides to consider in the second pass. A
     value of 0 will search all candiates. Default = 250.
  [--max-xlink-mods <integer>]
     Specify the maximum number of modifications allowed on a crosslinked
     peptide. This option is only available when use-old-xlink=F. Default = 255.
  [--min-mass <float>]
     The minimum mass (in Da) of peptides to consider. Default = 200.
  [--max-mass <float>]
     The maximum mass (in Da) of peptides to consider. Default = 7200.
  [--min-length <integer>]
     The minimum length of peptides to consider. Default = 6.
  [--max-length <integer>]
     The maximum length of peptides to consider. Default = 50.
  [--mods-spec <string>]
     Expression for static and variable mass modifications to include. Specify a
     comma-separated list of modification sequences of the form:
     C+57.02146,2M+15.9949,1STY+79.966331,... Default = C+57.02146.
  [--cmod <string>]
     Specify a variable modification to apply to C-terminus of peptides. . Note
     that this parameter only takes effect when specified in the parameter file.
     Default = NO MODS.
  [--nmod <string>]
     Specify a variable modification to apply to N-terminus of peptides.  . Note
     that this parameter only takes effect when specified in the parameter file.
     Default = NO MODS.
  [--max-mods <integer>]
     The maximum number of modifications that can be applied to a single
     peptide. Default = 255.
  [--mono-link <string>]
     Provides a list of amino acids and their mass modifications to consider as
     candidate for mono-/dead- links.  Format is the same as mods-spec. Default
     = <empty>.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--enzyme no-enzyme|trypsin|trypsin/p|chymotrypsin|elastase|clostripain|cyanogen-bromide|iodosobenzoate|proline-endopeptidase|staph-protease|asp-n|lys-c|lys-n|arg-c|glu-c|pepsin-a|elastase-trypsin-chymotrypsin|custom-enzyme]
     Specify the enzyme used to digest the proteins in silico. Available enzymes
     (with the corresponding digestion rules indicated in parentheses) include
     no-enzyme ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin
     ([FWYL]|{P}), elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide
     ([M]|[]), iodosobenzoate ([W]|[]), proline-endopeptidase ([P]|[]),
     staph-protease ([E]|[]), asp-n ([]|[D]), lys-c ([K]|{P}), lys-n ([]|[K]),
     arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a ([FL]|{P}),
     elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
     no-enzyme yields a non-enzymatic digest. Warning: the resulting index may
     be quite large. Default = trypsin.
  [--custom-enzyme <string>]
     Specify rules for in silico digestion of protein sequences. Overrides the
     enzyme option. Two lists of residues are given enclosed in square brackets
     or curly braces and separated by a |. The first list contains residues
     required/prohibited before the cleavage site and the second list is
     residues after the cleavage site. If the residues are required for
     digestion, they are in square brackets, '[' and ']'. If the residues
     prevent digestion, then they are enclosed in curly braces, '{' and '}'. Use
     X to indicate all residues. For example, trypsin cuts after R or K but not
     before P which is represented as [RK]|{P}. AspN cuts after any residue but
     only before D which is represented as [X]|[D]. To prevent the sequences
     from being digested at all, use [Z]|[Z]. Default = <empty>.
  [--digestion full-digest|partial-digest|non-specific-digest]
     Specify whether every peptide in the database must have two enzymatic
     termini (full-digest) or if peptides with only one enzymatic terminus are
     also included (partial-digest). Default = full-digest.
  [--missed-cleavages <integer>]
     Maximum number of missed cleavages per peptide to allow in enzymatic
     digestion. Default = 0.
  [--spectrum-min-mz <float>]
     The lowest spectrum m/z to search in the ms2 file. Default = 0.
  [--spectrum-max-mz <float>]
     The highest spectrum m/z to search in the ms2 file. Default = 1e+09.
  [--spectrum-charge 1|2|3|all]
     The spectrum charges to search. With 'all' every spectrum will be searched
     and spectra with multiple charge states will be searched once at each
     charge state. With 1, 2, or 3 only spectra with that charge state will be
     searched. Default = all.
  [--compute-sp T|F]
     Compute the preliminary score Sp for all candidate peptides. Report this
     score in the output, along with the corresponding rank, the number of
     matched ions and the total number of ions. This option is recommended if
     results are to be analyzed by Percolator or Barista. If sqt-output is
     enabled, then compute-sp is automatically enabled and cannot be overridden.
     Note that the Sp computation requires re-processing each observed spectrum,
     so turning on this switch involves significant computational overhead.
     Default = false.
  [--precursor-window <float>]
     Tolerance used for matching peptides to spectra. Peptides must be within
     +/- 'precursor-window' of the spectrum value. The precursor window units
     depend upon precursor-window-type. Default = 3.
  [--precursor-window-type mass|mz|ppm]
     Specify the units for the window that is used to select peptides around the
     precursor mass location (mass, mz, ppm). The magnitude of the window is
     defined by the precursor-window option, and candidate peptides must fall
     within this window. For the mass window-type, the spectrum precursor m+h
     value is converted to mass, and the window is defined as that mass +/-
     precursor-window. If the m+h value is not available, then the mass is
     calculated from the precursor m/z and provided charge. The peptide mass is
     computed as the sum of the average amino acid masses plus 18 Da for the
     terminal OH group. The mz window-type calculates the window as spectrum
     precursor m/z +/- precursor-window and then converts the resulting m/z
     range to the peptide mass range using the precursor charge. For the
     parts-per-million (ppm) window-type, the spectrum mass is calculated as in
     the mass type. The lower bound of the mass window is then defined as the
     spectrum mass / (1.0 + (precursor-window / 1000000)) and the upper bound is
     defined as spectrum mass / (1.0 - (precursor-window / 1000000)). Default =
     mass.
  [--precursor-window-weibull <float>]
     Search decoy peptides within +/- precursor-window-weibull of the precursor
     mass. The resulting scores are used only for fitting the Weibull
     distribution Default = 20.
  [--precursor-window-type-weibull mass|mz|ppm]
     Window type to use in conjunction with the precursor-window-weibull
     parameter. Default = mass.
  [--min-weibull-points <integer>]
     Keep shuffling and collecting XCorr scores until the minimum number of
     points for weibull fitting (using targets and decoys) is achieved. Default
     = 4000.
  [--use-a-ions T|F]
     Consider a-ions in the search? Note that an a-ion is equivalent to a
     neutral loss of CO from the b-ion.  Peak height is 10 (in arbitrary units).
     Default = false.
  [--use-b-ions T|F]
     Consider b-ions in the search? Peak height is 50 (in arbitrary units).
     Default = true.
  [--use-c-ions T|F]
     Consider c-ions in the search? Peak height is 50 (in arbitrary units).
     Default = false.
  [--use-x-ions T|F]
     Consider x-ions in the search? Peak height is 10 (in arbitrary units).
     Default = false.
  [--use-y-ions T|F]
     Consider y-ions in the search? Peak height is 50 (in arbitrary units).
     Default = true.
  [--use-z-ions T|F]
     Consider z-ions in the search? Peak height is 50 (in arbitrary units).
     Default = false.
  [--file-column T|F]
     Include the file column in tab-delimited output. Default = true.
  [--max-ion-charge <string>]
     Predict theoretical ions up to max charge state (1, 2, ... ,6) or up to the
     charge state of the peptide ("peptide"). If the max-ion-charge is greater
     than the charge state of the peptide, then the maximum is the peptide
     charge.  Default = peptide.
  [--scan-number <string>]
     A single scan number or a range of numbers to be searched. Range should be
     specified as 'first-last' which will include scans 'first' and 'last'.
     Default = <empty>.
  [--mz-bin-width <float>]
     Before calculation of the XCorr score, the m/z axes of the observed and
     theoretical spectra are discretized. This parameter specifies the size of
     each bin. The exact formula for computing the discretized m/z value is
     floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
     value. For low resolution ion trap ms/ms data 1.0005079 and for high
     resolution ms/ms 0.02 is recommended. Default = 1.0005079.
  [--mz-bin-offset <float>]
     In the discretization of the m/z axes of the observed and theoretical
     spectra, this parameter specifies the location of the left edge of the
     first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
     edge of the first bin will be located at +0.xx Da). Default = 0.4.
  [--mod-mass-format mod-only|total|separate]
     Specify how sequence modifications are reported in various output files.
     Each modification is reported as a number enclosed in square braces
     following the modified residue; however, the number may correspond to one
     of three different masses: (1) 'mod-only' reports the value of the mass
     shift induced by the modification; (2) 'total' reports the mass of the
     residue with the modification (residue mass plus modification mass); (3)
     'separate' is the same as 'mod-only', but multiple modifications to a
     single amino acid are reported as a comma-separated list of values. For
     example, suppose amino acid D has an unmodified mass of 115 as well as two
     moifications of masses +14 and +2. In this case, the amino acid would be
     reported as D[16] with 'mod-only', D[131] with 'total', and D[14,2] with
     'separate'. Default = mod-only.
  [--use-flanking-peaks T|F]
     Include flanking peaks around singly charged b and y theoretical ions. Each
     flanking peak occurs in the adjacent m/z bin and has half the intensity of
     the primary peak. Default = false.
  [--fragment-mass average|mono]
     Specify which isotopes to use in calculating fragment ion mass. Default =
     mono.
  [--isotopic-mass average|mono]
     Specify the type of isotopic masses to use when calculating the peptide
     mass. Default = mono.
  [--isotope-windows <string>]
     Provides a list of isotopic windows to search. For example, -1,0,1 will
     search in three disjoint windows: (1) precursor_mass - neutron_mass +/-
     window, (2) precursor_mass +/- window, and (3) precursor_mass +
     neutron_mass +/- window. The window size is defined from the
     precursor-window and precursor-window-type parameters. This option is only
     available when use-old-xlink=F. Default = 0.
  [--compute-p-values T|F]
     Estimate the parameters of the score distribution for each spectrum by
     fitting to a Weibull distribution, and compute a p-value for each xlink
     product. This option is only available when use-old-xlink=F. Default =
     false.
  [--seed <string>]
     When given a unsigned integer value seeds the random number generator with
     that value. When given the string "time" seeds the random number generator
     with the system time. Default = 1.
  [--concat T|F]
     When set to T, target and decoy search results are reported in a single
     file, and only the top-scoring N matches (as specified via --top-match) are
     reported for each spectrum, irrespective of whether the matches involve
     target or decoy peptides.Note that when used with search-for-xlinks, this
     parameter only has an effect if use-old-xlink=F. Default = false.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
  [--top-match <integer>]
     Specify the number of matches to report for each spectrum. Default = 5.
  [--print-search-progress <integer>]
     Show search progress by printing every n spectra searched. Set to 0 to show
     no search progress. Default = 1000.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_corresponding

### Tool Description
Supports a variety of commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find corresponding in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_scored

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry proteomics data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find scored in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_spectral-counts

### Tool Description
Calculate spectral counts for PSMs.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 1 arguments, but found 0

USAGE:

  crux spectral-counts [options] <input PSMs>

REQUIRED ARGUMENTS:

  <input PSMs> A PSM file in either tab delimited text format (as produced by
  percolator, q-ranker, or barista) or pepXML format.

OPTIONAL ARGUMENTS:

  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--parsimony none|simple|greedy]
     Perform a parsimony analysis on the proteins, and report a "parsimony rank"
     column in the output file. This column contains integers indicating the
     protein's rank in a list sorted by spectral counts. If the parsimony
     analysis results in two proteins being merged, then their parsimony rank is
     the same. In such a case, the rank is assigned based on the largest
     spectral count of any protein in the merged meta-protein. The "simple"
     parsimony algorithm only merges two proteins A and B if the peptides
     identified in protein A are the same as or a subset of the peptides
     identified in protein B. The "greedy" parsimony algorithm does additional
     merging, using the peptide q-values to greedily assign each peptide to a
     single protein. Default = none.
  [--threshold <float>]
     Only consider PSMs with a threshold value. By default, q-values are
     thresholded using a specified threshold value. This behavior can be changed
     using the --custom-threshold and --threshold-min parameters. Default =
     0.01.
  [--threshold-type none|qvalue|custom]
     Determines what type of threshold to use when filtering matches. none :
     read all matches, qvalue : use calculated q-value from percolator or
     q-ranker, custom : use --custom-threshold-name and --custom-threshold-min
     parameters. Default = qvalue.
  [--input-ms2 <string>]
     MS2 file corresponding to the psm file. Required to measure the SIN.
     Ignored for NSAF, dNSAF and EMPAI. Default = <empty>.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--unique-mapping T|F]
     Ignore peptides that map to multiple proteins. Default = false.
  [--quant-level protein|peptide]
     Quantification at protein or peptide level. Default = protein.
  [--measure RAW|NSAF|dNSAF|SIN|EMPAI]
     Type of analysis to make on the match results: (RAW|NSAF|dNSAF|SIN|EMPAI).
     With exception of the RAW metric, the database of sequences need to be
     provided using --protein-database. Default = NSAF.
  [--custom-threshold-name <string>]
     Specify which field to apply the threshold to. The direction of the
     threshold (<= or >=) is governed by --custom-threshold-min. By default, the
     threshold applies to the q-value, specified by "percolator q-value",
     "q-ranker q-value", "decoy q-value (xcorr)", or "barista q-value". Default
     = <empty>.
  [--custom-threshold-min T|F]
     When selecting matches with a custom threshold, custom-threshold-min
     determines whether to filter matches with custom-threshold-name values that
     are greater-than or equal (F) or less-than or equal (T) than the threshold.
     Default = true.
  [--mzid-use-pass-threshold T|F]
     Use mzid's passThreshold attribute to filter matches. Default = false.
  [--protein-database <string>]
     The name of the file in FASTA format. Default = <empty>.
```


## crux_spectral

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry proteomics data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find spectral in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_pipeline

### Tool Description
Run the Crux pipeline for peptide identification.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 2 arguments, but found 0

USAGE:

  crux pipeline [options] <mass spectra>+ <peptide source>

REQUIRED ARGUMENTS:

  <mass spectra>+ The name of the file(s) from which to parse the fragmentation
  spectra, in any of the file formats supported by ProteoWizard. Alteratively,
  with Tide-search, these files may be binary spectrum files produced by a
  previous run of crux tide-search using the store-spectra parameter.

  <peptide source> Either the name of a file in fasta format from which to
  retrieve proteins and peptides or an index created by a previous run of crux
  tide-index (for Tide searching).

OPTIONAL ARGUMENTS:

  [--bullseye T|F]
     Run the Bullseye algorithm on the given MS data, using it to assign
     high-resolution precursor values to the MS/MS data. If a spectrum file ends
     with .ms2 or .cms2, matching .ms1/.cms1 files will be used as the MS1 file.
     Otherwise, it is assumed that the spectrum file contains both MS1 and MS2
     scans. Default = false.
  [--search-engine comet|tide-search]
     Specify which search engine to use. Default = tide-search.
  [--post-processor percolator|assign-confidence|none]
     Specify which post-processor to apply to the search results. Default =
     percolator.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--max-persist <float>]
     Ignore PPIDs that persist for longer than this length of time in the MS1
     spectra. The unit of time is whatever unit is used in your data file
     (usually minutes). These PPIDs are considered contaminants. Default = 2.
  [--exact-match T|F]
     When true, require an exact match (as defined by --exact-tolerance) between
     the center of the precursor isolation window in the MS2 scan and the base
     isotopic peak of the PPID. If this option is set to false and no exact
     match is observed, then attempt to match using a wider m/z tolerance. This
     wider tolerance is calculated using the PPID's monoisotopic mass and charge
     (the higher the charge, the smaller the window). Default = false.
  [--exact-tolerance <float>]
     Set the tolerance (+/-ppm) for --exact-match. Default = 10.
  [--persist-tolerance <float>]
     Set the mass tolerance (+/-ppm) for finding PPIDs in consecutive MS1 scans.
     Default = 10.
  [--gap-tolerance <integer>]
     Allowed gap size when checking for PPIDs across consecutive MS1 scans.
     Default = 1.
  [--scan-tolerance <integer>]
     Total number of MS1 scans over which a PPID must be observed to be
     considered real. Gaps in persistence are allowed by setting
     --gap-tolerance. Default = 3.
  [--bullseye-max-mass <float>]
     Only consider PPIDs below this maximum mass in daltons. Default = 8000.
  [--bullseye-min-mass <float>]
     Only consider PPIDs above this minimum mass in daltons. Default = 600.
  [--retention-tolerance <float>]
     Set the tolerance (+/-units) around the retention time over which a PPID
     can be matches to the MS2 spectrum. The unit of time is whatever unit is
     used in your data file (usually minutes). Default = 0.5.
  [--spectrum-format |ms2|bms2|cms2|mgf]
     The format to write the output spectra to. If empty, the spectra will be
     output in the same format as the MS2 input. Default = <empty>.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--auto-mz-bin-width false|warn|fail]
     Automatically estimate optimal value for the mz-bin-width parameter from
     the spectra themselves. false=no estimation, warn=try to estimate but use
     the default value in case of failure, fail=try to estimate and quit in case
     of failure. Default = false.
  [--auto-precursor-window false|warn|fail]
     Automatically estimate optimal value for the precursor-window parameter
     from the spectra themselves. false=no estimation, warn=try to estimate but
     use the default value in case of failure, fail=try to estimate and quit in
     case of failure. Default = false.
  [--compute-sp T|F]
     Compute the preliminary score Sp for all candidate peptides. Report this
     score in the output, along with the corresponding rank, the number of
     matched ions and the total number of ions. This option is recommended if
     results are to be analyzed by Percolator or Barista. If sqt-output is
     enabled, then compute-sp is automatically enabled and cannot be overridden.
     Note that the Sp computation requires re-processing each observed spectrum,
     so turning on this switch involves significant computational overhead.
     Default = false.
  [--concat T|F]
     When set to T, target and decoy search results are reported in a single
     file, and only the top-scoring N matches (as specified via --top-match) are
     reported for each spectrum, irrespective of whether the matches involve
     target or decoy peptides.Note that when used with search-for-xlinks, this
     parameter only has an effect if use-old-xlink=F. Default = false.
  [--deisotope <float>]
     Perform a simple deisotoping operation across each MS2 spectrum. For each
     peak in an MS2 spectrum, consider lower m/z peaks. If the current peak
     occurs where an expected peak would lie for any charge state less than the
     charge state of the precursor, within mass tolerance, and if the current
     peak is of lower abundance, then the peak is removed.  The value of this
     parameter is the mass tolerance, in units of parts-per-million.  If set to
     0, no deisotoping is performed. Default = 0.
  [--exact-p-value T|F]
     Enable the calculation of exact p-values for the XCorr score. Calculation
     of p-values increases the running time but increases the number of
     identifications at a fixed confidence threshold. The p-values will be
     reported in a new column with header "exact p-value", and the "xcorr score"
     column will be replaced with a "refactored xcorr" column. Note that,
     currently, p-values can only be computed when the mz-bin-width parameter is
     set to its default value. Variable and static mods are allowed on
     non-terminal residues in conjunction with p-value computation, but
     currently only static mods are allowed on the N-terminus, and no mods on
     the C-terminus. Default = false.
  [--file-column T|F]
     Include the file column in tab-delimited output. Default = true.
  [--isotope-error <string>]
     List of positive, non-zero integers. Default = <empty>.
  [--mass-precision <integer>]
     Set the precision for masses and m/z written to sqt and text files. Default
     = 4.
  [--max-precursor-charge <integer>]
     The maximum charge state of a spectra to consider in search. Default = 5.
  [--min-peaks <integer>]
     The minimum number of peaks a spectrum must have for it to be searched.
     Default = 20.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--mz-bin-offset <float>]
     In the discretization of the m/z axes of the observed and theoretical
     spectra, this parameter specifies the location of the left edge of the
     first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
     edge of the first bin will be located at +0.xx Da). Default = 0.4.
  [--mz-bin-width <float>]
     Before calculation of the XCorr score, the m/z axes of the observed and
     theoretical spectra are discretized. This parameter specifies the size of
     each bin. The exact formula for computing the discretized m/z value is
     floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
     value. For low resolution ion trap ms/ms data 1.0005079 and for high
     resolution ms/ms 0.02 is recommended. Default = 1.0005079.
  [--mzid-output T|F]
     Output an mzIdentML results file to the output directory. Default = false.
  [--num-threads <integer>]
     0=poll CPU to set num threads; else specify num threads directly. Default =
     0.
  [--peptide-centric-search T|F]
     Carries out a peptide-centric search. For each peptide the top-scoring
     spectra are reported, in contrast to the standard spectrum-centric search
     where the top-scoring peptides are reported. Note that in this case the
     "xcorr rank" column will contain the rank of the given spectrum with
     respect to the given candidate peptide, rather than vice versa (which is
     the default). Default = false.
  [--score-function xcorr|residue-evidence|both]
     Function used for scoring PSMs. 'xcorr' is the original scoring function
     used by SEQUEST; 'residue-evidence' is designed to score high-resolution
     MS2 spectra; and 'both' calculates both scores. The latter requires that
     exact-p-value=T. Default = xcorr.
  [--fragment-tolerance <float>]
     Mass tolerance (in Da) for scoring pairs of peaks when creating the residue
     evidence matrix. This parameter only makes sense when score-function is
     'residue-evidence' or 'both'. Default = 0.02.
  [--evidence-granularity <integer>]
     When exact-pvalue=T, this parameter controls the granularity of the entries
     in the dynamic programming matrix.  Smaller values make the program run
     faster but give less exact p-values; larger values make the program run
     more slowly but give more exact p-values. Default = 25.
  [--pepxml-output T|F]
     Output a pepXML results file to the output directory. Default = false.
  [--pin-output T|F]
     Output a Percolator input (PIN) file to the output directory. Default =
     false.
  [--pm-charge <integer>]
     Precursor charge state to consider MS/MS spectra from, in measurement error
     estimation. Ideally, this should be the most frequently occurring charge
     state in the given data. Default = 2.
  [--pm-max-frag-mz <float>]
     Maximum fragment m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-precursor-delta-ppm <float>]
     Maximum ppm distance between precursor m/z values to consider two scans
     potentially generated by the same peptide for measurement error estimation.
     Default = 50.
  [--pm-max-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-scan-separation <integer>]
     Maximum number of scans two spectra can be separated by in order to be
     considered potentially generated by the same peptide, for measurement error
     estimation. Default = 1000.
  [--pm-min-common-frag-peaks <integer>]
     Number of the most-intense peaks that two spectra must share in order to
     potentially be generated by the same peptide, for measurement error
     estimation. Default = 20.
  [--pm-min-frag-mz <float>]
     Minimum fragment m/z value to use in measurement error estimation. Default
     = 150.
  [--pm-min-peak-pairs <integer>]
     Minimum number of peak pairs (for precursor or fragment) that must be
     successfully paired in order to attempt to estimate measurement error
     distribution. Default = 100.
  [--pm-min-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 400.
  [--pm-min-scan-frag-peaks <integer>]
     Minimum fragment peaks an MS/MS scan must contain to be used in measurement
     error estimation. Default = 40.
  [--pm-pair-top-n-frag-peaks <integer>]
     Number of fragment peaks per spectrum pair to be used in fragment error
     estimation. Default = 5.
  [--pm-top-n-frag-peaks <integer>]
     Number of most-intense fragment peaks to consider for measurement error
     estimation, per MS/MS spectrum. Default = 30.
  [--precision <integer>]
     Set the precision for scores written to sqt and text files. Default = 8.
  [--precursor-window <float>]
     Tolerance used for matching peptides to spectra. Peptides must be within
     +/- 'precursor-window' of the spectrum value. The precursor window units
     depend upon precursor-window-type. Default = 3.
  [--precursor-window-type mass|mz|ppm]
     Specify the units for the window that is used to select peptides around the
     precursor mass location (mass, mz, ppm). The magnitude of the window is
     defined by the precursor-window option, and candidate peptides must fall
     within this window. For the mass window-type, the spectrum precursor m+h
     value is converted to mass, and the window is defined as that mass +/-
     precursor-window. If the m+h value is not available, then the mass is
     calculated from the precursor m/z and provided charge. The peptide mass is
     computed as the sum of the average amino acid masses plus 18 Da for the
     terminal OH group. The mz window-type calculates the window as spectrum
     precursor m/z +/- precursor-window and then converts the resulting m/z
     range to the peptide mass range using the precursor charge. For the
     parts-per-million (ppm) window-type, the spectrum mass is calculated as in
     the mass type. The lower bound of the mass window is then defined as the
     spectrum mass / (1.0 + (precursor-window / 1000000)) and the upper bound is
     defined as spectrum mass / (1.0 - (precursor-window / 1000000)). Default =
     mass.
  [--print-search-progress <integer>]
     Show search progress by printing every n spectra searched. Set to 0 to show
     no search progress. Default = 1000.
  [--remove-precursor-peak T|F]
     If true, all peaks around the precursor m/z will be removed, within a range
     specified by the --remove-precursor-tolerance option. Default = false.
  [--remove-precursor-tolerance <float>]
     This parameter specifies the tolerance (in Th) around each precursor m/z
     that is removed when the --remove-precursor-peak option is invoked. Default
     = 1.5.
  [--scan-number <string>]
     A single scan number or a range of numbers to be searched. Range should be
     specified as 'first-last' which will include scans 'first' and 'last'.
     Default = <empty>.
  [--skip-preprocessing T|F]
     Skip preprocessing steps on spectra. Default = F. Default = false.
  [--spectrum-charge 1|2|3|all]
     The spectrum charges to search. With 'all' every spectrum will be searched
     and spectra with multiple charge states will be searched once at each
     charge state. With 1, 2, or 3 only spectra with that charge state will be
     searched. Default = all.
  [--spectrum-max-mz <float>]
     The highest spectrum m/z to search in the ms2 file. Default = 1e+09.
  [--spectrum-min-mz <float>]
     The lowest spectrum m/z to search in the ms2 file. Default = 0.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--sqt-output T|F]
     Outputs an SQT results file to the output directory. Note that if
     sqt-output is enabled, then compute-sp is automatically enabled and cannot
     be overridden. Default = false.
  [--store-index <string>]
     When providing a FASTA file as the index, the generated binary index will
     be stored at the given path. This option has no effect if a binary index is
     provided as the index. Default = <empty>.
  [--store-spectra <string>]
     Specify the name of the file where the binarized fragmentation spectra will
     be stored. Subsequent runs of crux tide-search will execute more quickly if
     provided with the spectra in binary format. The filename is specified
     relative to the current working directory, not the Crux output directory
     (as specified by --output-dir). This option is not valid if multiple input
     spectrum files are given. Default = <empty>.
  [--top-match <integer>]
     Specify the number of matches to report for each spectrum. Default = 5.
  [--txt-output T|F]
     Output a tab-delimited results file to the output directory. Default =
     true.
  [--use-flanking-peaks T|F]
     Include flanking peaks around singly charged b and y theoretical ions. Each
     flanking peak occurs in the adjacent m/z bin and has half the intensity of
     the primary peak. Default = false.
  [--use-neutral-loss-peaks T|F]
     Controls whether neutral loss ions are considered in the search. Two types
     of neutral losses are included and are applied only to singly charged b-
     and y-ions: loss of ammonia (NH3, 17.0086343 Da) and H2O (18.0091422). Each
     neutral loss peak has intensity 1/5 of the primary peak. Default = true.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
  [--decoy_search <integer>]
     0=no, 1=concatenated search, 2=separate search. Default = 0.
  [--num_threads <integer>]
     0=poll CPU to set num threads; else specify num threads directly. Default =
     0.
  [--peptide_mass_tolerance <float>]
     Controls the mass tolerance value.  The mass tolerance is set at +/- the
     specified number i.e. an entered value of "1.0" applies a -1.0 to +1.0
     tolerance. The units of the mass tolerance is controlled by the parameter
     "peptide_mass_units".  Default = 3.
  [--auto_peptide_mass_tolerance false|warn|fail]
     Automatically estimate optimal value for the peptide_mass_tolerancel
     parameter from the spectra themselves. false=no estimation, warn=try to
     estimate but use the default value in case of failure, fail=try to estimate
     and quit in case of failure. Default = false.
  [--peptide_mass_units <integer>]
     0=amu, 1=mmu, 2=ppm. Default = 0.
  [--mass_type_parent <integer>]
     0=average masses, 1=monoisotopic masses. Default = 1.
  [--mass_type_fragment <integer>]
     0=average masses, 1=monoisotopic masses. Default = 1.
  [--precursor_tolerance_type <integer>]
     0=singly charged peptide mass, 1=precursor m/z. Default = 0.
  [--isotope_error <integer>]
     0=off, 1=on -1/0/1/2/3 (standard C13 error), 2=-8/-4/0/4/8 (for +4/+8
     labeling). Default = 0.
  [--search_enzyme_number <integer>]
     Specify a search enzyme from the end of the parameter file. Default = 1.
  [--num_enzyme_termini <integer>]
     valid values are 1 (semi-digested), 2 (fully digested), 8 N-term, 9 C-term.
     Default = 2.
  [--allowed_missed_cleavage <integer>]
     Maximum value is 5; for enzyme search. Default = 2.
  [--fragment_bin_tol <float>]
     Binning to use on fragment ions. Default = 1.000507.
  [--fragment_bin_offset <float>]
     Offset position to start the binning (0.0 to 1.0). Default = 0.4.
  [--auto_fragment_bin_tol false|warn|fail]
     Automatically estimate optimal value for the fragment_bin_tol parameter
     from the spectra themselves. false=no estimation, warn=try to estimate but
     use the default value in case of failure, fail=try to estimate and quit in
     case of failure. Default = false.
  [--theoretical_fragment_ions <integer>]
     0=default peak shape, 1=M peak only. Default = 1.
  [--use_A_ions <integer>]
     Controls whether or not A-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_B_ions <integer>]
     Controls whether or not B-ions are considered in the search (0 - no, 1 -
     yes). Default = 1.
  [--use_C_ions <integer>]
     Controls whether or not C-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_X_ions <integer>]
     Controls whether or not X-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_Y_ions <integer>]
     Controls whether or not Y-ions are considered in the search (0 - no, 1 -
     yes). Default = 1.
  [--use_Z_ions <integer>]
     Controls whether or not Z-ions are considered in the search (0 - no, 1 -
     yes). Default = 0.
  [--use_NL_ions <integer>]
     0=no, 1= yes to consider NH3/H2O neutral loss peak. Default = 1.
  [--output_sqtfile <integer>]
     0=no, 1=yes  write sqt file. Default = 0.
  [--output_txtfile <integer>]
     0=no, 1=yes  write tab-delimited text file. Default = 1.
  [--output_pepxmlfile <integer>]
     0=no, 1=yes  write pep.xml file. Default = 1.
  [--output_percolatorfile <integer>]
     0=no, 1=yes write percolator file. Default = 0.
  [--output_outfiles <integer>]
     0=no, 1=yes  write .out files. Default = 0.
  [--print_expect_score <integer>]
     0=no, 1=yes to replace Sp with expect in out & sqt. Default = 1.
  [--num_output_lines <integer>]
     num peptide results to show. Default = 5.
  [--show_fragment_ions <integer>]
     0=no, 1=yes for out files only. Default = 0.
  [--sample_enzyme_number <integer>]
     Sample enzyme which is possibly different than the one applied to the
     search. Used to calculate NTT & NMC in pepXML output. Default = 1.
  [--scan_range <string>]
     Start and scan scan range to search; 0 as first entry ignores parameter.
     Default = 0 0.
  [--precursor_charge <string>]
     Precursor charge range to analyze; does not override mzXML charge; 0 as
     first entry ignores parameter. Default = 0 0.
  [--override_charge <integer>]
     Specifies the whether to override existing precursor charge state
     information when present in the files with the charge range specified by
     the "precursor_charge" parameter. Default = 0.
  [--ms_level <integer>]
     MS level to analyze, valid are levels 2 or 3. Default = 2.
  [--activation_method ALL|CID|ECD|ETD|PQD|HCD|IRMPD]
     Specifies which scan types are searched. Default = ALL.
  [--digest_mass_range <string>]
     MH+ peptide mass range to analyze. Default = 600.0 5000.0.
  [--num_results <integer>]
     Number of search hits to store internally. Default = 50.
  [--skip_researching <integer>]
     For '.out' file output only, 0=search everything again, 1=don't search if
     .out exists. Default = 1.
  [--max_fragment_charge <integer>]
     Set maximum fragment charge state to analyze (allowed max 5). Default = 3.
  [--max_precursor_charge <integer>]
     Set maximum precursor charge state to analyze (allowed max 9). Default = 6.
  [--nucleotide_reading_frame <integer>]
     0=proteinDB, 1-6, 7=forward three, 8=reverse three, 9=all six. Default = 0.
  [--clip_nterm_methionine <integer>]
     0=leave sequences as-is; 1=also consider sequence w/o N-term methionine.
     Default = 0.
  [--spectrum_batch_size <integer>]
     Maximum number of spectra to search at a time; 0 to search the entire scan
     range in one loop. Default = 0.
  [--decoy_prefix <string>]
     Specifies the prefix of the protein names that indicates a decoy. Default =
     decoy_.
  [--output_suffix <string>]
     Specifies the suffix string that is appended to the base output name for
     the pep.xml, pin.xml, txt and sqt output files. Default = <empty>.
  [--mass_offsets <string>]
     Specifies one or more mass offsets to apply. This value(s) are effectively
     subtracted from each precursor mass such that peptides that are smaller
     than the precursor mass by the offset value can still be matched to the
     respective spectrum. Default = <empty>.
  [--minimum_peaks <integer>]
     Minimum number of peaks in spectrum to search. Default = 10.
  [--minimum_intensity <float>]
     Minimum intensity value to read in. Default = 0.
  [--remove_precursor_peak <integer>]
     0=no, 1=yes, 2=all charge reduced precursor peaks (for ETD). Default = 0.
  [--remove_precursor_tolerance <float>]
     +- Da tolerance for precursor removal. Default = 1.5.
  [--clear_mz_range <string>]
     For iTRAQ/TMT type data; will clear out all peaks in the specified m/z
     range. Default = 0.0 0.0.
  [--variable_mod01 <string>]
     Up to 9 variable modifications are supported. Each modification is
     specified using seven entries: "<mass> <residues> <type> <max> <terminus>
     <distance> <force>." Type is 0 for static mods and non-zero for variable
     mods. Note that that if you set the same type value on multiple
     modification entries, Comet will treat those variable modifications as a
     binary set. This means that all modifiable residues in the binary set must
     be unmodified or modified. Multiple binary sets can be specified by setting
     a different binary modification value. Max is an integer specifying the
     maximum number of modified residues possible in a peptide for this
     modification entry. Distance specifies the distance the modification is
     applied to from the respective terminus: -1 = no distance contraint; 0 =
     only applies to terminal residue; N = only applies to terminal residue
     through next N residues. Terminus specifies which terminus the distance
     constraint is applied to: 0 = protein N-terminus; 1 = protein C-terminus; 2
     = peptide N-terminus; 3 = peptide C-terminus.Force specifies whether
     peptides must contain this modification: 0 = not forced to be present; 1 =
     modification is required. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod02 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod03 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod04 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod05 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod06 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod07 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod08 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--variable_mod09 <string>]
     See syntax for variable_mod01. Default = 0.0 null 0 4 -1 0 0.
  [--max_variable_mods_in_peptide <integer>]
     Specifies the total/maximum number of residues that can be modified in a
     peptide. Default = 5.
  [--require_variable_mod <integer>]
     Controls whether the analyzed peptides must contain at least one variable
     modification. Default = 0.
  [--add_Cterm_peptide <float>]
     Specifiy a static modification to the c-terminus of all peptides. Default =
     0.
  [--add_Nterm_peptide <float>]
     Specify a static modification to the n-terminus of all peptides. Default =
     0.
  [--add_Cterm_protein <float>]
     Specify a static modification to the c-terminal peptide of each protein.
     Default = 0.
  [--add_Nterm_protein <float>]
     Specify a static modification to the n-terminal peptide of each protein.
     Default = 0.
  [--add_A_alanine <float>]
     Specify a static modification to the residue A. Default = 0.
  [--add_B_user_amino_acid <float>]
     Specify a static modification to the residue B. Default = 0.
  [--add_C_cysteine <float>]
     Specify a static modification to the residue C. Default = 57.021464.
  [--add_D_aspartic_acid <float>]
     Specify a static modification to the residue D. Default = 0.
  [--add_E_glutamic_acid <float>]
     Specify a static modification to the residue E. Default = 0.
  [--add_F_phenylalanine <float>]
     Specify a static modification to the residue F. Default = 0.
  [--add_G_glycine <float>]
     Specify a static modification to the residue G. Default = 0.
  [--add_H_histidine <float>]
     Specify a static modification to the residue H. Default = 0.
  [--add_I_isoleucine <float>]
     Specify a static modification to the residue I. Default = 0.
  [--add_J_user_amino_acid <float>]
     Specify a static modification to the residue J. Default = 0.
  [--add_K_lysine <float>]
     Specify a static modification to the residue K. Default = 0.
  [--add_L_leucine <float>]
     Specify a static modification to the residue L. Default = 0.
  [--add_M_methionine <float>]
     Specify a static modification to the residue M. Default = 0.
  [--add_N_asparagine <float>]
     Specify a static modification to the residue N. Default = 0.
  [--add_O_ornithine <float>]
     Specify a static modification to the residue O. Default = 0.
  [--add_P_proline <float>]
     Specify a static modification to the residue P. Default = 0.
  [--add_Q_glutamine <float>]
     Specify a static modification to the residue Q. Default = 0.
  [--add_R_arginine <float>]
     Specify a static modification to the residue R. Default = 0.
  [--add_S_serine <float>]
     Specify a static modification to the residue S. Default = 0.
  [--add_T_threonine <float>]
     Specify a static modification to the residue T. Default = 0.
  [--add_U_selenocysteine <float>]
     Specify a static modification to the residue U. Default = 0.
  [--add_V_valine <float>]
     Specify a static modification to the residue V. Default = 0.
  [--add_W_tryptophan <float>]
     Specify a static modification to the residue W. Default = 0.
  [--add_X_user_amino_acid <float>]
     Specify a static modification to the residue X. Default = 0.
  [--add_Y_tyrosine <float>]
     Specify a static modification to the residue Y. Default = 0.
  [--add_Z_user_amino_acid <float>]
     Specify a static modification to the residue Z. Default = 0.
  [--c-neg <float>]
     Penalty for mistake made on negative examples. If not specified, then this
     value is set by cross validation over {0.1, 1, 10}. Default = 0.
  [--c-pos <float>]
     Penalty for mistakes made on positive examples. If this value is set to 0,
     then it is set via cross validation over the values {0.1, 1, 10}, selecting
     the value that yields the largest number of PSMs identified at the q-value
     threshold set via the --test-fdr parameter. Default = 0.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--decoy-xml-output T|F]
     Include decoys (PSMs, peptides, and/or proteins) in the XML output. Default
     = false.
  [--default-direction <string>]
     In its initial round of training, Percolator uses one feature to induce a
     ranking of PSMs. By default, Percolator will select the feature that
     produces the largest set of target PSMs at a specified FDR threshold (cf.
     --train-fdr). This option allows the user to specify which feature is used
     for the initial ranking, using the name as a string. The name can be
     preceded by a hyphen (e.g. "-XCorr") to indicate that a lower value is
     better. Default = <empty>.
  [--feature-file-out T|F]
     Output the computed features in tab-delimited Percolator input (.pin)
     format. The features will be normalized, using either unit norm or standard
     deviation normalization (depending upon the value of the unit-norm option).
     Default = false.
  [--fido-alpha <float>]
     Specify the probability with which a present protein emits an associated
     peptide. Set by grid search (see --fido-gridsearch-depth parameter) if not
     specified. Default = 0.
  [--fido-beta <float>]
     Specify the probability of the creation of a peptide from noise. Set by
     grid search (see --fido-gridsearch-depth parameter) if not specified.
     Default = 0.
  [--fido-empirical-protein-q T|F]
     Estimate empirical p-values and q-values for proteins using target-decoy
     analysis. Default = false.
  [--fido-fast-gridsearch <float>]
     Apply the specified threshold to PSM, peptide and protein probabilities to
     obtain a faster estimate of the alpha, beta and gamma parameters. Default =
     0.
  [--fido-gamma <float>]
     Specify the prior probability that a protein is present in the sample. Set
     by grid search (see --fido-gridsearch-depth parameter) if not specified.
     Default = 0.
  [--fido-gridsearch-depth <integer>]
     Set depth of the grid search for alpha, beta and gamma estimation. Default
     = 0.
  [--fido-gridsearch-mse-threshold <float>]
     Q-value threshold that will be used in the computation of the MSE and ROC
     AUC score in the grid search. Default = 0.05.
  [--fido-no-split-large-components T|F]
     Do not approximate the posterior distribution by allowing large graph
     components to be split into subgraphs. The splitting is done by duplicating
     peptides with low probabilities. Splitting continues until the number of
     possible configurations of each subgraph is below 2^18 Default = false.
  [--fido-protein-truncation-threshold <float>]
     To speed up inference, proteins for which none of the associated peptides
     has a probability exceeding the specified threshold will be assigned
     probability = 0. Default = 0.01.
  [--init-weights <string>]
     Read initial weights from the given file (one per line). Default = <empty>.
  [--klammer T|F]
     Use retention time features calculated as in "Improving tandem mass
     spectrum identification using peptide retention time prediction across
     diverse chromatography conditions" by Klammer AA, Yi X, MacCoss MJ and
     Noble WS. (Analytical Chemistry. 2007 Aug 15;79(16):6111-8.). Default =
     false.
  [--max-charge-feature <integer>]
     Specifies the maximum charge state feature.  When set to zero, use the
     maximum observed charge state. Default = 0.
  [--maxiter <integer>]
     Maximum number of iterations for training. Default = 10.
  [--only-psms T|F]
     Do not remove redundant peptides; keep all PSMs and exclude peptide level
     probability. Default = false.
  [--output-weights T|F]
     Output final weights to a file named "percolator.weights.txt". Default =
     false.
  [--override T|F]
     By default, Percolator will examine the learned weights for each feature,
     and if the weight appears to be problematic, then percolator will discard
     the learned weights and instead employ a previously trained, static score
     vector. This switch allows this error checking to be overriden. Default =
     false.
  [--percolator-seed <string>]
     When given a unsigned integer value seeds the random number generator with
     that value. When given the string "time" seeds the random number generator
     with the system time. Default = 1.
  [--picked-protein <string>]
     Use the picked protein-level FDR to infer protein probabilities, provide
     the fasta file as the argument to this flag. Default = <empty>.
  [--pout-output T|F]
     Output a Percolator pout.xml format results file to the output directory.
     Default = false.
  [--protein T|F]
     Use the Fido algorithm to infer protein probabilities. Must be true to use
     any of the Fido options. Default = false.
  [--protein-enzyme no_enzyme|elastase|pepsin|proteinasek|thermolysin|trypsinp|chymotrypsin|lys-n|lys-c|arg-c|asp-n|glu-c|trypsin]
     Type of enzyme Default = trypsin.
  [--protein-report-duplicates T|F]
     If multiple database proteins contain exactly the same set of peptides,
     then Percolator will randomly discard all but one of the proteins. If this
     option is set, then the IDs of these duplicated proteins will be reported
     as a comma-separated list. Not available for Fido. Default = false.
  [--protein-report-fragments T|F]
     By default, if the peptides associated with protein A are a proper subset
     of the peptides associated with protein B, then protein A is eliminated and
     all the peptides are considered as evidence for protein B. Note that this
     filtering is done based on the complete set of peptides in the database,
     not based on the identified peptides in the search results. Alternatively,
     if this option is set and if all of the identified peptides associated with
     protein B are also associated with protein A, then Percolator will report a
     comma-separated list of protein IDs, where the full-length protein B is
     first in the list and the fragment protein A is listed second. Not
     available for Fido. Default = false.
  [--quick-validation T|F]
     Quicker execution by reduced internal cross-validation. Default = false.
  [--search-input auto|separate|concatenated]
     Specify the type of target-decoy search. Using 'auto', percolator attempts
     to detect the search type automatically.  Using 'separate' specifies two
     searches: one against target and one against decoy protein db. Using
     'concatenated' specifies a single search on concatenated target-decoy
     protein db. Default = auto.
  [--spectral-counting-fdr <float>]
     Report the number of unique PSMs and total (including shared peptides) PSMs
     as two extra columns in the protein tab-delimited output. Default = 0.
  [--subset-max-train <integer>]
     Only train Percolator on a subset of PSMs, and use the resulting score
     vector to evaluate the other PSMs. Recommended when analyzing huge numbers
     (>1 million) of PSMs. When set to 0, all PSMs are used for training as
     normal. Default = 0.
  [--tdc T|F]
     Use target-decoy competition to assign q-values and PEPs. When set to F,
     the mix-max method, which estimates the proportion pi0 of incorrect target
     PSMs, is used instead. Default = true.
  [--test-each-iteration T|F]
     Measure performance on test set each iteration. Default = false.
  [--test-fdr <float>]
     False discovery rate threshold used in selecting hyperparameters during
     internal cross-validation and for reporting the final results. Default =
     0.01.
  [--train-best-positive T|F]
     Enforce that, for each spectrum, at most one PSM is included in the
     positive set during each training iteration. Note that if the user only
     provides one PSM per spectrum, then this option will have no effect.
     Default = false.
  [--train-fdr <float>]
     False discovery rate threshold to define positive examples in training.
     Default = 0.01.
  [--unitnorm T|F]
     Use unit normalization (i.e., linearly rescale each PSM's feature vector to
     have a Euclidean length of 1), instead of standard deviation normalization.
     Default = false.
  [--estimation-method mix-max|tdc|peptide-level]
     Specify the method used to estimate q-values.  The mix-max procedure or
     target-decoy competition apply to PSMs. The peptide-level option eliminates
     any PSM for which there exists a better scoring PSM involving the same
     peptide, and then uses decoys to assign confidence estimates. Default =
     tdc.
  [--score <string>]
     Specify the column (for tab-delimited input) or tag (for XML input) used as
     input to the q-value estimation procedure. If this parameter is
     unspecified, then the program searches for "xcorr score", "evalue" (comet),
     "exact p-value" score fields in this order in the input file.  Default =
     <empty>.
  [--sidak T|F]
     Adjust the score using the Sidak adjustment and reports them in a new
     column in the output file. Note that this adjustment only makes sense if
     the given scores are p-values, and that it requires the presence of the
     "distinct matches/spectrum" feature for each PSM. Default = false.
  [--top-match-in <integer>]
     Specify the maximum rank to allow when parsing results files. Matches with
     ranks higher than this value will be ignored (a value of zero allows
     matches with any rank). Default = 0.
  [--list-of-files T|F]
     Specify that the search results are provided as lists of files, rather than
     as individual files. Default = false.
  [--combine-charge-states T|F]
     Specify this parameter to T in order to combine charge states with peptide
     sequencesin peptide-centric search. Works only if estimation-method =
     peptide-level. Default = false.
  [--combine-modified-peptides T|F]
     Specify this parameter to T in order to treat peptides carrying different
     or no modifications as being the same. Works only if estimation =
     peptide-level. Default = false.
```


## crux_and

### Tool Description
crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output, then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find and in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_cascade-search

### Tool Description
Searches spectra against a series of databases in a cascade.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 2 arguments, but found 0

USAGE:

  crux cascade-search [options] <tide spectra file>+ <database-series>

REQUIRED ARGUMENTS:

  <tide spectra file>+ The name of one or more files from which to parse the
  fragmentation spectra, in any of the file formats supported by ProteoWizard.
  Alternatively, the argument may be one or more binary spectrum files produced
  by a previous run of crux tide-search using the store-spectra parameter.

  <database-series> A comma-separated list of databases, each generated by
  tide-index. Cascade-search will search the given spectra against these
  databases in the given order.

OPTIONAL ARGUMENTS:

  [--q-value-threshold <float>]
     The q-value threshold used by cascade search. Each spectrum identified in
     one search with q-value less than this threshold will be excluded from all
     subsequent searches. Note that the threshold is not applied to the final
     database in the cascade. Default = 0.01.
  [--estimation-method mix-max|tdc|peptide-level]
     Specify the method used to estimate q-values.  The mix-max procedure or
     target-decoy competition apply to PSMs. The peptide-level option eliminates
     any PSM for which there exists a better scoring PSM involving the same
     peptide, and then uses decoys to assign confidence estimates. Default =
     tdc.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--score <string>]
     Specify the column (for tab-delimited input) or tag (for XML input) used as
     input to the q-value estimation procedure. If this parameter is
     unspecified, then the program searches for "xcorr score", "evalue" (comet),
     "exact p-value" score fields in this order in the input file.  Default =
     <empty>.
  [--sidak T|F]
     Adjust the score using the Sidak adjustment and reports them in a new
     column in the output file. Note that this adjustment only makes sense if
     the given scores are p-values, and that it requires the presence of the
     "distinct matches/spectrum" feature for each PSM. Default = false.
  [--top-match-in <integer>]
     Specify the maximum rank to allow when parsing results files. Matches with
     ranks higher than this value will be ignored (a value of zero allows
     matches with any rank). Default = 0.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--list-of-files T|F]
     Specify that the search results are provided as lists of files, rather than
     as individual files. Default = false.
  [--combine-charge-states T|F]
     Specify this parameter to T in order to combine charge states with peptide
     sequencesin peptide-centric search. Works only if estimation-method =
     peptide-level. Default = false.
  [--combine-modified-peptides T|F]
     Specify this parameter to T in order to treat peptides carrying different
     or no modifications as being the same. Works only if estimation =
     peptide-level. Default = false.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--auto-mz-bin-width false|warn|fail]
     Automatically estimate optimal value for the mz-bin-width parameter from
     the spectra themselves. false=no estimation, warn=try to estimate but use
     the default value in case of failure, fail=try to estimate and quit in case
     of failure. Default = false.
  [--auto-precursor-window false|warn|fail]
     Automatically estimate optimal value for the precursor-window parameter
     from the spectra themselves. false=no estimation, warn=try to estimate but
     use the default value in case of failure, fail=try to estimate and quit in
     case of failure. Default = false.
  [--compute-sp T|F]
     Compute the preliminary score Sp for all candidate peptides. Report this
     score in the output, along with the corresponding rank, the number of
     matched ions and the total number of ions. This option is recommended if
     results are to be analyzed by Percolator or Barista. If sqt-output is
     enabled, then compute-sp is automatically enabled and cannot be overridden.
     Note that the Sp computation requires re-processing each observed spectrum,
     so turning on this switch involves significant computational overhead.
     Default = false.
  [--concat T|F]
     When set to T, target and decoy search results are reported in a single
     file, and only the top-scoring N matches (as specified via --top-match) are
     reported for each spectrum, irrespective of whether the matches involve
     target or decoy peptides.Note that when used with search-for-xlinks, this
     parameter only has an effect if use-old-xlink=F. Default = false.
  [--deisotope <float>]
     Perform a simple deisotoping operation across each MS2 spectrum. For each
     peak in an MS2 spectrum, consider lower m/z peaks. If the current peak
     occurs where an expected peak would lie for any charge state less than the
     charge state of the precursor, within mass tolerance, and if the current
     peak is of lower abundance, then the peak is removed.  The value of this
     parameter is the mass tolerance, in units of parts-per-million.  If set to
     0, no deisotoping is performed. Default = 0.
  [--exact-p-value T|F]
     Enable the calculation of exact p-values for the XCorr score. Calculation
     of p-values increases the running time but increases the number of
     identifications at a fixed confidence threshold. The p-values will be
     reported in a new column with header "exact p-value", and the "xcorr score"
     column will be replaced with a "refactored xcorr" column. Note that,
     currently, p-values can only be computed when the mz-bin-width parameter is
     set to its default value. Variable and static mods are allowed on
     non-terminal residues in conjunction with p-value computation, but
     currently only static mods are allowed on the N-terminus, and no mods on
     the C-terminus. Default = false.
  [--file-column T|F]
     Include the file column in tab-delimited output. Default = true.
  [--isotope-error <string>]
     List of positive, non-zero integers. Default = <empty>.
  [--mass-precision <integer>]
     Set the precision for masses and m/z written to sqt and text files. Default
     = 4.
  [--max-precursor-charge <integer>]
     The maximum charge state of a spectra to consider in search. Default = 5.
  [--min-peaks <integer>]
     The minimum number of peaks a spectrum must have for it to be searched.
     Default = 20.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--mz-bin-offset <float>]
     In the discretization of the m/z axes of the observed and theoretical
     spectra, this parameter specifies the location of the left edge of the
     first bin, relative to mass = 0 (i.e., mz-bin-offset = 0.xx means the left
     edge of the first bin will be located at +0.xx Da). Default = 0.4.
  [--mz-bin-width <float>]
     Before calculation of the XCorr score, the m/z axes of the observed and
     theoretical spectra are discretized. This parameter specifies the size of
     each bin. The exact formula for computing the discretized m/z value is
     floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
     value. For low resolution ion trap ms/ms data 1.0005079 and for high
     resolution ms/ms 0.02 is recommended. Default = 1.0005079.
  [--mzid-output T|F]
     Output an mzIdentML results file to the output directory. Default = false.
  [--num-threads <integer>]
     0=poll CPU to set num threads; else specify num threads directly. Default =
     0.
  [--peptide-centric-search T|F]
     Carries out a peptide-centric search. For each peptide the top-scoring
     spectra are reported, in contrast to the standard spectrum-centric search
     where the top-scoring peptides are reported. Note that in this case the
     "xcorr rank" column will contain the rank of the given spectrum with
     respect to the given candidate peptide, rather than vice versa (which is
     the default). Default = false.
  [--score-function xcorr|residue-evidence|both]
     Function used for scoring PSMs. 'xcorr' is the original scoring function
     used by SEQUEST; 'residue-evidence' is designed to score high-resolution
     MS2 spectra; and 'both' calculates both scores. The latter requires that
     exact-p-value=T. Default = xcorr.
  [--fragment-tolerance <float>]
     Mass tolerance (in Da) for scoring pairs of peaks when creating the residue
     evidence matrix. This parameter only makes sense when score-function is
     'residue-evidence' or 'both'. Default = 0.02.
  [--evidence-granularity <integer>]
     When exact-pvalue=T, this parameter controls the granularity of the entries
     in the dynamic programming matrix.  Smaller values make the program run
     faster but give less exact p-values; larger values make the program run
     more slowly but give more exact p-values. Default = 25.
  [--pepxml-output T|F]
     Output a pepXML results file to the output directory. Default = false.
  [--pin-output T|F]
     Output a Percolator input (PIN) file to the output directory. Default =
     false.
  [--pm-charge <integer>]
     Precursor charge state to consider MS/MS spectra from, in measurement error
     estimation. Ideally, this should be the most frequently occurring charge
     state in the given data. Default = 2.
  [--pm-max-frag-mz <float>]
     Maximum fragment m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-precursor-delta-ppm <float>]
     Maximum ppm distance between precursor m/z values to consider two scans
     potentially generated by the same peptide for measurement error estimation.
     Default = 50.
  [--pm-max-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-max-scan-separation <integer>]
     Maximum number of scans two spectra can be separated by in order to be
     considered potentially generated by the same peptide, for measurement error
     estimation. Default = 1000.
  [--pm-min-common-frag-peaks <integer>]
     Number of the most-intense peaks that two spectra must share in order to
     potentially be generated by the same peptide, for measurement error
     estimation. Default = 20.
  [--pm-min-frag-mz <float>]
     Minimum fragment m/z value to use in measurement error estimation. Default
     = 150.
  [--pm-min-peak-pairs <integer>]
     Minimum number of peak pairs (for precursor or fragment) that must be
     successfully paired in order to attempt to estimate measurement error
     distribution. Default = 100.
  [--pm-min-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 400.
  [--pm-min-scan-frag-peaks <integer>]
     Minimum fragment peaks an MS/MS scan must contain to be used in measurement
     error estimation. Default = 40.
  [--pm-pair-top-n-frag-peaks <integer>]
     Number of fragment peaks per spectrum pair to be used in fragment error
     estimation. Default = 5.
  [--pm-top-n-frag-peaks <integer>]
     Number of most-intense fragment peaks to consider for measurement error
     estimation, per MS/MS spectrum. Default = 30.
  [--precision <integer>]
     Set the precision for scores written to sqt and text files. Default = 8.
  [--precursor-window <float>]
     Tolerance used for matching peptides to spectra. Peptides must be within
     +/- 'precursor-window' of the spectrum value. The precursor window units
     depend upon precursor-window-type. Default = 3.
  [--precursor-window-type mass|mz|ppm]
     Specify the units for the window that is used to select peptides around the
     precursor mass location (mass, mz, ppm). The magnitude of the window is
     defined by the precursor-window option, and candidate peptides must fall
     within this window. For the mass window-type, the spectrum precursor m+h
     value is converted to mass, and the window is defined as that mass +/-
     precursor-window. If the m+h value is not available, then the mass is
     calculated from the precursor m/z and provided charge. The peptide mass is
     computed as the sum of the average amino acid masses plus 18 Da for the
     terminal OH group. The mz window-type calculates the window as spectrum
     precursor m/z +/- precursor-window and then converts the resulting m/z
     range to the peptide mass range using the precursor charge. For the
     parts-per-million (ppm) window-type, the spectrum mass is calculated as in
     the mass type. The lower bound of the mass window is then defined as the
     spectrum mass / (1.0 + (precursor-window / 1000000)) and the upper bound is
     defined as spectrum mass / (1.0 - (precursor-window / 1000000)). Default =
     mass.
  [--print-search-progress <integer>]
     Show search progress by printing every n spectra searched. Set to 0 to show
     no search progress. Default = 1000.
  [--remove-precursor-peak T|F]
     If true, all peaks around the precursor m/z will be removed, within a range
     specified by the --remove-precursor-tolerance option. Default = false.
  [--remove-precursor-tolerance <float>]
     This parameter specifies the tolerance (in Th) around each precursor m/z
     that is removed when the --remove-precursor-peak option is invoked. Default
     = 1.5.
  [--scan-number <string>]
     A single scan number or a range of numbers to be searched. Range should be
     specified as 'first-last' which will include scans 'first' and 'last'.
     Default = <empty>.
  [--skip-preprocessing T|F]
     Skip preprocessing steps on spectra. Default = F. Default = false.
  [--spectrum-charge 1|2|3|all]
     The spectrum charges to search. With 'all' every spectrum will be searched
     and spectra with multiple charge states will be searched once at each
     charge state. With 1, 2, or 3 only spectra with that charge state will be
     searched. Default = all.
  [--spectrum-max-mz <float>]
     The highest spectrum m/z to search in the ms2 file. Default = 1e+09.
  [--spectrum-min-mz <float>]
     The lowest spectrum m/z to search in the ms2 file. Default = 0.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--sqt-output T|F]
     Outputs an SQT results file to the output directory. Note that if
     sqt-output is enabled, then compute-sp is automatically enabled and cannot
     be overridden. Default = false.
  [--store-index <string>]
     When providing a FASTA file as the index, the generated binary index will
     be stored at the given path. This option has no effect if a binary index is
     provided as the index. Default = <empty>.
  [--store-spectra <string>]
     Specify the name of the file where the binarized fragmentation spectra will
     be stored. Subsequent runs of crux tide-search will execute more quickly if
     provided with the spectra in binary format. The filename is specified
     relative to the current working directory, not the Crux output directory
     (as specified by --output-dir). This option is not valid if multiple input
     spectrum files are given. Default = <empty>.
  [--txt-output T|F]
     Output a tab-delimited results file to the output directory. Default =
     true.
  [--use-flanking-peaks T|F]
     Include flanking peaks around singly charged b and y theoretical ions. Each
     flanking peak occurs in the adjacent m/z bin and has half the intensity of
     the primary peak. Default = false.
  [--use-neutral-loss-peaks T|F]
     Controls whether neutral loss ions are considered in the search. Two types
     of neutral losses are included and are applied only to singly charged b-
     and y-ions: loss of ammonia (NH3, 17.0086343 Da) and H2O (18.0091422). Each
     neutral loss peak has intensity 1/5 of the primary peak. Default = true.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
```


## crux_information

### Tool Description
Supports a variety of commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find information in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_assign-confidence

### Tool Description
Assign confidence estimates to peptide-spectrum matches (PSMs).

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 1 arguments, but found 0

USAGE:

  crux assign-confidence [options] <target input>+

REQUIRED ARGUMENTS:

  <target input>+ One or more files, each containing a collection of
  peptide-spectrum matches (PSMs) in tab-delimited text, PepXML, or mzIdentML
  format. In tab-delimited text format, only the specified score column is
  required. However if --estimation-method is tdc, then the columns "scan" and
  "charge" are required, as well as "protein ID" if the search was run with
  concat=F. Furthermore, if the --estimation-method is specified to
  peptide-level is set to T, then the column "peptide" must be included, and if
  --sidak is set to T, then the "distinct matches/spectrum" column must be
  included.

OPTIONAL ARGUMENTS:

  [--estimation-method mix-max|tdc|peptide-level]
     Specify the method used to estimate q-values.  The mix-max procedure or
     target-decoy competition apply to PSMs. The peptide-level option eliminates
     any PSM for which there exists a better scoring PSM involving the same
     peptide, and then uses decoys to assign confidence estimates. Default =
     tdc.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--score <string>]
     Specify the column (for tab-delimited input) or tag (for XML input) used as
     input to the q-value estimation procedure. If this parameter is
     unspecified, then the program searches for "xcorr score", "evalue" (comet),
     "exact p-value" score fields in this order in the input file.  Default =
     <empty>.
  [--sidak T|F]
     Adjust the score using the Sidak adjustment and reports them in a new
     column in the output file. Note that this adjustment only makes sense if
     the given scores are p-values, and that it requires the presence of the
     "distinct matches/spectrum" feature for each PSM. Default = false.
  [--top-match-in <integer>]
     Specify the maximum rank to allow when parsing results files. Matches with
     ranks higher than this value will be ignored (a value of zero allows
     matches with any rank). Default = 0.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--list-of-files T|F]
     Specify that the search results are provided as lists of files, rather than
     as individual files. Default = false.
  [--combine-charge-states T|F]
     Specify this parameter to T in order to combine charge states with peptide
     sequencesin peptide-centric search. Works only if estimation-method =
     peptide-level. Default = false.
  [--combine-modified-peptides T|F]
     Specify this parameter to T in order to treat peptides carrying different
     or no modifications as being the same. Works only if estimation =
     peptide-level. Default = false.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
```


## crux_each

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find each in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_make-pin

### Tool Description
Creates a pin file from one or more input files containing peptide-spectrum matches (PSMs).

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 1 arguments, but found 0

USAGE:

  crux make-pin [options] <target input>+

REQUIRED ARGUMENTS:

  <target input>+ One or more files, each containing a collection of
  peptide-spectrum matches (PSMs) in tab-delimited text, PepXML, or mzIdentML
  format. In tab-delimited text format, only the specified score column is
  required. However if --estimation-method is tdc, then the columns "scan" and
  "charge" are required, as well as "protein ID" if the search was run with
  concat=F. Furthermore, if the --estimation-method is specified to
  peptide-level is set to T, then the column "peptide" must be included, and if
  --sidak is set to T, then the "distinct matches/spectrum" column must be
  included.

OPTIONAL ARGUMENTS:

  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--max-charge-feature <integer>]
     Specifies the maximum charge state feature.  When set to zero, use the
     maximum observed charge state. Default = 0.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--output-file <string>]
     Path where pin file will be written instead of make-pin.pin. Default =
     <empty>.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--top-match <integer>]
     Specify the number of matches to report for each spectrum. Default = 5.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_file

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find file in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_predict-peptide-ions

### Tool Description
Predict theoretical peptide ions.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux predict-peptide-ions [options] <peptide sequence> <charge state>

REQUIRED ARGUMENTS:

  <peptide sequence> The peptide sequence.

  <charge state> The charge state of the peptide.

OPTIONAL ARGUMENTS:

  [--primary-ions a|b|y|by|bya]
     Predict the specified primary ion series. 'a' indicates a-ions only, 'b'
     indicates b-ions only, 'y' indicates y-ions only, 'by' indicates both b and
     y, 'bya' indicates b, y, and a. Default = by.
  [--precursor-ions T|F]
     Predict the precursor ions, and all associated ions (neutral losses,
     multiple charge states) consistent with the other specified options.
     Default = false.
  [--isotope <integer>]
     Predict the given number of isotope peaks (0|1|2). Default = 0.
  [--flanking T|F]
     Predict flanking peaks for b- and y ions. Default = false.
  [--max-ion-charge <string>]
     Predict theoretical ions up to max charge state (1, 2, ... ,6) or up to the
     charge state of the peptide ("peptide"). If the max-ion-charge is greater
     than the charge state of the peptide, then the maximum is the peptide
     charge.  Default = peptide.
  [--fragment-mass average|mono]
     Specify which isotopes to use in calculating fragment ion mass. Default =
     mono.
  [--nh3 <integer>]
     Include among the predicted peaks b/y ions with up to n losses of nh3. For
     example, for --nh3 2, predict a peak for each b- and y-ion with the loss of
     one nh3 group and predict a second peak for each b- and y-ion with the loss
     of two nh3 groups. These peaks will have 1 and 2, respectively, in the NH3
     column of the output. Default = 0.
  [--h2o <integer>]
     Include in the predicted peaks, b/y ions with the loss of 1 to n water
     molecules. See --nh3 for an example. Default = 0.
```


## crux_values

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find values in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_hardklor

### Tool Description
Parses high-resolution spectra from a file.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 1 arguments, but found 0

USAGE:

  crux hardklor [options] <spectra>

REQUIRED ARGUMENTS:

  <spectra> The name of a file from which to parse high-resolution spectra. The
  file may be in MS1 (.ms1), binary MS1 (.bms1), compressed MS1 (.cms1), or
  mzXML (.mzXML) format.

OPTIONAL ARGUMENTS:

  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--hardklor-algorithm basic|version1|version2]
     Determines which spectral feature detection algorithm to use. Different
     results are possible with each algorithm, and there are pros and cons to
     each. Default = version1.
  [--averagine-mod <string>]
     Defines alternative averagine models in the analysis that incorporate
     additional atoms and/or isotopic enrichments. Modifications are represented
     as text strings. Inclusion of additional atoms in the model is done using
     by entering an atomic formula, such as: PO2 or Cl. Inclusion of isotopic
     enrichment to the model is done by specifying the percent enrichment (as a
     decimal) followed by the atom being enriched and an index of the isotope.
     For example, 0.75H1 specifies 75% enrichment of the first heavy isotope of
     hydrogen. In other words, 75% deuterium enrichment. Two or more
     modifications can be combined into the same model, and separated by spaces:
     B2 0.5B1 Default = <empty>.
  [--boxcar-averaging <integer>]
     Boxcar averaging is a sliding window that averages n adjacent spectra prior
     to feature detection. Averaging generally improves the signal-to-noise
     ratio of features in the spectra, as well as improving the shape of
     isotopic envelopes. However, averaging will also change the observed peak
     intensities. Averaging with too wide a window will increase the occurrence
     of overlapping features and broaden the chromatographic profiles of
     observed features. The number specified is the total adjacent scans to be
     combined, centered on the scan being analyzed. Therefore, an odd number is
     recommended to center the boxcar window. For example, a value of 3 would
     produce an average of the scan of interest, plus one scan on each side. A
     value of 0 disables boxcar averaging. Default = 0.
  [--boxcar-filter <integer>]
     This parameter is only functional when boxcar-averaging is used. The filter
     will remove any peaks not seen in n scans in the boxcar window. The effect
     is to reduce peak accumulation due to noise and reduce chromatographic
     broadening of peaks. Caution should be used as over-filtering can occur.
     The suggested number of scans to set for filtering should be equal to or
     less than the boxcar-averaging window size. A value of 0 disables
     filtering. Default = 0.
  [--boxcar-filter-ppm <float>]
     This parameter is only functional when boxcar-filter is used. The value
     specifies the mass tolerance in ppm for declaring a peak the same prior to
     filtering across all scans in the boxcar window. Default = 10.
  [--centroided T|F]
     Indicates whether the data contain profile or centroided peaks. Default =
     false.
  [--cdm B|F|P|Q|S]
     Choose the charge state determination method. Default = Q.
  [--min-charge <integer>]
     Specifies the minimum charge state to allow when finding spectral features.
     It is best to set this value to the lowest assumed charge state to be
     present. If set higher than actual charge states that are present, those
     features will not be identified or incorrectly assigned a different charge
     state and mass. Default = 1.
  [--max-charge <integer>]
     Specifies the maximum charge state to allow when finding spectral features.
     It is best to set this value to a practical number (i.e. do not set it to
     20 when doing a tryptic shotgun analysis). If set higher than actual charge
     states that are present, the algorithm will perform significantly slower
     without any improvement in results. Default = 5.
  [--corr <float>]
     Sets the correlation threshold (cosine similarity) for accepting each
     predicted feature. Default = 0.85.
  [--depth <integer>]
     Sets the depth of combinatorial analysis. For a given set of peaks in a
     spectrum, search for up to this number of combined peptides that explain
     the observed peaks. The analysis stops before depth is reached if the
     current number of deconvolved features explains the observed peaks with a
     correlation score above the threshold defined with the correlation
     parameter. Default = 3.
  [--distribution-area T|F]
     When reporting each feature, report abundance as the sum of all isotope
     peaks. The value reported is the estimate of the correct peak heights based
     on the averagine model scaled to the observed peak heights. Default =
     false.
  [--hardklor-data-file <string>]
     Specifies an ASCII text file that defines symbols for the periodic table.
     Default = <empty>.
  [--instrument fticr|orbitrap|tof|qit]
     Indicates the type of instrument used to collect data. This parameter,
     combined with the resolution parameter, define how spectra will be
     centroided (if you provide profile spectra) and the accuracy when aligning
     observed peaks to the models. Default = fticr.
  [--isotope-data-file <string>]
     Specifies an ASCII text file that can be read to override the natural
     isotope abundances for all elements. Default = <empty>.
  [--max-features <integer>]
     Specifies the maximum number of models to build for a set of peaks being
     analyzed. Regardless of the setting, the number of models will never exceed
     the number of peaks in the current set. However, as many of the low
     abundance peaks are noise or tail ends of distributions, defining models
     for them is detrimental to the analysis. Default = 10.
  [--mzxml-filter <integer>]
     Filters the spectra prior to analysis for the requested MS/MS level. For
     example, if the data contain MS and MS/MS spectra, setting mzxml-filter = 1
     will analyze only the MS scan events. Setting mzxml-filter = 2 will analyze
     only the MS/MS scan events. Default = 1.
  [--mz-max <float>]
     Constrains the search in each spectrum to signals below this value in
     Thomsons. Setting to 0 disables this feature. Default = 0.
  [--mz-min <float>]
     Constrains the search in each spectrum to signals above this value in
     Thomsons. Setting to 0 disables this feature. Default = 0.
  [--mz-window <float>]
     Only used when algorithm = version1. Defines the maximum window size in
     Thomsons to analyze when deconvolving peaks in a spectrum into features.
     Default = 4.
  [--resolution <float>]
     Specifies the resolution of the instrument at 400 m/z for the data being
     analyzed. Default = 100000.
  [--scan-range-max <integer>]
     Used to restrict analysis to spectra with scan numbers below this parameter
     value. A value of 0 disables this feature. Default = 0.
  [--scan-range-min <integer>]
     Used to restrict analysis to spectra with scan numbers above this parameter
     value. A value of 0 disables this feature. Default = 0.
  [--sensitivity <integer>]
     Set the sensitivity level. There are four levels: 0 (low), 1 (moderate), 2
     (high), and 3 (max). Increasing the sensitivity will increase computation
     time, but will also yield more isotope distributions. Default = 2.
  [--signal-to-noise <float>]
     Filters spectra to remove peaks below this signal-to-noise ratio prior to
     finding features. Default = 1.
  [--smooth <integer>]
     Uses Savitzky-Golay smoothing on profile peak data prior to centroiding the
     spectra. This parameter is recommended for low resolution spectra only.
     Smoothing data causes peak depression and broadening. Only use odd numbers
     for the degree of smoothing (as it defines a window centered on each data
     point). Higher values will produce smoother peaks, but with greater
     depression and broadening. Setting this parameter to 0 disables smoothing.
     Default = 0.
  [--sn-window <float>]
     Set the signal-to-noise window length (in m/z). Because noise may be
     non-uniform across a spectrum, this value adjusts the segment size
     considered when calculating a signal-over-noise ratio. Default = 250.
  [--static-sn T|F]
     Applies the lowest noise threshold of any sn_window across the entire mass
     range for a spectrum. Setting this parameter to 0 turns off this feature,
     and different noise thresholds will be used for each local mass window in a
     spectrum. Default = true.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_high-resolution

### Tool Description
Supports a variety of commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find high-resolution in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_param-medic

### Tool Description
Parse fragmentation spectra to estimate measurement error.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected at least 1 arguments, but found 0

USAGE:

  crux param-medic [options] <spectrum-file>+

REQUIRED ARGUMENTS:

  <spectrum-file>+ File from which to parse fragmentation spectra.

OPTIONAL ARGUMENTS:

  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--pm-min-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 400.
  [--pm-max-precursor-mz <float>]
     Minimum precursor m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-min-frag-mz <float>]
     Minimum fragment m/z value to use in measurement error estimation. Default
     = 150.
  [--pm-max-frag-mz <float>]
     Maximum fragment m/z value to use in measurement error estimation. Default
     = 1800.
  [--pm-min-scan-frag-peaks <integer>]
     Minimum fragment peaks an MS/MS scan must contain to be used in measurement
     error estimation. Default = 40.
  [--pm-max-precursor-delta-ppm <float>]
     Maximum ppm distance between precursor m/z values to consider two scans
     potentially generated by the same peptide for measurement error estimation.
     Default = 50.
  [--pm-charge <integer>]
     Precursor charge state to consider MS/MS spectra from, in measurement error
     estimation. Ideally, this should be the most frequently occurring charge
     state in the given data. Default = 2.
  [--pm-top-n-frag-peaks <integer>]
     Number of most-intense fragment peaks to consider for measurement error
     estimation, per MS/MS spectrum. Default = 30.
  [--pm-pair-top-n-frag-peaks <integer>]
     Number of fragment peaks per spectrum pair to be used in fragment error
     estimation. Default = 5.
  [--pm-min-common-frag-peaks <integer>]
     Number of the most-intense peaks that two spectra must share in order to
     potentially be generated by the same peptide, for measurement error
     estimation. Default = 20.
  [--pm-max-scan-separation <integer>]
     Maximum number of scans two spectra can be separated by in order to be
     considered potentially generated by the same peptide, for measurement error
     estimation. Default = 1000.
  [--pm-min-peak-pairs <integer>]
     Minimum number of peak pairs (for precursor or fragment) that must be
     successfully paired in order to attempt to estimate measurement error
     distribution. Default = 100.
```


## crux_precursor

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry proteomics data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find precursor in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_database

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find database in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_print-processed-spectra

### Tool Description
Parse fragmentation spectra from MS2 files and write processed spectra to an output file.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux print-processed-spectra [options] <ms2 file> <output file>

REQUIRED ARGUMENTS:

  <ms2 file> The name of one or more files from which to parse the fragmentation
  spectra, in any of the file formats supported by ProteoWizard.

  <output file> File where spectrum will be written.

OPTIONAL ARGUMENTS:

  [--stop-after remove-precursor|square-root|remove-grass|ten-bin|xcorr]
     Stop after the specified pre-processing step. Default = xcorr.
  [--output-units mz|bin]
     Specify the output units for processed spectra. Default = bin.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
```


## crux_results

### Tool Description
Crux supports the following primary commands and utility commands.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find results in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_generate-peptides

### Tool Description
Generate peptides from a protein FASTA file.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 1 arguments, but found 0

USAGE:

  crux generate-peptides [options] <protein fasta file>

REQUIRED ARGUMENTS:

  <protein fasta file> The name of the file in FASTA format from which to
  retrieve proteins.

OPTIONAL ARGUMENTS:

  [--min-mass <float>]
     The minimum mass (in Da) of peptides to consider. Default = 200.
  [--max-mass <float>]
     The maximum mass (in Da) of peptides to consider. Default = 7200.
  [--min-length <integer>]
     The minimum length of peptides to consider. Default = 6.
  [--max-length <integer>]
     The maximum length of peptides to consider. Default = 50.
  [--enzyme no-enzyme|trypsin|trypsin/p|chymotrypsin|elastase|clostripain|cyanogen-bromide|iodosobenzoate|proline-endopeptidase|staph-protease|asp-n|lys-c|lys-n|arg-c|glu-c|pepsin-a|elastase-trypsin-chymotrypsin|custom-enzyme]
     Specify the enzyme used to digest the proteins in silico. Available enzymes
     (with the corresponding digestion rules indicated in parentheses) include
     no-enzyme ([X]|[X]), trypsin ([RK]|{P}), trypsin/p ([RK]|[]), chymotrypsin
     ([FWYL]|{P}), elastase ([ALIV]|{P}), clostripain ([R]|[]), cyanogen-bromide
     ([M]|[]), iodosobenzoate ([W]|[]), proline-endopeptidase ([P]|[]),
     staph-protease ([E]|[]), asp-n ([]|[D]), lys-c ([K]|{P}), lys-n ([]|[K]),
     arg-c ([R]|{P}), glu-c ([DE]|{P}), pepsin-a ([FL]|{P}),
     elastase-trypsin-chymotrypsin ([ALIVKRWFY]|{P}). Specifying --enzyme
     no-enzyme yields a non-enzymatic digest. Warning: the resulting index may
     be quite large. Default = trypsin.
  [--custom-enzyme <string>]
     Specify rules for in silico digestion of protein sequences. Overrides the
     enzyme option. Two lists of residues are given enclosed in square brackets
     or curly braces and separated by a |. The first list contains residues
     required/prohibited before the cleavage site and the second list is
     residues after the cleavage site. If the residues are required for
     digestion, they are in square brackets, '[' and ']'. If the residues
     prevent digestion, then they are enclosed in curly braces, '{' and '}'. Use
     X to indicate all residues. For example, trypsin cuts after R or K but not
     before P which is represented as [RK]|{P}. AspN cuts after any residue but
     only before D which is represented as [X]|[D]. To prevent the sequences
     from being digested at all, use [Z]|[Z]. Default = <empty>.
  [--digestion full-digest|partial-digest|non-specific-digest]
     Specify whether every peptide in the database must have two enzymatic
     termini (full-digest) or if peptides with only one enzymatic terminus are
     also included (partial-digest). Default = full-digest.
  [--missed-cleavages <integer>]
     Maximum number of missed cleavages per peptide to allow in enzymatic
     digestion. Default = 0.
  [--isotopic-mass average|mono]
     Specify the type of isotopic masses to use when calculating the peptide
     mass. Default = mono.
  [--seed <string>]
     When given a unsigned integer value seeds the random number generator with
     that value. When given the string "time" seeds the random number generator
     with the system time. Default = 1.
  [--clip-nterm-methionine T|F]
     When set to T, for each protein that begins with methionine, tide-index
     will put two copies of the leading peptide into the index, with and without
     the N-terminal methionine. Default = false.
  [--decoy-format none|shuffle|peptide-reverse|protein-reverse]
     Include a decoy version of every peptide by shuffling or reversing the
     target sequence or protein. In shuffle or peptide-reverse mode, each
     peptide is either reversed or shuffled, leaving the N-terminal and
     C-terminal amino acids in place. Note that peptides appear multiple times
     in the target database are only shuffled once. In peptide-reverse mode,
     palindromic peptides are shuffled. Also, if a shuffled peptide produces an
     overlap with the target or decoy database, then the peptide is re-shuffled
     up to 5 times. Note that, despite this repeated shuffling, homopolymers
     will appear in both the target and decoy database. The protein-reverse mode
     reverses the entire protein sequence, irrespective of the composite
     peptides. Default = shuffle.
  [--decoy-prefix <string>]
     Specifies the prefix of the protein names that indicate a decoy. Default =
     decoy_.
  [--keep-terminal-aminos N|C|NC|none]
     When creating decoy peptides using decoy-format=shuffle or
     decoy-format=peptide-reverse, this option specifies whether the N-terminal
     and C-terminal amino acids are kept in place or allowed to be shuffled or
     reversed. For a target peptide "EAMPK" with decoy-format=peptide-reverse,
     setting keep-terminal-aminos to "NC" will yield "EPMAK"; setting it to "C"
     will yield "PMAEK"; setting it to "N" will yield "EKPMA"; and setting it to
     "none" will yield "KPMAE". Default = NC.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--fileroot <string>]
     The fileroot string will be added as a prefix to all output file names.
     Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_list

### Tool Description
Crux supports the following primary commands and utility commands.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find list in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_specified

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry proteomics data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find specified in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_get-ms2-spectrum

### Tool Description
Parse fragmentation spectra from MS2 files.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 1 arguments, but found 0

USAGE:

  crux get-ms2-spectrum [options] <ms2 file>

REQUIRED ARGUMENTS:

  <ms2 file> The name of one or more files from which to parse the fragmentation
  spectra, in any of the file formats supported by ProteoWizard.

OPTIONAL ARGUMENTS:

  [--scan-number <string>]
     A single scan number or a range of numbers to be searched. Range should be
     specified as 'first-last' which will include scans 'first' and 'last'.
     Default = <empty>.
  [--remove-precursor-tolerance <float>]
     This parameter specifies the tolerance (in Th) around each precursor m/z
     that is removed when the --remove-precursor-peak option is invoked. Default
     = 1.5.
  [--stats T|F]
     Rather than the spectrum, output summary statistics to standard output.
     Each statistic is placed on a separate line, in the format <name>:<value>
     (e.g. "TIC:1000.0"). Default = false.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--use-z-line T|F]
     Specify whether, when parsing an MS2 spectrum file, Crux obtains the
     precursor mass information from the "S" line or the "Z" line.  Default =
     true.
```


## crux_then

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find then in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_psm-convert

### Tool Description
Convert PSM files to different formats.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux psm-convert [options] <input PSM file> <output format>

REQUIRED ARGUMENTS:

  <input PSM file> The name of a PSM file in tab-delimited text, SQT, pepXML or
  mzIdentML format

  <output format> The desired format of the output file. Legal values are tsv,
  html, sqt, pin, pepxml, mzidentml.

OPTIONAL ARGUMENTS:

  [--input-format auto|tsv|sqt|pepxml|mzidentml]
     Legal values are auto, tsv, sqt, pepxml or mzidentml format. Default =
     auto.
  [--distinct-matches T|F]
     Whether matches/ion are distinct (as opposed to total). Default = true.
  [--protein-database <string>]
     The name of the file in FASTA format. Default = <empty>.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_subtract-index

### Tool Description
A new peptide index containing all peptides that occur in the first index but not the second.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 3 arguments, but found 0

USAGE:

  crux subtract-index [options] <tide index 1> <tide index 2> <output index>

REQUIRED ARGUMENTS:

  <tide index 1> A peptide index produced using tide-index

  <tide index 2> A second peptide index, to be subtracted from the first index.

  <output index> A new peptide index containing all peptides that occur in
  thefirst index but not the second.

OPTIONAL ARGUMENTS:

  [--mass-precision <integer>]
     Set the precision for masses and m/z written to sqt and text files. Default
     = 4.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--peptide-list T|F]
     Create in the output directory a text file listing of all the peptides in
     the database, along with their neutral masses, one per line. If decoys are
     generated, then a second file will be created containing the decoy
     peptides. Decoys that also appear in the target database are marked with an
     asterisk in a third column. Default = false.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_the

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find the in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_that

### Tool Description
crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find that in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_xlink-assign-ions

### Tool Description
Assigns cross-linked peptides to MS/MS spectra.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 8 arguments, but found 0

USAGE:

  crux xlink-assign-ions [options] <peptide A> <peptide B> <pos A> <pos B> <link mass> <charge state> <scan number> <ms2 file>

REQUIRED ARGUMENTS:

  <peptide A> The sequence of peptide A.

  <peptide B> The sequence of peptide B.

  <pos A> Position of cross-link on peptide A

  <pos B> Position of cross-link on peptide B

  <link mass> The mass modification of the linker when attached to a peptide.

  <charge state> The charge state of the peptide.

  <scan number> Scan number identifying the spectrum.

  <ms2 file> The name of one or more files from which to parse the fragmentation
  spectra, in any of the file formats supported by ProteoWizard.

OPTIONAL ARGUMENTS:

  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--spectrum-parser pwiz|mstoolkit]
     Specify the parser to use for reading in MS/MS spectra. Default = pwiz.
  [--fragment-mass average|mono]
     Specify which isotopes to use in calculating fragment ion mass. Default =
     mono.
  [--max-ion-charge <string>]
     Predict theoretical ions up to max charge state (1, 2, ... ,6) or up to the
     charge state of the peptide ("peptide"). If the max-ion-charge is greater
     than the charge state of the peptide, then the maximum is the peptide
     charge.  Default = peptide.
  [--mz-bin-width <float>]
     Before calculation of the XCorr score, the m/z axes of the observed and
     theoretical spectra are discretized. This parameter specifies the size of
     each bin. The exact formula for computing the discretized m/z value is
     floor((x/mz-bin-width) + 1.0 - mz-bin-offset), where x is the observed m/z
     value. For low resolution ion trap ms/ms data 1.0005079 and for high
     resolution ms/ms 0.02 is recommended. Default = 1.0005079.
  [--precision <integer>]
     Set the precision for scores written to sqt and text files. Default = 8.
```


## crux_peaks

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find peaks in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_xlink-score-spectrum

### Tool Description
Score cross-linked peptides based on their mass spectrum.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 8 arguments, but found 0

USAGE:

  crux xlink-score-spectrum [options] <peptide A> <peptide B> <pos A> <pos B> <link mass> <charge state> <scan number> <ms2 file>

REQUIRED ARGUMENTS:

  <peptide A> The sequence of peptide A.

  <peptide B> The sequence of peptide B.

  <pos A> Position of cross-link on peptide A

  <pos B> Position of cross-link on peptide B

  <link mass> The mass modification of the linker when attached to a peptide.

  <charge state> The charge state of the peptide.

  <scan number> Scan number identifying the spectrum.

  <ms2 file> The name of one or more files from which to parse the fragmentation
  spectra, in any of the file formats supported by ProteoWizard.

OPTIONAL ARGUMENTS:

  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
  [--use-flanking-peaks T|F]
     Include flanking peaks around singly charged b and y theoretical ions. Each
     flanking peak occurs in the adjacent m/z bin and has half the intensity of
     the primary peak. Default = false.
  [--xlink-score-method composite|modification|concatenated]
     Score method for xlink {composite, modification, concatenated}. Default =
     composite.
  [--use-a-ions T|F]
     Consider a-ions in the search? Note that an a-ion is equivalent to a
     neutral loss of CO from the b-ion.  Peak height is 10 (in arbitrary units).
     Default = false.
  [--use-b-ions T|F]
     Consider b-ions in the search? Peak height is 50 (in arbitrary units).
     Default = true.
  [--use-c-ions T|F]
     Consider c-ions in the search? Peak height is 50 (in arbitrary units).
     Default = false.
  [--use-x-ions T|F]
     Consider x-ions in the search? Peak height is 10 (in arbitrary units).
     Default = false.
  [--use-y-ions T|F]
     Consider y-ions in the search? Peak height is 50 (in arbitrary units).
     Default = true.
  [--use-z-ions T|F]
     Consider z-ions in the search? Peak height is 50 (in arbitrary units).
     Default = false.
```


## crux_calculate

### Tool Description
Crux supports the following primary commands and utility commands.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find calculate in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_different

### Tool Description
Supports a variety of commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find different in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_localize-modification

### Tool Description
Localize modifications in PSM files.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 1 arguments, but found 0

USAGE:

  crux localize-modification [options] <input PSM file>

REQUIRED ARGUMENTS:

  <input PSM file> The name of a PSM file in tab-delimited text, SQT, pepXML or
  mzIdentML format

OPTIONAL ARGUMENTS:

  [--min-mod-mass <float>]
     Ignore implied modifications where the absolute value of its mass is below
     this value and only score the unmodified peptide. Default = 0.
  [--mod-precision <integer>]
     Set the precision for modifications as written to .txt files. Default = 2.
  [--top-match <integer>]
     Specify the number of matches to report for each spectrum. Default = 5.
  [--output-dir <string>]
     The name of the directory where output files will be created. Default =
     crux-output.
  [--overwrite T|F]
     Replace existing files if true or fail when trying to overwrite a file if
     false. Default = false.
  [--parameter-file <string>]
     A file containing parameters.  Default = <empty>.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_along

### Tool Description
Supports a variety of primary and utility commands for mass spectrometry data analysis.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find along in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_modification

### Tool Description
Crux is a suite of tools for analyzing mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find modification in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_from

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find from in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_mass

### Tool Description
Crux is a suite of tools for analyzing tandem mass spectrometry data.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find mass in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_extract-columns

### Tool Description
Extracts specified columns from a tab-delimited file.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux extract-columns [options] <tsv file> <column names>

REQUIRED ARGUMENTS:

  <tsv file> A tab-delimited file, with column headers in the first row. Use "-"
  to read from standard input.

  <column names> A comma-delimited list of column names.

OPTIONAL ARGUMENTS:

  [--delimiter <string>]
     Specify the input and output delimiter to use when processing the delimited
     file.  The argument can be either a single character or the keyword 'tab.'
     Default = tab.
  [--header T|F]
     Print the header line of the file, in addition to the columns that match.
     Default = true.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_extract-rows

### Tool Description
Extract rows from a TSV file based on a column value.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 3 arguments, but found 0

USAGE:

  crux extract-rows [options] <tsv file> <column name> <column value>

REQUIRED ARGUMENTS:

  <tsv file> A tab-delimited file, with column headers in the first row. Use "-"
  to read from standard input.

  <column name> A column name.

  <column value> A cell value for a column.

OPTIONAL ARGUMENTS:

  [--delimiter <string>]
     Specify the input and output delimiter to use when processing the delimited
     file.  The argument can be either a single character or the keyword 'tab.'
     Default = tab.
  [--header T|F]
     Print the header line of the file, in addition to the columns that match.
     Default = true.
  [--comparison eq|gt|gte|lt|lte|neq]
     Specify the operator that is used to compare an entry in the specified
     column to the value given on the command line. Default = eq.
  [--column-type int|real|string]
     Specifies the data type of the column, either an integer (int), a floating
     point number (real), or a string. Default = string.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_stat-column

### Tool Description
Extracts a column from a tab-delimited file.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux stat-column [options] <tsv file> <column name>

REQUIRED ARGUMENTS:

  <tsv file> A tab-delimited file, with column headers in the first row. Use "-"
  to read from standard input.

  <column name> A column name.

OPTIONAL ARGUMENTS:

  [--delimiter <string>]
     Specify the input and output delimiter to use when processing the delimited
     file.  The argument can be either a single character or the keyword 'tab.'
     Default = tab.
  [--header T|F]
     Print the header line of the file, in addition to the columns that match.
     Default = true.
  [--precision <integer>]
     Set the precision for scores written to sqt and text files. Default = 8.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```


## crux_tab-delimited

### Tool Description
crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output, then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Cannot find tab-delimited in available applications
 Usage: crux <command> [options] <argument>

crux supports the following primary commands:

  bullseye                 Assign high resolution precursor m/z values to
                           MS/MS data using the Hardklör algorithm.
  tide-index               Create an index for all peptides in a fasta file,
                           for use in subsequent calls to tide-search.
  tide-search              Search a collection of spectra against a sequence
                           database, returning a collection of
                           peptide-spectrum matches (PSMs). This is a fast
                           search engine but requires that you first build an
                           index with tide-index.
  comet                    Search a collection of spectra against a sequence
                           database, returning a collection of PSMs. This
                           search engine runs directly on a protein database
                           in FASTA format.
  percolator               Re-rank a collection of PSMs using the Percolator
                           algorithm. Optionally, also produce protein
                           rankings using the Fido algorithm.
  q-ranker                 Re-rank a collection of PSMs using the Q-ranker
                           algorithm.
  barista                  Rank PSMs, peptides and proteins, assigning a
                           confidence measure to each identification.
  search-for-xlinks        Search a collection of spectra against a sequence
                           database, returning a collection of matches
                           corresponding to linear and cross-linked peptides
                           scored by XCorr.
  spectral-counts          Quantify peptides or proteins using one of three
                           spectral counting methods.
  pipeline                 Runs a series of Crux tools on a protein database
                           and one or more sets of tandem mass spectra.
  cascade-search           An iterative procedure for incorporating
                           information about peptide groups into the database
                           search and confidence estimation procedure.
  assign-confidence        Assign two types of statistical confidence measures
                           (q-values and posterior error probabilities) to
                           each PSM in a given set.

crux supports the following utility commands:

  make-pin                 Given a set of search results files, generate a pin
                           file for input to crux percolator
  predict-peptide-ions     Given a peptide and a charge state, predict the m/z
                           values of the resulting fragment ions.
  hardklor                 Identify isotopic distributions from
                           high-resolution mass spectra.
  param-medic              Examine the spectra in a file to estimate the best
                           precursor and fragment error tolerances for
                           database search.
  print-processed-spectra  Process spectra as for scoring xcorr and print the
                           results to a file.
  generate-peptides        Extract from a given set of protein sequences a
                           list of target and decoy peptides fitting the
                           specified criteria.
  get-ms2-spectrum         Extract one or more fragmentation spectra,
                           specified by scan number, from an MS2 file.
  version                  Print the Crux version number to standard output,
                           then exit.
  psm-convert              Reads in a file containing peptide-spectrum matches
                           (PSMs) in one of the variety of supported formats
                           and outputs the same PSMs in a different format
  subtract-index           This command takes two peptide indices, created by
                           the tide-index command, and subtracts the second
                           index from the first. The result is an output index
                           that contains peptides that appear in the first
                           index but not the second.
  xlink-assign-ions        Given a spectrum and a pair of cross-linked
                           peptides, assign theoretical ion type labels to
                           peaks in the observed spectrum.
  xlink-score-spectrum     Given a cross-linked peptide and a spectrum
                           calculate the corresponding XCorr score a number of
                           different ways.
  localize-modification    This command finds, for each peptide-spectrum match
                           (PSM) in a given set, the most likely location
                           along the peptide for a post-translational
                           modification (PTM). The mass of the PTM is inferred
                           from the difference between the spectrum neutral
                           mass and the peptide mass.
  extract-columns          Print specified columns from a tab-delimited file.
  extract-rows             Print specified rows from a tab-delimited file.
  stat-column              Collect summary statistics from a column in a
                           tab-delimited file.
  sort-by-column           Sorts a tab-delimited file by a column.


Options and arguments are specific to each command.
Type 'crux <command>' for details.
```


## crux_sort-by-column

### Tool Description
Sorts a tab-delimited file by the values in a specified column.

### Metadata
- **Docker Image**: biocontainers/crux:v3.2_cv3
- **Homepage**: https://github.com/redbadger/crux
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
FATAL: Expected 2 arguments, but found 0

USAGE:

  crux sort-by-column [options] <tsv file> <column name>

REQUIRED ARGUMENTS:

  <tsv file> A tab-delimited file, with column headers in the first row. Use "-"
  to read from standard input.

  <column name> A column name.

OPTIONAL ARGUMENTS:

  [--delimiter <string>]
     Specify the input and output delimiter to use when processing the delimited
     file.  The argument can be either a single character or the keyword 'tab.'
     Default = tab.
  [--header T|F]
     Print the header line of the file, in addition to the columns that match.
     Default = true.
  [--column-type int|real|string]
     Specifies the data type of the column, either an integer (int), a floating
     point number (real), or a string. Default = string.
  [--ascending T|F]
     Sort in ascending (T) or descending (F) order. Default = true.
  [--verbosity <integer>]
     Specify the verbosity of the current processes. Each level prints the
     following messages, including all those at lower verbosity levels: 0-fatal
     errors, 10-non-fatal errors, 20-warnings, 30-information on the progress of
     execution, 40-more progress information, 50-debug info, 60-detailed debug
     info. Default = 30.
```

