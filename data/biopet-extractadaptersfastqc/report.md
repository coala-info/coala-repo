# biopet-extractadaptersfastqc CWL Generation Report

## biopet-extractadaptersfastqc

### Tool Description
Extracts adapters and contaminations from FastQC data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-extractadaptersfastqc:0.2--1
- **Homepage**: https://github.com/biopet/extractadaptersfastqc
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-extractadaptersfastqc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-extractadaptersfastqc/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/extractadaptersfastqc
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for ExtractAdaptersFastqc

Usage: ExtractAdaptersFastqc [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <value>  Fastqc data file (i.e., fastqc_data.txt file in the FastQC output)
  --adapterOutputFile <value>
                           Output file for adapters, if not supplied output will go to stdout
  --contamsOutputFile <value>
                           Output file for adapters, if not supplied output will go to stdout
  --skipContams            If this is set only the adapters block is used, other wise contaminations is also used
  --knownContamFile <value>
                           This file should contain the known contaminations from fastqc
  --knownAdapterFile <value>
                           This file should contain the known adapters from fastqc
  --adapterCutoff <value>  The fraction of the adapters in a read should be above this fraction, default is 0.001
  --outputAsFasta          Output in fasta format, default only sequences
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc$.cmdArrayToArgs(ExtractAdaptersFastqc.scala:31)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc$.main(ExtractAdaptersFastqc.scala:36)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc.main(ExtractAdaptersFastqc.scala)
```


## Metadata
- **Skill**: generated

## biopet-extractadaptersfastqc

### Tool Description
Extracts adapters and contaminations from FastQC data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-extractadaptersfastqc:0.2--1
- **Homepage**: https://github.com/biopet/extractadaptersfastqc
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-extractadaptersfastqc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for ExtractAdaptersFastqc

Usage: ExtractAdaptersFastqc [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <value>  Fastqc data file (i.e., fastqc_data.txt file in the FastQC output)
  --adapterOutputFile <value>
                           Output file for adapters, if not supplied output will go to stdout
  --contamsOutputFile <value>
                           Output file for adapters, if not supplied output will go to stdout
  --skipContams            If this is set only the adapters block is used, other wise contaminations is also used
  --knownContamFile <value>
                           This file should contain the known contaminations from fastqc
  --knownAdapterFile <value>
                           This file should contain the known adapters from fastqc
  --adapterCutoff <value>  The fraction of the adapters in a read should be above this fraction, default is 0.001
  --outputAsFasta          Output in fasta format, default only sequences
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc$.cmdArrayToArgs(ExtractAdaptersFastqc.scala:31)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc$.main(ExtractAdaptersFastqc.scala:36)
	at nl.biopet.tools.extractadaptersfastqc.ExtractAdaptersFastqc.main(ExtractAdaptersFastqc.scala)
```

