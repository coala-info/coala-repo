# figaro CWL Generation Report

## figaro_figaro.py

### Tool Description
Figaro is a tool for analyzing amplicon sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/Zymo-Research/figaro
- **Package**: https://anaconda.org/channels/bioconda/packages/figaro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/figaro/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Zymo-Research/figaro
- **Stars**: N/A
### Original Help Text
```text
Environment variable parameter ampliconLength was set as required, but no value was passed for it.
Environment variable parameter forwardPrimerLength was set as required, but no value was passed for it.
Environment variable parameter reversePrimerLength was set as required, but no value was passed for it.
Unable to find expected directory for environment variable parameter inputDirectory at /data/input
Traceback (most recent call last):
  File "/usr/local/bin/figaro.py", line 211, in <module>
    parameters = getApplicationParameters()
  File "/usr/local/bin/figaro.py", line 18, in getApplicationParameters
    parameters.addParameter("inputDirectory", str, default=default.inputFolder, expectedDirectory=True)
  File "/usr/local/lib/python3.9/site-packages/figaroSupport/environmentParameterParser.py", line 393, in addParameter
    parameter = EnvVariable(name, typeRequirement, default, flag, validationList, lowerBound, upperBound, expectedFile, createdFile, expectedDirectory, createdDirectory, logLevel, required, externalValidation)
  File "/usr/local/lib/python3.9/site-packages/figaroSupport/environmentParameterParser.py", line 52, in __init__
    self.runValidations()
  File "/usr/local/lib/python3.9/site-packages/figaroSupport/environmentParameterParser.py", line 87, in runValidations
    self.validateExpectedDirectoryPath()
  File "/usr/local/lib/python3.9/site-packages/figaroSupport/environmentParameterParser.py", line 148, in validateExpectedDirectoryPath
    raise NotADirectoryError("Unable to find expected file %s" %self.value)
NotADirectoryError: Unable to find expected file /data/input
```

