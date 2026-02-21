# biopet-validateannotation CWL Generation Report

## biopet-validateannotation

### Tool Description
A tool to validate annotation files such as Refflat, GTF, and check them against a reference fasta.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-validateannotation:0.1--0
- **Homepage**: https://github.com/biopet/validateannotation
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-validateannotation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-validateannotation/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/validateannotation
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --reference
General Biopet options


Options for ValidateAnnotation

Usage: ValidateAnnotation [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -r, --refflatFile <file>
                           Refflat file to check
  -g, --gtfFile <file>     Gtf files to check
  -R, --reference <file>   Reference fasta to check vcf file against
  --disableFail            Do not fail on error. The tool will still exit when encountering an error, but will do so with exit code 0
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.validateannotation.ValidateAnnotation$.cmdArrayToArgs(ValidateAnnotation.scala:33)
	at nl.biopet.tools.validateannotation.ValidateAnnotation$.main(ValidateAnnotation.scala:37)
	at nl.biopet.tools.validateannotation.ValidateAnnotation.main(ValidateAnnotation.scala)
```


## Metadata
- **Skill**: not generated
