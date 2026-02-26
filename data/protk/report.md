# protk CWL Generation Report

## protk_protk_setup.rb

### Tool Description
Post install tasks for protk.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iracooke/protk
- **Stars**: N/A
### Original Help Text
```text
"You must supply a setup task [all,system_packages]"
#<OptionParser:0x0000000015f17bc8 @stack=[#<OptionParser::List:0x0000000015d607d0 @atype={Object=>[/.*/m, #<Proc:0x0000000015d5e1b0@/usr/local/lib/ruby/2.4.0/optparse.rb:1814>], NilClass=>[/.*/m, #<Proc:0x0000000015d5e070@/usr/local/lib/ruby/2.4.0/optparse.rb:1816>], String=>[/.+/m, #<Proc:0x0000000015d5df80@/usr/local/lib/ruby/2.4.0/optparse.rb:1821>], Integer=>[/\A[-+]?(?:0(?:[0-7]+(?:_[0-7]+)*|b[01]+(?:_[01]+)*|x[\da-f]+(?:_[\da-f]+)*)?|\d+(?:_\d+)*)\z/i, #<Proc:0x0000000015d5db20@/usr/local/lib/ruby/2.4.0/optparse.rb:1834>], Float=>[/\A[-+]?(?:\d+(?:_\d+)*(?=(.)?)(?:\.(?:\d+(?:_\d+)*)?)?|\.\d+(?:_\d+)*)(?:E[-+]?\d+(?:_\d+)*)?\z/i, #<Proc:0x0000000015d5d800@/usr/local/lib/ruby/2.4.0/optparse.rb:1847>], Numeric=>[/\A([-+]?(?:0(?:[0-7]+(?:_[0-7]+)*|b[01]+(?:_[01]+)*|x[\da-f]+(?:_[\da-f]+)*)?|(?:\d+(?:_\d+)*(?=(.)?)(?:\.(?:\d+(?:_\d+)*)?)?|\.\d+(?:_\d+)*)(?:E[-+]?\d+(?:_\d+)*)?))(?:\/([-+]?(?:0(?:[0-7]+(?:_[0-7]+)*|b[01]+(?:_[01]+)*|x[\da-f]+(?:_[\da-f]+)*)?|(?:\d+(?:_\d+)*(?=(.)?)(?:\.(?:\d+(?:_\d+)*)?)?|\.\d+(?:_\d+)*)(?:E[-+]?\d+(?:_\d+)*)?)))?\z/i, #<Proc:0x0000000015d5d418@/usr/local/lib/ruby/2.4.0/optparse.rb:1854>], /\A[-+]?\d+(?:_\d+)*\z/i=>[/\A[-+]?\d+(?:_\d+)*\z/i, #<Proc:0x0000000015d5d120@/usr/local/lib/ruby/2.4.0/optparse.rb:1868>], /\A[-+]?(?:[0-7]+(?:_[0-7]+)*|0(?:b[01]+(?:_[01]+)*|x[\da-f]+(?:_[\da-f]+)*))\z/i=>[/\A[-+]?(?:[0-7]+(?:_[0-7]+)*|0(?:b[01]+(?:_[01]+)*|x[\da-f]+(?:_[\da-f]+)*))\z/i, #<Proc:0x0000000015d5cd88@/usr/local/lib/ruby/2.4.0/optparse.rb:1881>], /\A[-+]?(?:\d+(?:_\d+)*(?=(.)?)(?:\.(?:\d+(?:_\d+)*)?)?|\.\d+(?:_\d+)*)(?:E[-+]?\d+(?:_\d+)*)?\z/i=>[/\A[-+]?(?:\d+(?:_\d+)*(?=(.)?)(?:\.(?:\d+(?:_\d+)*)?)?|\.\d+(?:_\d+)*)(?:E[-+]?\d+(?:_\d+)*)?\z/i, #<Proc:0x0000000015d5cce8@/usr/local/lib/ruby/2.4.0/optparse.rb:1894>], TrueClass=>[{"-"=>false, "no"=>false, "false"=>false, "+"=>true, "yes"=>true, "true"=>true, "nil"=>false}, #<Proc:0x0000000015d5c860@/usr/local/lib/ruby/2.4.0/optparse.rb:1915>], FalseClass=>[{"-"=>false, "no"=>false, "false"=>false, "+"=>true, "yes"=>true, "true"=>true, "nil"=>false}, #<Proc:0x0000000015d5c770@/usr/local/lib/ruby/2.4.0/optparse.rb:1919>], Array=>[/.*/m, #<Proc:0x0000000015d5c608@/usr/local/lib/ruby/2.4.0/optparse.rb:1924>], Regexp=>[/\A\/((?:\\.|[^\\])*)\/([[:alpha:]]+)?\z|.*/, #<Proc:0x0000000015d5c4f0@/usr/local/lib/ruby/2.4.0/optparse.rb:1934>]}, @short={"-"=>#<OptionParser::Switch::NoArgument:0x0000000015d60708 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015d606b8@/usr/local/lib/ruby/2.4.0/optparse.rb:931>>}, @long={""=>#<OptionParser::Switch::NoArgument:0x0000000015d60618 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015d605f0@/usr/local/lib/ruby/2.4.0/optparse.rb:932>>}, @list=[]>, #<OptionParser::List:0x0000000015f17b00 @atype={}, @short={}, @long={"help"=>#<OptionParser::Switch::NoArgument:0x0000000015f176f0 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015f174c0@/usr/local/lib/ruby/2.4.0/optparse.rb:962>>, "*-completion-bash"=>#<OptionParser::Switch::RequiredArgument:0x0000000015f173d0 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015f17380@/usr/local/lib/ruby/2.4.0/optparse.rb:973>>, "*-completion-zsh"=>#<OptionParser::Switch::OptionalArgument:0x0000000015f171c8 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015f17100@/usr/local/lib/ruby/2.4.0/optparse.rb:984>>, "version"=>#<OptionParser::Switch::OptionalArgument:0x0000000015f17088 @pattern=nil, @conv=nil, @short=nil, @long=nil, @arg=nil, @desc=nil, @block=#<Proc:0x0000000015f16f98@/usr/local/lib/ruby/2.4.0/optparse.rb:995>>}, @list=[]>, #<OptionParser::List:0x0000000015f179e8 @atype={}, @short={"h"=>#<OptionParser::Switch::NoArgument:0x0000000015f158a0 @pattern=/.*/m, @conv=#<Proc:0x0000000015d5e1b0@/usr/local/lib/ruby/2.4.0/optparse.rb:1814>, @short=["-h"], @long=["--help"], @arg=nil, @desc=["Display this screen"], @block=#<Proc:0x0000000015f16c50@/usr/local/lib/ruby/gems/2.4.0/gems/protk-1.4.4/lib/protk/tool.rb:108>>}, @long={"help"=>#<OptionParser::Switch::NoArgument:0x0000000015f158a0 @pattern=/.*/m, @conv=#<Proc:0x0000000015d5e1b0@/usr/local/lib/ruby/2.4.0/optparse.rb:1814>, @short=["-h"], @long=["--help"], @arg=nil, @desc=["Display this screen"], @block=#<Proc:0x0000000015f16c50@/usr/local/lib/ruby/gems/2.4.0/gems/protk-1.4.4/lib/protk/tool.rb:108>>}, @list=[#<OptionParser::Switch::NoArgument:0x0000000015f158a0 @pattern=/.*/m, @conv=#<Proc:0x0000000015d5e1b0@/usr/local/lib/ruby/2.4.0/optparse.rb:1814>, @short=["-h"], @long=["--help"], @arg=nil, @desc=["Display this screen"], @block=#<Proc:0x0000000015f16c50@/usr/local/lib/ruby/gems/2.4.0/gems/protk-1.4.4/lib/protk/tool.rb:108>>]>], @program_name=nil, @banner="Post install tasks for protk.\nUsage: protk_setup.rb [options] toolname", @summary_width=32, @summary_indent="    ", @default_argv=[]>
```


## protk_manage_db.rb

### Tool Description
Manage named protein databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
- **Homepage**: https://github.com/iracooke/protk
- **Package**: https://anaconda.org/channels/bioconda/packages/protk/overview
- **Validation**: PASS

### Original Help Text
```text
Manage named protein databases.
Usage: manage_db.rb <command> [options] dbname
Commands are: add remove update list help
Type manage_db <command> -h to get help on a specific command
    -h, --help                       Display this screen
```


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

