[HippUnfold Documentation](../index.html)

Getting started

* [Installation](../getting_started/installation.html)
* [Running HippUnfold with Docker on Windows](../getting_started/docker.html)
* [Running HippUnfold with Singularity](../getting_started/singularity.html)
* [Running HippUnfold with a Vagrant VM](../getting_started/vagrant.html)

Usage Notes

* [Command-line interface](cli.html)
* [Running HippUnfold on your data](useful_options.html)
* [Specialized scans](specializedScans.html)
* Template-base segmentation
* [Frequently asked questions](faq.html)

Processing pipeline details

* [Pipeline Details](../pipeline/pipeline.html)
* [Algorithmic details](../pipeline/algorithms.html)

Outputs of HippUnfold

* [Output Files](../outputs/output_files.html)
* [Visualization](../outputs/visualization.html)
* [Quality Control](../outputs/QC.html)

Contributing

* [References](../contributing/references.html)
* [Contributing to Hippunfold](../contributing/contributing.html)

[HippUnfold Documentation](../index.html)

* Template-base segmentation
* [View page source](../_sources/usage/templates.md.txt)

---

# Template-base segmentation[](#template-base-segmentation "Permalink to this heading")

Template-based segmentation can be used with the `--use-template-seg` flag instead of a deep neural network for tissue class segmentation prior to unfolding. This is the recommended workflow for non-human data.

**Advantages:**

* Relatively robust to image quality
* Can be used without UNet training (which requires many manually segmented samples)
* Precision can be adjusted with the `--inject_template_smoothing_factor` and `--rigid-reg-template` flags

**Disadvantages:**

* Doesn’t account well for interindividual differences in folding patterns (not an issue in most non-human species where the hippocampus is relatively smooth)
* Can still fail due to registration errors

This is meant as an alternative to UNet-based tissue segmentation when only one or a few manually segmented training samples are available, which are not sufficient to train a UNet model. However, failures can still occur during this registration due to differences in image contrast and/or quality compared to the template. Adjusting the optional parameters is sufficient to solve this in most cases, but if not then you can manually register or segment your hippocampal images and then run with the `--modality segT1w`, `--modality segT2w`, or `--modality cropseg` (the latter doesn’t perform any additional cropping its its recommended you crop your segmentations to improve HippUnfold processing time).

If you have a unique template hippocmapal segmentation (e.g. from another species or special population) then please consider making it available to other HippUnfold users! We will be happy to include it, and any associated references, if you raise a [git issue](https://github.com/khanlab/hippunfold/issues).

[Previous](specializedScans.html "Specialized scans")
[Next](faq.html "Frequently asked questions")

---

© Copyright 2020, Jordan DeKraker and Ali R. Khan.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).