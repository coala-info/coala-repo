# dreamtools CWL Generation Report

## dreamtools

### Tool Description
General Description:
    You must provide the challenge alias (e.g., D8C1 for DREAM8, Challenge 1)
    and if there were several sub-challenges, you also must provide the
    sub-challenge alias (e.g., sc1). Finally, the submission has to be
    provided. The format must be in agreement with the description of the
    challenge itself.

    Help and documentation about the templates may be found either within
    the online documentation http://pythonhosted.org/dreamtools/ or within
    the source code hosted on github http://github.com/dreamtools/dreamtools.

    Registered challenge so far (and sub-challenges) are:
D2C1, D2C2, D2C3, D2C4, D2C5, D3C1, D3C2, D3C3, D3C4, D4C1, D4C2, D4C3, D5C1,
D5C2, D5C3, D5C4, D6C2, D6C3, D6C4, D7C1, D7C3, D7C4, D8C1, D8C2, D8C3,
D8dot5C1, D9C1, D9C3, D9dot5C1

### Metadata
- **Docker Image**: quay.io/biocontainers/dreamtools:1.3.0--py36_0
- **Homepage**: https://github.com/dreamtools/dreamtools
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dreamtools/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dreamtools/dreamtools
- **Stars**: N/A
### Original Help Text
```text
Creating directory /root/.config/dreamtools 
usage: usage: python dreamtools --challenge D8C1 --sub-challenge SC1A --submission <filename>
      python dreamtools --challenge D5C2 --submission <filename>

General Description:
    You must provide the challenge alias (e.g., D8C1 for DREAM8, Challenge 1)
    and if there were several sub-challenges, you also must provide the
    sub-challenge alias (e.g., sc1). Finally, the submission has to be
    provided. The format must be in agreement with the description of the
    challenge itself.

    Help and documentation about the templates may be found either within
    the online documentation http://pythonhosted.org/dreamtools/ or within
    the source code hosted on github http://github.org/dreamtools/dreamtools.

    Registered challenge so far (and sub-challenges) are:
D2C1, D2C2, D2C3, D2C4, D2C5, D3C1, D3C2, D3C3, D3C4, D4C1, D4C2, D4C3, D5C1,
D5C2, D5C3, D5C4, D6C2, D6C3, D6C4, D7C1, D7C3, D7C4, D8C1, D8C2, D8C3,
D8dot5C1, D9C1, D9C3, D9dot5C1

optional arguments:
  -h, --help            show this help message and exit

General:
  General options (compulsary or not)

  --version             verbose option.
  --challenge CHALLENGE
                        alias of the challenge (e.g., D8C1 stands fordream8
                        challenge 1).
  --sub-challenge SUB_CHALLENGE
                        Name of the data files
  --verbose             verbose option.
  --submission [FILENAME [FILENAME ...]]
                        submission/filename to score.
  --filename [FILENAME [FILENAME ...]]
                        submission/filename to score.
  --gold-standard GOLDSTANDARD
                        a gold standard filename. This may be required in some
                        challenges e.g. D2C3
  --onweb               Open synapse project page in a browser
  --info                Prints general information about the challenge
  --download-template   Download template. Templates for challenge may be
                        downloaded using this option. It returns the path to
                        template.
  --download-gold-standard
                        Download a gold standard, which can be used as a
                        submissions as well. It returns the location of the
                        file.

Author(s): Thomas Cokelaer (DREAMTools framework) and authors from
the DREAM consortium. Please see the scoring files headers for details
and the GitHub repository.

Source code on: https://github.com/dreamtools/dreamtools
Issues or bug report ? Please fill an issue on http://github.com/dreamtools/dreamtools/issues
```

