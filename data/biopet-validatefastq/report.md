# biopet-validatefastq CWL Generation Report

## biopet-validatefastq

### Tool Description
A tool to validate FASTQ files, supporting both single-end and paired-end data.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-validatefastq:0.1.1--1
- **Homepage**: https://github.com/biopet/validatefastq
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-validatefastq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-validatefastq/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/validatefastq
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --fastq1
General Biopet options


Options for ValidateFastq

Usage: ValidateFastq [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --fastq1 <file>      FASTQ file to be validated. (Required)
  -j, --fastq2 <file>      Second FASTQ to be validated if FASTQs are paired. (Optional)
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.validatefastq.ValidateFastq$.cmdArrayToArgs(ValidateFastq.scala:31)
	at nl.biopet.tools.validatefastq.ValidateFastq$.main(ValidateFastq.scala:35)
	at nl.biopet.tools.validatefastq.ValidateFastq.main(ValidateFastq.scala)
```


## Metadata
- **Skill**: not generated
