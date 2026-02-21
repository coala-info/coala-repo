# biopet-bamstats CWL Generation Report

## biopet-bamstats_generate

### Tool Description
Generate statistics for a BAM file, including information about mapping quality, clipping, and region-specific stats.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-bamstats:1.0.1--0
- **Homepage**: https://github.com/biopet/bamstats
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-bamstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-bamstats/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/bamstats
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --outputDir
Error: Missing option --bam
General Biopet options


Options for Generate

Usage: Generate [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -R, --reference <file>   Fasta file of reference
  -o, --outputDir <directory>
                           Output directory
  -b, --bam <file>         Input bam file
  --bedFile <file>         Extract information for the regions specified in the bedfile.
  --scatterMode            Exclude reads from which the start originates from another region. This is useful for running multiple instances of bamstats each on a different region. The files can be merged afterwards without duplicates.
  -u, --onlyUnmapped       Only returns stats on unmapped reads. (This is excluding singletons.
  --tsvOutputs             Also output tsv files, default there is only a json
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.bamstats.generate.Generate$.cmdArrayToArgs(Generate.scala:38)
	at nl.biopet.tools.bamstats.generate.Generate$.main(Generate.scala:44)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.bamstats.BamStats$.main(BamStats.scala:29)
	at nl.biopet.tools.bamstats.BamStats.main(BamStats.scala)
```


## biopet-bamstats_merge

### Tool Description
Merge bamstats files into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-bamstats:1.0.1--0
- **Homepage**: https://github.com/biopet/bamstats
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-bamstats/overview
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
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.bamstats.merge.Merge$.cmdArrayToArgs(Merge.scala:28)
	at nl.biopet.tools.bamstats.merge.Merge$.main(Merge.scala:34)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.bamstats.BamStats$.main(BamStats.scala:29)
	at nl.biopet.tools.bamstats.BamStats.main(BamStats.scala)
```


## biopet-bamstats_validate

### Tool Description
Validate a BamStats file schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-bamstats:1.0.1--0
- **Homepage**: https://github.com/biopet/bamstats
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-bamstats/overview
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
	at nl.biopet.tools.bamstats.validate.Validate$.cmdArrayToArgs(Validate.scala:28)
	at nl.biopet.tools.bamstats.validate.Validate$.main(Validate.scala:35)
	at nl.biopet.utils.tool.multi.MultiToolCommand$class.main(MultiToolCommand.scala:39)
	at nl.biopet.tools.bamstats.BamStats$.main(BamStats.scala:29)
	at nl.biopet.tools.bamstats.BamStats.main(BamStats.scala)
```


## Metadata
- **Skill**: generated
