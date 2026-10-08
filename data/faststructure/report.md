# faststructure CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| faststructure_chooseK.py | PASS | fixed: the result files are now staged as an input; run on the output files shipped in the fastStructure repository test folder (K=3 chosen) |
| faststructure_distruct.py | PASS | plot made from the meanQ file shipped in the fastStructure repository test folder |
| faststructure_structure.py | Failed | image problem: structure.py stops with TypeError: Cannot convert allelefreq.AlleleFreq to allelefreq.AlleleFreq (compiled module mismatch) for every option set |

## faststructure_structure.py

### Tool Description
Infer population structure from genotype data with the variational Bayes algorithm of fastStructure

### Metadata
- **Docker Image**: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
- **Homepage**: https://github.com/rajanil/fastStructure
- **Package**: https://anaconda.org/channels/bioconda/packages/faststructure/overview
- **Validation**: PASS

### Original Help Text
```text

Here is how you can use this script

Usage: python /usr/local/bin/structure.py
	 -K <int> (number of populations)
	 --input=<file> (/path/to/input/file)
	 --output=<file> (/path/to/output/file)
	 --tol=<float> (convergence criterion; default: 10e-6)
	 --prior={simple,logistic} (choice of prior; default: simple)
	 --cv=<int> (number of test sets for cross-validation, 0 implies no CV step; default: 0)
	 --format={bed,str} (format of input file; default: bed)
	 --full (to output all variational parameters; optional)
	 --seed=<int> (manually specify seed for random number generator; optional)
```

## faststructure_distruct.py

### Tool Description
Plot the estimated admixture proportions of a fastStructure run

### Metadata
- **Docker Image**: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
- **Homepage**: https://github.com/rajanil/fastStructure
- **Package**: https://anaconda.org/channels/bioconda/packages/faststructure/overview
- **Validation**: PASS

### Original Help Text
```text

Here is how you can use this script

Usage: python /usr/local/bin/distruct.py
	 -K <int>  (number of populations)
	 --input=<file>  (/path/to/input/file; same as output flag passed to structure.py)
	 --output=<file> (/path/to/output/file)
	 --popfile=<file> (file with known categorical labels; optional)
	 --title=<figure title> (a title for the figure; optional)
```

## Metadata
- **Skill**: generated

## faststructure_chooseK.py

### Tool Description
A script to help choose the number of populations (K) that best explains the data after running fastStructure.

### Metadata
- **Docker Image**: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
- **Homepage**: https://github.com/rajanil/fastStructure
- **Package**: https://anaconda.org/channels/bioconda/packages/faststructure/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/faststructure:1.0--py311h1f01909_6 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3465974587: no space left on device
```

