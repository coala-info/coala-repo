cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_and
doc: "crux supports the following primary commands:\n\n  bullseye                \
  \ Assign high resolution precursor m/z values to\n                           MS/MS
  data using the Hardklör algorithm.\n  tide-index               Create an index for
  all peptides in a fasta file,\n                           for use in subsequent
  calls to tide-search.\n  tide-search              Search a collection of spectra
  against a sequence\n                           database, returning a collection
  of\n                           peptide-spectrum matches (PSMs). This is a fast\n\
  \                           search engine but requires that you first build an\n\
  \                           index with tide-index.\n  comet                    Search
  a collection of spectra against a sequence\n                           database,
  returning a collection of PSMs. This\n                           search engine runs
  directly on a protein database\n                           in FASTA format.\n  percolator\
  \               Re-rank a collection of PSMs using the Percolator\n            \
  \               algorithm. Optionally, also produce protein\n                  \
  \         rankings using the Fido algorithm.\n  q-ranker                 Re-rank
  a collection of PSMs using the Q-ranker\n                           algorithm.\n\
  \  barista                  Rank PSMs, peptides and proteins, assigning a\n    \
  \                       confidence measure to each identification.\n  search-for-xlinks\
  \        Search a collection of spectra against a sequence\n                   \
  \        database, returning a collection of matches\n                         \
  \  corresponding to linear and cross-linked peptides\n                         \
  \  scored by XCorr.\n  spectral-counts          Quantify peptides or proteins using
  one of three\n                           spectral counting methods.\n  pipeline\
  \                 Runs a series of Crux tools on a protein database\n          \
  \                 and one or more sets of tandem mass spectra.\n  cascade-search\
  \           An iterative procedure for incorporating\n                         \
  \  information about peptide groups into the database\n                        \
  \   search and confidence estimation procedure.\n  assign-confidence        Assign
  two types of statistical confidence measures\n                           (q-values
  and posterior error probabilities) to\n                           each PSM in a
  given set.\n\ncrux supports the following utility commands:\n\n  make-pin      \
  \           Given a set of search results files, generate a pin\n              \
  \             file for input to crux percolator\n  predict-peptide-ions     Given
  a peptide and a charge state, predict the m/z\n                           values
  of the resulting fragment ions.\n  hardklor                 Identify isotopic distributions
  from\n                           high-resolution mass spectra.\n  param-medic  \
  \            Examine the spectra in a file to estimate the best\n              \
  \             precursor and fragment error tolerances for\n                    \
  \       database search.\n  print-processed-spectra  Process spectra as for scoring
  xcorr and print the\n                           results to a file.\n  generate-peptides\
  \        Extract from a given set of protein sequences a\n                     \
  \      list of target and decoy peptides fitting the\n                         \
  \  specified criteria.\n  get-ms2-spectrum         Extract one or more fragmentation
  spectra,\n                           specified by scan number, from an MS2 file.\n\
  \  version                  Print the Crux version number to standard output, then
  exit.\n  psm-convert              Reads in a file containing peptide-spectrum matches\n\
  \                           (PSMs) in one of the variety of supported formats\n\
  \                           and outputs the same PSMs in a different format\n  subtract-index\
  \           This command takes two peptide indices, created by\n               \
  \            the tide-index command, and subtracts the second\n                \
  \           index from the first. The result is an output index\n              \
  \             that contains peptides that appear in the first\n                \
  \           index but not the second.\n  xlink-assign-ions        Given a spectrum
  and a pair of cross-linked\n                           peptides, assign theoretical
  ion type labels to\n                           peaks in the observed spectrum.\n\
  \  xlink-score-spectrum     Given a cross-linked peptide and a spectrum\n      \
  \                     calculate the corresponding XCorr score a number of\n    \
  \                       different ways.\n  localize-modification    This command
  finds, for each peptide-spectrum match\n                           (PSM) in a given
  set, the most likely location\n                           along the peptide for
  a post-translational\n                           modification (PTM). The mass of
  the PTM is inferred\n                           from the difference between the
  spectrum neutral\n                           mass and the peptide mass.\n  extract-columns\
  \          Print specified columns from a tab-delimited file.\n  extract-rows  \
  \           Print specified rows from a tab-delimited file.\n  stat-column     \
  \         Collect summary statistics from a column in a\n                      \
  \     tab-delimited file.\n  sort-by-column           Sorts a tab-delimited file
  by a column.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The primary or utility command to run
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options specific to the chosen command
    inputBinding:
      position: 2
  - id: argument
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen command
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_and.out
