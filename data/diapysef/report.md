# diapysef CWL Generation Report

## diapysef_converttdftomzml

### Tool Description
Conversion program to convert a Bruker TIMS .d data file to mzML format

### Metadata
- **Docker Image**: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
- **Homepage**: https://github.com/Roestlab/dia-pasef
- **Package**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Roestlab/dia-pasef
- **Stars**: N/A
### Original Help Text
```text
Bruker sdk not found. Some functionalities that need access to raw data will not be available. To activate that functionality place libtimsdata.so (Linux) or timsdata.dll in the src folder. 

Warning: OPENMS_DATA_PATH environment variable already exists. pyOpenMS will use it (/usr/local/share/OpenMS/) to locate data in the OpenMS share folder (e.g., the unimod database), instead of the default (/usr/local/lib/python3.10/site-packages/pyopenms/share/OpenMS).
INFO: Could not find Bruker SDK! Attempting to download one from: https://raw.githubusercontent.com/MatteoLacki/opentims_bruker_bridge/main/opentims_bruker_bridge/libtimsdata.so
Usage: diapysef converttdftomzml [OPTIONS]

  Conversion program to convert a Bruker TIMS .d data file to mzML format

Options:
  --in PATH                       The location of the directory containing raw
                                  data (usually .d).  [required]
  --out TEXT                      The name of the output file (mzML).
                                  [required]
  --merge INTEGER                 Number of consecutive frames to sum up
                                  (squash). This is useful to boost S/N if
                                  exactly repeated frames are measured.
                                  [default: -1]
  --keep_frames / --no-keep_frames
                                  Whether to store frames exactly as measured
                                  or split them into individual spectra by
                                  precursor isolation window (default is to
                                  split them - this is almost always what you
                                  want).  [default: no-keep_frames]
  --verbose INTEGER               Verbosity.  [default: -1]
  --overlap INTEGER               How many overlapping windows were recorded
                                  for the same m/z window - will split the
                                  output into N output files.  [default: -1]
  --framerange TEXT               The minimum and maximum Frames to convert.
                                  Useful to only convert a part of a file.
                                  [default: [-1, -1]]
  --help                          Show this message and exit.
```


## diapysef_export

### Tool Description
Export a reduced targeted mzML file to a tsv, parquet or sqMass file

### Metadata
- **Docker Image**: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
- **Homepage**: https://github.com/Roestlab/dia-pasef
- **Package**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Validation**: PASS

### Original Help Text
```text
Bruker sdk not found. Some functionalities that need access to raw data will not be available. To activate that functionality place libtimsdata.so (Linux) or timsdata.dll in the src folder. 

Warning: OPENMS_DATA_PATH environment variable already exists. pyOpenMS will use it (/usr/local/share/OpenMS/) to locate data in the OpenMS share folder (e.g., the unimod database), instead of the default (/usr/local/lib/python3.10/site-packages/pyopenms/share/OpenMS).
INFO: Could not find Bruker SDK! Attempting to download one from: https://raw.githubusercontent.com/MatteoLacki/opentims_bruker_bridge/main/opentims_bruker_bridge/libtimsdata.so
Usage: diapysef export [OPTIONS]

  Export a reduced targeted mzML file to a tsv, parquet or sqMass file

Options:
  --in PATH                   A filtered targeted diaPASEF mzML file, or a
                              previously exported tsv file.  [required]
  --out TEXT                  Filename to save extracted data to, tsv or
                              parquet if input is mzML or sqMass if input is
                              tsv or mzML.  [default:
                              diapasef_extracted_data.tsv]
  --coords PATH               File that contains target coordinates to extract
                              data for, or a file that can be used to generate
                              target coordinates from.
                              
                              Can be one of:
                              
                              pickle (.pkl) - a pickle file that contains a
                              python dictionary of coordinates, i.e. {
                              "TELISVSEVHPS(UniMod:21)R" : {'precursor_mz':767
                              .3691,'charge':2,'product_mz': [311.0639,
                              312.6357, 322.1867, ..., 11432.6832],'rt_apex':1
                              736.98,'rt_boundaries':[1719.823,
                              1759.129],'im_apex':0.9884788},
                              "T(UniMod:21)ELISVSEVHPSR" :
                              {'precursor_mz':767.3691,
                              'charge':2,'product_mz': [311.0639, 312.6357,
                              322.1867, ..., 11432.6832],'rt_apex':1730.08,'rt
                              _boundaries':[1718.037,
                              1751.984],'im_apex':1.0261329}}
  --mslevel TEXT              list of mslevel(s) to extract data for. i.e.
                              [1,2] would extract data for MS1 and MS2.
                              [default: [1]]
  --mz_tol INTEGER            The m/z tolerance toget get upper and lower
                              bounds arround target mz. Must be in ppm.
                              [default: 25]
  --aggr_ms2 / --no-aggr_ms2  Whether you want to aggregate MS2 data for each
                              precursor. Only applicable for mzML to pkl
                              export.  [default: no-aggr_ms2]
  --verbose INTEGER           Level of verbosity. 0 - just displays info, 1 -
                              display some debug info, 10 displays a lot of
                              debug info.  [default: 0]
  --threads INTEGER           Number of threads to parallelize exporting
                              across threads.  [default: 1]
  --log_file TEXT             Log file to save console messages.  [default:
                              mobidik_export.log]
  --help                      Show this message and exit.
```


## diapysef_prepare-coordinates

### Tool Description
Generate peptide coordinates for targeted extraction of DIA-PASEF data

### Metadata
- **Docker Image**: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
- **Homepage**: https://github.com/Roestlab/dia-pasef
- **Package**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Validation**: PASS

### Original Help Text
```text
Bruker sdk not found. Some functionalities that need access to raw data will not be available. To activate that functionality place libtimsdata.so (Linux) or timsdata.dll in the src folder. 

Warning: OPENMS_DATA_PATH environment variable already exists. pyOpenMS will use it (/usr/local/share/OpenMS/) to locate data in the OpenMS share folder (e.g., the unimod database), instead of the default (/usr/local/lib/python3.10/site-packages/pyopenms/share/OpenMS).
INFO: Could not find Bruker SDK! Attempting to download one from: https://raw.githubusercontent.com/MatteoLacki/opentims_bruker_bridge/main/opentims_bruker_bridge/libtimsdata.so
Usage: diapysef prepare-coordinates [OPTIONS]

  Generate peptide coordinates for targeted extraction of DIA-PASEF data

Options:
  --in PATH                       An OSW file post Pyprophet statiscal
                                  validation.  [required]
  --out TEXT                      Filename to save pickle of peptide
                                  coordinates.  [default:
                                  peptides_coordinates.pkl]
  --run_id INTEGER                Run id in OSW file corresponding to DIA-
                                  PASEF run. Required if your OSW file is a
                                  merged OSW file.
  --target_peptides TEXT          list of peptides (ModifiedPeptideSequence)
                                  to generate coordinates for. i.e.
                                  ["T(UniMod:21)ELISVSEVHPSR",
                                  "TELIS(UniMod:21)VSEVHPSR"]. You can
                                  alternatively pass a text file containing
                                  comma separate peptide sequences.
  --m_score FLOAT                 QValue to filter for peptides below QValue,
                                  generate coordinates for these peptides.
                                  [default: 0.05]
  --use_transition_peptide_mapping / --no-use_transition_peptide_mapping
                                  Use the TRANSITION_PEPTIDE_MAPPING when
                                  getting PRODUCT MZ, instead of joining on
                                  TRANSITION_PRECURSOR_MAPPING.  [default: no-
                                  use_transition_peptide_mapping]
  --use_only_detecting_transitions / --no-use_only_detecting_transitions
                                  Only include product m/z of detecting
                                  transitions. i.e do not use identifying
                                  transitions.  [default:
                                  use_only_detecting_transitions]
  --verbose INTEGER               Level of verbosity. 0 - just displays info,
                                  1 - display some debug info, 10 displays a
                                  lot of debug info.  [default: 0]
  --log_file TEXT                 Log file to save console messages.
                                  [default:
                                  mobidik_peptide_coordinate_generation.log]
  --help                          Show this message and exit.
```


## diapysef_report

### Tool Description
Generate a report for a specfific type of plot

### Metadata
- **Docker Image**: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
- **Homepage**: https://github.com/Roestlab/dia-pasef
- **Package**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Validation**: PASS

### Original Help Text
```text
Bruker sdk not found. Some functionalities that need access to raw data will not be available. To activate that functionality place libtimsdata.so (Linux) or timsdata.dll in the src folder. 

Warning: OPENMS_DATA_PATH environment variable already exists. pyOpenMS will use it (/usr/local/share/OpenMS/) to locate data in the OpenMS share folder (e.g., the unimod database), instead of the default (/usr/local/lib/python3.10/site-packages/pyopenms/share/OpenMS).
INFO: Could not find Bruker SDK! Attempting to download one from: https://raw.githubusercontent.com/MatteoLacki/opentims_bruker_bridge/main/opentims_bruker_bridge/libtimsdata.so
Usage: diapysef report [OPTIONS]

  Generate a report for a specfific type of plot

Options:
  --in PATH                       Data tsv file that contains data to be
                                  plotting. i.e peptide sequence, charge
                                  state, m/z, MS level, retention time, ion
                                  mobility, and intensity  [required]
  --out TEXT                      The pdf file name to save the plots to.
                                  [required]
  --type [rt_im_heatmap]          Type of plot to generate.  [default:
                                  rt_im_heatmap]
  --plot_contours / --no-plot_contours
                                  Should contour lines be plotted? Arg for
                                  type rt_im_heatmap  [default: no-
                                  plot_contours]
  --verbose INTEGER               Level of verbosity. 0 - just displays info,
                                  1 - display some debug info, 10 displays a
                                  lot of debug info.  [default: 0]
  --log_file TEXT                 Log file to save console messages.
                                  [default: mobidik_report.log]
  --help                          Show this message and exit.
```


## diapysef_targeted-extraction

### Tool Description
Extract from the raw data given a set of target coordinates to extract for.

### Metadata
- **Docker Image**: quay.io/biocontainers/diapysef:1.0.10--pyh7cba7a3_0
- **Homepage**: https://github.com/Roestlab/dia-pasef
- **Package**: https://anaconda.org/channels/bioconda/packages/diapysef/overview
- **Validation**: PASS

### Original Help Text
```text
Bruker sdk not found. Some functionalities that need access to raw data will not be available. To activate that functionality place libtimsdata.so (Linux) or timsdata.dll in the src folder. 

Warning: OPENMS_DATA_PATH environment variable already exists. pyOpenMS will use it (/usr/local/share/OpenMS/) to locate data in the OpenMS share folder (e.g., the unimod database), instead of the default (/usr/local/lib/python3.10/site-packages/pyopenms/share/OpenMS).
INFO: Could not find Bruker SDK! Attempting to download one from: https://raw.githubusercontent.com/MatteoLacki/opentims_bruker_bridge/main/opentims_bruker_bridge/libtimsdata.so
Usage: diapysef targeted-extraction [OPTIONS]

  Extract from the raw data given a set of target coordinates to extract for.

Options:
  --in PATH                      Raw data, diaPASEF mzML file.  [required]
  --coords PATH                  File that contains target coordinates to
                                 extract data for, or a file that can be used
                                 to generate target coordinates from.
                                 
                                 Can be one of:
                                 
                                 pickle (.pkl) - a pickle file that contains a
                                 python dictionary of coordinates, i.e. {
                                 "TELISVSEVHPS(UniMod:21)R" : {'precursor_mz':
                                 767.3691,'charge':2,'product_mz': [311.0639,
                                 312.6357, 322.1867, ..., 11432.6832],'rt_apex
                                 ':1736.98,'rt_boundaries':[1719.823,
                                 1759.129],'im_apex':0.9884788},
                                 "T(UniMod:21)ELISVSEVHPSR" :
                                 {'precursor_mz':767.3691,
                                 'charge':2,'product_mz': [311.0639, 312.6357,
                                 322.1867, ..., 11432.6832],'rt_apex':1730.08,
                                 'rt_boundaries':[1718.037,
                                 1751.984],'im_apex':1.0261329}}  [required]
  --out TEXT                     Filename to save extracted data to. Must be
                                 type mzML  [default:
                                 targed_data_extraction.mzML]
  --mz_tol INTEGER               The m/z tolerance toget get upper and lower
                                 bounds arround target mz. Must be in ppm.
                                 [default: 20]
  --rt_window INTEGER            The total window range of RT, i.e. a window
                                 of 50 would be 25 points to either side of
                                 the target RT.  [default: 50]
  --im_window FLOAT              The total window range of IM, i.e. a window
                                 of 0.06 would be 0.03 points to either side
                                 of the target IM.  [default: 0.06]
  --mslevel TEXT                 list of mslevel(s) to extract data for. i.e.
                                 [1,2] would extract data for MS1 and MS2.
                                 [default: [1]]
  --readOptions [ondisk|cached]  Context to estimate gene-level FDR control.
                                 [default: ondisk]
  --verbose INTEGER              Level of verbosity. 0 - just displays info, 1
                                 - display some debug info, 10 displays a lot
                                 of debug info.  [default: 0]
  --log_file TEXT                Log file to save console messages.  [default:
                                 mobidik_data_extraction.log]
  --threads INTEGER              Number of threads to parallelize filtering of
                                 spectrums across threads.  [default: 1]
  --help                         Show this message and exit.
```

