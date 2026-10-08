# flock CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| flock_cent_adjust | PASS |  |
| flock_flock1 | PASS |  |
| flock_flock2 | PASS |  |

## flock_flock1

### Tool Description
FLOCK flow cytometry population identification (flock1).

### Metadata
- **Docker Image**: quay.io/biocontainers/flock:1.0--0
- **Homepage**: https://github.com/cristhomas/immport-test
- **Package**: https://anaconda.org/channels/bioconda/packages/flock/overview
- **Validation**: PASS

### Original Help Text
```text
Incorrect number of input parameters!
advanced mode: flock data_file num_bin density_index max_num_pop
```

## flock_flock2

### Tool Description
FLOCK flow cytometry population identification (flock2).

### Metadata
- **Docker Image**: quay.io/biocontainers/flock:1.0--0
- **Homepage**: https://github.com/cristhomas/immport-test
- **Package**: https://anaconda.org/channels/bioconda/packages/flock/overview
- **Validation**: PASS

### Original Help Text
```text
Incorrect number of input parameters!
usage:
basic mode: flock data_file
advanced mode 0 (specify maximum # of pops): flock data_file max_num_pop
advanced mode 1 (without # of pops): flock data_file num_bin density_index
advanced mode 2 (specify # of pops): flock data_file num_bin density_index number_of_pop
advanced mode 3 (specify both # of pops): flock data_file num_bin density_index number_of_pop max_num_pop
```

## flock_cent_adjust

### Tool Description
FLOCK flow cytometry population identification (cent_adjust).

### Metadata
- **Docker Image**: quay.io/biocontainers/flock:1.0--0
- **Homepage**: https://github.com/cristhomas/immport-test
- **Package**: https://anaconda.org/channels/bioconda/packages/flock/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cent_adjust input_center input_data_file
```

## Metadata
- **Skill**: not generated
