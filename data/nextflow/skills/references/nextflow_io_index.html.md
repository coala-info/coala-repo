[![](/img/nextflow.svg "Nextflow Logo")](/index.html)

* [Documentation](https://docs.seqera.io/nextflow/)
* [Training](http://training.nextflow.io)
* [Forums![External link](/img/assets/external-link-arrow.svg)](https://community.seqera.io/tag/nextflow)
* Examples![Expand](/img/assets/angle-down.svg)
  + [Basic pipeline](/basic-pipeline.html)
  + [Mixing scripting languages](/mixing-scripting-languages.html)
  + [BLAST pipeline](/blast-pipeline.html)
  + [RNA-Seq pipeline](/rna-seq-pipeline.html)
  + [Machine Learning pipeline](/machine-learning-pipeline.html)
  + [Simple RNAseq pipeline![External link](/img/assets/external-link-arrow.svg)](https://github.com/nextflow-io/rnaseq-nf)
  + [Implementation patterns![External link](/img/assets/external-link-arrow.svg)](http://nextflow-io.github.io/patterns/index.html)
* Tools![Expand](/img/assets/angle-down.svg)
  + [Pipelines![External link](/img/assets/external-link-arrow.svg)](https://seqera.io/pipelines/)
  + [Containers![External link](/img/assets/external-link-arrow.svg)](https://seqera.io/containers/)
  + [Plugins![External link](/img/assets/external-link-arrow.svg)](https://registry.nextflow.io/)
  + [Seqera AI![External link](/img/assets/external-link-arrow.svg)](https://seqera.io/ask-ai/)
* Resources![Expand](/img/assets/angle-down.svg)
  + [Blog![External link](/img/assets/external-link-arrow.svg)](https://seqera.io/blog/tag-nextflow/)
  + [Podcast![External link](/img/assets/external-link-arrow.svg)](https://seqera.io/podcasts/)
  + [Community forum![External link to forum page](/img/assets/external-link-arrow.svg)](https://community.seqera.io/tag/nextflow)
  + [Slack community chat![External link](/img/assets/external-link-arrow.svg)](https://www.nextflow.io/slack-invite.html)
  + [nf-core pipelines![External link](/img/assets/external-link-arrow.svg)](https://nf-co.re)
  + [About Nextflow](/about-us.html)
  + [Nextflow Ambassadors](/ambassadors.html)

* [GitHub repository](https://github.com/nextflow-io/nextflow "GitHub Repository")

# Reproducible Scientific Workflows at Scale

Nextflow enables scalable, reproducible, and portable scientific workflows for research and production use
cases.

[Documentation](https://docs.seqera.io/nextflow/)   [Community forum](https://community.seqera.io/tag/nextflow)

Open-source software supported by

  [![Seqera](/_astro/logo_seqera.CCUx983j.svg)](https://seqera.io)

> Features

## Nextflow supercharges science with reproducible containers, streamlined Git collaboration, and frictionless cloud and HPC for scale

![](/_astro/console.DH68GqIa.svg)

### Fast prototyping

Nextflow allows you to write a computational pipeline by making it simpler to put together many different
tasks.

You may reuse your existing scripts and tools and you don't need to learn a new language or API to start
using it.

![](/_astro/dna.BAxRgJca.svg)

### Reproducibility

Nextflow supports [Docker](http://docker.io) and [Singularity](http://singularity.lbl.gov/) containers technology.

This, along with the integration of the [GitHub](http://github.com) code sharing platform, allows you to write self-contained pipelines, manage versions and to rapidly reproduce
any former configuration.

![](/_astro/check.DDDQaCf1.svg)

### Continuous checkpoints

All the intermediate results produced during the pipeline execution are automatically tracked.

This allows you to resume its execution, from the last successfully executed step, no matter what the
reason was for it stopping.

![](/_astro/containers2.DeDo3aO3.svg)

### Portable

Nextflow provides an abstraction layer between your pipeline's logic and the execution layer, so that it
can be executed on multiple platforms without it changing.

It provides out of the box executors for GridEngine, SLURM, LSF, PBS, Moab and HTCondor batch schedulers
and for [Kubernetes](http://kubernetes.io/),
[Amazon AWS](http://aws.amazon.com),
[Google Cloud](https://cloud.google.com/compute/) and
[Microsoft Azure](https://azure.microsoft.com/) platforms.

![](/_astro/flow.CNJPPGdN.svg)

### Stream oriented

Nextflow extends the Unix pipes model with a fluent DSL, allowing you to handle complex stream
interactions easily.

It promotes a programming approach, based on functional composition, that results in resilient and easily
reproducible pipelines.

![](/_astro/arrow.DuYavJKX.svg)

### Unified parallelism

Nextflow is based on the *dataflow* programming model which greatly simplifies writing complex distributed
pipelines.

Parallelisation is implicitly defined by the processes input and output declarations. The resulting
applications are inherently parallel and can scale-up or scale-out, transparently, without having to adapt
to a specific platform architecture.

> Community resources

## Containers, tools and workflows for everyone

## ![Pipelines Icon](/_astro/pipelinesIcon.CovdTs30.svg)

[![nf-core](/_astro/nf-core.BgFFpwFr.png)

RNA sequencing analysis pipeline using STAR, RSEM, HISAT2 or Salmon with gene/isoform counts and extensive quality control.

nextflowpipelineworkflownf-core+ 2 more

![Star icon](/_astro/star.DX_NA36R.svg)

•198 KB•Updated 11 months ago](https://seqera.io/pipelines/rnaseq--nf-core/)[![nf-core](/_astro/nf-core.BgFFpwFr.png)

Analysis pipeline to detect germline or somatic variants (pre-processing, variant calling and annotation) from WGS / targeted sequencing

nextflowpipelineworkflownf-core+ 16 more

![Star icon](/_astro/star.DX_NA36R.svg)

•470 KB•Updated 11 months ago](https://seqera.io/pipelines/sarek--nf-core/)

[Launch pipelines![arrow](/_astro/arrow.CR_B6gkw.svg)](https://seqera.io/pipelines/)

## ![Containers Icon](/_astro/containersIcon.BZn_laH3.svg)

[![nf-core](/_astro/containersIcon.BZn_laH3.svg)bioconda::bcftools

BCFtools is a set of utilities that manipulate variant calls in the Variant Call Format (VCF) and its binary counterpart BCF.

linux/amd64linux/arm64

120k downloads•Updated 2 months ago](https://seqera.io/containers/?packages=bioconda::bcftools=1.2)[![nf-core](/_astro/containersIcon.BZn_laH3.svg)bioconda::samtools

Tools for manipulating next-generation sequencing data

linux/amd64linux/arm64

95k downloads•Updated 3 months ago](https://seqera.io/containers/?packages=pip:numpy==2.0.0rc1)

[Build containers![arrow](/_astro/arrow.CR_B6gkw.svg)](https://seqera.io/containers/)

> Next steps

### Boost your developer experience

![Visual Studio Code extension for Nextflow](/img/assets/vscode.svg)

### Boost Your Workflow with the Nextflow Extension

Streamline pipeline development right from your IDE with the official Nextflow extension for Visual Studio
Code.

[Install from VS Code Marketplace
![arrow](/_astro/arrow.CR_B6gkw.svg)](https://marketplace.visualstudio.com/items?itemName=nextflow.nextflow)

![Seqera AI assistant for Nextflow](/img/assets/seqeraai.svg)

### Got Questions? Ask AI.

Explore Seqera's AI-powered assistant to get instant answers about Nextflow, nf-core, and more — right
from the source.

 [Ask Seqera AI ![arrow](/_astro/arrow.CR_B6gkw.svg)](https://seqera.io/ask-ai/)

### Check out the documentation

The Nextflow reference manual is available at the above link.

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](https://docs.seqera.io/nextflow/)

### Look at the examples

See example code to get a feel for how Nextflow pipelines work.

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](/basic-pipeline.html)

### Follow the training

Check out the Nextflow training portal for video and written exercies to get started with Nextflow.

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](https://training.nextflow.io/latest/)

### Confused? Ask the community

Get help on the Seqera Community Forum.

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](https://community.seqera.io/)

### Report bugs or request features

Bug reports help Nextflow improve, so please report any issue you may have!

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](https://github.com/nextflow-io/nextflow/issues)

### Find pipelines

Browse open-source pipelines that you can use today, developed by the Nextflow community.

[Get Started![arrow](/_astro/arrow.CR_B6gkw.svg)](https://seqera.io/pipelines/)

---

* [![Seqera](/_astro/Logo_Seqera_white.CSFGV2Tv.svg)](https://seqera.io "Developed by Seqera")

* Resources
* [Blog](https://seqera.io/blog/tag-nextflow/)
* [Podcast](https://seqera.io/podcasts/)
* [Community forum](https://community.seqera.io/tag/nextflow)
* [Slack community chat](https://www.nextflow.io/slack-invite.html)
* [nf-core pipelines](https://nf-co.re)
* [About Nextflow](/about-us.html)
* [Nextflow Ambassadors](/ambassadors.html)

* Examples
* [Basic pipeline](/basic-pipeline.html)
* [Mixing scripting languages](/mixing-scripting-languages.html)
* [BLAST pipeline](/blast-pipeline.html)
* [RNA-Seq pipeline](/rna-seq-pipeline.html)
* [Machine Learning pipeline](/machine-learning-pipeline.html)
* [Simple RNAseq pipeline](https://github.com/nextflow-io/rnaseq-nf)
* [Implementation patterns](http://nextflow-io.github.io/patterns/index.html)

* Tools
* [Pipelines](https://seqera.io/pipelines/)
* [Containers](https://seqera.io/containers/)
* [Plugins](https://registry.nextflow.io/)
* [Seqera AI](https://seqera.io/ask-ai/)

* Documentation
* [Documentation](https://docs.seqera.io/nextflow/)

* Training
* [Training portal](http://training.nextflow.io)

* Forum
* [Community Forum](https://community.seqera.io/tag/nextflow)

* © 2026 Seqera. All Rights Reserved.