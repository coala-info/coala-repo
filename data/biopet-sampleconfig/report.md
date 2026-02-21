# biopet-sampleconfig CWL Generation Report

## biopet-sampleconfig_extracttsv

### Tool Description
Extracts TSV information from a sample configuration JSON file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-sampleconfig:0.3--0
- **Homepage**: https://github.com/biopet/sampleconfig
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-sampleconfig/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-sampleconfig/overview
- **Total Downloads**: 13.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/sampleconfig
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for ExtractTsv

Usage: ExtractTsv [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <value>  Input sample json, can give multiple file
  --sample <value>         Sample name
  --library <value>        Library Name
  --readgroup <value>      Readgroup name
  --jsonOutput <value>     json output file
  --tsvOutput <value>      tsv output file
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.sampleconfig.extracttsv.ExtractTsv$.cmdArrayToArgs(ExtractTsv.scala:32)
	at nl.biopet.tools.sampleconfig.extracttsv.ExtractTsv$.main(ExtractTsv.scala:37)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.sampleconfig.SampleConfig$.main(SampleConfig.scala:32)
	at nl.biopet.tools.sampleconfig.SampleConfig.main(SampleConfig.scala)
```


## biopet-sampleconfig_readfromtsv

### Tool Description
Converts TSV files containing sample and library information into a Biopet configuration file (YAML or JSON).

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-sampleconfig:0.3--0
- **Homepage**: https://github.com/biopet/sampleconfig
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-sampleconfig/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
General Biopet options


Options for ReadFromTsv

Usage: ReadFromTsv [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFiles <file>  Input must be a tsv file, first line is seen as header and must at least have a 'sample' column,
 'library' column is optional, multiple files can be specified by using multiple flags.
  -t, --tagFiles <file>    This works the same as for a normal input file. Difference is that it placed in a sub key 'tags' in the config file
  -o, --outputFile <file>  
When the extension is .yml or .yaml the output is in yaml format, otherwise it is in json.
When no file is given the output goes to stdout as yaml.
```


## biopet-sampleconfig_cromwellarrays

### Tool Description
A tool to generate Cromwell arrays configuration from sample JSON or YAML files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-sampleconfig:0.3--0
- **Homepage**: https://github.com/biopet/sampleconfig
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-sampleconfig/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
General Biopet options


Options for CromwellArrays

Usage: CromwellArrays [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFile <value>  Input sample json / yml, can give multiple file
  -o, --outputFile <value>
                           Output file, if none given stdout is used
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.sampleconfig.cromwellarrays.CromwellArrays$.cmdArrayToArgs(CromwellArrays.scala:29)
	at nl.biopet.tools.sampleconfig.cromwellarrays.CromwellArrays$.main(CromwellArrays.scala:34)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.sampleconfig.SampleConfig$.main(SampleConfig.scala:32)
	at nl.biopet.tools.sampleconfig.SampleConfig.main(SampleConfig.scala)
```


## biopet-sampleconfig_casecontrol

### Tool Description
Options for CaseControl. This tool handles sample configuration for case-control studies, allowing input of BAM files and sample configurations with specific tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-sampleconfig:0.3--0
- **Homepage**: https://github.com/biopet/sampleconfig
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-sampleconfig/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFiles
Error: Missing option --sampleConfig
General Biopet options


Options for CaseControl

Usage: CaseControl [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -i, --inputFiles <file>  Input bam files
  -s, --sampleConfig <file>
                           This works the same as for a normal input file. Difference is that it placed in a sub key 'tags' in the config file
  --controlTag <tag>       This works the same as for a normal input file. Difference is that it placed in a sub key 'tags' in the config file
  -o, --outputFile <file>  Output file, if not given stdout is used
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.sampleconfig.casecontrol.CaseControl$.cmdArrayToArgs(CaseControl.scala:34)
	at nl.biopet.tools.sampleconfig.casecontrol.CaseControl$.main(CaseControl.scala:58)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.sampleconfig.SampleConfig$.main(SampleConfig.scala:32)
	at nl.biopet.tools.sampleconfig.SampleConfig.main(SampleConfig.scala)
```


## Metadata
- **Skill**: not generated
