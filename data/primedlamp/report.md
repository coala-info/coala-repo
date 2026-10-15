# primedlamp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| primedlamp_PrimedLAMP | PASS |  |
| primedlamp_PrimedLAMP_Amplicon_Success | PASS |  |
| primedlamp_PrimedLAMP_Cross_Reactivity_Update | PASS |  |
| primedlamp_PrimedLAMP_Custom | PASS |  |
| primedlamp_PrimedLAMP_Inclusivity_Update | Failed | image problem: the script has no shebang line, so it fails with exec format error |
| primedlamp_PrimedLAMP_Tm_Update | PASS |  |

## primedlamp_PrimedLAMP

### Tool Description
LAMP primer design for aligned target sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP [-h] --RunID RUNID [--InputFile INPUTFILE]
                  [--PriorAlignmentSummary PRIORALIGNMENTSUMMARY]
                  [--PriorOligoSites PRIOROLIGOSITES]
                  [--IdentityThreshold IDENTITYTHRESHOLD]
                  [--ConservedAnchor CONSERVEDANCHOR]
                  [--PrimerLength PRIMERLENGTH]
                  [--NucleotideRepeatLimit NUCLEOTIDEREPEATLIMIT]
                  [--MinGC MINGC] [--MaxGC MAXGC]
                  [--DimerisationThresh DIMERISATIONTHRESH]
                  [--BackgroundCheck BACKGROUNDCHECK]
                  [--BlastDBPath BLASTDBPATH]
                  [--CrossReactivityThresh CROSSREACTIVITYTHRESH]
                  [--Threads THREADS]
                  [--MonovalentSaltConc MONOVALENTSALTCONC]
                  [--DivalentSaltConc DIVALENTSALTCONC] [--dNTPConc DNTPCONC]
                  [--OligoConc OLIGOCONC] [--OligoConcPair OLIGOCONCPAIR]
                  [--Degenerate DEGENERATE] [--MinimumTm MINIMUMTM]
                  [--MaximumTm MAXIMUMTM]
                  [--TmDifferenceLimit TMDIFFERENCELIMIT]
                  [--MinimumTerminalDeltaG MINIMUMTERMINALDELTAG]
                  [--MaxDistance3to2 MAXDISTANCE3TO2]
                  [--MaxDistance2toL MAXDISTANCE2TOL]
                  [--MaxDistance2to1 MAXDISTANCE2TO1]
                  [--MaxDistance1to1 MAXDISTANCE1TO1]
                  [--MaxDistance2to2 MAXDISTANCE2TO2]
                  [--BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY]
                  [--EvalueThresh EVALUETHRESH] [--F3SetLimit F3SETLIMIT]
                  [--LoopPrimers LOOPPRIMERS]

optional arguments:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --InputFile INPUTFILE
                        Path to Target Input Fasta File
  --PriorAlignmentSummary PRIORALIGNMENTSUMMARY
                        Path to Prior Generated Alignment Summary
  --PriorOligoSites PRIOROLIGOSITES
                        Path to Prior Generated Oligo Sites
  --IdentityThreshold IDENTITYTHRESHOLD
                        Desired Identity Threshold
  --ConservedAnchor CONSERVEDANCHOR
                        Identity Anchor Required
  --PrimerLength PRIMERLENGTH
                        Desired Primer Length
  --NucleotideRepeatLimit NUCLEOTIDEREPEATLIMIT
                        Nucleotide Repeat Limit (i.e 5 = AAAAA)
  --MinGC MINGC         Minimum GC Content
  --MaxGC MAXGC         Maximum GC Content
  --DimerisationThresh DIMERISATIONTHRESH
                        Percentage Dimerisation Tolerated
  --BackgroundCheck BACKGROUNDCHECK
                        Options [NO, Path To Background Fasta File]
  --BlastDBPath BLASTDBPATH
                        Path to BlastnDB
  --CrossReactivityThresh CROSSREACTIVITYTHRESH
                        Max Cross Reactivity Threshold
  --Threads THREADS     Default Set To 1
  --MonovalentSaltConc MONOVALENTSALTCONC
                        Millimolar Concentration (10^-3)
  --DivalentSaltConc DIVALENTSALTCONC
                        Millimolar Concentration (10^-3)
  --dNTPConc DNTPCONC   Millimolar Concentration (10^-3)
  --OligoConc OLIGOCONC
                        Micromolar Concentration (10^-6)
  --OligoConcPair OLIGOCONCPAIR
                        Leave as Default
  --Degenerate DEGENERATE
  --MinimumTm MINIMUMTM
  --MaximumTm MAXIMUMTM
  --TmDifferenceLimit TMDIFFERENCELIMIT
  --MinimumTerminalDeltaG MINIMUMTERMINALDELTAG
  --MaxDistance3to2 MAXDISTANCE3TO2
  --MaxDistance2toL MAXDISTANCE2TOL
  --MaxDistance2to1 MAXDISTANCE2TO1
  --MaxDistance1to1 MAXDISTANCE1TO1
  --MaxDistance2to2 MAXDISTANCE2TO2
  --BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY
                        Options [Basic or Advanced or Fast]
  --EvalueThresh EVALUETHRESH
                        Options [Basic or Advanced or Fast]
  --F3SetLimit F3SETLIMIT
                        Set Limit with for identical F3 Primer
  --LoopPrimers LOOPPRIMERS
                        Include Loop Primers
```

## primedlamp_PrimedLAMP_Amplicon_Success

### Tool Description
Assess amplicon success of LAMP oligo sets

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP_Amplicon_Success [-h] --RunID RUNID --InputFile INPUTFILE
                                   --InputFasta INPUTFASTA [--Threads THREADS]
                                   [--NonCriticalThreshold NONCRITICALTHRESHOLD]
                                   [--CriticalRegionLen CRITICALREGIONLEN]

optional arguments:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --InputFile INPUTFILE
                        Path <RunID>_Oligo_Analysis.csv
  --InputFasta INPUTFASTA
                        Path to target sequence in fasta format. This needs to
                        be the same file used in the prior PrimedLAMP or
                        PrimedLAMP_Custom Run
  --Threads THREADS     Default Set To 1
  --NonCriticalThreshold NONCRITICALTHRESHOLD
                        Number of mismatches tolerated in non-critical region
  --CriticalRegionLen CRITICALREGIONLEN
                        Number of nucleotides in from either the 5' or 3'
                        terminus
```

## primedlamp_PrimedLAMP_Cross_Reactivity_Update

### Tool Description
Update cross-reactivity of a prior PrimedLAMP run

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP_Cross_Reactivity_Update [-h] --RunID RUNID --PriorOligoSites
                                          PRIOROLIGOSITES --PriorBlastnOutput
                                          PRIORBLASTNOUTPUT
                                          --ExlusionIDFilePath
                                          EXLUSIONIDFILEPATH
                                          [--Threads THREADS]

optional arguments:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --PriorOligoSites PRIOROLIGOSITES
                        Path to Prior Generated Oligo Sites
  --PriorBlastnOutput PRIORBLASTNOUTPUT
                        Path to Blastn_Output directory
  --ExlusionIDFilePath EXLUSIONIDFILEPATH
                        Path to .txt file contain sequence IDs to excluded
  --Threads THREADS     Default Set To 1
```

## primedlamp_PrimedLAMP_Custom

### Tool Description
Assess custom LAMP primer sets

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP_Custom [-h] --RunID RUNID --InputFile INPUTFILE
                         [--InputFasta INPUTFASTA] [--PriorAlign PRIORALIGN]
                         [--BackgroundCheck BACKGROUNDCHECK]
                         [--BlastDBPath BLASTDBPATH]
                         [--BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY]
                         [--EvalueThresh EVALUETHRESH] [--Threads THREADS]
                         [--TspacerLen TSPACERLEN]
                         [--InclusivityCheck INCLUSIVITYCHECK]

optional arguments:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --InputFile INPUTFILE
                        Path to Custom Sets Input File (CSV)
  --InputFasta INPUTFASTA
                        Path to target sequence in fasta format
  --PriorAlign PRIORALIGN
                        Path to Alignment Summary CSV File
  --BackgroundCheck BACKGROUNDCHECK
                        Path to cross-reactivity fasta file. If no cross
                        reactivity check is required please set as: NO
  --BlastDBPath BLASTDBPATH
                        Path to BlastnDB for cross reactivity check.
  --BackgroundSearchSensitivity BACKGROUNDSEARCHSENSITIVITY
                        Options [Basic or Advanced or Fast]
  --EvalueThresh EVALUETHRESH
                        Cross Reactivity search sensntivity.
  --Threads THREADS     Default set to 1
  --TspacerLen TSPACERLEN
                        Length of T Spacer in FIP and BIP if required
  --InclusivityCheck INCLUSIVITYCHECK
                        Inclusivity and binding site assessment
```

## primedlamp_PrimedLAMP_Inclusivity_Update

### Tool Description
Update inclusivity scores of a prior PrimedLAMP run

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP_Inclusivity_Update [-h] --RunID RUNID [--InputFasta INPUTFASTA] --PriorOligoSites PRIOROLIGOSITES [--Threads THREADS]

(The script has no shebang line in this image, so --help cannot run: "exec format error". Options taken from the script source.)

  --RunID RUNID         Desired Run ID
  --InputFasta INPUTFASTA
                        Path to Target Input Fasta File
  --PriorOligoSites PRIOROLIGOSITES
                        Path to Prior Generated Oligo Sites
  --Threads THREADS     Default Set To 1
```

## primedlamp_PrimedLAMP_Tm_Update

### Tool Description
Recalculate Tm of the oligo sites of a prior PrimedLAMP run

### Metadata
- **Docker Image**: quay.io/biocontainers/primedlamp:1.0.1--py_0
- **Homepage**: https://github.com/MatthewHiggins2017/bioconda-PrimedRPA
- **Package**: https://anaconda.org/channels/bioconda/packages/primedlamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PrimedLAMP_Tm_Update [-h] --RunID RUNID --PriorOligoSites
                            PRIOROLIGOSITES
                            [--MonovalentSaltConc MONOVALENTSALTCONC]
                            [--DivalentSaltConc DIVALENTSALTCONC]
                            [--dNTPConc DNTPCONC] [--OligoConc OLIGOCONC]
                            [--OligoConcPair OLIGOCONCPAIR]
                            [--Threads THREADS]

optional arguments:
  -h, --help            show this help message and exit
  --RunID RUNID         Desired Run ID
  --PriorOligoSites PRIOROLIGOSITES
                        Path to Prior Generated Oligo Sites
  --MonovalentSaltConc MONOVALENTSALTCONC
                        Millimolar Concentration (10^-3)
  --DivalentSaltConc DIVALENTSALTCONC
                        Millimolar Concentration (10^-3)
  --dNTPConc DNTPCONC   Millimolar Concentration (10^-3)
  --OligoConc OLIGOCONC
                        Micromolar Concentration (10^-6)
  --OligoConcPair OLIGOCONCPAIR
                        Leave as Default
  --Threads THREADS     Default Set To 1
```

## Metadata
- **Skill**: not generated
