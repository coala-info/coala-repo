[UCSC Computational Genomics Lab](https://cgl.genomics.ucsc.edu/)

* [Documentation](https://toil.readthedocs.io/)
* [GitHub](https://github.com/BD2KGenomics/toil)

# Toil

A scalable, efficient, cross-platform pipeline management system written entirely in Python and designed around the principles of functional programming.

[Get Started](http://toil.readthedocs.io/en/latest)

## Get Started

### Download

Installing Toil is as easy as:
`$ pip install toil`
 For more info, see the [installation instructions](http://toil.readthedocs.io/en/latest/gettingStarted/install.html) and [release notes](https://github.com/BD2KGenomics/toil/releases/latest).

### Documentation

Installation instructions, a quickstart guide, and full [documentation](https://toil.readthedocs.io/) on the latest stable release can be found at Read the Docs.

### Support

If the [documentation](https://toil.readthedocs.io/) doesn't answer your question, feel free to reach out on [Gitter](https://gitter.im/bd2k-genomics-toil/Lobby) or open an [issue on GitHub](https://github.com/BD2KGenomics/toil/issues).

## Features

### Pythonic

Easily mastered, the Python user API for defining and running workflows is built on one core class. Also, everything is open source under the Apache License.

### Robust

Toil workflows support arbitrary worker and leader failure, with strong check-pointing that always allows resumption.

### Efficient

Caching, fine grained, per task, resource requirement specifications, and support for the AWS spot market mean workflows can be executed with little waste.

![](https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Noun_project_1841.svg/2000px-Noun_project_1841.svg.png)

## Cloud. Scalable.

To demonstrate Toil, we processed over 20,000 RNA-seq samples to create a consistent meta-analysis of five datasets free of computational batch effects that we make freely available. Nearly all the samples were analysed in under four days using a commercial cloud cluster of 32,000 preemptable cores. [Read our paper.](http://biorxiv.org/content/early/2016/07/07/062497)

### Built for the cloud

Develop and test on your laptop, then deploy on Microsoft Azure, Amazon Web Services (including the spot market), Google Compute Engine, OpenStack, or on an individual machine.

### Strongly scalable

Build a workflow on your laptop, then scale to the cloud and run it concurrently on hundreds of nodes and thousands of cores with ease. We've tested it with [32,000 preemptable cores](http://biorxiv.org/content/early/2016/07/07/062497) so far, but Toil can handle more.

### Service integration

Toil plays nice with databases and services, such as Apache Spark. Service clusters can be created quickly and easily integrated with a Toil workflow, with precisely defined start and end times that fits with the flow of other jobs in the workflow.

### Common Workflow Language

The [Common Workflow Language](http://www.commonwl.org) is an open standard for writing portable workflows. Toil has full support for the v1.0, v1.1, and v1.2 CWL standards. [Read more.](http://toil.readthedocs.io/en/latest/running/cwl.html)

### Declarative and dynamic workflows

Workflows can be declared statically, but new jobs can be added dynamically during execution within any existing job, allowing arbitrarily complex workflow graphs with millions of jobs within them.

### Complete file and stream management

Temporary and persistent file management that abstracts the details of the underlying file system, providing a uniform interface regardless of environment. Supports both atomic file transfer and streaming interfaces, and user data encryption.

[![UCSC Genomics Institute logo](static/gi-logo.png)](https://ucscgenomics.soe.ucsc.edu/)

Organic, free-range, grass-fed Python. [GitHub.](https://github.com/BD2KGenomics/toil/)
© 2017 [UCSC Computational Genomics Lab](https://cgl.genomics.ucsc.edu/)