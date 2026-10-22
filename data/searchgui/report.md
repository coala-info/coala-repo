# searchgui CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| searchgui_fasta_cli | PASS | ran on the bioconda tiny target FASTA (12 proteins); -decoy wrote a concatenated target/decoy FASTA with 24 entries |
| searchgui_identification_parameters_cli | PASS | created a .par file; tolerances, enzyme, fixed and variable modifications match the options given |
| searchgui_search_cli | PASS | ran X!Tandem on the bioconda tiny MGF (21 spectra) and FASTA; zip holds an X!Tandem result with 21 spectrum groups |

## searchgui_fasta_cli

### Tool Description
FastaCLI takes a FASTA file as input, generates general information about the database and allows operations on the FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
- **Homepage**: https://github.com/compomics/searchgui
- **Package**: https://anaconda.org/channels/bioconda/packages/searchgui/overview
- **Validation**: PASS

### Original Help Text
```text

FASTA file not specified.


======================
FastaCLI
======================

FastaCLI takes a FASTA file as input, generates general information about the database and allows operations on the FASTA file.

For further help see https://compomics.github.io/projects/searchgui.html and https://compomics.github.io/projects/searchgui/wiki/SearchCLI.html.

----------------------
OPTIONS
----------------------

Mandatory Parameters:

-in                        FASTA file


Optional Parameters:

-decoy                     Create a concatenated target/decoy database.
-decoy_suffix              Target decoy suffix, defaults to _concatenated_target_decoy.


Optional Temporary Folder:

-temp_folder               A folder for temporary file storage. Use only if you encounter problems with the default configuration.


FASTA Parameters:

-name                                The name of the database, FASTA file name by default.
-description                         The description of the database, FASTA file name by default.
-version                             The version of the database, date of creation of the file by default.
-decoy_flag                          The decoy flag, default: -REVERSED.
-suffix                              The location of the decoy flag: (1) prefix, (2) suffix. Inferred if not specified.
```

## searchgui_search_cli

### Tool Description
SearchCLI searches spectrum files according to search parameters using multiple search engines.

### Metadata
- **Docker Image**: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
- **Homepage**: https://github.com/compomics/searchgui
- **Package**: https://anaconda.org/channels/bioconda/packages/searchgui/overview
- **Validation**: PASS

### Original Help Text
```text

======================
SearchCLI
======================

SearchCLI searches spectrum files according to search parameters using multiple search engines.

Spectra must be provided either as mgf or mzML.

The identification parameters can be provided as a file as saved from the GUI or generated using the IdentificationParametersCLI.
See https://compomics.github.io/projects/compomics-utilities/wiki/IdentificationParametersCLI.html for more details.

For further help see https://compomics.github.io/projects/searchgui.html and https://compomics.github.io/projects/searchgui/wiki/SearchCLI.html.

Or contact the developers at https://groups.google.com/group/peptide-shaker.

----------------------
OPTIONS
----------------------

Mandatory Parameters:

-spectrum_files            Spectrum files (mgf or mzml), comma separated list or an entire folder.
-fasta_file                The complete path to the FASTA file.
-output_folder             The output folder.
-id_params                 The identification parameters file to use.


Search Engine Selection:

-omssa                     Turn the OMSSA search on or off (0: off, 1: on,  default is '0').
-xtandem                   Turn the X!Tandem search on or off (0: off, 1: on, default is '0').
-msgf                      Turn the MS-GF+ search on or off (0: off, 1: on, default is '0').
-ms_amanda                 Turn the MS Amanda search on or off (0: off, 1: on, default is '0').
-myrimatch                 Turn the MyriMatch search on or off (0: off,1: on,  default is '0').
-comet                     Turn the Comet search on or off (0: off, 1: on, default is '0').
-tide                      Turn the Tide search on or off (0: off, 1: on, default is '0').
-andromeda                 Turn the Andromeda search on or off (0: off, 1: on, default is '0').
-meta_morpheus             Turn the MetaMorpheus search on or off (0: off, 1: on, default is '0').
-novor                     Turn the Novor sequencing on or off (0: off, 1: on, default is '0').
-directag                  Turn the DirecTag sequencing on or off (0: off, 1: on, default is '0').


Tools Location:

-omssa_folder              The folder where OMSSA is installed, defaults to the provided version for the given OS.
-xtandem_folder            The folder where X!Tandem is installed, defaults to the provided version for the given OS.
-msgf_folder               The folder where MS-GF+ is installed, defaults to the included version.
-ms_amanda_folder          The folder where MS Amanda is installed, defaults to the included version.
-myrimatch_folder          The folder where MyriMatch is installed, defaults to the included version.
-comet_folder              The folder where Comet is installed, defaults to the included version.
-tide_folder               The folder where Tide is installed, defaults to the included version.
-tide_index_file           The folder where the Tide index should be stored. If this option is provided and the folder is not found, an index will be created in this folder and not deleted so that the index can be reused in subsequent runs. If this option is provided and the index is found, the creation of the index will be skipped. If this option is not provided, the index will always be created and stored either in the Tide or the temp folder and handled according to the Tide advanced parameters.
-andromeda_folder          The folder where Andromeda is installed, defaults to the included version.
-meta_morpheus_folder      The folder where MetaMorpheus is installed, defaults to the included version.
-novor_folder              The folder where Novor is installed, defaults to the included version.
-directag_folder           The folder where DirecTag is installed, defaults to the included version.
-makeblastdb_folder        The folder where makeblastdb is installed, defaults to the provided version for the given OS.


Input Files Handling:

-mgf_check_size            Turn the mgf size check on or off (0: off, 1: on, default is '0').
-mgf_splitting             The maximum mgf file size in MB before splitting the mgf. Default is '1000'.
-mgf_spectrum_count        The maximum number of spectra per mgf file when splitting. Default is '25000'.
-correct_titles            Correct for duplicate spectrum titles. (0: no correction, 1: rename spectra, 2: delete spectra, default is '1').
-missing_titles            Add missing spectrum titles. (0: no correction, 1: add missing spectrum titles, default is '0').


Output Files Handling:

-output_default_name       Optional output default name, default is 'searchgui_out'.
-output_gzip               Gzip result files (0: no, 1: yes, default is '1').
-output_option             Optional result file packaging (0: Group all files in a single compressed zip folder, 1: Group files per run (i.e. spectrum file), 2: Group files per identification algorithm, 3: No file grouping), default is '0'.
-output_data               Include mgf and FASTA file in zipped output (0: no, 1: yes, default is '0').
-output_date               Include date in output name (0: no, 1: yes, default is '0').
-rename_xtandem            Turn the renaming of the X! Tandem files on/off. (0: off, 1: on, default is '1').


Processing Options:

-threads                   Number of threads to use for the processing, default: the number of cores.


Advanced Options:

-ref_mass                  Reference mass for the conversion of the fragment ion tolerance from ppm to Dalton. Default is '2000'.


Optional Folder Options:

-temp_folder               A folder for temporary file storage. Use only if you encounter problems with the default configuration.
-config_folder             The config folder.



For identification parameters options:
Replace eu.isas.searchgui.cmd.SearchCLI with eu.isas.searchgui.cmd.IdentificationParametersCLI
```

## searchgui_identification_parameters_cli

### Tool Description
IdentificationParametersCLI creates an identification parameters file.

### Metadata
- **Docker Image**: quay.io/biocontainers/searchgui:4.3.15--hdfd78af_0
- **Homepage**: https://github.com/compomics/searchgui
- **Package**: https://anaconda.org/channels/bioconda/packages/searchgui/overview
- **Validation**: PASS

### Original Help Text
```text

============================
IdentificationParametersCLI
============================

IdentificationParametersCLI creates an identification parameters file.

Use the out option to specify the output file or the mods option to list the available modifications.

For further help see https://compomics.github.io/projects/compomics-utilities/wiki/IdentificationParametersCLI.html.

Or contact the developers at https://compomics.github.io/projects/compomics-utilities.html.

----------------------
OPTIONS
----------------------

Parameters Files:

-out                                 The destination Identification Parameters file (.par). (Mandatory)
-id_params                           The identification parameters file to use. (Optional)


Search Parameters:

-prec_tol                  Precursor ion mass tolerance, default is '10'.
-prec_ppm                  Precursor ion tolerance unit: ppm (1) or Da (0), default is '1'.
-frag_tol                  Fragment ion mass tolerance, default is '0.5'.
-frag_ppm                  Fragment ion tolerance unit: ppm (1) or Da (0), default is '1'.
-digestion                 The type of digestion to consider: 0: Enzyme, 1: Unspecific, 2: Whole Protein. Default is 0.
... (full option list: 345 options, see CWL)
```

