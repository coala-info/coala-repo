# sirius-csifingerid CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sirius-csifingerid_sirius_decomp | PASS | SIRIUS demo mass 368.1136 ([M+H]+, 5 ppm, CHNOP) gives 50 formulas including the known C20H17NO6 (Bicuculline) with its mass error |
| sirius-csifingerid_sirius_formula | PASS | 5 demo compounds (SIRIUS repo .ms and .mgf files) give the right top formulas: C20H17NO6 Bicuculline, C15H10O6 Kaempferol, C10H13N5O4 Adenosine, C21H27NO4 Laudanosine; output is a project-space folder (a .sirius zip project fails with a Java error in this image) |
| sirius-csifingerid_sirius_ftree_export | PASS | json and dot files for the top fragmentation tree of each of the 5 compounds (10 files) |
| sirius-csifingerid_sirius_lcms_align | Not completed | no small metabolomics LC-MS mzML found; the only small real mzML is proteomics data and gives an empty project-space |
| sirius-csifingerid_sirius_login | Not completed | needs a SIRIUS web service account to log in; only the --show option ran (Not logged in) |
| sirius-csifingerid_sirius_mgf_export | PASS | mgf with 6 spectra (4 MS1 and 2 merged MS2) for the Bicuculline and Kaempferol demo compounds |
| sirius-csifingerid_sirius_passatutto | PASS | decoy spectra file written for each compound of the formula project |
| sirius-csifingerid_sirius_project_space | PASS | --keep-by-name keeps the 2 compounds Kaempferol and Adenosine of the 5 in the project-space folder |
| sirius-csifingerid_sirius_similarity | PASS | cosine and fragmentation tree alignment matrices for 2 demo compounds; diagonal 1.0 for cosine; input project staged writable because SIRIUS writes into it |
| sirius-csifingerid_sirius_write_summaries | PASS | summary tables written from the ZODIAC project: formula_identifications.tsv has the 5 top formulas with SiriusScore and ZodiacScore |
| sirius-csifingerid_sirius_zodiac | PASS | ZODIAC run on the formula project of the 5 demo compounds gives ZodiacScore values (0.99 for the correct Bicuculline and Adenosine formulas); needs at least about 5 compounds, with 2 it fails |

## sirius-csifingerid_sirius_login

### Tool Description
Allows a user to login for SIRIUS Webservices (e.g. CSI:FingerID or CANOPUS) and securely store a personal access token.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Total Downloads**: 49.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/boecker-lab/sirius
- **Stars**: N/A
### Original Help Text
```text
Usage: sirius login [-hV] [--clear] [--limits] [--request-token-only] [--show]
                    [--select-license=<sid>] [[-u=<username> -p] |
                    [--token=<token>] | [--user-env=<username>
                    --password-env=<password>]]
<STANDALONE> Allows a user to login for SIRIUS Webservices (e.g. CSI:FingerID
or CANOPUS) and securely store a personal access token.
      --clear, --logout      Logout. Deletes stored refresh and access token
                               (re-login required to use webservices again).
  -h, --help                 Show this help message and exit.
      --limits, --license-info
                             Show license information and compound limits.
  -p, --pwd, --password      Console password input.
      --password-env=<password>
                             Environment variable with login password.
      --request-token-only   Requests and prints a new SECRET refresh token but
                               does not store the token as login.
                             This can be used to request a token to be used in
                               third party applications that wish to call
                               SIRIUS Web Services using your account.
                             Do never store your username and password in third
                               party apps.
                             Do not store the output of this command in any
                               log. We recommend redirecting the output into a
                               file.
      --select-license, --select-subscription=<sid>
                             Specify active subscription (sid) if multiple
                               licenses are available at your account.
                               Available subscriptions can be listed with
                               '--show'
      --show                 Show profile information about the profile you are
                               logged in with.
      --token=<token>        Refresh token to use as login.
  -u, --user, --email=<username>
                             Login username/email
      --user-env=<username>  Environment variable with login username.
  -V, --version              Print version information and exit.
```

## sirius-csifingerid_sirius_lcms_align

### Tool Description
Align and merge compounds of multiple LCMS Runs. Use this tool if you want to import from mzML/mzXml

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius lcms-align [-hV] [-w=<workflow>] [COMMAND]
<PREPROCESSING> Align and merge compounds of multiple LCMS Runs. Use this tool
if you want to import from mzML/mzXml
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
  -w, --workflow=<workflow>

Commands:
  formula, tree, sirius  <COMPOUND_TOOL> Identify molecular formula for each
                           compound individually using fragmentation trees and
                           isotope patterns.
```

## sirius-csifingerid_sirius_passatutto

### Tool Description
Compute a decoy spectra based on the fragmentation trees of the given input spectra.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius passatutto [-hV] [COMMAND]
<COMPOUND_TOOL> Compute a decoy spectra based on the fragmentation trees of the
given input spectra. If no molecular formula is provided in the input, the top
scoring computed formula is used.
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
Commands:
  fingerprint         <COMPOUND_TOOL> Predict molecular fingerprint from MS/MS
                        and fragmentation trees for each compound Individually
                        using CSI:FingerID fingerprint prediction.
  write-summaries, W  <STANDALONE, POSTPROCESSING> Write Summary files from a
                        given project-space into the given project-space or a
                        custom location.
```

## sirius-csifingerid_sirius_decomp

### Tool Description
Small tool to decompose masses with given deviation, ionization, chemical alphabet and chemical filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius decomp [-hnrV] [-a=<absDeviation>] [-d=<maxDecomps>]
                     [-e=<alphabet>] [-f=<level>] [-i=<ionization>] [-o=<out>]
                     [-p=<ppm>] [--parent=<parentFormula>] [-m=<masses>[,
                     <masses>...]]...
<STANDALONE> Small tool to decompose masses with given deviation, ionization,
chemical alphabet and chemical filter.
  -a, --abs=<absDeviation>   Absolute mass error in Dalton.
  -d, --max-decomps=<maxDecomps>
                             Maximum number of decompositions to be computed.
                               The output might contain less than
                               [--max-decomps] decompositions if there are not
                               more available.
  -e, --elements=<alphabet>  Elements which should be used in decomposition.
                             Example: 'CH[min-max]N[min-]O[-max]P[num]'.
  -f, --filter=<level>       Set the strictness of the chemical filter.
                             Example: levels are STRICT < COMMON < PERMISSIVE <
                               RDBE < NONE.
  -h, --help                 Show this help message and exit.
  -i, --ion=<ionization>     Ionization mode.
                             Example: '[M+H]+'.
  -m, --mass=<masses>[,<masses>...]
                             Masses that will be decomposed.
  -n, --nofilter             If set, the molecular formulas are not filtered by
                               their chemical properties.
  -o, --output=<out>         File to with output to.
  -p, --ppm=<ppm>            Relative mass error in ppm.
      --parent=<parentFormula>
                             If set, the decompositions have to be subformulas
                               of the given parent formula.
  -r, --errors               print mass errors
  -V, --version              Print version information and exit.
```

## sirius-csifingerid_sirius_zodiac

### Tool Description
Identify Molecular formulas of all compounds in a dataset together using ZODIAC.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius zodiac [-hV] [--ignore-spectra-quality] [--burn-in=<burnInSteps>]
                     [--considered-candidates-at-300=<numberOfConsideredCandidat
                     esBelow300>]
                     [--considered-candidates-at-800=<numberOfConsideredCandidat
                     esAbove800>] [--iterations=<iterationSteps>]
                     [--lambda=<lambda>] [--library-hits=<libraryHits>]
                     [--min-cosine=<minCosine>]
                     [--minLocalConnections=<minLocalConnections>]
                     [--thresholdFilter=<thresholdFilter>] [COMMAND]
<DATASET_TOOL> Identify Molecular formulas of all compounds in a dataset
together using ZODIAC.
      --burn-in=<burnInSteps>
                          Number of epochs considered as 'burn-in period'.
                          Default: 2000
      --considered-candidates-at-300=<numberOfConsideredCandidatesBelow300>
                          Maximum number of candidate molecular formulas
                            (fragmentation trees computed by SIRIUS) per
                            compound which are considered by ZODIAC for
                            compounds below 300 m/z.
                          Default: 10
      --considered-candidates-at-800=<numberOfConsideredCandidatesAbove800>
                          Maximum number of candidate molecular formulas
                            (fragmentation trees computed by SIRIUS) per
                            compound which are considered by ZODIAC for
                            compounds above 800 m/z.
                          Default: 50
  -h, --help              Show this help message and exit.
      --ignore-spectra-quality
                          As default ZODIAC runs a 2-step approach. First
                            running 'good quality compounds' only, and
                            afterwards including the remaining.
      --iterations=<iterationSteps>
                          Number of epochs to run the Gibbs sampling. When
                            multiple Markov chains are computed, all chains'
                            iterations sum up to this value.
                          Default: 20000
      --lambda=<lambda>   Lambda used in the scoring function of spectral
                            library hits. The higher this value the higher are
                            library hits weighted in ZODIAC scoring.
                          Default: 1000
      --library-hits=<libraryHits>
                          CSV file containing spectral library hits. Library
                            hits are used as anchors to improve ZODIAC scoring.
      --min-cosine=<minCosine>
                          Spectral library hits must have at least this cosine
                            or higher to be considered in scoring.
                          Value must be in [0,1].
                          Default: 0.5
      --minLocalConnections=<minLocalConnections>
                          Minimum number of compounds to which at least one
                            candidate per compound must be connected to.
                          Default: 10
      --thresholdFilter=<thresholdFilter>
                          Defines the proportion of edges of the complete
                            network which will be ignored.
                          Default: 0.95
  -V, --version           Print version information and exit.
Commands:
  passatutto          <COMPOUND_TOOL> Compute a decoy spectra based on the
                        fragmentation trees of the given input spectra. If no
                        molecular formula is provided in the input, the top
                        scoring computed formula is used.
  fingerprint         <COMPOUND_TOOL> Predict molecular fingerprint from MS/MS
                        and fragmentation trees for each compound Individually
                        using CSI:FingerID fingerprint prediction.
  write-summaries, W  <STANDALONE, POSTPROCESSING> Write Summary files from a
                        given project-space into the given project-space or a
                        custom location.
```

## sirius-csifingerid_sirius_ftree_export

### Tool Description
Exports the fragmentation trees of a project into various formats

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius ftree-export [-hV] [--all] [--dot] [--json] [-o=<output>]
<STANDALONE> Exports the fragmentation trees of a project into various formats
      --json              Export trees as json format (as used by the
                            project-space)
      --dot               Export trees as dot format (for easy rendering with
                            3rd party tools.)
      --all               Export all trees instead of only the top ranked trees.
  -o, --output=<output>   Specify the output destination directory.
  -h, --help              Show this help message and exit.
  -V, --version           Print version information and exit.
```

## sirius-csifingerid_sirius_similarity

### Tool Description
Computes the similarity between all compounds in the dataset and outputs a matrix of similarities.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius similarity [-hV] [--cosine] [--ftalign] [--numpy] [--tanimoto]
                         [--tanimoto-canopus] [-d=<outputDirectory>]
                         [--ftblast=<useFtblast>] [--minpeaks=<useMinPeaks>]
                         [-p=<digits>]
<STANDALONE> Computes the similarity between all compounds in the dataset and
outputs a matrix of similarities.
      --cosine             Compute spectral cosine similarity between all
                             compounds in the dataset
  -d, --directory=<outputDirectory>
                           Directory to store the matrices.
                             Default: .
      --ftalign            Compute fragmentation tree alignments between all
                             compounds in the dataset.
      --ftblast=<useFtblast>
                           Compute fragmentation tree alignments between all
                             compounds in the dataset, incorporating the given
                             fragmentation tree library. The similarity is not
                             the raw alignment score, but the correlation of
                             the scores.
  -h, --help               Show this help message and exit.
      --minpeaks=<useMinPeaks>
                           For cosine: when less than K peaks are matching, set
                             cosine to zero.
                             Default: 0
      --numpy, --matrix    Write as tab separated file with a comment line
                             containing the row/col names (numpy compatible).
                             Otherwise, write as tab separated file with row
                             and column names.
  -p, --digits, --precision=<digits>
                           Specify number of digits used for values in the
                             distance matrix. -1 -> full length Double value.
                             Default: -1
      --tanimoto           compute fingerprint similarity between all compounds
                             in the dataset
      --tanimoto-canopus   compute canopus fingerprint similarity between all
                             compounds in the dataset
  -V, --version            Print version information and exit.
```

## sirius-csifingerid_sirius_mgf_export

### Tool Description
Exports the spectra of a given input as mgf.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius mgf-export [-hV] [--feature-id] [--merge-ms2] [--write-ms1]
                         [--merge-ppm=<mergePpm>] [-o=<output>]
                         [--quant-table=<quantTable>]
<STANDALONE> Exports the spectra of a given input as mgf.
      --write-ms1         Write MS1 spectra into file.
      --merge-ms2         Merge all MS2 of a compound into one single spectrum.
      --feature-id        If available use the feature ids from the input data
                            instead of the SIRIUS internal id. internal id will
                            be used as fallback if the given feature ids are
                            not available or contain duplicates.
      --quant-table=<quantTable>
                          Quantification table file name for Feature Based
                            Molecular Networking.
      --merge-ppm=<mergePpm>
                          Maximum allowed deviation (in ppm) for peaks of MS2
                            spectra to be merged.
  -o, --output=<output>   Specify the mgf file destination.
  -h, --help              Show this help message and exit.
  -V, --version           Print version information and exit.
```

## sirius-csifingerid_sirius_formula

### Tool Description
Identify molecular formula for each compound individually using fragmentation trees and isotope patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius formula [-hV] [--no-isotope-filter] [--no-isotope-score]
                      [--no-recalibration] [-c=<numberOfCandidates>]
                      [--candidates-per-ion=<numberOfCandidatesPerIon>]
                      [--compound-timeout=<instanceTimeout>] [-d=<dbName>[,
                      <dbName>...]] [-e=<detectableElements>]
                      [-E=<enforcedElements>] [-f=<candidateFormulas>]
                      [--heuristic=<mzToUseHeuristic>]
                      [--heuristic-only=<mzToUseHeuristicOnly>]
                      [-i=<ionsConsidered>] [-I=<ionsEnforced>] [-p=<profile>]
                      [--ppm-max=<ppmMax>] [--ppm-max-ms2=<ppmMaxMs2>]
                      [--solver=<solver>] [--tree-timeout=<treeTimeout>] []
                      [COMMAND]
<COMPOUND_TOOL> Identify molecular formula for each compound individually using
fragmentation trees and isotope patterns.
      --no-recalibration    Disable Recalibration of input Spectra
      --no-isotope-filter   Disable molecular formula filter. When filtering is
                              enabled, molecular formulas are excluded if their
                              theoretical isotope pattern does not match the
                              theoretical one, even if their MS/MS pattern has
                              high score.
      --no-isotope-score    Disable isotope pattern score.
      --solver, --ilp-solver=<solver>
                            Set ILP solver to be used for fragmentation
                              computation. Valid values: 'CLP' (included),
                              'CPLEX', 'GUROBI'.
                            For GUROBI and CPLEX environment variables need to
                              be configure (see Manual).
  -h, --help                Show this help message and exit.
  -V, --version             Print version information and exit.
  -d, --db, --database=<dbName>[,<dbName>...]
                            Search formulas in the Union of the given
                              databases. If no database is given all possible
                              molecular formulas will be respected (no database
                              is used).
                            Example: possible DBs: 'ALL,ALL_BUT_INSILICO,BIO,
                              PUBCHEM,MESH,HMDB,KNAPSACK,CHEBI,PUBMED,KEGG,HSDB,
                              MACONDA,METACYC,GNPS,ZINCBIO,UNDP,YMDB,PLANTCYC,
                              NORMAN,ADDITIONAL,PUBCHEMANNOTATIONBIO,
                              PUBCHEMANNOTATIONDRUG,
                              PUBCHEMANNOTATIONSAFETYANDTOXIC,
                              PUBCHEMANNOTATIONFOOD,KEGGMINE,ECOCYCMINE,
                              YMDBMINE'
                            Default: none
      --ppm-max=<ppmMax>    Maximum allowed mass deviation in ppm for
                              decomposing masses.
                            Default: 10.0 ppm
      --ppm-max-ms2=<ppmMaxMs2>
                            Maximum allowed mass deviation in ppm for
                              decomposing masses in MS2. If not specified, the
                              same value as for the MS1 is used.
                            Default: 10.0 ppm
      --tree-timeout=<treeTimeout>
                            Time out in seconds per fragmentation tree
                              computations. 0 for an infinite amount of time.
                            Default: 0
      --compound-timeout=<instanceTimeout>
                            Maximal computation time in seconds for a single
                              compound. 0 for an infinite amount of time.
                            Default: 0
  -p, --profile=<profile>   Name of the configuration profile.
                            Predefined profiles are: `default`, 'qtof',
                              'orbitrap', 'fticr'.
                            Default: default
  -c, --candidates=<numberOfCandidates>
                            Number of formula candidates in the output.
                            Default: 10
      --candidates-per-ion=<numberOfCandidatesPerIon>
                            Minimum number of candidates in the output for each
                              ionization. Set to force output of results for
                              each possible ionization, even if not part of
                              highest ranked results.
                            Default: 1
  -e, --elements-considered=<detectableElements>
                            Set the allowed elements for rare element detection.
                            Example: `SBrClBSe` to allow the elements S,Br,Cl,B
                              and Se.
                            Default: S,Br,Cl,B,Se
  -E, --elements-enforced=<enforcedElements>
                            Enforce elements for molecular formula
                              determination.
                            Example: CHNOPSCl to allow the elements C, H, N, O,
                              P, S and Cl. Add numbers in brackets to restrict
                              the minimal and maximal allowed occurrence of
                              these elements: CHNOP[5]S[8]Cl[1-2]. When one
                              number is given then it is interpreted as upper
                              bound.
                            Default: C,H,N,O,P
  -f, --formulas=<candidateFormulas>
                            Specify a list of candidate formulas the method
                              should use. Omit this option if you want to
                              consider all possible molecular formulas
                            Default: null
  -i, --ions-considered=<ionsConsidered>
                            the iontype/adduct of the MS/MS data. Example: [M+H]
                              +, [M-H]-, [M+Cl]-, [M+Na]+, [M]+. You can also
                              provide a comma separated list of adducts.
                            Default: [M+H]+,[M+K]+,[M+Na]+,[M+H-H2O]+,[M+H-H4O2]
                              +,[M+NH4]+,[M-H]-,[M+Cl]-,[M-H2O-H]-,[M+Br]-
  -I, --ions-enforced=<ionsEnforced>
                            the iontype/adduct of the MS/MS data. Example: [M+H]
                              +, [M-H]-, [M+Cl]-, [M+Na]+, [M]+. You can also
                              provide a comma separated list of adducts.
                            Default: ,
      --heuristic=<mzToUseHeuristic>
                            Enable heuristic preprocessing for compounds >= the
                              specified m/z.
                            Default: 300
      --heuristic-only=<mzToUseHeuristicOnly>
                            Use only heuristic tree computation compounds >=
                              the specified m/z.
                            Default: 650
Commands:
  passatutto               <COMPOUND_TOOL> Compute a decoy spectra based on the
                             fragmentation trees of the given input spectra. If
                             no molecular formula is provided in the input, the
                             top scoring computed formula is used.
  zodiac, rerank-formulas  <DATASET_TOOL> Identify Molecular formulas of all
                             compounds in a dataset together using ZODIAC.
  fingerprint              <COMPOUND_TOOL> Predict molecular fingerprint from
                             MS/MS and fragmentation trees for each compound
                             Individually using CSI:FingerID fingerprint
                             prediction.
  write-summaries, W       <STANDALONE, POSTPROCESSING> Write Summary files
                             from a given project-space into the given
                             project-space or a custom location.
```

## sirius-csifingerid_sirius_project_space

### Tool Description
Modify a given project Space: Read project(s) with --input, apply modification and write the result via --output.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius project-space [-hmV] [--dm=<makeDeleteMassFilter>]
                            [--dn=<makeDeleteIdxFilter>]
                            [--kc=<makeKeepConfidenceFilter>]
                            [--kei=<makeKeepExplainedIntensityFilter>]
                            [--km=<makeKeepMassFilter>]
                            [--kn=<makeKeepNameFilter>]
                            [--kts=<makeKeepTreeSizeFilter>]
                            [--merge-compounds-cosine=<mergeCompoundsCosine>]
                            [--merge-compounds-rtdiff=<mergeCompoundsRtDiff>]
                            [--merge-compounds-top=<mergeCompoundsTopK>]
                            [-d=<makeDeleteIdxFilter>[,
                            <makeDeleteIdxFilter>...]]...
                            [-k=<makeKeepIdxFilter>[,
                            <makeKeepIdxFilter>...]]... [[-s=<type>]
                            [-c=<count>] [-o=<order>]]
<STANDALONE> Modify a given project Space: Read project(s) with --input, apply
modification and write the result via --output. If either --input or --output
is given, the modifications will be made in-place.
  -d, --di, --delete-by-idx=<makeDeleteIdxFilter>[,<makeDeleteIdxFilter>...]
                        Delete all compounds that match the given indices from
                          the given project-space.
      --dm, --delete-by-mass=<makeDeleteMassFilter>
                        Delete all compounds that are within the given mass
                          window.
                        Example: Use 'mass1:mass2' to match compounds with
                          mass1 <= mass <= mass2. Leave a value empty to set no
                          bound.
      --dn, --delete-by-name=<makeDeleteIdxFilter>
                        Delete all compounds where the 'identifier' (dir name,
                          ID) matches the given regex (JAVA).
  -h, --help            Show this help message and exit.
  -k, --ki, --keep-by-idx=<makeKeepIdxFilter>[,<makeKeepIdxFilter>...]
                        Keep all compounds that match the given indices from
                          the given project-space
      --kc, --keep-by-confidence=<makeKeepConfidenceFilter>
                        Keep all compounds that have a valid confidence score
                          greater or equal than the given minimum confidence.
      --kei, --keep-by-explained-intensity=<makeKeepExplainedIntensityFilter>
                        Keep all compounds that have at least one fragmentation
                          tree that explains at least a minimum total intensity
                          of the spectrum. Value between 0 to 1.
      --km, --keep-by-mass=<makeKeepMassFilter>
                        Keep all compounds that are within the given mass
                          window.
                        Example: Use 'mass1:mass2' to match compounds with
                          mass1 <= mass <= mass2. Leave a value empty to set no
                          bound.
      --kn, --keep-by-name=<makeKeepNameFilter>
                        Keep all compounds where the 'identifier' (Dir name,
                          ID) matches the given regex (JAVA).
      --kts, --keep-by-tree-size=<makeKeepTreeSizeFilter>
                        Keep all compounds that have at least one fragmentation
                          tree with number of fragments (including precursor)
                          greater or equal than the given minimum.
  -m, --move            DANGERZONE: Move instead of copy data (where possible)
                          when merging or splitting projects to save time. Be
                          aware of the risk that you may end up with corrupted
                          input or output data when the program crashes.
      --merge-compounds-cosine=<mergeCompoundsCosine>
                        Merge compounds which have the same spectra and m/z
                          into one. The criteria for merging can be specified
                          with --merge-compounds-cosine and
                          --merge-compounds-rtdiff.
      --merge-compounds-rtdiff=<mergeCompoundsRtDiff>
                        Merge compounds which have the same spectra and m/z
                          into one. The criteria for merging can be specified
                          with --merge-compounds-cosine and
                          --merge-compounds-rtdiff. Retention time difference
                          for merging is either specified in seconds, or by
                          adding a unit after the number (e.g., '5 min'
      --merge-compounds-top=<mergeCompoundsTopK>
                        Merge compounds which have the same spectra and m/z
                          into one. For each such cluster of compounds, keep
                          only the top k most abundant ones. The criteria for
                          merging can be specified with
                          --merge-compounds-cosine and --merge-compounds-rtdiff.
  -V, --version         Print version information and exit.
Split the project into chunks:
  -c, --count=<count>   Sets batch number or batch size depending on <--split>
                          Default: 1
  -o, --split-order=<order>
                        Specify the order of Compounds before putting them into
                          batches.
                          Default: SHUFFLE
  -s, --split=<type>    Split the output into batches. Either in a specific
                          number of batches or in batches of specific size!
                          Default: NO
```

## sirius-csifingerid_sirius_write_summaries

### Tool Description
Write Summary files from a given project-space into the given project-space or a custom location.

### Metadata
- **Docker Image**: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
- **Homepage**: https://bio.informatik.uni-jena.de/software/sirius/
- **Package**: https://anaconda.org/channels/bioconda/packages/sirius-csifingerid/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sirius write-summaries [-chV] [--[no-]full-summary] [--[no-]
                              top-hit-summary] [--[no-]top-hit-adduct-summary]
                              [-o=<location>] [[--classyfire] [--npc]
                              [--fingerprint] [--pubchem] [--maccs] [--all]
                              [-p=<digits>]]
<STANDALONE, POSTPROCESSING> Write Summary files from a given project-space
into the given project-space or a custom location.
  -c, --zip, --compress     Summaries will be written into a compressed zip
                              archive. This parameter will be ignored if the
                              summary is written into the project-space.
      --[no-]full-summary   Write project wide summary files with ALL Hits.
                            (Use with care! Might create large files and
                              consume large amounts of memory for large
                              projects.)
  -h, --help                Show this help message and exit.
      --[no-]top-hit-summary
                            Write project wide summary files with all Top Hits.
  -o, --output=<location>   Specify location (outside the project) for writing
                              summary files. Per default summaries are written
                              to the project-space
      --[no-]top-hit-adduct-summary
                            Write project wide summary files with all Top Hits
                              and their adducts
  -V, --version             Print version information and exit.
Include Predictions Table      --all                 Output all predicted CSI:FingerID and CANOPUS
                              probabilities (sets --fingerprints, --classyfire,
                              --npc).
      --classyfire          Output predicted  classyfire probabilities by
                              CANOPUS.
      --fingerprint, --fingerprints
                            Output predicted fingerprint probabilities by CSI:
                              FingerID.
      --maccs               Output predicted MACCS fingerprint probabilities by
                              CSI:FingerID (subset of --fingerprint).
      --npc                 Output predicted NPC (natural product classifier)
                              probabilities by CANOPUS.
  -p, --digits, --precision=<digits>
                            Specify number of digits used for printing floating
                              point values. -1 -> full length Double value.
                              Default: -1
      --pubchem             Output predicted PubChem fingerprint probabilities
                              by CSI:FingerID (subset of --fingerprint).
```

