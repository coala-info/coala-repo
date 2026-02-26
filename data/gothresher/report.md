# gothresher CWL Generation Report

## gothresher

### Tool Description
Gothresher is a tool for filtering and processing GO annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gothresher:1.0.29--pyh7cba7a3_0
- **Homepage**: https://github.com/FriedbergLab/GOThresher
- **Package**: https://anaconda.org/channels/bioconda/packages/gothresher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gothresher/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FriedbergLab/GOThresher
- **Stars**: N/A
### Original Help Text
```text
usage: gothresher.py [-h] [--prefix PREFIX] [--cutoff_prot CUTOFF_PROT]
                     [--cutoff_attn CUTOFF_ATTN] [--output OUTPUT]
                     [--evidence EVIDENCE [EVIDENCE ...] | --evidence_inverse
                     EVIDENCE_INVERSE [EVIDENCE_INVERSE ...]] --input INPUT
                     [INPUT ...] [--aspect ASPECT [ASPECT ...]]
                     [--assigned_by ASSIGNED_BY [ASSIGNED_BY ...] |
                     --assigned_by_inverse ASSIGNED_BY_INVERSE
                     [ASSIGNED_BY_INVERSE ...]] [--recalculate RECALCULATE]
                     [--info_threshold_Wyatt_Clark_percentile INFO_THRESHOLD_WYATT_CLARK_PERCENTILE | --info_threshold_Wyatt_Clark INFO_THRESHOLD_WYATT_CLARK | --info_threshold_Phillip_Lord_percentile INFO_THRESHOLD_PHILLIP_LORD_PERCENTILE | --info_threshold_Phillip_Lord INFO_THRESHOLD_PHILLIP_LORD]
                     [--verbose VERBOSE] [--date_before DATE_BEFORE]
                     [--date_after DATE_AFTER] [--single_file SINGLE_FILE]
                     [--select_references SELECT_REFERENCES [SELECT_REFERENCES ...]
                     | --select_references_inverse SELECT_REFERENCES_INVERSE
                     [SELECT_REFERENCES_INVERSE ...]] [--report REPORT]

options:
  -h, --help            show this help message and exit
  --prefix PREFIX, -pref PREFIX
                        Add a prefix to the name of your output files.
  --cutoff_prot CUTOFF_PROT, -cprot CUTOFF_PROT
                        The threshold level for deciding to eliminate
                        annotations which come from references that annotate
                        more than the given 'threshold' number of PROTEINS
  --cutoff_attn CUTOFF_ATTN, -cattn CUTOFF_ATTN
                        The threshold level for deciding to eliminate
                        annotations which come from references that annotate
                        more than the given 'threshold' number of ANNOTATIONS
  --output OUTPUT, -odir OUTPUT
                        Writes the final outputs to the directory in this
                        path.
  --evidence EVIDENCE [EVIDENCE ...], -e EVIDENCE [EVIDENCE ...]
                        Accepts Standard Evidence Codes outlined in
                        http://geneontology.org/page/guide-go-evidence-codes.
                        All 3 letter code for each standard evidence is
                        acceptable. In addition to that EXPEC is accepted
                        which will pull out all annotations which are made
                        experimentally. COMPEC will extract all annotations
                        which have been done computationally. Similarly,
                        AUTHEC and CUREC are also accepted. Cannot be provided
                        if -einv is provided
  --evidence_inverse EVIDENCE_INVERSE [EVIDENCE_INVERSE ...], -einv EVIDENCE_INVERSE [EVIDENCE_INVERSE ...]
                        Leaves out the provided Evidence Codes. Cannot be
                        provided if -e is provided
  --aspect ASPECT [ASPECT ...], -a ASPECT [ASPECT ...]
                        Enter P, C or F for Biological Process, Cellular
                        Component or Molecular Function respectively
  --assigned_by ASSIGNED_BY [ASSIGNED_BY ...], -assgn ASSIGNED_BY [ASSIGNED_BY ...]
                        Choose only those annotations which have been
                        annotated by the provided list of databases. Cannot be
                        provided if -assgninv is provided
  --assigned_by_inverse ASSIGNED_BY_INVERSE [ASSIGNED_BY_INVERSE ...], -assgninv ASSIGNED_BY_INVERSE [ASSIGNED_BY_INVERSE ...]
                        Choose only those annotations which have NOT been
                        annotated by the provided list of databases. Cannot be
                        provided if -assgn is provided
  --recalculate RECALCULATE, -recal RECALCULATE
                        Set this to 1 if you wish to enforce the recalculation
                        of the Information Accretion for every GO term.
                        Calculation of the information accretion is time
                        consuming. Therefore keep it to zero if you are
                        performing rerun on old data. The program will then
                        read the information accretion values from a file
                        which it wrote to in the previous run of the program
  --info_threshold_Wyatt_Clark_percentile INFO_THRESHOLD_WYATT_CLARK_PERCENTILE, -WCTHRESHp INFO_THRESHOLD_WYATT_CLARK_PERCENTILE
                        Provide the percentile p. All annotations having
                        information content below p will be discarded
  --info_threshold_Wyatt_Clark INFO_THRESHOLD_WYATT_CLARK, -WCTHRESH INFO_THRESHOLD_WYATT_CLARK
                        Provide a threshold value t. All annotations having
                        information content below t will be discarded
  --info_threshold_Phillip_Lord_percentile INFO_THRESHOLD_PHILLIP_LORD_PERCENTILE, -PLTHRESHp INFO_THRESHOLD_PHILLIP_LORD_PERCENTILE
                        Provide the percentile p. All annotations having
                        information content below p will be discarded
  --info_threshold_Phillip_Lord INFO_THRESHOLD_PHILLIP_LORD, -PLTHRESH INFO_THRESHOLD_PHILLIP_LORD
                        Provide a threshold value t. All annotations having
                        information content below t will be discarded
  --verbose VERBOSE, -v VERBOSE
                        Set this argument to 1 if you wish to view the outcome
                        of each operation on console
  --date_before DATE_BEFORE, -dbfr DATE_BEFORE
                        The date entered here will be parsed by the parser
                        from dateutil package. For more information on
                        acceptable date formats please visit
                        https://github.com/dateutil/dateutil/. All annotations
                        made prior to this date will be picked up
  --date_after DATE_AFTER, -daftr DATE_AFTER
                        The date entered here will be parsed by the parser
                        from dateutil package. For more information on
                        acceptable date formats please visit
                        https://github.com/dateutil/dateutil/. All annotations
                        made after this date will be picked up
  --single_file SINGLE_FILE, -single SINGLE_FILE
                        Set to 1 in order to output the results of each
                        individual species in a single file.
  --select_references SELECT_REFERENCES [SELECT_REFERENCES ...], -selref SELECT_REFERENCES [SELECT_REFERENCES ...]
                        Provide the paths to files which contain references
                        you wish to select. It is possible to include
                        references in case you wish to select annotations made
                        by a few references. This will prompt the program to
                        interpret string which have the keywords
                        'GO_REF','PMID' and 'Reactome' as a GO reference.
                        Strings which do not contain that keyword will be
                        interpreted as a file path which the program will
                        except to contain a list of GO references. The program
                        will accept a mixture of GO_REF and file names. It is
                        also possible to choose all references of a particular
                        category and a handful of references from another. For
                        example if you wish to choose all PMID references,
                        just put PMID. The program will then select all PMID
                        references. Currently the program can accept PMID,
                        GO_REF and Reactome
  --select_references_inverse SELECT_REFERENCES_INVERSE [SELECT_REFERENCES_INVERSE ...], -selrefinv SELECT_REFERENCES_INVERSE [SELECT_REFERENCES_INVERSE ...]
                        Works like -selref but does not select the references
                        which have been provided as input
  --report REPORT, -r REPORT
                        Provide the path where the report file will be stored.
                        If you are providing a path please make sure your path
                        ends with a '/'. Otherwise the program will assume the
                        last string after the final '/' as the name of the
                        report file. A single report file will be generated.
                        Information for each species will be put into
                        individual worksheets.

Required arguments:
  --input INPUT [INPUT ...], -i INPUT [INPUT ...]
                        The input file path. Please remember the name of the
                        file must start with goa in front of it, with the name
                        of the species following separated by an underscore
```

