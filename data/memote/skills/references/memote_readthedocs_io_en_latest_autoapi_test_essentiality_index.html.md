[![](../../_static/memote-logo.png)](../../index.html)
**0.11.1**

* [Site](../../index.html)

  - [Installation](../../installation.html)
  - [Getting Started](../../getting_started.html)
  - [Flowchart](../../flowchart.html)
  - [Understanding the reports](../../understanding_reports.html)
  - [Experimental Data](../../experimental_data.html)
  - [Custom Tests](../../custom_tests.html)
  - [Test Suite](../../test_suite.html)
  - [Contributing](../../contributing.html)
  - [Credits](../../authors.html)
  - [History](../../history.html)
  - [API Reference](../index.html)
* Page

  - `test_essentiality`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_gene\_essentiality\_from\_data\_qualitative](#test_essentiality.test_gene_essentiality_from_data_qualitative)
* [Source](../../_sources/autoapi/test_essentiality/index.rst.txt)

# [`test_essentiality`](#module-test_essentiality "test_essentiality")[¶](#module-test_essentiality "Permalink to this headline")

Perform tests on an instance of cobra.Model using gene data.

Gene data currently only includes knockout screens. However, other types of
experiments that make changes to individual genes such as expression
modulation experiments, etc may be possible extensions in the future.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_gene_essentiality_from_data_qualitative`](#test_essentiality.test_gene_essentiality_from_data_qualitative "test_essentiality.test_gene_essentiality_from_data_qualitative")(model, experiment, threshold=0.95) | Expect a perfect accuracy when predicting gene essentiality. |

`test_essentiality.``test_gene_essentiality_from_data_qualitative`(*model*, *experiment*, *threshold=0.95*)[[source]](../../_modules/test_essentiality.html#test_gene_essentiality_from_data_qualitative)[¶](#test_essentiality.test_gene_essentiality_from_data_qualitative "Permalink to this definition")
:   Expect a perfect accuracy when predicting gene essentiality.

    The in-silico gene essentiality is compared with experimental
    data and the accuracy is expected to be better than 0.95.
    In principal, Matthews’ correlation coefficient is a more comprehensive
    metric but is a little fragile to not having any false negatives or false
    positives in the output.

    Implementation:
    Read and validate experimental config file and data tables. Constrain the
    model with the parameters provided by a user’s definition of the medium,
    then compute a confusion matrix based on the predicted essential, expected
    essential, predicted nonessential and expected nonessential genes.
    The individual values of the confusion matrix are calculated as described
    in <https://en.wikipedia.org/wiki/Confusion_matrix>

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.