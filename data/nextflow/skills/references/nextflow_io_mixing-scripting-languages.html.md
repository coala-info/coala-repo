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

## Mixing scripting languages

With Nextflow, you are not limited to Bash scripts -- you can use any scripting language! In other words, for each *process* you can use the language that best fits the specific task or that you simply prefer.

```
#!/usr/bin/env nextflow

params.range = 100

/*
 * A trivial Perl script that produces a list of number pairs
 */
process perlTask {
    output:
    stdout

    shell:
    '''
    #!/usr/bin/env perl
    use strict;
    use warnings;

    my $count;
    my $range = !{params.range};
    for ($count = 0; $count < 10; $count++) {
        print rand($range) . ', ' . rand($range) . "\n";
    }
    '''
}

/*
 * A Python script which parses the output of the previous script
 */
process pyTask {
    input:
    stdin

    output:
    stdout

    """
    #!/usr/bin/env python
    import sys

    x = 0
    y = 0
    lines = 0
    for line in sys.stdin:
        items = line.strip().split(",")
        x += float(items[0])
        y += float(items[1])
        lines += 1

    print("avg: %s - %s" % ( x/lines, y/lines ))
    """
}

workflow {
    perlTask | pyTask | view
}
```

### Synopsis

In the above example we define a simple pipeline with two processes.

The first process executes a Perl script, because the script block definition starts
with a Perl *shebang* declaration (line 14). Since Perl uses the `$` character for variables, we use the special `shell` block instead of the normal `script` block to easily distinguish the Perl variables from the Nextflow variables.

In the same way, the second process will execute a Python script, because the script block starts with a Python shebang (line 36).

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