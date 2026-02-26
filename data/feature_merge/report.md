# feature_merge CWL Generation Report

## feature_merge

### Tool Description
Accepts GFF or GTF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/feature_merge:1.3.0--pyh3252c3a_0
- **Homepage**: https://github.com/brinkmanlab/feature_merge
- **Package**: https://anaconda.org/channels/bioconda/packages/feature_merge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/feature_merge/overview
- **Total Downloads**: 11.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brinkmanlab/feature_merge
- **Stars**: N/A
### Original Help Text
```text
Argument error( help ):  option --help not recognized
Usage: feature_merge [-i] [-e] [-s] [-x] [-v] [-t <number>]  [-m merge|append|error|skip|replace] [-f type[,type..]].. <input1> [<input_n>..]
Accepts GFF or GTF format.
-v Print version and exit
-f Comma seperated types of features to merge. Must be terms or accessions from the SOFA sequence ontology, "ALL", or "NONE". (Can be provided more than once to specify multiple merge groups)
-i Ignore strand, merge feature regardless of strand
-s Ignore sequence id, merge feature regardless of sequence id
-x Only merge features with identical coordinates
-t Threshold distance between features to merge 
-e Exclude component features from output
-m Merge strategy used to deal with id collisions between input files.
    merge: attributes of all features with the same primary key will be merged
    append: entry will have a unique, autoincremented primary key assigned to it (default)
    error: exception will be raised. This means you will have to edit the file yourself to fix the duplicated IDs
    skip: ignore duplicates, emitting a warning
    replace: keep last duplicate
```

