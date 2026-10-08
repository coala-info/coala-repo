# mintie CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mintie_run | Not completed | pipeline, skipped: mintie runs the whole MINTIE bpipe pipeline and needs hg38 references; rewritten to call the mintie wrapper instead of bare bpipe |

## mintie_run

### Tool Description
MINTIE wrapper script: invokes the MINTIE bpipe pipeline on case and control FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
- **Homepage**: https://github.com/Oshlack/MINTIE
- **Package**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mintie/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Oshlack/MINTIE
- **Stars**: N/A
### Original Help Text
```text
  __  __ ___ _   _ _____ ___ _____
 |  \/  |_ _| \ | |_   _|_ _| ____|
 | |\/| || ||  \| | | |  | ||  _|
 | |  | || || |\  | | |  | || |___
 |_|  |_|___|_| \_| |_| |___|_____|

Method for Inferring Novel Transcripts and Isoforms using Equivalences classes

MINTIE wrapper script

Invokes the MINTIE bpipe pileline.
See https://github.com/Oshlack/MINTIE/wiki/ for further information on using MINTIE.

usage (info): mintie [-h] 

usage (setup references): mintie -r 

usage (setup test data): mintie -t 

usage (wrapper): mintie -w -p [params.txt] cases/*.fastq.gz controls/*.fastq.gz 

usage (direct):
 export $MINTIEDIR=/usr/local/share/mintie-0.4.3-0;
 bpipe run -@$MINTIEDIR/params.txt  [ <other bpipe options >] 
	 $MINTIEDIR/MINTIE.groovy cases/*.fastq.gz controls/*fastq.gz

usage (direct single-end):
 export $MINTIEDIR=/usr/local/share/mintie-0.4.3-0;
 bpipe run -@$MINTIEDIR/params.txt  [ <other bpipe options >] 
	 $MINTIEDIR/MINTIE_SE.groovy cases/*.fastq.gz controls/*fastq.gz
```


## Metadata
- **Skill**: generated
