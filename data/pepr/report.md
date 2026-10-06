# pepr CWL Generation Report

## Metadata
- **Skill**: generated

## pepr_PePr-preprocess

### Tool Description
Pre-processing and parameter estimation for PePr (Peak-calling and Prioritization pipeline for ChIP-seq)

### Metadata
- **Docker Image**: quay.io/biocontainers/pepr:1.1.24--py35_0
- **Homepage**: https://github.com/shawnzhangyx/PePr/
- **Package**: https://anaconda.org/channels/bioconda/packages/pepr/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: Basic usage: PePr-preprocess -c chip_files -i input_files -f file_type
You could also use a parameter file by: PePr-preprocess -p param_file
For pre-processing only (parameter estimation), run: PePr-preprocess
For post-processing, run: PePr-postprocess

Options:
  -h, --help            show this help message and exit
  -p PARAMETER-FILE, --parameter-file=PARAMETER-FILE
                        provide a file that contain the parameters
  -c CHIP1, --chip1=CHIP1
                        chip1 file names separated by comma
  -i INPUT1, --input1=INPUT1
                        input1 file names separated by comma
  --chip2=CHIP2         chip2 file names separated by comma
  --input2=INPUT2       input2 file names separated by comma
  -f FORMAT, --file-format=FORMAT
                        bed, sam, bam, sampe, bampe...
  -s SHIFTSIZE, --shiftsize=SHIFTSIZE
                        Half the fragment size.
  -w WINDOWSIZE, --windowsize=WINDOWSIZE
                        Window sizes
  --diff                Perform differential binding instead of peak-calling
  -n NAME, --name=NAME  the experimental name. NA if none provided
  --threshold=THRESHOLD
                        p-value threshold. Default 1e-5.
  --peaktype=PEAKTYPE   sharp or broad. Default broad.
  --num-processors=NUM_PROCS
                        number of cores for use.
  --input-directory=INPUT_DIRECTORY
                        where the data files are. Absolute path recommended.
  --output-directory=OUTPUT_DIRECTORY
                        where you want the output files to be
  --normalization=NORMALIZATION
                        Normalization method. inter-group, intra-group, scale
                        or no. Must manually specify for differential binding
                        analysis.
  --keep-max-dup=KEEP_MAX_DUP
                        maximum number of reads to keep at each position.
                        if not specified, will not remove any duplicate.
  --version             Show version information and exit
```

## pepr_PePr-postprocess

### Tool Description
Post-process PePr peak calling results, including artifact removal and peak boundary refinement.

### Metadata
- **Docker Image**: quay.io/biocontainers/pepr:1.1.24--py35_0
- **Homepage**: https://github.com/shawnzhangyx/PePr/
- **Package**: https://anaconda.org/channels/bioconda/packages/pepr/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: PePr-postprocess [options]

Options:
  -h, --help            show this help message and exit
  --peak=PEAK           peak file
  --chip=CHIP           chip files separated by comma
  --input=INPUT         input files separated by comma
  --file-type=TYPE      read file types. bed, sam, bam
  --remove-artefacts    remove peaks that may be caused by excess PCR
                        duplicates
  --narrow-peak-boundary
                        make peak width smaller but still contain the core
                        binding region
```

