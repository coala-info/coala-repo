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

  - `test_matrix`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_absolute\_extreme\_coefficient\_ratio](#test_matrix.test_absolute_extreme_coefficient_ratio)
        - [test\_number\_independent\_conservation\_relations](#test_matrix.test_number_independent_conservation_relations)
        - [test\_matrix\_rank](#test_matrix.test_matrix_rank)
        - [test\_degrees\_of\_freedom](#test_matrix.test_degrees_of_freedom)
* [Source](../../_sources/autoapi/test_matrix/index.rst.txt)

# [`test_matrix`](#module-test_matrix "test_matrix")[¶](#module-test_matrix "Permalink to this headline")

Tests for matrix properties performed on an instance of `cobra.Model`.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_absolute_extreme_coefficient_ratio`](#test_matrix.test_absolute_extreme_coefficient_ratio "test_matrix.test_absolute_extreme_coefficient_ratio")(model, threshold=1000000000.0) | Show the ratio of the absolute largest and smallest non-zero coefficients. |
| [`test_number_independent_conservation_relations`](#test_matrix.test_number_independent_conservation_relations "test_matrix.test_number_independent_conservation_relations")(model) | Show the number of independent conservation relations in the model. |
| [`test_matrix_rank`](#test_matrix.test_matrix_rank "test_matrix.test_matrix_rank")(model) | Show the rank of the stoichiometric matrix. |
| [`test_degrees_of_freedom`](#test_matrix.test_degrees_of_freedom "test_matrix.test_degrees_of_freedom")(model) | Show the degrees of freedom of the stoichiometric matrix. |

`test_matrix.``test_absolute_extreme_coefficient_ratio`(*model*, *threshold=1000000000.0*)[[source]](../../_modules/test_matrix.html#test_absolute_extreme_coefficient_ratio)[¶](#test_matrix.test_absolute_extreme_coefficient_ratio "Permalink to this definition")
:   Show the ratio of the absolute largest and smallest non-zero coefficients.

    This test will return the absolute largest and smallest, non-zero
    coefficients of the stoichiometric matrix. A large ratio of these values
    may point to potential numerical issues when trying to solve different
    mathematical optimization problems such as flux-balance analysis.

    To pass this test the ratio should not exceed 10^9. This threshold has
    been selected based on experience, and is likely to be adapted when more
    data on solver performance becomes available.

    Implementation:
    Compose the stoichiometric matrix, then calculate absolute coefficients and
    lastly use the maximal value and minimal non-zero value to calculate the
    ratio.

`test_matrix.``test_number_independent_conservation_relations`(*model*)[[source]](../../_modules/test_matrix.html#test_number_independent_conservation_relations)[¶](#test_matrix.test_number_independent_conservation_relations "Permalink to this definition")
:   Show the number of independent conservation relations in the model.

    This test will return the number of conservation relations, i.e.,
    conservation pools through the left null space of the stoichiometric
    matrix. This test is not scored, as the dimension of the left null space
    is system-specific.

    Implementation:
    Calculate the left null space, i.e., the null space of the transposed
    stoichiometric matrix, using an algorithm based on the singular value
    decomposition adapted from
    <https://scipy.github.io/old-wiki/pages/Cookbook/RankNullspace.html>
    Then, return the estimated dimension of that null space.

`test_matrix.``test_matrix_rank`(*model*)[[source]](../../_modules/test_matrix.html#test_matrix_rank)[¶](#test_matrix.test_matrix_rank "Permalink to this definition")
:   Show the rank of the stoichiometric matrix.

    The rank of the stoichiometric matrix is system specific. It is
    calculated using singular value decomposition (SVD).

    Implementation:
    Compose the stoichiometric matrix, then estimate the rank, i.e. the
    dimension of the column space, of a matrix. The algorithm used by this
    function is based on the singular value decomposition of the matrix.

`test_matrix.``test_degrees_of_freedom`(*model*)[[source]](../../_modules/test_matrix.html#test_degrees_of_freedom)[¶](#test_matrix.test_degrees_of_freedom "Permalink to this definition")
:   Show the degrees of freedom of the stoichiometric matrix.

    The degrees of freedom of the stoichiometric matrix, i.e., the number
    of ‘free variables’ is system specific and corresponds to the dimension
    of the (right) null space of the matrix.

    Implementation:
    Compose the stoichiometric matrix, then calculate the dimensionality of the
    null space using the rank-nullity theorem outlined by
    Alama, J. The Rank+Nullity Theorem. Formalized Mathematics 15, (2007).

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.