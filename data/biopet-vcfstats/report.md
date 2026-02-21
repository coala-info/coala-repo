# biopet-vcfstats CWL Generation Report

## biopet-vcfstats

### Tool Description
A tool to generate statistics from VCF files, including general, genotype, and sample comparison stats.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-vcfstats:1.2--0
- **Homepage**: https://github.com/biopet/vcfstats
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-vcfstats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-vcfstats/overview
- **Total Downloads**: 18.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/vcfstats
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputFile
Error: Missing option --referenceFile
Error: Missing option --outputDir
General Biopet options


Options for VcfStats

Usage: VcfStats [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputFile <file>   Input VCF file (required)
  -R, --referenceFile <file>
                           Fasta reference which was used to call input VCF (required)
  -o, --outputDir <file>   Path to directory for output (required)
  --intervals <file>       Path to interval (BED) file (optional)
  --infoTag <tag>          Summarize these info tags
  --genotypeTag <tag>      Summarize these genotype tags
  --sampleToSampleMinDepth <value>
                           Minimal depth require to consider sample to sample comparison
  --binSize <value>        Binsize in estimated base pairs
  --maxContigsInSingleJob <value>
                           Max number of bins to be combined, default is 250
  --writeBinStats          Write bin statistics. Default False
  -t, --localThreads <value>
                           Number of local threads to use
  --notWriteContigStats    Number of local threads to use
  --skipGeneral            Skipping general stats
  --skipGenotype           Skipping genotype stats
  --skipSampleDistributions
                           Skipping sample distributions stats
  --skipSampleCompare      Skipping sample compare
  --repartition            Repartition after reading records (only in spark mode)
  --executeModulesAsJobs   Execute modules as jobs (only in spark mode)
  --sparkMaster <value>    Spark master to use
  --sparkExecutorMemory <value>
                           Spark executor memory to use
  --sparkConfigValue:<key>=<value>
                           Add values to the spark config
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.vcfstats.VcfStats$.cmdArrayToArgs(VcfStats.scala:36)
	at nl.biopet.tools.vcfstats.VcfStats$.main(VcfStats.scala:43)
	at nl.biopet.tools.vcfstats.VcfStats.main(VcfStats.scala)
```


## Metadata
- **Skill**: not generated
