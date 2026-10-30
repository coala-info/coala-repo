# protk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| protk_add_retention_times.rb | PASS | synthetic data: small pepXML skeleton for the protk repo tiny.mgf spectra (scan=4 to 6); retention times 2760, 2760 and 5269.998 s added, matching RTINSECONDS in the mgf |
| protk_augustus_to_proteindb.rb | PASS | Ran on the protk repo Augustus sample GFF; 12 protein records written with CDS coordinates in the headers |
| protk_filter_psms.rb | PASS | Ran on protk repo X!Tandem pepXML (97 spectrum queries); kept the 19 whose top hit is a DROME protein |
| protk_interprophet.rb | PASS |  |
| protk_make_decoy.rb | PASS |  |
| protk_maker_to_proteindb.rb | Failed | image problem: samtools is not in the image, so no protein sequences are fetched and only the FASTA headers are written |
| protk_mascot_search.rb | Not completed | Needs a Mascot server with network access and an account; not available. |
| protk_mascot_to_pepxml.rb | PASS | Ran on the protk repo Mascot results file; pepXML with 240 spectrum queries written (the FASTA given with --database does not hold the hit proteins) |
| protk_msgfplus_search.rb | Failed | image problem: the image has no MSGFPlus.jar, so msgfplus_search.rb stops with 'Could not find MSGFPlus.jar'. |
| protk_mzid_to_pepxml.rb | Failed | tool bug: protk 1.4.4 calls SpectrumQuery.from_mzid with one argument but it needs two, so it stops with ArgumentError |
| protk_mzid_to_protxml.rb | PASS | Ran on the protk repo PeptideShaker mzIdentML file; protXML with one protein group and 17 peptides written |
| protk_omssa_search.rb | Failed | image problem: the image has no omssacl and no makeblastdb, so the search cannot run |
| protk_peptide_prophet.rb | PASS |  |
| protk_pepxml_to_table.rb | PASS |  |
| protk_protein_prophet.rb | PASS | Ran on tandem pepXML data from the protk repo; protein groups match the repo reference (database path in the input pepXML was made relative and the FASTA staged beside it). |
| protk_protxml_to_gff.rb | Failed | image problem: the image has no makeblastdb, so protxml_to_gff.rb stops with ENOENT when it indexes the FASTA database. |
| protk_protxml_to_psql.rb | Failed | image problem: libsqlite3 is missing, so the sqlite3 Ruby gem cannot load and the command stops at start |
| protk_protxml_to_table.rb | PASS |  |
| protk_repair_run_summary.rb | PASS | Ran on protk repo X!Tandem pepXML; msms_run_summary base_name and raw_data changed to the values given |
| protk_sixframe.rb | PASS |  |
| protk_spectrast_create.rb | PASS | Ran on protk repo iProphet pepXML with two mzML files; library of 251 spectra written (.splib, .spidx, .pepidx) |
| protk_spectrast_filter.rb | PASS | Filtered the library made by spectrast_create with Charge==2; 95 of 251 spectra kept, all charge 2 |
| protk_swissprot_to_table.rb | PASS | Ran on protk repo UniProt flat file and its query list; table with one row per query (190 rows) written |
| protk_tandem_search.rb | Failed | image problem: the image has no X!Tandem binary, so tandem_search.rb stops with 'Unable to locate tandem'. |
| protk_tandem_to_pepxml.rb | PASS | Ran on a protk repo X!Tandem result file; pepXML with 97 spectrum queries written |
| protk_unimod_to_loc.rb | PASS | Ran on the protk repo unimod.xml; mascot_mods.loc with 74 modification names written |
| protk_uniprot_mapper.rb | Failed | tool bug: protk uses the retired www.uniprot.org/mapping service, which now answers 301 Moved Permanently |

## protk_tandem_search.rb

### Tool Description
Run an X!Tandem msms search on a set of mzML input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Run an X!Tandem msms search on a set of mzML input files.

Usage: tandem_search.rb [options] file1.mzML file2.mzML ...
    -h, --help                               Display this screen
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -n, --threads num                        Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
        --enzyme enz                         Enzyme [Trypsin]
        --var-mods vm                        Variable modifications. These should be provided in a comma separated list
        --fix-mods fm                        Fixed modifications. These should be provided in a comma separated list
        --fragment-ion-tol-units tolu        Fragment ion mass tolerance units (Da or mmu). [Da]
        --precursor-ion-tol-units tolu       Precursor ion mass tolerance units (ppm or Da). [ppm]
    -f, --fragment-ion-tol tol               Fragment ion mass tolerance (unit dependent). [0.65]
    -p, --precursor-ion-tol tol              Precursor ion mass tolerance. [200]
    -v, --num-missed-cleavages num           Number of missed cleavages allowed [2]
        --cleavage-semi                      Search for peptides with up to 1 non-enzymatic cleavage site [false]
        --multi-isotope-search               Expand parent mass window to include windows around neighbouring isotopic peaks [false]
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
    -y, --acetyl-nterm                       Expect N-terminal acetylation as a variable mod in a search or as a parameter when building statistical models [false]
    -m, --methionineo                        Expect Oxidised Methionine modifications as variable mod in a search [false]
    -T, --tandem-params tandem               Either the full path to an xml file containing a complete set of default parameters, or one of the following (isb_native,isb_kscore,gpm). Default is isb_native [isb_native]
    -K, --keep-params-files                  Keep X!Tandem parameter files [false]
        --output-spectra                     Include spectra in the output file [false]
```


## protk_msgfplus_search.rb

### Tool Description
Run an MSGFPlus msms search on a set of msms spectrum input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Run an MSGFPlus msms search on a set of msms spectrum input files.

Usage: msgfplus_search.rb [options] file1.mzML file2.mzML ...
    -h, --help                               Display this screen
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -n, --threads num                        Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
        --enzyme enz                         Enzyme [Trypsin]
        --var-mods vm                        Variable modifications. These should be provided in a comma separated list
        --fix-mods fm                        Fixed modifications. These should be provided in a comma separated list
        --instrument instrument              Instrument [ESI-QUAD-TOF]
        --cleavage-semi                      Search for peptides with up to 1 non-enzymatic cleavage site [false]
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
    -y, --acetyl-nterm                       Expect N-terminal acetylation as a variable mod in a search or as a parameter when building statistical models [false]
    -m, --methionineo                        Expect Oxidised Methionine modifications as variable mod in a search [false]
    -c, --carbamidomethyl                    Expect Carbamidomethyl C modifications as fixed mod in a search [false]
    -p, --precursor-ion-tol tol              Precursor ion mass tolerance. [20]
        --precursor-ion-tol-units tolu       Precursor ion mass tolerance units (ppm or Da). [ppm]
        --pepxml                             Convert results to pepxml. [false]
        --isotope-error-range range          Takes into account of the error introduced by chooosing a non-monoisotopic peak for fragmentation. [0,1]
        --fragment-method method             Fragment method 0: As written in the spectrum or CID if no info (Default), 1: CID, 2: ETD, 3: HCD, 4: Merge spectra from the same precursor [0]
        --decoy-search                       Build and search a decoy database on the fly. Input db should not contain decoys if this option is used [false]
        --protocol p                         0: NoProtocol (Default), 1: Phosphorylation, 2: iTRAQ, 3: iTRAQPhospho [0]
        --min-pep-length p                   Minimum peptide length to consider [6]
        --max-pep-length p                   Maximum peptide length to consider [40]
        --min-pep-charge c                   Minimum precursor charge to consider if charges are not specified in the spectrum file [2]
        --max-pep-charge c                   Maximum precursor charge to consider if charges are not specified in the spectrum file [3]
        --num-reported-matches n             Number of matches per spectrum to be reported, Default: 1 [1]
        --add-features                       output additional features [false]
        --java-mem mem                       Java memory limit when running the search (Default 3.5Gb) [3500M]
```


## protk_mascot_search.rb

### Tool Description
Run a Mascot msms search on a set of mgf input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file

Run a Mascot msms search on a set of mgf input files.

Usage: mascot_search.rb [options] msmsfile.mgf
    -h, --help                               Display this screen
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
        --enzyme enz                         Enzyme [Trypsin]
        --var-mods vm                        Variable modifications. These should be provided in a comma separated list
        --fix-mods fm                        Fixed modifications. These should be provided in a comma separated list
        --instrument instrument              Instrument [ESI-QUAD-TOF]
        --fragment-ion-tol-units tolu        Fragment ion mass tolerance units (Da or mmu). [Da]
        --precursor-ion-tol-units tolu       Precursor ion mass tolerance units (ppm or Da). [ppm]
    -f, --fragment-ion-tol tol               Fragment ion mass tolerance (unit dependent). [0.65]
    -p, --precursor-ion-tol tol              Precursor ion mass tolerance. [200]
    -a, --search-type type                   Use monoisotopic or average precursor masses. (monoisotopic or average) [monoisotopic]
    -v, --num-missed-cleavages num           Number of missed cleavages allowed [2]
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
    -y, --acetyl-nterm                       Expect N-terminal acetylation as a variable mod in a search or as a parameter when building statistical models [false]
    -m, --methionineo                        Expect Oxidised Methionine modifications as variable mod in a search [false]
    -c, --carbamidomethyl                    Expect Carbamidomethyl C modifications as fixed mod in a search [false]
    -S, --server url                         The url to the cgi directory of the mascot server [www.matrixscience.com/mascot/cgi]
        --allowed-charges ac                 Allowed precursor ion charges. [1+,2+,3+]
        --quantitation method                Mascot quant method
        --email em                           User email.
        --username un                        Username.
        --proxy url                          The url to a proxy server
        --password psswd                     Password to use when Mascot security is enabled
        --use-security                       When Mascot security is enabled this is required [false]
        --download-only path                 Specify a relative path to an existing results file on the server for download eg(20131113/F227185.dat)
        --timeout seconds                    Timeout for sending data file to mascot in seconds [200]
```


## protk_peptide_prophet.rb

### Tool Description
Run PeptideProphet on a set of pep.xml input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Run PeptideProphet on a set of pep.xml input files.

Usage: peptide_prophet.rb [options] file1.pep.xml file2.pep.xml ...
    -h, --help                               Display this screen
    -b, --output-prefix pref                 A string to prepend to the name of output files
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -n, --threads num                        Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
    -l, --maldi                              Run a search on MALDI data [false]
        --p-thresh val                       Probability threshold below which PSMs are discarded [0.05]
        --useicat                            Use icat information [false]
        --phospho                            Use phospho information [false]
        --usepi                              Use pI information [false]
        --usert                              Use hydrophobicity / RT information [false]
        --accurate-mass                      Use accurate mass binning [false]
        --no-ntt                             Don't use NTT model [false]
        --no-nmc                             Don't use NMC model [false]
        --usegamma                           Use Gamma distribution to model the negatives [false]
        --use-only-expect                    Only use Expect Score as the discriminant [false]
        --force-fit                          Force fitting of mixture model and bypass checks [false]
        --allow-alt-instruments              Warning instead of exit with error if instrument types between runs is different [false]
    -F, --one-ata-time                       Create a separate pproph output file for each analysis [false]
        --decoy-prefix prefix                Prefix for decoy sequences [decoy]
        --use-non-parametric-model           Use Non-parametric model, can only be used with decoy option [false]
        --no-decoy                           Don't use decoy sequences to pin down the negative distribution [false]
        --experiment-label label             used to commonly label all spectra belonging to one experiment (required by iProphet)
```


## protk_interprophet.rb

### Tool Description
Run InterProphet on a set of pep.xml input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Run InterProphet on a set of pep.xml input files.

Usage: interprophet.rb [options] file1.pep.xml file2.pep.xml ...
    -h, --help                               Display this screen
    -b, --output-prefix pref                 A string to prepend to the name of output files
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -n, --threads num                        Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
        --p-thresh val                       Probability threshold below which PSMs are discarded [0.05]
        --no-nss                             Don't use NSS (Number of Sibling Searches) in Model [false]
        --no-nrs                             Don't use NRS (Number of Replicate Spectra) in Model [false]
        --no-nse                             Don't use NSE (Number of Sibling Experiments) in Model [false]
        --no-nsi                             Don't use NSE (Number of Sibling Ions) in Model [false]
        --no-nsm                             Don't use NSE (Number of Sibling Modifications) in Model [false]
```


## protk_protein_prophet.rb

### Tool Description
Run ProteinProphet on a set of pep.xml input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Run ProteinProphet on a set of pep.xml input files.

Usage: protein_prophet.rb [options] file1.pep.xml file2.pep.xml ...
    -h, --help                               Display this screen
    -b, --output-prefix pref                 A string to prepend to the name of output files
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
        --iprophet-input                     Inputs are from iProphet [false]
        --no-occam                           Do not attempt to derive the simplest protein list explaining observed peptides [false]
        --group-wts                          Check peptide's total weight (rather than actual weight) in the Protein Group against the threshold [false]
        --norm-protlen                       Normalize NSP using Protein Length [false]
        --log-prob                           Use the log of probability in the confidence calculations [false]
        --confem                             Use the EM to compute probability given the confidence [false]
        --allpeps                            Consider all possible peptides in the database in the confidence model [false]
        --unmapped                           Report results for unmapped proteins [false]
        --instances                          Use Expected Number of Ion Instances to adjust the peptide probabilities prior to NSP adjustment [false]
        --delude                             Do NOT use peptide degeneracy information when assessing proteins [false]
        --minprob mp                         Minimum peptide prophet probability for peptides to be considered [0.05]
        --minindep mp                        Minimum percentage of independent peptides required for a protein [0]
```


## protk_pepxml_to_table.rb

### Tool Description
Convert a pepXML file to a tab delimited table.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Convert a pepXML file to a tab delimited table.

Usage: pepxml_to_table.rb [options] file1.pep.xml
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --invert-probabilities       Output 1-p instead of p for all probability values [false]
```


## protk_protxml_to_table.rb

### Tool Description
Convert a protXML file to a tab delimited table.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Convert a protXML file to a tab delimited table.

Usage: protxml_to_table.rb [options] file1.protXML
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --groups                     Print output by groups rather than for each protein [false]
        --invert-probabilities       Output 1-p instead of p for all probability values [false]
```


## protk_protxml_to_gff.rb

### Tool Description
Map proteins and peptides to genomic coordinates.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing options: database, coords_file
Map proteins and peptides to genomic coordinates.

Usage: protxml_to_gff.rb [options] proteins.<protXML>
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --debug                      Run in debug mode [false]
    -d, --database filename          Database used for ms/ms searches (Fasta Format)
    -c, --coords-file filename.gff3  A file containing genomic coordinates for predicted proteins and/or 6-frame translations
        --stack-charge-states        Different peptide charge states get separate gff entries [false]
        --threshold prob             Peptide Probability Threshold (Default 0.95) [0.95]
        --prot-threshold prob        Protein Probability Threshold (Default 0.99) [0.99]
        --gff-idregex pre            Regex with capture group for parsing gff ids from protein ids
        --genome-idregex pre         Regex with capture group for parsing genomic ids from protein ids
        --ignore-regex pre           Regex to match protein ids that we should ignore completely
        --include-mods               Output gff entries for peptide modification sites [false]
```


## protk_make_decoy.rb

### Tool Description
Create a decoy database from real protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Missing options: explicit_output
Create a decoy database from real protein sequences.

Usage: make_decoy.rb [options] realdb.fasta
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
    -L, --db-length len              Number of sequences to generate [0]
    -P, --prefix-string str          String to prepend to sequence ids [decoy_]
        --reverse-only               Just reverse sequences. Dont try to randomize. Ignores -L [false]
        --id-regex regex             Regex for finding IDs. If reverse-only is used then this will be used to find ids and prepend with the decoy string. Default .*?\|(.*?)[ \|] [.*?\|(.*?)[ \|]]
    -A, --append                     Append input sequences to the generated database [false]
```


## protk_sixframe.rb

### Tool Description
Create a sixframe translation of a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
You must supply an input file
Create a sixframe translation of a genome.

Usage: sixframe.rb [options] genome.fasta
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --peptideshaker              Format fasta output for peptideshaker compatibility [false]
        --coords                     Write genomic coordinates in the fasta header [false]
        --strip-header               Dont write sequence definition [true]
        --min-len l                  Minimum ORF length to keep [20]
        --gff3                       Output gff3 instead of fasta [false]
```


## protk_add_retention_times.rb

### Tool Description
Look up retention times in a raw file and add them to a pepxml file.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Look up retention times in a raw file and add them to a pepxml file.

Usage: add_retention_times.rb [options] file1.pep.xml file2.mgf
    -h, --help                       Display this screen
    -r, --replace-output             Dont skip analyses for which the output file already exists [false]
    -o, --output out                 An explicitly named output file.
```

## protk_augustus_to_proteindb.rb

### Tool Description
Create a protein database from Augustus gene prediction output that is suitable for later processing by proteogenomics tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Create a protein database from Augustus gene prediction output that is suitable for later processing by proteogenomics tools.

Usage: augustus_to_proteindb.rb [options] augustus.gff3
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file. \
  The default is to write to standard output
        --info                       Include CDS Coordinates [false]
```

## protk_filter_psms.rb

### Tool Description
Filter psms in a pepxml file.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Filter psms in a pepxml file.

Usage: filter_psms.rb [options] expression file.pepxml
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --debug                      Run in debug mode [false]
    -A, --attribute name             Match expression against a specific search_hit attribute [protein]
    -C, --check-alternatives         Also match expression against to alternative_proteins [false]
    -R, --reject                     Keep mismatches instead of matches [false]
```

## protk_maker_to_proteindb.rb

### Tool Description
Create a protein database from Maker gene prediction output that is suitable for later processing by proteogenomics tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Create a protein database from Maker gene prediction output that is suitable for later processing by proteogenomics tools.

Usage: maker_to_proteindb.rb [options] maker.gff3
    -h, --help                               Display this screen
    -o, --output out                         An explicitly named output file.
        --debug                              Run in debug mode [false]
        --info                               Include CDS Coordinates [false]
    -p, --prot-fasta proteins                A fasta file \
	containing protein sequences for each transcript
```

## protk_mascot_to_pepxml.rb

### Tool Description
Convert mascot dat files to pep.xml files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert mascot dat files to pep.xml files.

Usage: mascot_to_pepxml.rb [options] file1.dat file2.dat ... 
    -h, --help                               Display this screen
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
        --enzyme enz                         Enzyme [Trypsin]
        --shortid                            Use short protein id as per Mascot result (default uses full protein ids in fasta file) [false]
```

## protk_mzid_to_pepxml.rb

### Tool Description
Convert an mzIdentML file to pep.xml

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert an mzIdentML file to pep.xml

Usage: mzid_to_pepxml.rb [options] file1.mzid
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --debug                      Run in debug mode [false]
```

## protk_mzid_to_protxml.rb

### Tool Description
Convert an mzIdentML file to protXML.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert an mzIdentML file to protXML.

Usage: mzid_to_protxml.rb [options] file1.mzid
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --debug                      Run in debug mode [false]
        --minprob mp                 Minimum probability for protein to be included in the output [0.05]
```

## protk_omssa_search.rb

### Tool Description
Run an OMSSA msms search on a set of mgf input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Run an OMSSA msms search on a set of mgf input files.

Usage: omssa_search.rb [options] file1.mgf file2.mgf ...
    -h, --help                               Display this screen
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
    -n, --threads num                        Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
    -d, --database dbname                    Specify the database to use for this search. Can be a named protk database or the path to a fasta file [sphuman]
        --enzyme enz                         Enzyme [Trypsin]
        --var-mods vm                        Variable modifications. These should be provided in a comma separated list
        --fix-mods fm                        Fixed modifications. These should be provided in a comma separated list
        --instrument instrument              Instrument [ESI-QUAD-TOF]
        --fragment-ion-tol-units tolu        Fragment ion mass tolerance units (Da or mmu). [Da]
        --precursor-ion-tol-units tolu       Precursor ion mass tolerance units (ppm or Da). [ppm]
    -f, --fragment-ion-tol tol               Fragment ion mass tolerance (unit dependent). [0.65]
    -p, --precursor-ion-tol tol              Precursor ion mass tolerance. [200]
    -a, --search-type type                   Use monoisotopic or average precursor masses. (monoisotopic or average) [monoisotopic]
    -v, --num-missed-cleavages num           Number of missed cleavages allowed [2]
    -q, --respect-charges                    Dont respect charges in the input file. Instead impute them by trying various options [false]
        --searched-ions si                   Ion series to search
        --num-peaks-for-multi-isotope-search np
                                             Number of peaks to include in multi-isotope search [0]
    -g, --glyco                              Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building statistical models [false]
    -m, --methionineo                        Expect Oxidised Methionine modifications as variable mod in a search [false]
    -c, --carbamidomethyl                    Expect Carbamidomethyl C modifications as fixed mod in a search [false]
    -R, --no-add-retention-times             Don't post process the output to add retention times [true]
        --max-hit-expect exp                 Expect values less than this are considered to be hits [1]
        --intensity-cut-off co               Peak intensity cut-off as a fraction of maximum peak intensity [0.0005]
        --galaxy-index-dir dir               Specify galaxy index directory, will search for mods file there.
        --omx-output path                    Specify path for additional OMX output (optional).
        --logfile path                       Send OMSSA stdout to a logfile
```

## protk_protxml_to_psql.rb

### Tool Description
Convert a protXML file to a sqlite database.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert a protXML file to a sqlite database.

Usage: protxml_to_psql.rb [options] file1.protXML
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
    -r, --replace-output             Dont skip analyses for which the output file already exists [false]
    -d, --database path              A Fasta file where full protein sequences can be looked up

(Help text taken from the protk 1.4.4 source, bin/protxml_to_psql.rb. Running the command with --help fails
in this image because libsqlite3 is missing. Further arguments after the protXML file are mzML spectrum files.)
```

## protk_repair_run_summary.rb

### Tool Description
Repair msms_run_summary tag in a pepXML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Repair msms_run_summary tag in a pepXML file.

Usage: repair_run_summary.rb [options] file1.pepXML
    -h, --help                       Display this screen
    -N, --base-name mzmlfile         Original MSMS spectrum file used for search
    -R, --raw-type type              Raw data type used for search
        --omssa-itol fitol           Add a fragment ion tolerance parameter to the omssa search summary
```

## protk_spectrast_create.rb

### Tool Description
Create a spectral library from pep.xml input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Create a spectral library from pep.xml input files.

Usage: spectrast_create.rb [options] file1.pep.xml file1.pep.xml ...
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --spectrum-files sf          Paths to raw spectrum files. These should be provided in a comma separated list
    -B, --binary-output              Produce spectral libraries in binary format rather than ASCII [false]
        --predicate pred             Keep only spectra satifying predicate pred. Should be a C-style predicate
        --p-thresh val               Probability threshold below which spectra are discarded [0.99]
        --instrument-acquisition setting
                                     Set the instrument and acquisition settings of the spectra (in case not specified in data files).
	                             Examples: CID, ETD, CID-QTOF, HCD. The latter two are treated as high-mass accuracy spectra. [CID]
```

## protk_spectrast_filter.rb

### Tool Description
Manipulate splib files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Manipulate splib files.

Usage: spectrast_filter.rb [options] file1.splib file1.splib ...
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
    -B, --binary-output              Produce spectral libraries in binary format rather than ASCII [false]
        --predicate pred             Keep only spectra satifying predicate pred. Should be a C-style predicate
        --merge method               How to combine multiple splib files (if provided). Options are U,S,H
				     U: Union. Include all the peptide ions in all the files.
				     S: Subtraction. Only include peptide ions in the first file 
				     	that are not present in any of the other files.
				     H: Subtraction of homologs. Only include peptide ions in the
				     	first file that do not have any homologs with 
				     	same charge and similar m/z in any of the other files.
				     A: Appending. Each peptide ion is added from only one library: 
				     	the first file in the argument list that contains that peptide ion.
				     	Useful for keeping existing consensus spectra unchanged while adding
				     	only previously unseen peptide ions. [U]
        --replicates method          How to derive a single spectrum from replicates. Options are None, C,B
				     C: Consensus. Create the consensus spectrum of all replicate spectra of each peptide ion.
				     B: Best replicate. Pick the best replicate of each peptide ion. [None]
```

## protk_swissprot_to_table.rb

### Tool Description
Query a swissprot flat file and output to tab delimited table.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Query a swissprot flat file and output to tab delimited table.

Usage: swissprot_to_table.rb [options] -d flatfile.dat queries.txt
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --debug                      Run in debug mode [false]
    -d, --database file              Uniprot flatfile database containing full records for proteins
    -K, --keys keys                  Filter output to only the specified keys (comma separated)
        --show-keys                  Print a list of possible values for the keys field and exit [false]
    -S, --separator sep              Separator character for output, default (tab) [	]
    -A, --array-separator sep        Array Separator character, default , [,]
        --query-separator sep        Separator character for queries.txt, default is tab [	]
        --id-column num              Column in queries.txt in which Uniprot Accessions are found [1]
```

## protk_tandem_to_pepxml.rb

### Tool Description
Convert tandem files to pep.xml files.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Convert tandem files to pep.xml files.

Usage: tandem_to_pepxml.rb [options] file1.dat file2.dat ... 
    -h, --help                               Display this screen
    -b, --output-prefix pref                 A string to prepend to the name of output files
    -r, --replace-output                     Dont skip analyses for which the output file already exists [false]
    -o, --output out                         An explicitly named output file.
```

## protk_unimod_to_loc.rb

### Tool Description
Reads a unimod xml file (eg from a Mascot installation) and produces a loc file with names of allowable chemical modifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Reads a unimod xml file (eg from a Mascot installation) and produces a loc file with names of allowable chemical modifications.

Usage: unimod_to_loc.rb unimod.xml
    (no options; the result is written to mascot_mods.loc in the current directory)

(Help text taken from the protk 1.4.4 source, bin/unimod_to_loc.rb. The command has no --help option.)
```

## protk_uniprot_mapper.rb

### Tool Description
Given a set of IDs convert them to a different type of ID

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Given a set of IDs convert them to a different type of ID

Usage: uniprot_mapper.rb input_file.txt fromID_type
    -h, --help                       Display this screen
    -o, --output out                 An explicitly named output file.
        --id-column num              Specify a column for ids (default is column 1)
        --to-id id                   Specify an ID to output. Can be used multiple times.
```

## Metadata
- **Skill**: generated
