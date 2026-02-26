# cfm CWL Generation Report

## cfm_fraggraph-gen

### Tool Description
Generates a fragmentation graph from a molecule.

### Metadata
- **Docker Image**: quay.io/biocontainers/cfm:33--h7600467_7
- **Homepage**: https://sourceforge.net/p/cfm-id/wiki/Home/
- **Package**: https://anaconda.org/channels/bioconda/packages/cfm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cfm/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
fraggraph-gen.exe <smiles or inchi string> <max_depth> <ionization_mode (+,- or *)> <opt: fullgraph (default) or fragonly> <opt: output_filename (else stdout)>

ionization_mode: Positive ESI Ionization (+), Negative ESI Ionization (-), Positive EI Ionization (*)
```


## cfm_cfm-predict

### Tool Description
Predicts mass spectra for a given chemical structure.

### Metadata
- **Docker Image**: quay.io/biocontainers/cfm:33--h7600467_7
- **Homepage**: https://sourceforge.net/p/cfm-id/wiki/Home/
- **Package**: https://anaconda.org/channels/bioconda/packages/cfm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cfm-predict.exe <input_smiles_or_inchi> <prob_thresh_for_prune> <param_filename> <config_filename> <include_annotations> <output_filename> <apply_post_processing>



input_smiles_or_inchi_or_file:
The smiles or inchi string of the structure whose spectra you want to predict, or a .txt file containing a list of <id smiles> pairs, one per line.

prob_thresh_for_prune (opt):
The probability below which to prune unlikely fragmentations (default 0.001)

param_filename (opt):
The filename where the parameters of a trained cfm model can be found (if not given, assumes param_output.log in current directory)

config_filename (opt):
The filename where the configuration parameters of the cfm model can be found (if not given, assumes param_config.txt in current directory)

include_annotations (opt):
Whether to include fragment information in the output spectra (0 = NO (default), 1 = YES ). Note: ignored for msp/mgf output.

output_filename_or_dir (opt):
The filename of the output spectra file to write to (if not given, prints to stdout), OR directory if multiple smiles inputs are given (else current directory) OR msp or mgf file.

apply_postprocessing (opt):
Whether or not to post-process predicted spectra to take the top 80% of energy (at least 5 peaks), or the highest 30 peaks (whichever comes first) (0 = OFF, 1 = ON (default) ).

suppress_exception (opt):
Suppress exceptions so that the program returns normally even when it fails to produce a result (0 = OFF (default), 1 = ON).
```


## cfm_cfm-id

### Tool Description
Predicts candidate structures for a given spectrum and list of candidates.

### Metadata
- **Docker Image**: quay.io/biocontainers/cfm:33--h7600467_7
- **Homepage**: https://sourceforge.net/p/cfm-id/wiki/Home/
- **Package**: https://anaconda.org/channels/bioconda/packages/cfm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cfm-id.exe <spectrum_file> <id> <candidate_file> <num_highest> <ppm_mass_tol> <abs_mass_tol> <prob_thresh_for_prune> <param_filename> <config_filename> <score_type> <apply_postprocessing> <output_filename> <output_msp_or_mgf>



spectrum_file:
The filename where the input spectra can be found. This can be a .msp file in which the desired spectrum is listed under a corresponding id (next arg). Or it could be a single file with a list of peaks 'mass intensity' delimited by lines, with either 'low','med' and 'high' lines beginning spectra of different energy levels, or 'energy0', 'energy1', etc. e.g.
energy0
65.02 40.0
86.11 60.0
energy1
65.02 100.0 ... etc

id:
An identifier for the target molecule (Used to retrieve input spectrum from msp (if used). Otherwise not used but printed to output, in case of multiple concatenated results)

candidate_file:
The filename where the input list of candidate structures can be found - line separated 'id smiles_or_inchi' pairs.

num_highest (opt):
The number of (ranked) candidates to return or -1 for all (if not given, returns all in ranked order)

ppm_mass_tol (opt):
The mass tolerance in ppm to use when matching peaks within the dot product comparison - will use higher resulting tolerance of ppm and abs (if not given defaults to 10ppm)

abs_mass_tol (opt):
The mass tolerance in abs Da to use when matching peaks within the dot product comparison - will use higher resulting tolerance of ppm and abs ( if not given defaults to 0.01Da)

prob_thresh_for_prune (opt):
The probabiltiy threshold at which to prune unlikely fragmnetations (default 0.001)

param_filename (opt):
The filename where the parameters of a trained cfm model can be found (if not given, assumes param_output.log in current directory)

config_filename (opt):
The filename where the configuration parameters of the cfm model can be found (if not given, assumes param_config.txt in current directory)

score_type (opt):
The type of scoring function to use when comparing spectra. Options: Jaccard (default for ESI-MS/MS), DotProduct (default for EI-MS)

apply_postprocessing (opt):
Whether or not to post-process predicted spectra to take the top 80% of energy (at least 5 peaks), or the highest 30 peaks (whichever comes first) (0 = OFF (default for EI-MS), 1 = ON (default for ESI-MS/MS)).

output_filename (opt):
The filename of the output file to write to (if not given, prints to stdout)

output_msp_or_mgf (opt):
The filename for an output msp or mgf file to record predicted candidate spectra (if not given, doesn't save predicted spectra)
```

