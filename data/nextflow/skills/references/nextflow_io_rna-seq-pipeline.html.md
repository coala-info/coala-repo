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

### All examples

* [Basic pipeline](basic-pipeline.html)
* [Mixing scripting languages](mixing-scripting-languages.html)
* [BLAST pipeline](blast-pipeline.html)
* [RNA-Seq pipeline](rna-seq-pipeline.html)
* [Machine Learning pipeline](machine-learning-pipeline.html)

## RNA-Seq pipeline

This example shows how to put together a basic RNA-Seq pipeline. It maps a collection of read-pairs to a given reference genome and outputs the respective transcript model.

```
#!/usr/bin/env nextflow

/*
 * The following pipeline parameters specify the reference genomes
 * and read pairs and can be provided as command line options
 */
params.reads = "$baseDir/data/ggal/ggal_gut_{1,2}.fq"
params.transcriptome = "$baseDir/data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa"
params.outdir = "results"

workflow {
    read_pairs_ch = channel.fromFilePairs( params.reads, checkIfExists: true )

    INDEX(params.transcriptome)
    FASTQC(read_pairs_ch)
    QUANT(INDEX.out, read_pairs_ch)
}

process INDEX {
    tag "$transcriptome.simpleName"

    input:
    path transcriptome

    output:
    path 'index'

    script:
    """
    salmon index --threads $task.cpus -t $transcriptome -i index
    """
}

process FASTQC {
    tag "FASTQC on $sample_id"
    publishDir params.outdir

    input:
    tuple val(sample_id), path(reads)

    output:
    path "fastqc_${sample_id}_logs"

    script:
    """
    fastqc.sh "$sample_id" "$reads"
    """
}

process QUANT {
    tag "$pair_id"
    publishDir params.outdir

    input:
    path index
    tuple val(pair_id), path(reads)

    output:
    path pair_id

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}
```

### Try it in your computer

To run this pipeline on your computer, you will need:

* Unix-like operating system
* Java 17 (or higher)
* Docker

Install Nextflow by entering the following command in the terminal:

```
$ curl -fsSL get.nextflow.io | bash
```

Then launch the pipeline with this command:

```
$ nextflow run rnaseq-nf -with-docker
```

It will automatically download the pipeline [GitHub repository](https://github.com/nextflow-io/rnaseq-nf) and the associated Docker images, thus the first execution may take a few minutes to complete depending on your network connection.

**NOTE**: To run this example with versions of Nextflow older than 22.04.0, you must include the `-dsl2` flag with `nextflow run`.

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