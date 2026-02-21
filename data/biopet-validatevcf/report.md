# biopet-validatevcf CWL Generation Report

## biopet-validatevcf

### Tool Description
A tool to validate a VCF file against a reference fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-validatevcf:0.1--0
- **Homepage**: https://github.com/biopet/validatevcf
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-validatevcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-validatevcf/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/validatevcf
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputVcf
Error: Missing option --reference
General Biopet options


Options for ValidateVcf

Usage: ValidateVcf [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputVcf <file>    Vcf file to check
  -R, --reference <file>   Reference fasta to check vcf file against
  --disableFail            Do not fail on error. The tool will still exit when encountering an error, but will do so with exit code 0
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.validatevcf.ValidateVcf$.cmdArrayToArgs(ValidateVcf.scala:30)
	at nl.biopet.tools.validatevcf.ValidateVcf$.main(ValidateVcf.scala:34)
	at nl.biopet.tools.validatevcf.ValidateVcf.main(ValidateVcf.scala)
```


## Metadata
- **Skill**: not generated
