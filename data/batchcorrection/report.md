# batchcorrection CWL Generation Report

## batchcorrection_batch_correction_all_loess_wrapper.r

### Tool Description
Wrapper script for batch correction, with options to use LOESS or other methods.

### Metadata
- **Docker Image**: biocontainers/batchcorrection:phenomenal-vphenomenal_2017.12.14_cv0.3.3
- **Homepage**: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/batchcorrection/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection
- **Stars**: N/A
### Original Help Text
```text
Usage: Rscript  batch_correction_docker_wrapper.R {args} 
 parameters: 
 	-h: display this help message, call all scripts with the same option and exit (optional) 
 	--loess "TRUE": call the script as "batch_correction_all_loess_wrapper.R"; otherwise call it as "batch_correction_wrapper.R" one (optional) 
 for other parameters, please refer to each script specific options and parameters. 
 
Usage: Rscript  batch_correction_all_loess_wrapper.R {args} 
 parameters: 
 	dataMatrix {file}: set the input data matrix file (mandatory) 
 	sampleMetadata {file}: set the input sample metadata file (mandatory) 
 	variableMetadata {file}: set the input variable metadata file (mandatory) 
 	method {opt}: set the method; can set to "all_loess_pool" or "all_loess_sample" (mandatory) 
 	span {condition}: set the span condition; (mandatory) 
 	dataMatrix_out {file}: set the output data matrix file (mandatory) 
 	variableMetadata_out {file}: set the output variable metadata file (mandatory) 
 	graph_output {file}: set the output graph file (mandatory) 
 	rdata_output {file}: set the output Rdata file (mandatory) 
 
Usage: Rscript  batch_correction_wrapper.R {args} 
 parameters: 
 	analyse {val}: must be set to "batch_correction" 	dataMatrix {file}: set the input data matrix file (mandatory) 
 	sampleMetadata {file}: set the input sample metadata file (mandatory) 
 	variableMetadata {file}: set the input variable metadata file (mandatory) 
 	method {opt}: set the method; can set to "linear", "lowess" or "loess" (mandatory) 
 	span {condition}: set the span condition; set to "none" if method is set to "linear" (mandatory) 
 	ref_factor {value}: set the ref_factor value; (if span value is set to NULL, optional) 
 	detail {value}: set the detail value; (if span value is set to NULL, optional) 
 	dataMatrix_out {file}: set the output data matrix file (mandatory) 
 	variableMetadata_out {file}: set the output variable metadata file (mandatory) 
 	graph_output {file}: set the output graph file (mandatory) 
 	rdata_output {file}: set the output Rdata file (mandatory)
```


## batchcorrection_batch_correction_wrapper.r

### Tool Description
Wrapper script for batch correction, can delegate to different underlying scripts based on options.

### Metadata
- **Docker Image**: biocontainers/batchcorrection:phenomenal-vphenomenal_2017.12.14_cv0.3.3
- **Homepage**: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: Rscript  batch_correction_docker_wrapper.R {args} 
 parameters: 
 	-h: display this help message, call all scripts with the same option and exit (optional) 
 	--loess "TRUE": call the script as "batch_correction_all_loess_wrapper.R"; otherwise call it as "batch_correction_wrapper.R" one (optional) 
 for other parameters, please refer to each script specific options and parameters. 
 
Usage: Rscript  batch_correction_all_loess_wrapper.R {args} 
 parameters: 
 	dataMatrix {file}: set the input data matrix file (mandatory) 
 	sampleMetadata {file}: set the input sample metadata file (mandatory) 
 	variableMetadata {file}: set the input variable metadata file (mandatory) 
 	method {opt}: set the method; can set to "all_loess_pool" or "all_loess_sample" (mandatory) 
 	span {condition}: set the span condition; (mandatory) 
 	dataMatrix_out {file}: set the output data matrix file (mandatory) 
 	variableMetadata_out {file}: set the output variable metadata file (mandatory) 
 	graph_output {file}: set the output graph file (mandatory) 
 	rdata_output {file}: set the output Rdata file (mandatory) 
 
Usage: Rscript  batch_correction_wrapper.R {args} 
 parameters: 
 	analyse {val}: must be set to "batch_correction" 	dataMatrix {file}: set the input data matrix file (mandatory) 
 	sampleMetadata {file}: set the input sample metadata file (mandatory) 
 	variableMetadata {file}: set the input variable metadata file (mandatory) 
 	method {opt}: set the method; can set to "linear", "lowess" or "loess" (mandatory) 
 	span {condition}: set the span condition; set to "none" if method is set to "linear" (mandatory) 
 	ref_factor {value}: set the ref_factor value; (if span value is set to NULL, optional) 
 	detail {value}: set the detail value; (if span value is set to NULL, optional) 
 	dataMatrix_out {file}: set the output data matrix file (mandatory) 
 	variableMetadata_out {file}: set the output variable metadata file (mandatory) 
 	graph_output {file}: set the output graph file (mandatory) 
 	rdata_output {file}: set the output Rdata file (mandatory)
```

