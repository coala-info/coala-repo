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

## Machine Learning pipeline

This example shows how to put together a basic Machine Learning pipeline. It fetches a dataset from OpenML, trains a variety of machine learning models on a prediction target, and selects the best model based on some evaluation criteria.

```
#!/usr/bin/env nextflow

params.dataset_name = 'wdbc'
params.train_models = ['dummy', 'gb', 'lr', 'mlp', 'rf']
params.outdir = 'results'

workflow {
    // fetch dataset from OpenML
    ch_datasets = fetch_dataset(params.dataset_name)

    // split dataset into train/test sets
    (ch_train_datasets, ch_predict_datasets) = split_train_test(ch_datasets)

    // perform training
    (ch_models, ch_train_logs) = train(ch_train_datasets, params.train_models)

    // perform inference
    ch_predict_inputs = ch_models.combine(ch_predict_datasets, by: 0)
    (ch_scores, ch_predict_logs) = predict(ch_predict_inputs)

    // select the best model based on inference score
    ch_scores
        | max {
            new JsonSlurper().parse(it[2])['value']
        }
        | subscribe { dataset_name, model_type, score_file ->
            def score = new JsonSlurper().parse(score_file)
            println "The best model for ${dataset_name} was ${model_type}, with ${score['name']} = ${score['value']}"
        }
}

// view the entire code on GitHub ...
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
$ nextflow run ml-hyperopt -profile wave
```

It will automatically download the pipeline [GitHub repository](https://github.com/nextflow-io/ml-hyperopt) and build a Docker image on-the-fly using [Wave](https://seqera.io/wave/), thus the first execution may take a few minutes to complete depending on your network connection.

**NOTE**: Nextflow 22.10.0 or newer is required to run this pipeline with Wave.

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