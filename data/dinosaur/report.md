# dinosaur CWL Generation Report

## dinosaur

### Tool Description
Analyze MzML files for isotope patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1
- **Homepage**: https://github.com/fickludd/dinosaur
- **Package**: https://anaconda.org/channels/bioconda/packages/dinosaur/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dinosaur/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fickludd/dinosaur
- **Stars**: N/A
### Original Help Text
```text
usage:
> java -jar Dinosaur-1.2.0.jar [OPTIONS] mzML
OPTIONS:
              PARAMETER DEFAULT         	DESCRIPTION
                advHelp false           	set to output adv param file help and quit
              advParams                 	path to adv param file
            concurrency 2               	the number of assays to analyze in parallel
                  force false           	ignore missing mzML params
              maxCharge 6               	max searched ion charge
              minCharge 1               	min searched ion charge
                   mode global          	analysis mode: global or target. Global mode reports all isotope patterns, targeted only those matching targets.
                   mzML -               	The shotgun MzML file to analyze
                nReport 10              	number of random assay to export control figure for
                 outDir                 	output directory (by default same as input mzML)
                outName                 	basename for output files (by default same as input mzML)
              profiling false           	set to enable CPU profiling
    reportDeisoMzHeight 15.0            	mz range in deisotoper reports
          reportHighRes false           	generate high-resolution plot trail when supported (for print)
             reportSeed -1              	seed to use for report assay selection (<0 means random)
          reportTargets false           	set to create a special report figure for each target
                   seed -1              	seed to use for bootstrapping of mass calibration (<0 means random)
       targetPreference rt              	if multiple isotope patterns fit target, take the closest rt apex (rt) or the most intense (intensity)
                targets                 	path to isotope patterns target file (not used by default)
                verbose false           	increase details in output
            writeBinary false           	set to output binary MSFeatureProtocol file
             writeHills false           	set to output csv file with all hills assigned to isotope patterns
         writeMsInspect false           	set to output MsInspect feature csv file
           writeQuantML false           	set to output mzQuantML file
            zipQcFolder false           	set to zip the entire qc folder on algorithm completion

Error parsing 'help'. Option does not exist.
Not enough arguments!
```

