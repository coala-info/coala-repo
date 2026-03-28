[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](data.html)
* haptools
  + [Documentation](haptools.html)
* [examples](examples.html)

[haptools](../index.html)

* haptools
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/api/modules.rst)

---

# haptools[](#haptools "Link to this heading")

* [Documentation](haptools.html)
  + [Command line interface](haptools.html#command-line-interface)
    - [haptools](haptools.html#haptools)
      * [clump](haptools.html#haptools-clump)
      * [index](haptools.html#haptools-index)
      * [karyogram](haptools.html#haptools-karyogram)
      * [ld](haptools.html#haptools-ld)
      * [simgenotype](haptools.html#haptools-simgenotype)
      * [simphenotype](haptools.html#haptools-simphenotype)
      * [transform](haptools.html#haptools-transform)
  + [Module contents](haptools.html#module-contents)
    - [haptools.data.data module](haptools.html#module-haptools.data.data)
      * [`Data`](haptools.html#haptools.data.data.Data)
    - [haptools.data.genotypes module](haptools.html#module-haptools.data.genotypes)
      * [`Genotypes`](haptools.html#haptools.data.genotypes.Genotypes)
      * [`GenotypesPLINK`](haptools.html#haptools.data.genotypes.GenotypesPLINK)
      * [`GenotypesPLINKTR`](haptools.html#haptools.data.genotypes.GenotypesPLINKTR)
      * [`GenotypesTR`](haptools.html#haptools.data.genotypes.GenotypesTR)
      * [`GenotypesVCF`](haptools.html#haptools.data.genotypes.GenotypesVCF)
      * [`TRRecordHarmonizerRegion`](haptools.html#haptools.data.genotypes.TRRecordHarmonizerRegion)
    - [haptools.data.phenotypes module](haptools.html#module-haptools.data.phenotypes)
      * [`Phenotypes`](haptools.html#haptools.data.phenotypes.Phenotypes)
    - [haptools.data.covariates module](haptools.html#module-haptools.data.covariates)
      * [`Covariates`](haptools.html#haptools.data.covariates.Covariates)
    - [haptools.data.haplotypes module](haptools.html#module-haptools.data.haplotypes)
      * [`Extra`](haptools.html#haptools.data.haplotypes.Extra)
      * [`Haplotype`](haptools.html#haptools.data.haplotypes.Haplotype)
      * [`Haplotypes`](haptools.html#haptools.data.haplotypes.Haplotypes)
      * [`Repeat`](haptools.html#haptools.data.haplotypes.Repeat)
      * [`Variant`](haptools.html#haptools.data.haplotypes.Variant)
      * [`classproperty`](haptools.html#haptools.data.haplotypes.classproperty)
    - [haptools.data.breakpoints module](haptools.html#module-haptools.data.breakpoints)
      * [`Breakpoints`](haptools.html#haptools.data.breakpoints.Breakpoints)
    - [haptools.sim\_genotype module](haptools.html#module-haptools.sim_genotype)
      * [`get_segment()`](haptools.html#haptools.sim_genotype.get_segment)
      * [`output_vcf()`](haptools.html#haptools.sim_genotype.output_vcf)
      * [`simulate_gt()`](haptools.html#haptools.sim_genotype.simulate_gt)
      * [`start_segment()`](haptools.html#haptools.sim_genotype.start_segment)
      * [`validate_params()`](haptools.html#haptools.sim_genotype.validate_params)
      * [`write_breakpoints()`](haptools.html#haptools.sim_genotype.write_breakpoints)
    - [haptools.sim\_phenotype module](haptools.html#module-haptools.sim_phenotype)
      * [`Effect`](haptools.html#haptools.sim_phenotype.Effect)
      * [`Haplotype`](haptools.html#haptools.sim_phenotype.Haplotype)
      * [`PhenoSimulator`](haptools.html#haptools.sim_phenotype.PhenoSimulator)
      * [`Repeat`](haptools.html#haptools.sim_phenotype.Repeat)
      * [`simulate_pt()`](haptools.html#haptools.sim_phenotype.simulate_pt)
    - [haptools.karyogram module](haptools.html#module-haptools.karyogram)
      * [`GetCentromereClipMask()`](haptools.html#haptools.karyogram.GetCentromereClipMask)
      * [`GetChrom()`](haptools.html#haptools.karyogram.GetChrom)
      * [`GetChromOrder()`](haptools.html#haptools.karyogram.GetChromOrder)
      * [`GetCmRange()`](haptools.html#haptools.karyogram.GetCmRange)
      * [`GetHaplotypeBlocks()`](haptools.html#haptools.karyogram.GetHaplotypeBlocks)
      * [`GetPopList()`](haptools.html#haptools.karyogram.GetPopList)
      * [`PlotHaplotypeBlock()`](haptools.html#haptools.karyogram.PlotHaplotypeBlock)
      * [`PlotKaryogram()`](haptools.html#haptools.karyogram.PlotKaryogram)
    - [haptools.transform module](haptools.html#module-haptools.transform)
      * [`GenotypesAncestry`](haptools.html#haptools.transform.GenotypesAncestry)
      * [`HaplotypeAncestry`](haptools.html#haptools.transform.HaplotypeAncestry)
      * [`HaplotypesAncestry`](haptools.html#haptools.transform.HaplotypesAncestry)
      * [`transform_haps()`](haptools.html#haptools.transform.transform_haps)
    - [haptools.ld module](haptools.html#module-haptools.ld)
      * [`Haplotype`](haptools.html#haptools.ld.Haplotype)
      * [`calc_ld()`](haptools.html#haptools.ld.calc_ld)
      * [`pearson_corr_ld()`](haptools.html#haptools.ld.pearson_corr_ld)
    - [haptools.index module](haptools.html#module-haptools.index)
      * [`append_suffix()`](haptools.html#haptools.index.append_suffix)
      * [`index_haps()`](haptools.html#haptools.index.index_haps)
    - [haptools.clump module](haptools.html#module-haptools.clump)
      * [`ComputeExactLD()`](haptools.html#haptools.clump.ComputeExactLD)
      * [`ComputeLD()`](haptools.html#haptools.clump.ComputeLD)
      * [`GetOverlappingSamples()`](haptools.html#haptools.clump.GetOverlappingSamples)
      * [`LoadVariant()`](haptools.html#haptools.clump.LoadVariant)
      * [`SummaryStats`](haptools.html#haptools.clump.SummaryStats)
      * [`Variant`](haptools.html#haptools.clump.Variant)
      * [`WriteClump()`](haptools.html#haptools.clump.WriteClump)
      * [`clumpstr()`](haptools.html#haptools.clump.clumpstr)

[Previous](data.html "data")
[Next](haptools.html "Documentation")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).