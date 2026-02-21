# biopet-basecounter CWL Generation Report

## biopet-basecounter

### Tool Description
A tool for counting bases in a BAM file using a refFlat file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-basecounter:0.1--0
- **Homepage**: https://github.com/biopet/basecounter
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-basecounter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-basecounter/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/basecounter
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --refFlat
Error: Missing option --outputDir
Error: Missing option --bam
General Biopet options


Options for BaseCounter

Usage: BaseCounter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -r, --refFlat <file>     refFlat file. Mandatory
  -o, --outputDir <directory>
                           Output directory. Mandatory
  -b, --bam <file>         Bam file. Mandatory
  -p, --prefix <prefix>    The prefix for the output files
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.basecounter.BaseCounter$.cmdArrayToArgs(BaseCounter.scala:35)
	at nl.biopet.tools.basecounter.BaseCounter$.main(BaseCounter.scala:39)
	at nl.biopet.tools.basecounter.BaseCounter.main(BaseCounter.scala)
```


## Metadata
- **Skill**: not generated
