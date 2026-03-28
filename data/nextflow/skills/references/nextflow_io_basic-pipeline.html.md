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

## Basic pipeline

This pipeline shows how to write a pipeline with two simple Bash processes. The first process splits a string into chunks, and the second process converts the lowercase letters in each chunk to uppercase. It also shows how to publish pipeline outputs to named directories.

```
// Default parameter input
params.str = "Hello world!"

// split process
process split {
    input:
    val x

    output:
    path 'chunk_*'

    script:
    """
    printf '${x}' | split -b 6 - chunk_
    """
}

// convert_to_upper process
process convert_to_upper {
    tag "$y"

    input:
    path y

    output:
    path 'upper_*'

    script:
    """
    cat $y | tr '[a-z]' '[A-Z]' > upper_${y}
    """
}

// Workflow block
workflow {
    main:
    ch_str = channel.of(params.str)
    ch_chunks = split(ch_str)
    ch_upper = convert_to_upper(ch_chunks.flatten())

    publish:
    lower = ch_chunks.flatten()
    upper = ch_upper
}

output {
    lower {
        path 'lower'
    }
    upper {
        path 'upper'
    }
}
```

### Synopsis

This pipeline defines two processes:

• `split`: takes a string as input, splits it into 6-byte chunks, and writes the chunks to files with the prefix `chunk_`

• `convert_to_upper`: takes files as input, transforms their contents to uppercase letters, and writes the uppercase strings to files with the prefix `upper_`

The `split` output is emitted as a single element containing all chunk files. The `flatten` operator splits this combined element so that each file is treated as a sole element and processed independently by `convert_to_upper`.

The `workflow` block is organized into two sections:

• `main:` defines the workflow logic and how processes are connected via channels

• `publish:` declares which channels should be published as workflow outputs

The `output` block (outside the workflow) defines where and how each output should be published. In this example, the outputs from both processes are published in subdirectories (`lower` and `upper`) in the default results output directory (`params.outdir`).

To run this pipeline:

1. [Install Nextflow](https://docs.seqera.io/nextflow/install) (version 25.10 or later)

2. Create a new file named `main.nf` in your current directory

3. Copy and save the above script to your new file

4. Run your pipeline:

```
nextflow run main.nf
```

See [Your first script](https://docs.seqera.io/nextflow/your-first-script) for more information about this pipeline.

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