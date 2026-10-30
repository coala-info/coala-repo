# msproteomicstools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| msproteomicstools_MSE2mzML.py | Failed | image problem: pyopenms is not installed in the image (ImportError) |
| msproteomicstools_MSE_split.py | PASS | synthetic data: a small MSE text file was split into 3 files at the FUNCTION lines |
| msproteomicstools_NISTParser.py | Not completed | no real NIST msp library in the test data; the SpectraST text library of the repo tests crashes the parser (IndexError) |
| msproteomicstools_ProtFDRTraML2Fasta.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_ProtFDRmProphet2Mayu.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_add_protein_annotation.py | PASS | synthetic data: a 3-row table with real FASTA ids; descriptions added, unknown protein gets NA |
| msproteomicstools_compute_full_matrix.py | PASS | peakgroup matrix from the repo test input matches the expected output (only the last digits of one float differ) |
| msproteomicstools_convertFromPeakview.py | PASS | converted the Peakview library made by spectrast2tsv and filterPeakview into an OpenSWATH library with the expected columns |
| msproteomicstools_convertMassLynxTomzML.py | Failed | image problem: pyopenms is not installed in the image (ImportError) |
| msproteomicstools_convertNISTLibraryToTSV.py | Not completed | no real NIST msp library in the test data; the SpectraST text library of the repo tests crashes the parser (IndexError) |
| msproteomicstools_copy_accesion.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_count_pep_prot.py | PASS | counted 54 precursors, 1 peptide and 1 protein in the repo test table |
| msproteomicstools_extract_matrix.py | PASS | wrote a matrix with Intensity, RT and m_score from a feature_alignment output |
| msproteomicstools_fdr_cutoff.py | PASS | kept 15 rows of the repo test table up to the FDR cutoff and added the FDREstimate column |
| msproteomicstools_feature_alignment.py | PASS | id and matrix outputs equal the repo expected files (matrix differs only in the last digit of two floats); transformation files collected |
| msproteomicstools_featurealigner2msstats.py | PASS | converted the feature_alignment output to an MSstats csv with one row per fragment ion |
| msproteomicstools_filterChrom.py | Failed | image problem: pyopenms is not installed in the image (ImportError) |
| msproteomicstools_filterPeakview.py | PASS | filtered the Peakview library made by spectrast2tsv and added the UniProtID column |
| msproteomicstools_filterSqMass.py | PASS | kept only PEPTIDEA with --chrom_filter and only the listed chromatograms with --tsv_filter on the repo sqMass test files |
| msproteomicstools_fix_sonar.py | Not completed | no SONAR mzML test file available |
| msproteomicstools_fix_swath_windows.py | PASS | synthetic data: MS2 scans planted into a real test mzXML; baseCommand fixed to fix_swath_windows.py and output path added |
| msproteomicstools_makeSwathFile.py | Failed | image problem: the script has a Python syntax error (SyntaxError), so it cannot run |
| msproteomicstools_mergeSqMass.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_pepxml2csv.py | PASS | converted the repo test pepXML to a tab-delimited csv next to the input |
| msproteomicstools_pepxml2csv_simple.py | PASS | output equals the repo expected csv exactly |
| msproteomicstools_plot_alignment_tree.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_preprocess_peakview.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_proteinDBmasses.py | PASS | synthetic data: abundance file; weights and peptide counts for 9 proteins are plausible (the help says -a is optional but the script exits without it) |
| msproteomicstools_proteinDigest.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_proteins_not_in_library.py | PASS | synthetic data: a 1-row table; listed the one FASTA entry that is not in it |
| msproteomicstools_pseudoreverseDB.py | PASS | output equals the repo expected pseudo-reversed FASTA |
| msproteomicstools_requantAlignedValues.py | Failed | tool bug: the default lowess re-alignment crashes (UnboundLocalError); single-run mode works and its output matches the repo's expected files |
| msproteomicstools_spectrast2spectrast_irt.py | Not completed | no test library with Biognosys RT-kit peptides in each run; the repo test library gives 'run does not contain any RT-kit peptides' |
| msproteomicstools_spectrast2tsv.py | PASS | OpenSWATH output equals the repo expected file; Peakview output also written |
| msproteomicstools_spectrast_cluster.py | Failed | image problem: scikit-learn (sklearn) is not installed in the image (ImportError) |
| msproteomicstools_spectrast_updateiRTs.py | PASS | synthetic data: hand-written iRT model file; RetentionTime values changed as a*RT+b (6210.1 -> 114.202) |
| msproteomicstools_splitMSE.py | PASS | synthetic data: a small MSE text file was split into 3 files at the FUNCTION lines |
| msproteomicstools_split_mzXML_intoSwath.py | Failed | image problem: the script has a Python syntax error (from __future__ import after other code), so it cannot run |
| msproteomicstools_trafoXML_visualize.py | Failed | image problem: the script has no interpreter line, so it cannot start (exec format error) |
| msproteomicstools_tsv2spectrast.py | PASS | synthetic data: header-renamed real library table; baseCommand fixed to tsv2spectrast.py |

## msproteomicstools_tsv2spectrast.py

### Tool Description
Converts TSV files to Spectrast format.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Total Downloads**: 16.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/msproteomicstools/msproteomicstools
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/tsv2spectrast.py", line 56, in <module>
    outfile = sys.argv[2]
IndexError: list index out of range
```


## msproteomicstools_fix_swath_windows.py

### Tool Description
Fixes SWATH windows based on a parameter file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/fix_swath_windows.py", line 73, in <module>
    paramfilename = sys.argv[2]
IndexError: list index out of range
```


## msproteomicstools_MSE2mzML.py

### Tool Description
Convert a MSE text export to mzML.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MSE2mzML.py input.txt output.mzML
Convert a MSE text export to mzML.
  input.txt    MSE text file (first argument)
  output.mzML  output mzML file (second argument)
(Usage text taken from the script source /usr/local/bin/MSE2mzML.py; the script has no --help.)
```

## msproteomicstools_MSE_split.py

### Tool Description
Split a MassLynx MSE text export into one file per FUNCTION block (files MSE_0.txt, MSE_1.txt, ... under the given output prefix).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MSE_split.py filename outputpath
Split a MassLynx MSE text export at every line containing FUNCTION. The parts are written as <outputpath>MSE_<n>.txt.
  filename    first argument, input text file
  outputpath  second argument, output path prefix
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_NISTParser.py

### Tool Description
Parse a NIST spectral library (msp text) into a transition TSV (top 6 fragment ions above m/z 400 per spectrum).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: NISTParser.py input.msp output.tsv
Parse a NIST spectral library (text) into a transition TSV with the top 6 fragment ions above m/z 400 per spectrum.
  input.msp   first argument, NIST library
  output.tsv  second argument, output file
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_ProtFDRTraML2Fasta.py

### Tool Description
Convert a TSV that was converted from a TraML file into a FASTA file with the peptides of each protein concatenated.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ProtFDRTraML2Fasta.py input.tsv output.fasta
Convert a TSV that was converted from a TraML file into a FASTA file where the peptides of each protein are concatenated.
(Usage text taken from the script source; the script cannot be started: exec format error.)
```

## msproteomicstools_ProtFDRmProphet2Mayu.py

### Tool Description
Convert an mProphet TSV output file to a Mayu input file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ProtFDRmProphet2Mayu.py [-h] --in INFILE --out OUTFILE

This program converts an mProphet TSV output file to a Mayu input file

  --in INFILE    A list of mProphet output files containing all peakgroups (use quotes around the filenames)
  --out OUTFILE  Output file
(Usage text taken from the argparse definition in the script source; the script cannot be started: exec format error.)
```

## msproteomicstools_add_protein_annotation.py

### Tool Description
Annotate a csv with protein descriptions from FASTA. It searches for a column named ProteinName, looks it up in the FASTA file and adds a column ProteinDescription to the csv.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: A script to annotate a csv with protein descriptions from FASTA. It will search for a column named ProteinName, look it upin the FASTA file and add a column with the name ProteinDescription to the csv.

Options:
  -h, --help            show this help message and exit

  Feature Alignments Options:
    --fasta=FASTA_FILE  A fasta file
    --in=MPROPHET_FILE  A mProphet output file
    --out=OUTFILE       A modified mProphet output file
```

## msproteomicstools_compute_full_matrix.py

### Tool Description
Select all peakgroups below the FDR cutoff in all files and try to align them to each other. With one file it acts as peakgroup selector (best by m_score) and applies the FDR cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compute_full_matrix.py [-h] --in INFILES [INFILES ...]
                              [--out_matrix MATRIX_OUTFILE]
                              [--frac_selected 0] [--file_format FILE_FORMAT]
                              [--output_method OUTPUT_METHOD]
                              [--readmethod READMETHOD]
                              [--remove_requant_values]
                              [--aligner_mscore_threshold ALIGNER_MSCORE_THRESHOLD]

This program will select all peakgroups below the FDR cutoff in all files and
try to align them to each other. If only one file is given, it will act as
peakgroup selector (best by m_score) and will apply the provided FDR cutoff.

optional arguments:
  -h, --help            show this help message and exit
  --in INFILES [INFILES ...]
                        A list of mProphet output files containing all
                        peakgroups (use quotes around the filenames)
  --out_matrix MATRIX_OUTFILE
                        Matrix containing one peak group per (supports .csv,
                        .tsv or .xls)
  --frac_selected 0     Do not write peakgroup if selected in less than this
                        fraction of runs (range 0 to 1)
  --file_format FILE_FORMAT
                        Which input file format is used (openswath or
                        peakview)
  --output_method OUTPUT_METHOD
                        Which columns are written besides Intensity (none, RT,
                        score or full)
  --readmethod READMETHOD
                        Read full or minimal transition groups (minimal,full)
  --remove_requant_values
  --aligner_mscore_threshold ALIGNER_MSCORE_THRESHOLD
                        cutoff used at alignment, for coloring realigned
                        values in blue
```

## msproteomicstools_convertFromPeakview.py

### Tool Description
Convert a Peakview library (tab-delimited) to the OpenSWATH format.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert from Peakview format to OpenSWATH format
Example command:
    python convertFromPeakview.py peakview_library.csv openswath_library.csv
(Usage text taken from the docstring of the script source; the script has no --help.)
```

## msproteomicstools_convertMassLynxTomzML.py

### Tool Description
Convert a MassLynx text file to mzML.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: convertMassLynxTomzML.py input.txt output.mzML
Convert a MassLynx text file to mzML.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_convertNISTLibraryToTSV.py

### Tool Description
Convert a NIST spectral library (msp text) to a transition TSV (top 6 fragment ions above m/z 400 per spectrum).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: convertNISTLibraryToTSV.py input.msp output.tsv
Convert a NIST spectral library (text) to a transition TSV with the top 6 fragment ions above m/z 400 per spectrum.
  input.msp   first argument, NIST library
  output.tsv  second argument, output file
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_copy_accesion.py

### Tool Description
Swap the two accession codes of every protein in a FASTA file; the result is written to the input file name plus '.new'.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: copy_accesion.py fasta_file
Swap the two accession codes (code1 and code2) of every protein of the FASTA file and write the result to <fasta_file>.new in sp format.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_count_pep_prot.py

### Tool Description
Count precursors, peptides and proteins (single and multiple hits) in a tab-delimited result table with columns Sequence and ProteinName.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count_pep_prot.py table.tsv
Count precursors, peptides and proteins (single and multiple hits) in a tab-delimited table with the columns Sequence and ProteinName. The counts are printed to standard output.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_extract_matrix.py

### Tool Description
Generate a matrix with flexible columns from a featurealigner.tsv or featurealigner_requant.tsv file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_matrix.py [-h] --in INFILE --out OUT
                         [--columns COLUMNS [COLUMNS ...]]

Generates matrix with flexible columns from featurealigner.tsv or
featurealigner_requant.tsv file.For filtering or peak type highlighting use
compute_full_matrix.py

optional arguments:
  -h, --help            show this help message and exit
  --in INFILE           feature aligner file
  --out OUT             output matrix
  --columns COLUMNS [COLUMNS ...]
                        Which columns are written
```

## msproteomicstools_fdr_cutoff.py

### Tool Description
Sort a tab-delimited table by a score column, estimate the FDR from decoy rows and write the rows up to the FDR cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fdr_cutoff.py input.tsv output.tsv sort_by decoy_name fdr_cutoff reverse use_fdr_score
Sort a tab-delimited table by the column sort_by, count rows that contain decoy_name in any cell as decoys, estimate the FDR and write the rows up to fdr_cutoff with an added FDREstimate column.
  reverse        TRUE sorts in descending order (any other value ascending)
  use_fdr_score  TRUE uses the sort column directly as the FDR (any other value estimates it from decoys)
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_feature_alignment.py

### Tool Description
Select all peakgroups below the FDR cutoff in all files and align them to each other. With one file it acts as peakgroup selector (best by m_score) and applies the FDR cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: cannot import optimized MST alignment, will use Python version (slower).
usage: feature_alignment.py [-h] --in INP [INP ...] [--file_format] --out
                            OUTFILE [--out_matrix] [--out_ids] [--out_meta]
                            [--fdr_cutoff 0.01] [--target_fdr 0.01]
                            [--max_fdr_quality -1] [--max_rt_diff 30]
                            [--iso_max_rt_diff 30] [--frac_selected 0]
                            [--method METHOD] [--verbosity 0]
                            [--matrix_output_method] [--realign_method diRT]
                            [--force] [--version VERSION]
                            [--mst:useRTCorrection True]
                            [--mst:Stdev_multiplier -1.0]
                            [--mst:useLocalStdev False]
                            [--mst:useReference False]
                            [--disable_isotopic_grouping]
                            [--use_dscore_filter] [--dscore_cutoff 1.96]
                            [--nr_high_conf_exp 1] [--readmethod minimal]
                            [--tmpdir TMPDIR] [--alignment_score 0.0001]
                            [--realign_runs] [--use_external_r]

Feature Alignment -- version 0.11.0 This program will select all peakgroups
below the FDR cutoff in all files and try to align them to each other. If only
one file is given, it will act as peakgroup selector (best by m_score) and
will apply the provided FDR cutoff.

optional arguments:
  -h, --help            show this help message and exit
  --in INP [INP ...]    A list of mProphet output files containing all
                        peakgroups (use quotes around the filenames)
  --file_format         Input file format (openswath, mprophet or peakview)
  --out OUTFILE         Output file with filtered peakgroups
  --out_matrix          Matrix containing one peak group per row (supports
                        .csv, .tsv or .xlsx)
  --out_ids             Id file only containing the ids
  --out_meta            Outfile containing meta information
  --fdr_cutoff 0.01     Fixed FDR cutoff used for seeding (only assays where
                        at least one peakgroup in one run is below this cutoff
                        will be included in the result), see also target_fdr
                        for a non-fixed cutoff
  --target_fdr 0.01     If parameter estimation is used, which target FDR
                        should be optimized for. If set to lower than 0,
                        parameter estimation is turned off.
  --max_fdr_quality -1  Extension m-score score cutoff, peakgroups of this
                        quality will still be considered for alignment during
                        extension
  --max_rt_diff 30      Maximal difference in RT (in seconds) for two aligned
                        features
  --iso_max_rt_diff 30  Maximal difference in RT (in seconds) for two isotopic
                        channels in the same run
  --frac_selected 0     Do not write peakgroup if selected in less than this
                        fraction of runs (range 0 to 1)
  --method METHOD       Method to use for the clustering (best_overall,
                        best_cluster_score or global_best_cluster_score,
                        global_best_overall, LocalMST, LocalMSTAllCluster).
  --verbosity 0         Verbosity (0 = little)
  --matrix_output_method 
                        Which columns are written besides Intensity (none, RT,
                        score, source or full)
  --realign_method diRT
                        RT alignment method (diRT, linear, splineR,
                        splineR_external, splinePy, lowess, lowess_biostats,
                        lowess_statsmodels, lowess_cython, nonCVSpline,
                        CVSpline, Earth, WeightedNearestNeighbour,
                        SmoothLLDMedian, None)
  --force               Force alignment
  --version VERSION     Print version and exit

options for the MST:
  --mst:useRTCorrection True
                        Use aligned peakgroup RT to continue threading
  --mst:Stdev_multiplier -1.0
                        How many standard deviations the peakgroup can deviate
                        in RT during the alignment (if less than max_rt_diff,
                        then max_rt_diff is used)
  --mst:useLocalStdev False
                        Use local standard deviation of the alignment
  --mst:useReference False
                        Use a reference-based tree for alignment

experimental options:
  --disable_isotopic_grouping
                        Disable grouping of isotopic variants by
                        peptide_group_label
  --use_dscore_filter
  --dscore_cutoff 1.96  Discard all peakgroups below this d-score
  --nr_high_conf_exp 1  Number of experiments in which the peptide needs to be
                        identified with confidence above fdr_cutoff
  --readmethod minimal  Read full or minimal transition groups
                        (cminimal,minimal,full)
  --tmpdir TMPDIR       Temporary directory
  --alignment_score 0.0001
                        Minimal score needed for a feature to be considered
                        for alignment between runs
  --realign_runs        Deprecated option (equals '--realign_method
                        external_r')
  --use_external_r      Deprecated option (equals '--realign_method
                        external_r')
```

## msproteomicstools_featurealigner2msstats.py

### Tool Description
Convert a feature alignment table (tsv or tsv.gz) to an MSstats compatible csv file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: align2msstats.py input_feature_alignment.tsv[.gz] output_msstats_compatible.csv
```

## msproteomicstools_filterChrom.py

### Tool Description
Filter a chromatogram mzML file by native id (regular expression); with the inverse option the matching chromatograms are removed.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
A small program that will filter chromatogram mzML file by their native id
Usage: python filterChrom.py infile.mzML outfile.mzML chrom_id inverse
Note: chrom_id can be a regex; using True as 'inverse' argument allows to do inverse matching
```

## msproteomicstools_filterPeakview.py

### Tool Description
Filter Peakview csv libraries: remove transitions below 350 m/z or within 10 Da of the precursor, keep the top 6, normalize intensities to 10000 and map modifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Script to filter peakview csv libraries
Applies to PeakView libraries that are unfiltered and have not gone through the conversion process with the spectrast2tsv.py
- remove transitions that are not within the cutoff (less than 350 m/z)
- normalize intensity to 10k
- fix modifications
    python filterPeakview.py input.csv output.csv
```

## msproteomicstools_filterSqMass.py

### Tool Description
Filter chromatograms of an sqMass file by native id or by a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filterSqMass.py [-h] --in INP --out OUT [--chrom_filter NATIVE_ID]
                       [--tsv_filter TSV]

A script to merge multiple sqMass files

optional arguments:
  -h, --help            show this help message and exit
  --in INP              An input file
  --out OUT             An output file
  --chrom_filter NATIVE_ID
                        Filter chromatograms by native id
  --tsv_filter TSV      Filter chromatograms by TSV file
```

## msproteomicstools_fix_sonar.py

### Tool Description
Fix SONAR mzML files by adding the precursor isolation window information into the file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
This program intends to fix SONAR mzML files by adding the precursor isolation window information into the file.
It changes the mzML by fixing the following issues:
    - replace MS-level MS:1000511 in SONAR scans with MS2 (which is wrongly written as MS1)
    - removes the MS:1000579 tag from SONAR scans (indicates MS1 scan)
    - add the precursor tag with isolation window target and offsets based on the formula provided
Usage:
    python fix_sonar.py input.mzML paramfile output.mzML
```

## msproteomicstools_makeSwathFile.py

### Tool Description
Write three small synthetic SWATH test files (Swath_test_osw.mzML, Swath_test_pwiz.mzML and Swath_test_missing.mzML) to the working directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makeSwathFile.py
The script takes no arguments. It builds a small synthetic SWATH experiment (20 scans, 5 swaths) and writes Swath_test_osw.mzML, Swath_test_pwiz.mzML and Swath_test_missing.mzML to the working directory.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_mergeSqMass.py

### Tool Description
Merge multiple sqMass files into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mergeSqMass.py [-h] --in INP [INP ...] --out OUT

A script to merge multiple sqMass files

  --in INP [INP ...]  A list of files to be merged
  --out OUT           Output file
(Usage text taken from the argparse definition in the script source; the script cannot be started: exec format error.)
```

## msproteomicstools_pepxml2csv.py

### Tool Description
Convert a pepXML file to a tab-delimited csv file written next to the input (input name with extension replaced by .csv).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pepxml2csv.py file.pep.xml
Convert a pepXML file (pyteomics reader) to a tab-delimited csv file; the output is written next to the input with the extension replaced by .csv.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_pepxml2csv_simple.py

### Tool Description
Convert a pepXML file to a simple csv table of spectrum, peptide, scores and protein.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pepxml2csv_simple.py input.pep.xml output.csv
Convert a pepXML file to a csv table with the columns Spectrum, Scan number, Peptide_Sequence, PrecursorMass, Massdiff, Expect value, Pvalue, MatchedIons, TotalIons and Protein.
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_plot_alignment_tree.py

### Tool Description
Draw the alignment tree from a .yaml output file of a feature_alignment run in a graph format (pdf, svg, ...) using graphviz.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: input.yaml output.pdf treeFormat drawFormat
  treeFormat is one of (Mapped, MappedFile, MappedFileInput, Raw)
  drawFormat is one of (dot, neato, twopi, circo, fdp, sfdp)

    this software takes a .yaml output file from a feature_alignment
    run and draws the corresponding tree in a specific output format (pdf, svg, ...)
    requires the graphviz package to be installed and works on a linux machine
(Usage text taken from the script source; the script cannot be started: exec format error.)
```

## msproteomicstools_preprocess_peakview.py

### Tool Description
Add a preprocess_id column (row number) to a Peakview file.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: preprocess_peakview.py input.txt output.txt
Add a preprocess_id column (row number) to the front of a Peakview table.
(Usage text taken from the script source; the script cannot be started: exec format error.)
```

## msproteomicstools_proteinDBmasses.py

### Tool Description
Retrieve the protein weights and in-silico peptide counts for the proteins of FASTA files. The result is written next to each FASTA file as <name>_mass.tsv (and <name>_simulation.tsv with --dynamic-range).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text

proteinDBmasses.py
---------------
This script retrieves the protein weights given a fasta file.

Usage: 
python proteinDBmasses.py [options] fasta_file(s)
-h		Display this help
-a	abundancefile	Protein abundance file. If not used, the script will just report the number of peptides and molecular weight of the proteins.
-d	dynamic-range	Simulation of peptide intensity by using the peptide detectability dynamic range specified. If not used, there will not be any simulation
-e 	enzyme	Enzyme used for in-silico digestion (peptide counting). Options: trypsin, Asp-N, Arg-C, Chymotrypsin, Lys-C, Lys-N. Default: trypsin
-l 	pep-length	Minimum peptide length for the in-silico digestion. Default: 5
-m	min-peptides	Define a minimum number of peptides to identify a protein. This must be completed with the -n option.
-n	peptides-identified Define a number of identified peptides to estimate the number of proteins identified.
```

## msproteomicstools_proteinDigest.py

### Tool Description
In-silico digestion of the proteins of FASTA files; the peptides are written next to each FASTA file as <name>_digest.tsv.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
proteinDBmasses.py
---------------
This script retrieves the protein weights given a fasta file.

Usage: 
python proteinDBmasses.py [options] fasta_file(s)
-h        Display this help
-e     enzyme    Enzyme used for in-silico digestion (peptide counting). Options: trypsin, Asp-N, Arg-C, Chymotrypsin, Lys-C, Lys-N. Default: trypsin
-l     pep-length    Minimum peptide length for the in-silico digestion. Default: 5
-m     missed-cleav  Allowed missed cleavages. Default: 0
(Usage text taken from the script source; the script cannot be started: exec format error. It writes <fasta base>_digest.tsv.)
```

## msproteomicstools_proteins_not_in_library.py

### Tool Description
Display which proteins of a FASTA file are not present in a library csv (column ProteinName); entries starting with DECOY and sp| are ignored.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
    A script to display which proteins were not present in a library.
    It will search for a column named ProteinName in a csv, look it up
    in the FASTA file and then print out all extra entries in the FASTA file
    (except those starting with DECOY and sp|).
    

Options:
  -h, --help            show this help message and exit

  Feature Alignments Options:
    --fasta=FASTA_FILE  A fasta file
    --in=CSV_FILE       A csv file with the column ProteinName
    --out=OUTFILE       A csv output file containing all proteins not in the
                        csv file
```

## msproteomicstools_pseudoreverseDB.py

### Tool Description
Create pseudo-reversed decoys (peptide level reversion) from a FASTA file. If no cleavage site is found the protein is simply reversed.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: python pseudoreverseDB [options]
Options:
-i   input.fasta input fasta file
-o   output.fasta output file with decoys
[-t] tag for decoys (optional, default 'DECOY_')
[-c] cleavage rule (optional, default '[KR](?!P)' =trypsin)
Creates pseudo-reversed decoys (peptide level reversion). If no cleavage site is found protein is simply reversed.
See http://dx.doi.org/10.1038/nmeth1019 Figure 6
```

## msproteomicstools_requantAlignedValues.py

### Tool Description
Impute missing values: requantify aligned peakgroups in the chromatogram files of all runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: cannot import optimized MST alignment, will use Python version (slower).
usage: requantAlignedValues.py [-h] [--in INFILES [INFILES ...]]
                               --peakgroups_infile PEAKGROUPS_INFILE --out
                               OUTPUT [--file_format FILE_FORMAT]
                               [--out_matrix MATRIX_OUTFILE]
                               [--matrix_output_method MATRIX_OUTPUT_METHOD]
                               [--border_option median] [--dry_run] [--test]
                               [--cache_in_memory] [--method METHOD]
                               [--realign_runs REALIGN_METHOD]
                               [--verbosity VERBOSITY] [--do_single_run]
                               [--alignment_score 0.0001] [--version VERSION]
                               [--disable_isotopic_grouping]
                               [--disable_isotopic_transfer]

Requantification -- version 0.11.0 This program will impute missing values

optional arguments:
  -h, --help            show this help message and exit
  --in INFILES [INFILES ...]
                        A list of transformation files in the same folder as
                        the .chrom.mzML files
  --peakgroups_infile PEAKGROUPS_INFILE
                        Infile containing peakgroups (outfile from
                        feature_alignment.py)
  --out OUTPUT          Output file with imputed values
  --file_format FILE_FORMAT
                        Which input file format is used (openswath, mprophet
                        or peakview)
  --out_matrix MATRIX_OUTFILE
                        Matrix containing one peak group per row (supports
                        .csv, .tsv or .xls)
  --matrix_output_method MATRIX_OUTPUT_METHOD
                        Which columns are written besides Intensity (none, RT,
                        score, source or full)
  --border_option median
                        How to determine integration border (possible values:
                        max_width, mean, median). Max width will use the
                        maximal possible width (most conservative since it
                        will overestimate the background signal).
  --dry_run             Perform a dry run only
  --test                For running the tests (does not add a random id to the
                        results)
  --cache_in_memory     Cache data from a single run in memory
  --method METHOD       Which method to use (singleShortestPath,
                        singleClosestRun, reference)
  --realign_runs REALIGN_METHOD
                        How to re-align runs in retention time ('diRT': use
                        only deltaiRT from the input file, 'linear': perform a
                        linear regression using best peakgroups, 'splineR':
                        perform a spline fit using R, 'splineR_external':
                        perform a spline fit using R (start an R process using
                        the command line), 'splinePy' use Python native spline
                        from scikits.datasmooth (slow!), 'lowess': use Robust
                        locally weighted regression (lowess smoother),
                        'nonCVSpline, CVSpline': splines with and without
                        cross-validation, 'Earth' : use Multivariate Adaptive
                        Regression Splines using py-earth
  --verbosity VERBOSITY
                        Verbosity
  --do_single_run       Only do a single run
  --alignment_score 0.0001
                        Minimal score needed for a feature to be considered
                        for alignment between runs
  --version VERSION     Print version and exit

experimental options:
  --disable_isotopic_grouping
                        Disable grouping of isotopic variants by
                        peptide_group_label, thus disabling matching of
                        isotopic variants of the same peptide across channels.
                        If turned off, each isotopic channel will be matched
                        independently of the other. If enabled, the more
                        certain identification will be used to infer the
                        location of the peak in the other channel.
  --disable_isotopic_transfer
                        Disable the transfer of isotopic boundaries in all
                        cases. If enabled (default), the best (best score)
                        isotopic channel dictates the peak boundaries and all
                        other channels use those boundaries. This ensures
                        consistency in peak picking in all cases.
```

## msproteomicstools_spectrast2spectrast_irt.py

### Tool Description
Normalize the retention times of a SpectraST library (txt format) to iRT using the Biognosys RT-kit peptides and write regression plots for all runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
SpectraST RT Normalizer
---------------------------------------------------------------------------------------------
Usage:     spectrast2spectrast_irt.py -i non_consensus_library.[splib/sptxt] -o non_consensus_library_irt.splib
Input:     SpectraST non_consensus_library.splib in txt format
Output:    SpectraST non_consensus_library_irt.[splib/pepidx] and regression plots for all runs.
Argument:  -i [--in]: input file
           -o [--out]: output file
           (optional) -k [--kit]: specifiy RT-kit [LGGNEQVTR:-28.3083,GAGSSEPVTGLDAK:0.227424,VEATFGVDESNAK:13.1078,YILAGVENSK:22.3798,TPVISGGPYEYR:28.9999,TPVITGAPYEYR:33.6311,DGLDAASYYAPVR:43.2819,ADVTPADFSEWSK:54.969,GTFIIDPGGVIR:71.3819,GTFIIDPAAVIR:86.7152,LFLQFGAQGSPFLK:98.0897]
           (optional) -a [--applychauvenet]: should Chavenet's criterion be used to exclude outliers?
           (optional) -p [--precursorlevel]: should precursors instead of peptides be used for grouping?
           (optional)    [--spectralevel]: do not merge or group any peptides or precursors (use raw spectra)
           (optional) -r [--report]: should a csv report be written?
           (optional) -e [--exclude]: specify peptides from the RT-kit to exclude [run_id1:LGGNEQVTR,run_id2:GAGSSEPVTGLDAK]
           (optional) -s [--surrogate]: specify surrogate calibrations [broken_run_id1:working_run_id2]
           (optional) -l [--linearregression]: specify surrogate linear regressions (first number: c, second number: m) [broken_run_id1:1/3]
           (optional) -t [--rsq_threshold]: specify r-squared threshold to accept linear regression [0.95]
Important: The splib need to be in txt format!
           spectrast -c_BIN! -cNnon_consensus.txt non_consensus.bin.splib
           All runs in your library further need to contain the Biognosys RT-kit peptides.
Contact:   George Rosenberger <rosenberger@imsb.biol.ethz.ch>
```

## msproteomicstools_spectrast2tsv.py

### Tool Description
Filter SpectraST library files into SWATH assay libraries (OpenSWATH or Peakview format).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text

spectrast2tsv.py
---------------
This script is used as filter from spectraST files to swath input files.

Usage: 
python spectrast2tsv.py [options] spectrast_file(s)
-h                  Display this help
-d                  Remove duplicate masses from labeling
-e                  Use theoretical mass
-f    fasta_file    Fasta file to relate peptides to their proteins (this is optional).
-g    mass_modifs   List of allowed fragment mass modifications. Useful for phosphorylation and neutral losses. Example: -g -79.97,-97.98,-17.03,-18.01
-i    labeling_file File containing the amino acid isotopic labeling mass shifts. If this option is used, heavy transitions will be generated.
-k    output_key    Select the output provided. Keys available: openswath, peakview. Default: peakview
-l    mass_limits   Lower and upper mass limits of fragment ions. Example: -l 400,2000
-m    mods_file     File with the modifications delta mass
-n    int           Max number of reported ions per peptide/z. Default: 20
-o    int           Min number of reported ions per peptide/z. Default: 3
-p    float         Maximum error allowed at the annotation of a fragment ion. Default: 0.05
-q    int            Number of processors to use (only for isoforms!). Default: 1
-s    ion_series    List of ion series to be used. Example: -s y,b
-t    time-scale    Options: minutes, seconds. Default: seconds.
-u     unimod-code    Use this unimod code as a switching modification. Useful for phosphorylations. Example: -u 21
-v                  Verbose mode.
-w    swaths_file   File containing the swath ranges. This is used to remove transitions with Q3 falling in the swath mass range. (line breaks in windows/unix format)
-x    allowed_frg_z Fragment ion charge states allowed. Default: 1,2
-y    UIS-order     When using a switching modification, this determines the UIS order to be calculated. If -1 is set, all transitions for each isoform will be reported. Default : 2
-a    outfile       Output file name (default: appends _peakview.txt)
```

## msproteomicstools_spectrast_cluster.py

### Tool Description
Cluster the spectra of SpectraST sptxt files by iRT and write the clusters in separate .sptxt files.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
spectrast_cluster.py
--------------------
This script clusters by iRT peptide spectra from spectraST, and writes the clusters in separate .sptxt files

Usage: 
python cluster_spectrast.py [options] spectrast_file(s)
-h            --help        Display this help
-d    distance        --distance        Cluster distance. Default : 1
```

## msproteomicstools_spectrast_updateiRTs.py

### Tool Description
Update the RetTime values of SpectraST sptxt files with iRT values calculated with a linear model; the result is written as <name>_iRT.sptxt.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text

spectrast_updateiRTs.py
-----------------------
This script updates the RetTime values of a spectraST files with different values (i.e. iRTs) calculated with a linear model.

Usage: 
python spectrast_updateiRTs.py [options] spectrast_file(s)
-a            --auto-align  Calculates automatically the alignment models based on the internal identifications of the calibration peptides
-h            --help        Display this help
-i    iRT_models_file    --irtmodel    File with the iRT models
-p    iRT_peptides_file    --irtpeptides File containing the peptides and their iRTs to do the linear model alignment.
-t   time-scale            Options: minutes, seconds. Default: seconds.
```

## msproteomicstools_splitMSE.py

### Tool Description
Split a MassLynx MSE text export into one file per FUNCTION block (files MSE_0.txt, MSE_1.txt, ... under the given output prefix).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: splitMSE.py filename outputpath
Split a MassLynx MSE text export at every line containing FUNCTION. The parts are written as <outputpath>MSE_<n>.txt.
  filename    first argument, input text file
  outputpath  second argument, output path prefix
(Usage text taken from the script source; the script has no --help.)
```

## msproteomicstools_split_mzXML_intoSwath.py

### Tool Description
Split an mzXML(.gz) file of SWATH scans into one file per SWATH window (and an MS1 file).

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: split.py file.mzXML[.gz] windowSize [outputdir [noms1map]]]
where
    filename is an mzXML or mzXML.gz file
    window size is usually 32
    outputdir is . default
    noms1map is default false (ms1scans are written)
Purpose: To split files from SWATH scans into individual files.
```

## msproteomicstools_trafoXML_visualize.py

### Tool Description
Plot the residues and the retention time correlation of a trafoXML file (linear fit) to PDF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
- **Homepage**: https://github.com/msproteomicstools/msproteomicstools
- **Package**: https://anaconda.org/channels/bioconda/packages/msproteomicstools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: trafoXML_visualize.py file.trafoXML [result_dir_prefix]
Fit a line to the Pair elements of a trafoXML file and plot the residues (trafo_residues_plot.pdf) and the retention time correlation (rt_correlation.pdf).
(Usage text taken from the script source; the script cannot be started: exec format error.)
```

## Metadata
- **Skill**: generated
