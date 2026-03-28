[canu](index.html)

latest

* [Canu Quick Start](quick-start.html)
* Canu FAQ
  + [What resources does Canu require for a bacterial genome assembly? A mammalian assembly?](#what-resources-does-canu-require-for-a-bacterial-genome-assembly-a-mammalian-assembly)
  + [How do I run Canu on my SLURM / SGE / PBS / LSF / Torque system?](#how-do-i-run-canu-on-my-slurm-sge-pbs-lsf-torque-system)
  + [My run stopped with the error `'Mhap precompute jobs failed'`](#my-run-stopped-with-the-error-mhap-precompute-jobs-failed)
  + [My run stopped with the error `'Failed to submit batch jobs'`](#my-run-stopped-with-the-error-failed-to-submit-batch-jobs)
  + [My run of Canu was killed by the sysadmin; the power going out; my cat stepping on the power button; et cetera. Is it safe to restart? How do I restart?](#my-run-of-canu-was-killed-by-the-sysadmin-the-power-going-out-my-cat-stepping-on-the-power-button-et-cetera-is-it-safe-to-restart-how-do-i-restart)
  + [My genome size and assembly size are different, help!](#my-genome-size-and-assembly-size-are-different-help)
  + [What parameters should I use for my reads?](#what-parameters-should-i-use-for-my-reads)
  + [Can I assemble RNA sequence data?](#can-i-assemble-rna-sequence-data)
  + [Can I assemble amplicon sequence data?](#can-i-assemble-amplicon-sequence-data)
  + [My assembly is running out of space, is too slow?](#my-assembly-is-running-out-of-space-is-too-slow)
  + [My assembly continuity is not good, how can I improve it?](#my-assembly-continuity-is-not-good-how-can-i-improve-it)
  + [What parameters can I tweak?](#what-parameters-can-i-tweak)
  + [My asm.contigs.fasta is empty, why?](#my-asm-contigs-fasta-is-empty-why)
  + [Why is my assembly is missing my favorite short plasmid?](#why-is-my-assembly-is-missing-my-favorite-short-plasmid)
  + [Why do I get less corrected read data than I asked for?](#why-do-i-get-less-corrected-read-data-than-i-asked-for)
  + [What is the minimum coverage required to run Canu?](#what-is-the-minimum-coverage-required-to-run-canu)
  + [Can I use Illumina data too?](#can-i-use-illumina-data-too)
  + [My circular element is duplicated/has overlap?](#my-circular-element-is-duplicated-has-overlap)
  + [My genome is AT (or GC) rich, do I need to adjust parameters? What about highly repetitive genomes?](#my-genome-is-at-or-gc-rich-do-i-need-to-adjust-parameters-what-about-highly-repetitive-genomes)
  + [How can I send data to you?](#how-can-i-send-data-to-you)
* [Canu Tutorial](tutorial.html)
* [Canu Pipeline](pipeline.html)
* [Canu Parameter Reference](parameter-reference.html)
* [Software Background](history.html)

[canu](index.html)

* [Docs](index.html) »
* Canu FAQ
* [Edit on GitHub](https://github.com/marbl/canu/blob/master/documentation/source/faq.rst)

---

# Canu FAQ[¶](#canu-faq "Permalink to this headline")

* [What resources does Canu require for a bacterial genome assembly? A mammalian assembly?](#what-resources-does-canu-require-for-a-bacterial-genome-assembly-a-mammalian-assembly)
* [How do I run Canu on my SLURM / SGE / PBS / LSF / Torque system?](#how-do-i-run-canu-on-my-slurm-sge-pbs-lsf-torque-system)
* [My run stopped with the error `'Mhap precompute jobs failed'`](#my-run-stopped-with-the-error-mhap-precompute-jobs-failed)
* [My run stopped with the error `'Failed to submit batch jobs'`](#my-run-stopped-with-the-error-failed-to-submit-batch-jobs)
* [My run of Canu was killed by the sysadmin; the power going out; my cat stepping on the power button; et cetera. Is it safe to restart? How do I restart?](#my-run-of-canu-was-killed-by-the-sysadmin-the-power-going-out-my-cat-stepping-on-the-power-button-et-cetera-is-it-safe-to-restart-how-do-i-restart)
* [My genome size and assembly size are different, help!](#my-genome-size-and-assembly-size-are-different-help)
* [What parameters should I use for my reads?](#what-parameters-should-i-use-for-my-reads)
* [Can I assemble RNA sequence data?](#can-i-assemble-rna-sequence-data)
* [Can I assemble amplicon sequence data?](#can-i-assemble-amplicon-sequence-data)
* [My assembly is running out of space, is too slow?](#my-assembly-is-running-out-of-space-is-too-slow)
* [My assembly continuity is not good, how can I improve it?](#my-assembly-continuity-is-not-good-how-can-i-improve-it)
* [What parameters can I tweak?](#what-parameters-can-i-tweak)
* [My asm.contigs.fasta is empty, why?](#my-asm-contigs-fasta-is-empty-why)
* [Why is my assembly is missing my favorite short plasmid?](#why-is-my-assembly-is-missing-my-favorite-short-plasmid)
* [Why do I get less corrected read data than I asked for?](#why-do-i-get-less-corrected-read-data-than-i-asked-for)
* [What is the minimum coverage required to run Canu?](#what-is-the-minimum-coverage-required-to-run-canu)
* [Can I use Illumina data too?](#can-i-use-illumina-data-too)
* [My circular element is duplicated/has overlap?](#my-circular-element-is-duplicated-has-overlap)
* [My genome is AT (or GC) rich, do I need to adjust parameters? What about highly repetitive genomes?](#my-genome-is-at-or-gc-rich-do-i-need-to-adjust-parameters-what-about-highly-repetitive-genomes)
* [How can I send data to you?](#how-can-i-send-data-to-you)

## [What resources does Canu require for a bacterial genome assembly? A mammalian assembly?](#id1)[¶](#what-resources-does-canu-require-for-a-bacterial-genome-assembly-a-mammalian-assembly "Permalink to this headline")

> Canu will detect available resources and configure itself to run efficiently using those
> resources. It will request resources, for example, the number of compute threads to use, Based
> on the genome size being assembled. It will fail to even start if it feels there are
> insufficient resources available.
>
> A typical bacterial genome can be assembled with 8GB memory in a few CPU hours - around an hour
> on 8 cores. It is possible, but not allowed by default, to run with only 4GB memory.
>
> A well-behaved large genome, such as human or other mammals, can be assembled in 10,000 to
> 25,000 CPU hours, depending on coverage from raw data. A well-behaved large genome, such as human or other mammals with HiFi data can be assembled in 1,000 to 2,000 CPU hours. A grid environment is strongly recommended, with at
> least 16GB available on each compute node, and one node with at least 64GB memory. You should
> plan on having 3TB free disk space (200 GB for HiFi), much more for highly repetitive genomes.
>
> Our compute nodes have 48 compute threads and 128GB memory, with a few larger nodes with up to
> 1TB memory. We develop and test (mostly bacteria, yeast and drosophila) on laptops and desktops
> with 4 to 12 compute threads and 16GB to 64GB memory.

## [How do I run Canu on my SLURM / SGE / PBS / LSF / Torque system?](#id2)[¶](#how-do-i-run-canu-on-my-slurm-sge-pbs-lsf-torque-system "Permalink to this headline")

> Canu will detect and configure itself to use on most grids. You do not need to submit Canu to the grid in this case.
> Canu will query the system for grid support, configure itself for the machines available in the grid,
> then submit itself to the grid for execution. You can then monitor the run using your grid.
>
> Canu will NOT request
> explicit time limits or queues/partitions. You can supply your own grid options, such as a partition on SLURM, an account code
> on SGE, and/or time limits with `gridOptions="<your options list>"` which will passed to every job
> submitted by Canu. Similar options exist for every stage of Canu, which could be used to, for example,
> restrict overlapping to a specific partition or queue.
>
> To disable grid support and run only on the local machine, specify `useGrid=false`
>
> It is possible to limit the number of grid jobs running at the same time, but this isn’t
> directly supported by Canu. The various [gridOptions](parameter-reference.html#grid-options) parameters
> can pass grid-specific parameters to the submit commands used; see
> [Issue #756](https://github.com/marbl/canu/issues/756) for Slurm and SGE examples.

## [My run stopped with the error `'Mhap precompute jobs failed'`](#id3)[¶](#my-run-stopped-with-the-error-mhap-precompute-jobs-failed "Permalink to this headline")

> Several package managers make a mess of the installation causing this error (conda and ubuntu in particular). Package managers don’t add much benefit to a tool like Canu which is distributed as pre-compiled binaries compatible with most systems so our recommended installation method is downloading a binary release. Try running the assembly from scratch using our release distribution and if you continue to encounter errors, submit an issue.

## [My run stopped with the error `'Failed to submit batch jobs'`](#id4)[¶](#my-run-stopped-with-the-error-failed-to-submit-batch-jobs "Permalink to this headline")

> The grid you run on must allow compute nodes to submit jobs. This means that if you are on a
> compute host, `qsub/bsub/sbatch/etc` must be available and working. You can test this by
> starting an interactive compute session and running the submit command manually (e.g. `qsub`
> on SGE, `bsub` on LSF, `sbatch` on SLURM).
>
> If this is not the case, Canu **WILL NOT** work on your grid. You must then set
> `useGrid=false` and run on a single machine. Alternatively, you can run Canu with
> `useGrid=remote` which will stop at every submit command, list what should be submitted. You
> then submit these jobs manually, wait for them to complete, and run the Canu command again. This
> is a manual process but currently the only workaround for grids without submit support on the
> compute nodes.

## [My run of Canu was killed by the sysadmin; the power going out; my cat stepping on the power button; et cetera. Is it safe to restart? How do I restart?](#id5)[¶](#my-run-of-canu-was-killed-by-the-sysadmin-the-power-going-out-my-cat-stepping-on-the-power-button-et-cetera-is-it-safe-to-restart-how-do-i-restart "Permalink to this headline")

> Yes, perfectly safe! It’s actually how Canu runs normally: each time Canu starts, it examines
> the state of the assembly to decide what it should do next. For example, if six overlap tasks
> have no results, it’ll run just those six tasks.
>
> This also means that if you want to redo some step, just remove those results from the assembly
> directory. Some care needs to be taken to make sure results computed after those are also
> removed.
>
> Short answer: just rerun the \_exact\_ same command as before. It’ll do the right thing.

## [My genome size and assembly size are different, help!](#id6)[¶](#my-genome-size-and-assembly-size-are-different-help "Permalink to this headline")

> The difference could be due to a heterozygous genome where the assembly separated some loci. It could also be because the previous estimate is incorrect. We typically use two analyses to see what happened. First, a [BUSCO](https://busco.ezlab.org) analysis will indicate duplicated genes. For example this assembly:
>
> ```
> INFO      C:98.5%[S:97.9%,D:0.6%],F:1.0%,M:0.5%,n:2799
> INFO      2756 Complete BUSCOs (C)
> INFO      2740 Complete and single-copy BUSCOs (S)
> INFO      16 Complete and duplicated BUSCOs (D)
> ```
>
> does not have much duplication but this assembly:
>
> ```
> INFO      C:97.6%[S:15.8%,D:81.8%],F:0.9%,M:1.5%,n:2799
> INFO      2732 Complete BUSCOs (C)
> INFO      443 Complete and single-copy BUSCOs (S)
> INFO      2289 Complete and duplicated BUSCOs (D)
> ```
>
> does. We have had success using [purge\_dups](https://github.com/dfguan/purge_dups) to remove duplication. Purge dups will also generate a coverage histogram which will usually have two peaks when assemblies have separated some loci, make sure to inspect it to make sure the cutoffs selected are reasonable.

## [What parameters should I use for my reads?](#id7)[¶](#what-parameters-should-i-use-for-my-reads "Permalink to this headline")

> Canu is designed to be universal on a large range of PacBio CLR, PacBio HiFi, Oxford
> Nanopore (R6 through R10) data. Assembly quality and/or efficiency can be enhanced for specific
> datatypes:
>
> **Nanopore R7 1D** and **Low Identity Reads**
> :   With R7 1D sequencing data, and generally for any raw reads lower than 80% identity, five to
>     ten rounds of error correction are helpful:
>
>     ```
>     canu -p r1 -d r1 -correct corOutCoverage=500 corMinCoverage=0 corMhapSensitivity=high -nanopore-raw your_reads.fasta
>     canu -p r2 -d r2 -correct corOutCoverage=500 corMinCoverage=0 corMhapSensitivity=high -nanopore-raw r1/r1.correctedReads.fasta.gz
>     canu -p r3 -d r3 -correct corOutCoverage=500 corMinCoverage=0 corMhapSensitivity=high -nanopore-raw r2/r2.correctedReads.fasta.gz
>     canu -p r4 -d r4 -correct corOutCoverage=500 corMinCoverage=0 corMhapSensitivity=high -nanopore-raw r3/r3.correctedReads.fasta.gz
>     canu -p r5 -d r5 -correct corOutCoverage=500 corMinCoverage=0 corMhapSensitivity=high -nanopore-raw r4/r4.correctedReads.fasta.gz
>     ```
>
>     Then assemble the output of the last round, allowing up to 30% difference in overlaps:
>
>     ```
>     canu -p asm -d asm correctedErrorRate=0.3 utgGraphDeviation=50 -nanopore-corrected r5/r5.correctedReads.fasta.gz
>     ```
>
> **Nanopore R7 2D** and **Nanopore R9 1D**
> :   The defaults were designed with these datasets in mind so they should work. Having very high
>     coverage or very long Nanopore reads can slow down the assembly significantly. You can try the
>     `-fast` option which is much faster but may produce less
>     contiguous assemblies on large genomes.
>
> **Nanopore flip-flop R9.4 or R10.3**
> :   Based on a human dataset, the flip-flop basecaller reduces both the raw read error rate and the residual error rate remaining after Canu read correction. For this reason you can reduce the error tolerated by Canu. If you have over 30x coverage add the options: `'corMhapOptions=--threshold 0.8 --ordered-sketch-size 1000 --ordered-kmer-size 14' correctedErrorRate=0.105`. This is primarily a speed optimization so you can use defaults, especially if your genome’s accuracy is not improved by the flip-flop caller.
>
> **PacBio Sequel**
> :   > Based on an *A. thaliana* [dataset](http://www.pacb.com/blog/sequel-system-data-release-arabidopsis-dataset-genome-assembly/),
>     > and a few more recent mammalian genomes, slightly increase the maximum allowed difference from the default of 4.5% to 8.5% with
>     > `correctedErrorRate=0.085 corMhapSensitivity=normal`.
>
>     Only add the second parameter (`corMhapSensivity=normal`) if you have >50x coverage.
>
> **PacBio Sequel II**
> :   The defaults for PacBio should work on this data. You could speed up the assembly by decreasing the error rate from the default, especially if you have high (>50x) coverage via `correctedErrorRate=0.035 utgOvlErrorRate=0.065 trimReadsCoverage=2 trimReadsOverlap=500`
>
> **PacBio HiFi**
> :   The defaults for -pacbio-hifi should work on this data. There is still some variation in data quality bet