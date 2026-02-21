# biopet-seqstat CWL Generation Report

## biopet-seqstat_generate

### Tool Description
Generate stats from FastQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seqstat:1.0.1--0
- **Homepage**: https://github.com/biopet/seqstat
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seqstat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-seqstat/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/seqstat
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --fastqR1
Error: Missing option --output
Error: Missing option --sample
Error: Missing option --library
Error: Missing option --readgroup
General Biopet options


Options for Generate

Usage: Generate [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --fastqR1 <fastq file>
                           FastQ file to generate stats from
  -j, --fastqR2 <fastq file>
                           FastQ file to generate stats from
  -o, --output <json>      File to write output to, if not supplied output go to stdout
  --sample <name>          Sample name
  --library <name>         Library name
  --readgroup <name>       Readgroup name
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.seqstat.generate.Generate$.cmdArrayToArgs(Generate.scala:32)
	at nl.biopet.tools.seqstat.generate.Generate$.main(Generate.scala:37)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.seqstat.SeqStat$.main(SeqStat.scala:30)
	at nl.biopet.tools.seqstat.SeqStat.main(SeqStat.scala)
```


## biopet-seqstat_merge

### Tool Description
Merge seqstat files into a single file

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seqstat:1.0.1--0
- **Homepage**: https://github.com/biopet/seqstat
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seqstat/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for Merge

Usage: Merge [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <seqstat file>
                           Files to merge into a single file
  -o, --outputFile <seqstat file>
                           Output file
  --combinedOutputFile <seqstat file>
                           Combined output file
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.seqstat.merge.Merge$.cmdArrayToArgs(Merge.scala:28)
	at nl.biopet.tools.seqstat.merge.Merge$.main(Merge.scala:33)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.seqstat.SeqStat$.main(SeqStat.scala:30)
	at nl.biopet.tools.seqstat.SeqStat.main(SeqStat.scala)
```


## biopet-seqstat_validate

### Tool Description
Validate a seqstat schema file

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-seqstat:1.0.1--0
- **Homepage**: https://github.com/biopet/seqstat
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-seqstat/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for Validate

Usage: Validate [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <seqstat file>
                           File to validate schema
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.seqstat.validate.Validate$.cmdArrayToArgs(Validate.scala:28)
	at nl.biopet.tools.seqstat.validate.Validate$.main(Validate.scala:33)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.seqstat.SeqStat$.main(SeqStat.scala:30)
	at nl.biopet.tools.seqstat.SeqStat.main(SeqStat.scala)
```


## Metadata
- **Skill**: generated
