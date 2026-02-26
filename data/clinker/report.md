# clinker CWL Generation Report

## clinker

### Tool Description
Clinker Wrapper Script
The command clinker will invoke the Clinker bpipe pipeline with simple options. Use the direct pipeline method to use any advanced bpipe features.
See https://github.com/Oshlack/Clinker/wiki/ for further information onusing Clinker.

### Metadata
- **Docker Image**: quay.io/biocontainers/clinker:1.33--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/Clinker
- **Package**: https://anaconda.org/channels/bioconda/packages/clinker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clinker/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Oshlack/Clinker
- **Stars**: N/A
### Original Help Text
```text
___         ___             ___         ___         ___         ___     
     /\  \       /\__\  ___      /\__\       /\__\       /\  \       /\  \    
    /::\  \     /:/  / /\  \    /::|  |     /:/  /      /::\  \     /::\  \   
   /:/\:\  \   /:/  /  \:\  \  /:|:|  |    /:/__/      /:/\:\  \   /:/\:\  \  
  /:/  \:\  \ /:/  /   /::\__\/:/|:|  |__ /::\__\____ /::\~\:\  \ /::\~\:\  \ 
 /:/__/ \:\__/:/__/ __/:/\/__/:/ |:| /\__/:/\:::::\__/:/\:\ \:\__/:/\:\ \:\__\ 
 \:\  \  \/__\:\  \/\/:/  /  \/__|:|/:/  \/_|:|~~|~  \:\~\:\ \/__\/_|::\/:/  / 
  \:\  \      \:\  \::/__/       |:/:/  /   |:|  |    \:\ \:\__\    |:|::/  / 
   \:\  \      \:\  \:\__\       |::/  /    |:|  |     \:\ \/__/    |:|\/__/  
    \:\__\      \:\__\/__/       /:/  /     |:|  |      \:\__\      |:|  |    
     \/__/       \/__/           \/__/       \|__|       \/__/       \|__|    

Clinker Wrapper Script

The command clinker will invoke the Clinker bpipe pipeline with simple options. Use the direct pipeline method to use any advanced bpipe features.
See https://github.com/Oshlack/Clinker/wiki/ for further information onusing Clinker.


usage (info): clinker [-h] 

usage (wrapper): clinker -w [-p option1="values" -p option2="values" ...]" *.fastq.gz 

usage (direct):
 export $CLINKERDIR=/usr/local/share/clinker-1.33-0;
 bpipe run  [-p option1="values" -p option2="values" ...] [ <other bpipe options >] 
	 $CLINKERDIR/workflow/clinker.pipe *.fastq.gz
```

