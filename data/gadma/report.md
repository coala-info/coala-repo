# gadma CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gadma | PASS | GADMA repo YRI_CEU spectrum: short run (structure 1,1) finished with model code files; CWL fixed (input data as File list joined by comma, params files optional) |
| gadma_gadma-get_confidence_intervals | PASS | confidence intervals from the 10 bootstrap result table contain the known YRI_CEU values |
| gadma_gadma-get_confidence_intervals_for_ld | Not completed | needs the output of a full momentsLD GADMA run; the only real example file refers to the author's local data path |
| gadma_gadma-precompute_ld_data | PASS | repo small VCF with population map: preprocessed_data.bp is written and added to the params file (CWL stages inputs writable) |
| gadma_gadma-run_ls_on_boot_data | PASS | 10 repo bootstrap spectra of YRI_CEU with the repo moments model: estimates (nu1F about 1.9, nu2B about 0.07, m about 0.9) match the known values |

## gadma

### Tool Description
GADMA is a tool for demographic inference.

### Metadata
- **Docker Image**: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/GADMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Total Downloads**: 26.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ctlab/GADMA
- **Stars**: N/A
### Original Help Text
```text
GADMA version 2.0.3	by Ekaterina Noskova (ekaterina.e.noskova@gmail.com)
Usage: 
	gadma	-p/--params	<params_file>
		-e/--extra	<extra_params_file>


Instead/With -p/--params and -e/--extra option you can set:
	-o/--output	<output_dir>		output directory.
	-i/--input	<in.fs>/<in.txt>/	input data for demographic inference
			<in.vcf>,<popmap>	(AFS, dadi format or VCF).
	--resume	<resume_dir>		resume another launch from <resume_dir>.
	--only_models		flag to take models only from another
				launch (--resume option).

	-h/--help		show this help message and exit.
	-v/--version		show version and exit.
	--test			run test case.

In case of any questions or problems, please contact: ekaterina.e.noskova@gmail.com
```

## gadma_gadma-run_ls_on_boot_data

### Tool Description
GADMA module for runs of local search on bootstrapped data. Is needed for calculating confidence intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/GADMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Validation**: PASS

### Original Help Text
```text
[help] gadma-run_ls_on_boot_data: ok via gadma-run_ls_on_boot_data --help (--help=ok, -h=ok, -help=ok, (no args)=usage_only)
usage: GADMA module for runs of local search on bootstrapped data. Is needed for calculating confidence intervals.

       [-h] -b <dir> -d <filename> -o <dir> [-j N] [--opt log/powell]
       [-p <filename>] [-e <engine_id>]

options:
  -h, --help            show this help message and exit
  -b <dir>, --boots <dir>
                        Directory where bootstrapped data is located.
  -d <filename>, --dem_model <filename>
                        File with demographic model. Should contain
                        `model_func` or `generated_model` function. One can
                        put there several extra parameters and they will be
                        taken automatically, otherwise one will need to enter
                        them manually. Such parameters are: 1) p0 (or popt) -
                        initial parameters values 2) lower_bound - list of
                        lower bounds for parameters values 3) upper_bound -
                        list of pper bounds for parameters values 4)
                        par_labels/param_labels - list of string names for
                        parameters 6) pts - pts for dadi (if there is no pts
                        then moments will be run automatically).
  -o <dir>, --output <dir>
                        Output directory.
  -j N, --jobs N        Number of threads for parallel run.
  --opt log/powell      Local search algorithm, by now it can be: 1) `log` -
                        Inference.optimize_log 2) `powell` -
                        Inference.optimize_powell.
  -p <filename>, --params <filename>
                        Filename with parameters, should be valid python file.
                        Parameters are presented in -d/--dem_model option
                        description upper.
  -e <engine_id>, --engine <engine_id>
                        Engine to use for the demographic inference.Could be
                        one of the following: ['dadi', 'moments', 'momentsLD']
```

## gadma_gadma-get_confidence_intervals

### Tool Description
GADMA module for calculating confidence intervals from the result table of local search runs on bootstrapped data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/GADMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Validation**: PASS

### Original Help Text
```text
[help] gadma-get_confidence_intervals: ok via gadma-get_confidence_intervals --help (--help=ok, -h=ok, -help=flag_rejected, (no args)=usage_only)
usage: GADMA module for calculating confidence intervals from the result table of local search runs on bootstrapped data.
       [-h] [--log] [--tex] [--acc N] <filename>

positional arguments:
  <filename>  Filename (.csv or .pkl) with result from local search runs on
              bootstrapped data. Output of gadma-run_ls_on_boot_data.

options:
  -h, --help  show this help message and exit
  --log       If log then logarithm will be used to calculate confidence
              intervals.
  --tex       LaTex output.
  --acc N     Precision of an output (default: 5).
```

## gadma_gadma-get_confidence_intervals_for_ld

### Tool Description
GADMA module for calculating confidence intervals from calculated LD params.

### Metadata
- **Docker Image**: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/GADMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Validation**: PASS

### Original Help Text
```text
[help] gadma-get_confidence_intervals_for_ld: ok via gadma-get_confidence_intervals_for_ld --help (--help=usage_only, -h=usage_only, -help=flag_rejected, (no args)=usage_only)
usage: GADMA module for calculating confidence intervals from calculated LD params
       [-h] <filename>

positional arguments:
  <filename>  Filename (.py) with result from run on data. Output of gadma.

options:
  -h, --help  show this help message and exit
```

## gadma_gadma-precompute_ld_data

### Tool Description
GADMA module for data preprocessing with momentsLD engine.

### Metadata
- **Docker Image**: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/ctlab/GADMA
- **Package**: https://anaconda.org/channels/bioconda/packages/gadma/overview
- **Validation**: PASS

### Original Help Text
```text
[help] gadma-precompute_ld_data: ok via gadma-precompute_ld_data --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
GADMA module for data preprocessing with momentsLD engine
Usage: 
	gadma-precompute_ld_data	-p/--params	<params_file>
		-e/--extra	<extra_params_file>


Instead/With -p/--params and -e/--extra option you can set:
	-o/--output	<output_dir>		output directory.
	-i/--input	<in.fs>/<in.txt>/	input data for demographic inference
			<in.vcf>,<popmap>	(AFS, dadi format or VCF).
	--resume	<resume_dir>		resume another launch from <resume_dir>.
	--only_models		flag to take models only from another
				launch (--resume option).

	-h/--help		show this help message and exit.
	-v/--version		show version and exit.
	--test			run test case.

In case of any questions or problems, please contact: ekaterina.e.noskova@gmail.com
```

