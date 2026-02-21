# biopet-vcffilter CWL Generation Report

## biopet-vcffilter

### Tool Description
A tool for filtering VCF files based on various criteria such as depth, genotypes, and trio relationships.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet-vcffilter:0.2--0
- **Homepage**: https://github.com/biopet/vcffilter
- **Package**: https://anaconda.org/channels/bioconda/packages/biopet-vcffilter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biopet-vcffilter/overview
- **Total Downloads**: 4.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biopet/vcffilter
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Error: Missing option --inputVcf
Error: Missing option --outputVcf
General Biopet options


Options for VcfFilter

Usage: VcfFilter [options]

  -l, --log_level <value>  Level of log information printed. Possible levels: 'debug', 'info', 'warn', 'error'
  -h, --help               Print usage
  -v, --version            Print version
  -I, --inputVcf <file>    Input vcf file
  -o, --outputVcf <file>   Output vcf file
  --invertedOutputVcf <file>
                           inverted output vcf file
  --minSampleDepth <int>   Min value for DP in genotype fields
  --minTotalDepth <int>    Min value of DP field in INFO fields
  --minAlternateDepth <int>
                           Min value of AD field in genotype fields
  --minSamplesPass <int>   Min number off samples to pass --minAlternateDepth, --minBamAlternateDepth and --minSampleDepth
  --resToDom <child:father:mother>
                           Only shows variants where child is homozygous and both parants hetrozygous
  --trioCompound <child:father:mother>
                           Only shows variants where child is a compound variant combined from both parants
  --deNovoInSample <sample>
                           Only show variants that contain unique alleles in complete set for given sample
  --deNovoTrio <child:father:mother>
                           Only show variants that are denovo in the trio
  --trioLossOfHet <child:father:mother>
                           Only show variants where a loss of hetrozygosity is detected
  --mustHaveVariant <sample>
                           Given sample must have 1 alternative allele
  --mustNotHaveVariant <sample>
                           Given sample may not have alternative alleles
  --calledIn <sample>      Must be called in this sample
  --mustHaveGenotype <sample:genotype>
                           Must have genotoype <genotype> for this sample. Genotype can be NO_CALL, HOM_REF, HET, HOM_VAR, UNAVAILABLE, MIXED
  --diffGenotype <sample:sample>
                           Given samples must have a different genotype
  --filterHetVarToHomVar <sample:sample>
                           If variants in sample 1 are heterogeneous and alternative alleles are homogeneous in sample 2 variants are filtered
  --filterRefCalls         Filter when there are only ref calls
  --filterNoCalls          Filter when there are only no calls
  --uniqueOnly             Filter when there more then 1 sample have this variant
  --sharedOnly             Filter when not all samples have this variant
  --minCalled <value>      Number of sample where a call must be made
  --minQualScore <value>   Min qual score
  --id <value>             Id that may pass the filter
  --idFile <value>         File that contain list of IDs to get from vcf file
  --minGenomeQuality <value>
                           The minimum value in the Genome Quality field.
  --advancedGroups <value>
                           All members of groups sprated with a ','
  --minAvgVariantGQ <value>
                           Filter on the average GQ of variants
  --infoArrayMustContain:<key>=<value>
                           Info field must be a array and should match the given regex
Exception in thread "main" java.lang.IllegalArgumentException
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at nl.biopet.utils.tool.ToolCommand$$anonfun$cmdArrayToArgs$1.apply(ToolCommand.scala:57)
	at scala.Option.getOrElse(Option.scala:121)
	at nl.biopet.utils.tool.ToolCommand$class.cmdArrayToArgs(ToolCommand.scala:57)
	at nl.biopet.tools.vcffilter.VcfFilter$.cmdArrayToArgs(VcfFilter.scala:37)
	at nl.biopet.tools.vcffilter.VcfFilter$.main(VcfFilter.scala:41)
	at nl.biopet.tools.vcffilter.VcfFilter.main(VcfFilter.scala)
```


## Metadata
- **Skill**: not generated
