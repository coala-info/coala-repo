# biopet-scatterregions CWL Generation Report

## biopet-scatterregions

### Tool Description
A tool to scatter genomic regions into smaller chunks, potentially based on a reference fasta or BAM file index.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-scatterregions:0.2--0
- **Homepage**: https://github.com/biopet/scatterregions
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-scatterregions/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-scatterregions/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/scatterregions
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --outputDir
Error: Missing option --referenceFasta
General Biopet options


Options for ScatterRegions

Usage: ScatterRegions [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -o, --outputDir <value>  Output directory
  -R, --referenceFasta <value>
                           Reference fasta file, (dict file should be next to it)
  -s, --scatterSize <value>
                           Approximately scatter size, tool will make all scatters the same size. default = 1000000
  -L, --regions <value>    If given only regions in the given bed file will be used for scattering
  --notCombineContigs      If set each scatter can only contain 1 contig
  --maxContigsInScatterJob <value>
                           If set each scatter can only contain 1 contig
  --bamFile <value>        When given the regions will be scattered based on number of reads in the index file
  --notSplitContigs        When this option is set contigs are not split.
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.scatterregions.ScatterRegions$.cmdArrayToArgs(ScatterRegions.scala:36)
	at nl.biopet.tools.scatterregions.ScatterRegions$.main(ScatterRegions.scala:41)
	at nl.biopet.tools.scatterregions.ScatterRegions.main(ScatterRegions.scala)
```


## Metadata
- **Skill**: not generated
