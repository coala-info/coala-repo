# philosopher CWL Generation Report

## philosopher_abacus

### Tool Description
Generates abacus reports.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Total Downloads**: 497
- **Last updated**: 2025-12-12
- **GitHub**: https://github.com/Nesvilab/philosopher
- **Stars**: N/A
### Original Help Text
```text
time="2026-02-26T15:56:03Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher abacus [flags]

Flags:
      --full            generates combined tables with extra information
  -h, --help            help for abacus
      --labels          indicates whether the data sets includes TMT labels or not
      --pepProb float   minimum peptide probability (default 0.5)
      --peptide         global level peptide report
      --picked          apply the picked FDR algorithm before the protein scoring
      --plex string     number of channels (default "10")
      --protein         global level protein report
      --prtProb float   minimum protein probability (default 0.9)
      --razor           use razor peptides for protein FDR scoring
      --reprint         create abacus reports using the Reprint format
      --tag string      decoy tag (default "rev_")
      --uniqueonly      report TMT quantification based on only unique peptides
```


## philosopher_bioquant

### Tool Description
Bioquant

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:56:27Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher bioquant [flags]

Flags:
  -h, --help          help for bioquant
      --id string     UniProt proteome ID
      --level float   cluster identity level (default 0.9)
```


## philosopher_comet

### Tool Description
Run comet

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:57:16Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher comet [flags]

Flags:
  -h, --help           help for comet
      --noindex        skip raw file indexing
      --param string   comet parameter file (default "comet.params.txt")
      --print          print a comet.params file
```


## philosopher_completion

### Tool Description
Generate the autocompletion script for philosopher for the specified shell.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
Generate the autocompletion script for philosopher for the specified shell.
See each sub-command's help for details on how to use the generated script.

Usage:
  philosopher completion [command]

Available Commands:
  bash        Generate the autocompletion script for bash
  fish        Generate the autocompletion script for fish
  powershell  Generate the autocompletion script for powershell
  zsh         Generate the autocompletion script for zsh

Flags:
  -h, --help   help for completion

Use "philosopher completion [command] --help" for more information about a command.
```


## philosopher_database

### Tool Description
Process a database for peptide identification.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:58:12Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher database [flags]

Flags:
      --add string        add custom sequences (UniProt FASTA format only)
      --annotate string   process a ready-to-use database
      --contam            add common contaminants
      --contamprefix      mark the contaminant sequences with a prefix tag
      --custom string     use a pre-formatted custom database
      --decoymode int8    define the decoy generating mode, 0: revere sequence (default), 1:reverse and shift KR, 2:reverse and swap Kr
      --enzyme string     enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin) (default "trypsin")
  -h, --help              help for database
      --id string         UniProt proteome ID
      --isoform           add isoform sequences
      --nodecoys          don't add decoys to the database
      --prefix string     define a decoy prefix (default "rev_")
      --reviewed          use only reviwed sequences from Swiss-Prot
      --verbose           debug the sequence classification for each FASTA record
```


## philosopher_filter

### Tool Description
Filter peptides and proteins based on FDR levels and other criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:58:32Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher filter [flags]

Flags:
      --2d               two-dimensional FDR filtering
      --group            use the group label to filter the data
  -h, --help             help for filter
      --inference        extremely fast and efficient protein inference compatible with 2D and Sequential filters
      --ion float        peptide ion FDR level (default 0.01)
      --mapmods          map modifications
      --minPepLen int    minimum peptide length criterion for protein probability assignment (default 7)
      --models           print model distribution
      --pep float        peptide FDR level (default 0.01)
      --pepProb float    top peptide probability threshold for the FDR filtering (default 0.7)
      --pepxml string    pepXML file or directory containing a set of pepXML files
      --picked           apply the picked FDR algorithm before the protein scoring
      --prot float       protein FDR level (default 0.01)
      --protProb float   protein probability threshold for the FDR filtering (not used with the razor algorithm) (default 0.5)
      --protxml string   protXML file path
      --psm float        psm FDR level (default 0.01)
      --razor            use razor peptides for protein FDR scoring
      --sequential       alternative algorithm that estimates FDR using both filtered PSM and protein lists
      --tag string       decoy tag (default "rev_")
      --weight float     threshold for defining peptide uniqueness (default 1)
```


## philosopher_freequant

### Tool Description
Quantify peaks using free energy calculations.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:58:51Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher freequant [flags]

Flags:
      --dir string   folder path containing the raw files
      --faims        Use FAIMS information for the quantification
  -h, --help         help for freequant
      --ptw float    specify the time windows for the peak (minute) (default 0.4)
      --raw          read raw files instead of converted XML
      --tol float    m/z tolerance in ppm (default 10)
```


## philosopher_iprophet

### Tool Description
iprophet

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:59:08Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher iprophet [flags]

Flags:
      --decoy string    specify the decoy tag
  -h, --help            help for iprophet
      --length          use Peptide Length model
      --minProb float   specify minimum probability of results to report
      --nofpkm          do not use FPKM model
      --nonrs           do not use NRS model
      --nonse           do not use NSE model
      --nonsi           do not use NSI model
      --nonsm           do not use NSM model
      --nonsp           do not use NSP model
      --nonss           do not use NSS model
      --output string   specify output name prefix (default "interact.iproph")
      --sharpnse        use more discriminating model for NSE in SWATH mode
      --threads int     specify threads to use (default 4)
```


## philosopher_labelquant

### Tool Description
Quantify isobaric labeling experiments.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:59:25Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher labelquant [flags]

Flags:
      --annot string      annotation file with custom names for the TMT channels
      --bestpsm           select the best PSMs for protein quantification
      --brand string      isobaric labeling brand (tmt, itraq, sCLIP)
      --dir string        folder path containing the raw files
  -h, --help              help for labelquant
      --level int         ms level for the quantification (default 2)
      --minprob float     only use PSMs with the specified minimum probability score (default 0.7)
      --plex string       number of reporter ion channels
      --purity float      ion purity threshold (default 0.5)
      --raw               read raw files instead of converted XML
      --removelow float   ignore the lower % of PSMs based on their summed abundances. 0 means no removal, entry value must be a decimal
      --tol float         m/z tolerance in ppm (default 20)
      --uniqueonly        report quantification based only on unique peptides
```


## philosopher_msfragger

### Tool Description
MSFragger is a fast and accurate mass spectrometry data analysis tool for peptide identification.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T15:59:51Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher msfragger [flags]

Flags:
      --Y_type_masses string                            [nglycan/labile search_mode only]. Specify fragments of labile mods that are commonly retained on intact peptides (e.g. Y ions for glycans). Only used if 'Y' is included in fragment_ion_series.
      --add_A_alanine float                             
      --add_C_cysteine float                             (default 57.021464)
      --add_Cterm_peptide float                         
      --add_Cterm_protein float                         
      --add_D_aspartic_acid float                       
      --add_E_glutamic_acid float                       
      --add_F_phenylalanine float                       
      --add_G_glycine float                             
      --add_H_histidine float                           
      --add_I_isoleucine float                          
      --add_K_lysine float                              
      --add_L_leucine float                             
      --add_M_methionine float                          
      --add_N_asparagine float                          
      --add_Nterm_peptide float                         
      --add_Nterm_protein float                         
      --add_P_proline float                             
      --add_Q_glutamine float                           
      --add_R_arginine float                            
      --add_S_serine float                              
      --add_T_threonine float                           
      --add_V_valine float                              
      --add_W_tryptophan float                          
      --add_Y_tyrosine float                            
      --add_topN_complementary int                      
      --allow_multiple_variable_mods_on_residue int     static mods are not considered
      --allowed_missed_cleavage_1 int                   First enzyme's allowed number of missed cleavages per peptide. Maximum value is 5. (default 2)
      --allowed_missed_cleavage_2 int                   Second enzyme's allowed number of missed cleavages per peptide. Maximum value is 5. (default 2)
      --calibrate_mass int                              0=Off, 1=On, 2=On and find optimal parameters
      --check the spectral files before searching int    (default 1)
      --clear_mz_range string                            (default "0.0 0.0")
      --clip_nTerm_M int                                 (default 1)
      --data_type int                                   0 for DDA, 1 for DIA, 2 for DIA-narrow-window
      --database_name string                            
      --decoy_prefix string                             prefix added to the decoy protein ID (used for parameter optimization only) (default "rev_")
      --deisotope int                                   Perform deisotoping or not (0=no, 1=yes and assume singleton peaks single charged, 2=yes and assume singleton (default 1)
      --deneutralloss int                               Perform deneutrallossing or not (0=no, 1=yes)
      --diagnostic_fragments string                     [nglycan/labile search_mode only]. Specify diagnostic fragments of labile mods that appear in the low m/z region. Only used if diagnostic_intensity_filter > 0.
      --diagnostic_intensity_filter int                 [nglycan/labile search_mode only]. Specify diagnostic fragments of labile mods that appear in the low m/z region. Only used if diagnostic_intensity_filter > 0.
      --digest_mass_range string                         (default "500.0 5000.0")
      --digest_max_length int                            (default 50)
      --digest_min_length int                            (default 7)
      --extension string                                determine the input file extension (mzML, raw, RAW (default "mzML")
      --fragment_ion_series string                      Ion series used in search, specify any of a,b,c,x,y,z,b~,y~,Y,b-18,y-18 (comma separated) (default "b,y")
      --fragment_mass_tolerance float                    (default 20)
      --fragment_mass_units int                          (default 1)
  -h, --help                                            help for msfragger
      --intensity_transform int                         transform peaks intensities with sqrt root. 0 = not transform; 1 = transform using sqrt root.
      --ion_series_definitions string                   User defined ion series. (Example: b* N -17.026548;b0 N -18.010565)
      --isotope_error string                            0=off, 0/1/2 (standard C13 error) (default "0/1/2")
      --labile_search_mode string                       type of search (nglycan, labile, or off). Off means non-labile/typical search. (default "off")
      --localize_delta_mass int                         
      --mass_diff_to_variable_mod int                   Put mass diff as a variable modification. 0 for no; 1 for yes and change the original mass diff and the calculated mass accordingly; 2 for yes but do not change the original mass diff.
      --mass_offsets string                             allow for additional precursor mass window shifts
      --max_fragment_charge int                          (default 2)
      --max_variable_mods_combinations int              maximum of 65534, limits number of modified peptides generated from sequence (default 5000)
      --max_variable_mods_per_peptide int               maximun of 5 (default 3)
      --memory int                                       (default 8)
      --min_fragments_modelling int                      (default 2)
      --min_matched_fragments int                        (default 4)
      --minimum_peaks int                               required minimum number of peaks in spectrum to search (default 10) (default 15)
      --minimum_ratio float                              (default 0.01)
      --num_enzyme_termini int                          2 for enzymatic, 1 for semi-enzymatic, 0 for nonspecific digestion (default 2)
      --num_threads int                                 CPU to set num threads; else specify num threads directly (max 64)
      --output_format string                             (default "pepXML")
      --output_max_expect int                            (default 50)
      --output_report_topN int                           (default 1)
      --override_charge int                             
      --param string                                    
      --path string                                     
      --precursor_charge string                         precursor charge range to analyze; does not override any existing charge; 0 as 1st entry ignores parameter (default "1 4")
      --precursor_mass_lower int                         (default -20)
      --precursor_mass_mode string                       (default "selected")
      --precursor_mass_units int                        0=Daltons, 1=ppm (default 1)
      --precursor_mass_upper int                         (default 20)
      --precursor_true_tolerance int                     (default 20)
      --precursor_true_units int                        0=Daltons, 1=ppm (default 1)
      --remove_precursor_peak int                       remove precursor peaks from tandem mass spectra. 0=not remove; 1=remove the peak with precursor charge;
      --remove_precursor_range string                   m/z range in removing precursor peaks. Unit: Da. (default "-1.5,1.5")
      --report_alternative_proteins int                 0=no, 1=yes
      --restrict_deltamass_to string                    Specify amino acids on which delta masses (mass offsets or search modifications) can occur. Allowed values are single letter codes (e.g. ACD) (default "all")
      --search_enzyme_cut_1 string                      First enzyme's cutting amino acid. (default "KR")
      --search_enzyme_cut_2 string                      Second enzyme's cutting amino acid.
      --search_enzyme_name_1 string                     Name of the first enzyme. (default "Trypsin")
      --search_enzyme_name_2 string                     Name of the second enzyme.
      --search_enzyme_nocut_1 string                    First enzyme's protecting amino acid. (default "P")
      --search_enzyme_nocut_2 string                    Second enzyme's protecting amino acid.
      --search_enzyme_sense_1 string                    First enzyme's cutting terminal. (default "C")
      --search_enzyme_sense_2 string                    Second enzyme's cutting terminal. (default "C")
      --track_zero_topN int                             in addition to topN results, keep track of top results in zero bin
      --use_all_mods_in_first_search int                Use all variable modifications in first search (0 for No, 1 for Yes)
      --use_topN_peaks int                               (default 150)
      --variable_mod_01 string                          
      --variable_mod_02 string                          
      --variable_mod_03 string                          
      --variable_mod_04 string                          
      --variable_mod_05 string                          
      --variable_mod_06 string                          
      --variable_mod_07 string                          
      --write_calibrated_mgf int                        write calibrated MS2 scan to a MGF file (0 for No, 1 for Yes)
      --zero_bin_accept_expect int                      boost top zero bin entry to top if it has expect under 0.01 - set to 0 to disable
      --zero_bin_mult_expect int                        disabled if above passes - multiply expect of zero bin for ordering purposes (does not affect reported expect) (default 1)
```


## philosopher_peptideprophet

### Tool Description
peptideprophet

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T16:00:24Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher peptideprophet [flags]

Flags:
      --accmass            use accurate mass model binning
      --clevel int         set Conservative Level in neg_stdev from the neg_mean, low numbers are less conservative, high numbers are more conservative
      --combine            combine the results from PeptideProphet into a single result file
      --database string    path to the database
      --decoy string       semi-supervised mode, protein name prefix to identify decoy entries (default "rev_")
      --decoyprobs         compute possible non-zero probabilities for decoy entries on the last iteration
      --enzyme string      enzyme used in sample
      --expectscore        use expectation value as the only contributor to the f-value for modeling
      --glyc               enable peptide glyco motif model
  -h, --help               help for peptideprophet
      --ignorechg string   use comma to separate the charge states to exclude from modeling
      --masswidth float    model mass width (default 5)
      --minpeplen int      minimum peptide length not rejected (default 7)
      --minprob float      report results with minimum probability (default 0.05)
      --nomass             disable mass model
      --nonmc              disable NMC missed cleavage model
      --nonparam           use semi-parametric modeling, must be used in conjunction with --decoy option
      --nontt              disable NTT enzymatic termini model
      --output string      output name prefix (default "interact")
      --phospho            enable peptide phospho motif model
      --ppm                use ppm mass error instead of Daltons for mass modeling
```


## philosopher_pipeline

### Tool Description
Executes a pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="16:00:53" level=info msg="Executing Pipeline  v5.1.2"
time="16:00:53" level=error msg="Cannot read file. read /: is a directory"
panic: Cannot read file. read /: is a directory

goroutine 1 [running]:
github.com/Nesvilab/philosopher/lib/msg.callLogrus({0xc0001408d0, 0x28}, {0x569173a0b3c7?, 0x1?})
	github.com/Nesvilab/philosopher/lib/msg/msg.go:327 +0x2d8
github.com/Nesvilab/philosopher/lib/msg.ReadFile({0x569173e7dd18?, 0xc000224060?}, {0x569173a0b3c7, 0x5})
	github.com/Nesvilab/philosopher/lib/msg/msg.go:76 +0x68
github.com/Nesvilab/philosopher/cmd.init.func16(0x5691758c3980?, {0x569175904fc0, 0x0, 0x0})
	github.com/Nesvilab/philosopher/cmd/pipeline.go:53 +0x21c
github.com/spf13/cobra.(*Command).execute(0x5691758c3980, {0x569175904fc0, 0x0, 0x0})
	github.com/spf13/cobra@v1.6.1/command.go:920 +0x871
github.com/spf13/cobra.(*Command).ExecuteC(0x5691758c3c60)
	github.com/spf13/cobra@v1.6.1/command.go:1044 +0x398
github.com/spf13/cobra.(*Command).Execute(...)
	github.com/spf13/cobra@v1.6.1/command.go:968
github.com/Nesvilab/philosopher/cmd.Execute()
	github.com/Nesvilab/philosopher/cmd/root.go:35 +0x1a
main.main()
	./main.go:23 +0x85
```


## philosopher_proteinprophet

### Tool Description
Runs ProteinProphet on Philosopher results.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T16:01:10Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher proteinprophet [flags]

Flags:
  -h, --help             help for proteinprophet
      --iprophet         input is from iProphet
      --maxppmdiff int   maximum peptide mass difference in ppm (default 2000000)
      --minprob float    probability threshold (default 0.05)
      --nonsp            do not use NSP model
      --output string    Output name (default "interact")
      --subgroups        do not use NOGROUPS
      --unmapped         report results for UNMAPPED proteins
```


## philosopher_ptmprophet

### Tool Description
PTMProphet is a tool for PTM localization.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T16:01:34Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher ptmprophet [flags]

Flags:
      --autodirect                 use direct evidence when the lability is high, use in combination with LABILITY
      --cions string               use specified C-term ions, separate multiple ions by commas (default: y for CID, z for ETD)
      --direct                     use only direct evidence for evaluating PTM site probabilities
      --em int                     set EM models to 0 (no EM), 1 (Intensity EM Model Applied) or 2 (Intensity and Matched Peaks EM Models Applied) (default 2)
      --excludemassdiffmax float   Maximun mass difference excluded for MASSDIFFFMODE analysis (default=0)
      --excludemassdiffmin float   Minimum mass difference excluded for MASSDIFFFMODE analysis (default=0)
      --fragppmtol int             when computing PSM-specific mass_offset and mass_tolerance, use specified default +/- MS2 mz tolerance on fragment ions (default 15)
  -h, --help                       help for ptmprophet
      --ifrags                     use internal fragments for localization
      --keepold                    retain old PTMProphet results in the pepXML file
      --lability                   compute Lability of PTMs
      --massdiffmode               use the mass difference and localize
      --massoffset int             adjust the massdiff by offset <number>
      --maxfragz int               limit maximum fragment charge (default: 0=precursor charge, negative values subtract from precursor charge)
      --maxthreads int             use specified number of threads for processing (default 1)
      --mino int                   use specified number of pseudo-counts when computing Oscore
      --minprob float              use specified minimum probability to evaluate peptides (default 0.9)
      --mods string                <amino acids, n, or c>:<mass_shift>:<neut_loss1>:...:<neut_lossN>,<amino acids, n, or c>:<mass_shift>:<neut_loss1>:...:<neut_lossN> (overrides the modifications from the interact.pep.xml file)
      --nions string               use specified N-term ions, separate multiple ions by commas (default: a,b for CID, c for ETD)
      --nominofactor               disable MINO factor correction when MINO= is set greater than 0 (default: apply MINO factor correction)
      --output string              output name prefix (default "interact")
      --ppmtol float               use specified +/- MS1 ppm tolerance on peptides which may have a slight offset depending on search parameters (default 1)
      --static                     use static fragppmtol for all PSMs instead of dynamically estimated offsets and tolerances
      --verbose                    produce Warnings to help troubleshoot potential PTM shuffling or mass difference issues
```


## philosopher_report

### Tool Description
Generate reports from philosopher runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="2026-02-26T16:02:02Z" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher report [flags]

Flags:
      --decoys         add decoy observations to reports
  -h, --help           help for report
      --ionmobility    forces the printing of the ion mobility column
      --msstats        create an output compatible with MSstats
      --mzid           create a mzID output
      --prefix         add the project (folder) name as a prefix to the output files
      --removecontam   remove contaminant sequences from the reports
```


## philosopher_slack

### Tool Description
Send messages to Slack

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="16:02:23" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher slack [flags]

Flags:
      --channel string    specify the channel name
      --direct string     send a direct message to a user ID
  -h, --help              help for slack
      --message string    specify the text of the message to send
      --token string      specify the Slack API token
      --username string   specify the name of the bot (default "Philosopher")
```


## philosopher_tmtintegrator

### Tool Description
Integrates TMT quantification results from Philosopher.

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
time="16:02:47" level=warning msg="workspace not detected"
Error: unknown shorthand flag: 'e' in -elp
Usage:
  philosopher tmtintegrator [flags]

Flags:
  -h, --help           help for tmtintegrator
      --memory int      (default 8)
      --param string   
      --path string
```


## philosopher_workspace

### Tool Description
Manage the experiment workspace for the analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
- **Homepage**: https://github.com/Nesvilab/philosopher
- **Package**: https://anaconda.org/channels/bioconda/packages/philosopher/overview
- **Validation**: PASS

### Original Help Text
```text
Manage the experiment workspace for the analysis

Usage:
  philosopher workspace [flags]

Flags:
      --analytics     reports when a workspace is created for usage estimation (default true)
      --backup        create a backup of the experiment meta data
      --clean         remove the workspace and all meta data. Experimental file are kept intact
  -h, --help          help for workspace
      --init          initialize the workspace
      --nocheck       do not check for new versions
      --temp string   define a custom temporary folder for Philosopher
```


## Metadata
- **Skill**: generated
