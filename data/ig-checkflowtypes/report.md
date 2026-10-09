# ig-checkflowtypes CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ig-checkflowtypes_checkFCS.R | PASS | new CWL; flowCore example FCS file gives TRUE, an RDS file gives the invalid message |
| ig-checkflowtypes_checkFlowSOM.R | PASS | new CWL; synthetic data: an empty object with class FlowSOM gives TRUE (FlowSOM is not in the image), a flowSet RDS gives the invalid message |
| ig-checkflowtypes_checkFlowSet.R | PASS | fixed baseCommand to checkFlowSet.R; flowCore example flowSet RDS gives TRUE, a flowFrame RDS gives the invalid message |
| ig-checkflowtypes_checkFlowframe.R | PASS | new CWL; flowFrame RDS from flowCore example data gives TRUE, a flowSet RDS gives the invalid message |

## ig-checkflowtypes_checkFlowSet.R

### Tool Description
Checks flowSet objects for validity and readability.

### Metadata
- **Docker Image**: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
- **Homepage**: https://github.com/ImmPortDB/ig-checkflowtypes
- **Package**: https://anaconda.org/channels/bioconda/packages/ig-checkflowtypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: checkFlowSet.R <input file>   (no --help; prints TRUE or an error message)
```

## ig-checkflowtypes_checkFCS.R

### Tool Description
Checks whether a file is a valid FCS file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
- **Homepage**: https://github.com/ImmPortDB/ig-checkflowtypes
- **Package**: https://anaconda.org/channels/bioconda/packages/ig-checkflowtypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: checkFCS.R <input file>   (no --help; prints TRUE or an error message)
```

## ig-checkflowtypes_checkFlowSOM.R

### Tool Description
Checks whether an RDS file holds a valid FlowSOM object.

### Metadata
- **Docker Image**: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
- **Homepage**: https://github.com/ImmPortDB/ig-checkflowtypes
- **Package**: https://anaconda.org/channels/bioconda/packages/ig-checkflowtypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: checkFlowSOM.R <input file>   (no --help; prints TRUE or an error message)
```

## ig-checkflowtypes_checkFlowframe.R

### Tool Description
Checks whether an RDS file holds a valid flowFrame object.

### Metadata
- **Docker Image**: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
- **Homepage**: https://github.com/ImmPortDB/ig-checkflowtypes
- **Package**: https://anaconda.org/channels/bioconda/packages/ig-checkflowtypes/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: checkFlowframe.R <input file>   (no --help; prints TRUE or an error message)
```

