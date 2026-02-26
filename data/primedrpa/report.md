# primedrpa CWL Generation Report

## primedrpa_PrimedRPA

### Tool Description
Finding RPA Primer and Probe Sets

### Metadata
- **Docker Image**: quay.io/biocontainers/primedrpa:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA/
- **Package**: https://anaconda.org/channels/bioconda/packages/primedrpa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/primedrpa/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Stars**: N/A
### Original Help Text
```text
-------------------------------------------
----------------PrimedRPA------------------
-----Finding RPA Primer and Probe Sets-----
-------------Higgins M et al.--------------
-------------------------------------------


usage: PrimedRPA [-h] --RunID RUNID [--PriorAlign PRIORALIGN]
                 [--PriorBindingSite PRIORBINDINGSITE] [--InputFile INPUTFILE]
                 [--InputFileType INPUTFILETYPE]
                 [--IdentityThreshold IDENTITYTHRESHOLD]
                 [--ConservedAnchor CONSERVEDANCHOR]
                 [--PrimerLength PRIMERLENGTH] [--ProbeRequired PROBEREQUIRED]
                 [--ProbeLength PROBELENGTH]
                 [--AmpliconSizeLimit AMPLICONSIZELIMIT]
                 [--NucleotideRepeatLimit NUCLEOTIDEREPEATLIMIT]
                 [--MinGC MINGC] [--MaxGC MAXGC]
                 [--DimerisationThresh DIMERISATIONTHRESH]
                 [--BackgroundCheck BACKGROUNDCHECK]
                 [--CrossReactivityThresh CROSSREACTIVITYTHRESH]
                 [--HardCrossReactFilter HARDCROSSREACTFILTER]
                 [--MaxSets MAXSETS] [--Threads THREADS]
                 [--BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY]
                 [--Evalue EVALUE]

options:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --PriorAlign PRIORALIGN
                        Optional: Path to Prior Binding File
  --PriorBindingSite PRIORBINDINGSITE
                        Optional: Path to Prior Binding File
  --InputFile INPUTFILE
                        Path to Input File
  --InputFileType INPUTFILETYPE
                        Options [SS,MS,MAS]
  --IdentityThreshold IDENTITYTHRESHOLD
                        Desired Identity Threshold
  --ConservedAnchor CONSERVEDANCHOR
                        Identity Anchor Required
  --PrimerLength PRIMERLENGTH
                        Desired Primer Length
  --ProbeRequired PROBEREQUIRED
                        Options [NO,EXO,NFO]
  --ProbeLength PROBELENGTH
                        Desired Probe Length
  --AmpliconSizeLimit AMPLICONSIZELIMIT
                        Amplicon Size Limit
  --NucleotideRepeatLimit NUCLEOTIDEREPEATLIMIT
                        Nucleotide Repeat Limit (i.e 5 = AAAAA)
  --MinGC MINGC         Minimum GC Content
  --MaxGC MAXGC         Maximum GC Content
  --DimerisationThresh DIMERISATIONTHRESH
                        Percentage Dimerisation Tolerated
  --BackgroundCheck BACKGROUNDCHECK
                        Options [NO, Path To Background Fasta File]
  --CrossReactivityThresh CROSSREACTIVITYTHRESH
                        Max Cross Reactivity Threshold
  --HardCrossReactFilter HARDCROSSREACTFILTER
                        Hard Cross Reactivity Filter
  --MaxSets MAXSETS     Default Set To 100
  --Threads THREADS     Default Set To 1
  --BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY
                        Options [Basic or Advanced or Fast]
  --Evalue EVALUE       Default Set To 1000
Please run PrimedRPA --help to see valid options
```

