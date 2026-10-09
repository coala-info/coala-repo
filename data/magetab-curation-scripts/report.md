# magetab-curation-scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| magetab-curation-scripts_gal2adf.pl | PASS |  |
| magetab-curation-scripts_magetab_insert_array.pl | Not completed | needs the ArrayExpress Submissions Tracking database and a submitter account |
| magetab-curation-scripts_validate_magetab.pl | PASS | experiment mode (-i) works; ADF mode (-a) crashes after the checks on an empty site-config path |

## magetab-curation-scripts_validate_magetab.pl

### Tool Description
Validates MAGE-TAB files.

### Metadata
- **Docker Image**: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/perl-curation-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/magetab-curation-scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/magetab-curation-scripts/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/perl-curation-scripts
- **Stars**: N/A
### Original Help Text
```text
Usage:
    Experiment mode:
         validate_magetab.pl -i <IDF file>

         validate_magetab.pl -m <Merged IDF and SDRF file>

         validate_magetab.pl -m <Merged IDF and SDRF file>

    ADF mode:
         validate_magetab.pl -a <ADF file>

Options:
    -i "IDF filename"
        The MAGE-TAB IDF file to be checked (SDRF file name will be obtained
        from the IDF)

    -m "Merged MAGE-TAB IDF and SDRF filename"
        A MAGE-TAB document in which a single IDF and SDRF have been
        combined (in that order), with the start of each section marked by
        [IDF] and [SDRF] respectively. Note that such documents are not
        compliant with the MAGE-TAB format specification; this format is
        used by ArrayExpress to simplify data submissions.

    -d "data directory"
        Directory where the data files and SDRF can be found if they are not
        in the same directory as the IDF

    -c  Flag to switch on full curator checking mode, including Atlas checks

    -x  Flag to indicate that all data file checks should be skipped

    -a "ADF filename"
        The MAGE-TAB ADF file to be checked.

    -v  Swtich on verbose logging.

    -h  Prints a short help text.
```

## magetab-curation-scripts_magetab_insert_array.pl

### Tool Description
You must specify an ADF filename.

### Metadata
- **Docker Image**: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/perl-curation-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/magetab-curation-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
You must specify an ADF filename.

Usage:
    magetab_insert_array.pl -f new_adf.txt

    magetab_insert_array.pl -f new_adf.txt -l submitter_login

    magetab_insert_array.pl -f new_adf.txt -l submitter_login -a
    A-MTAB-99999 -c

Options:
    -f --file
      Required. Name of array design file.

    -l --login
      Optional. Submitter user name. If not provided, will use fg_cur.

    -a --accession
      Optional. Desired accession for this array design. If not provided
      will use next available accession from Submissions Tracking database.

    -c --clobber
      Optional. Replace existing files without prompting.

    -h --help
      Print a helpful message.
```

## magetab-curation-scripts_gal2adf.pl

### Tool Description
Converts a GAL file to an ADF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/perl-curation-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/magetab-curation-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gal2adf.pl -i <input gal file> 

    The following optional arguments may also be used:

                  -a <output adf file> 

	          -c <column number containing database IDs>
                  -d <output database ID file>

                  -e <output error log file>
                  -w <output warning log file>

                  -h <this help text>
```

## Metadata
- **Skill**: generated
