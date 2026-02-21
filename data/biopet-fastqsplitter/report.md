# biopet-fastqsplitter CWL Generation Report

## biopet-fastqsplitter

### Tool Description
A tool for splitting FastQ files into multiple output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-fastqsplitter:0.1--2
- **Homepage**: https://github.com/biopet/fastq-splitter
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-fastqsplitter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-fastqsplitter/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/fastq-splitter
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
Error: Missing option --outputFile
General Biopet options


Options for FastqSplitter

Usage: FastqSplitter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Path to input file
  -o, --outputFile <file>  Path to output file. Multiple output files can be specified.
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.fastqsplitter.FastqSplitter$.cmdArrayToArgs(FastqSplitter.scala:31)
	at nl.biopet.tools.fastqsplitter.FastqSplitter$.main(FastqSplitter.scala:40)
	at nl.biopet.tools.fastqsplitter.FastqSplitter.main(FastqSplitter.scala)
```


## Metadata
- **Skill**: not generated
