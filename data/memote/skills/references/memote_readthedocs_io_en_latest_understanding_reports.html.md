[![](_static/memote-logo.png)](index.html)
**0.11.1**

* [Site](index.html)

  - [Installation](installation.html)
  - [Getting Started](getting_started.html)
  - [Flowchart](flowchart.html)
  - Understanding the reports
  - [Experimental Data](experimental_data.html)
  - [Custom Tests](custom_tests.html)
  - [Test Suite](test_suite.html)
  - [Contributing](contributing.html)
  - [Credits](authors.html)
  - [History](history.html)
  - [API Reference](autoapi/index.html)
* Page

  - Understanding the reports
    * [Orientation](#orientation)
      + [Toolbar](#toolbar)
      + [Main Body](#main-body)
      + [Test Results](#test-results)
    * [Interpretation](#interpretation)
      + [Color](#color)
      + [Score](#score)
    * [Paradigms](#paradigms)
      + [“Reconstructions” and “Models”](#reconstructions-and-models)
      + [“Lumped” and “Split” Biomass Reaction](#lumped-and-split-biomass-reaction)
      + [“Average” and “Unique” Metabolites](#average-and-unique-metabolites)
* [« Flowchart](flowchart.html "Previous Chapter: Flowchart")
* [Experimental Data »](experimental_data.html "Next Chapter: Experimental Data")
* [Source](_sources/understanding_reports.rst.txt)

# Understanding the reports[¶](#understanding-the-reports "Permalink to this headline")

Memote will return one of four possible outputs.
If your preferred workflow is to benchmark one or several genome-scale
metabolic models (GSM) memote generates either a snapshot or a diff report,
respectively. For the reconstruction workflow the primary output is a history
report. This will only work if the provided input models are formatted
correctly in the systems biology markup language ([SBML](http://sbml.org/Main_Page)). However, if a
provided model is not a valid SBML file, memote composes a report
enumerating errors and warnings from the SBML validator in
order of appearance. To better understand the output of the error report we
refer the reader to this section of the [SBML documentation](http://sbml.org/Facilities/Documentation/Error_Categories). In this section
we will focus on how to understand the snapshot, diff and history reports.

## Orientation[¶](#orientation "Permalink to this headline")

### Toolbar[¶](#toolbar "Permalink to this headline")

In all three reports, the blue toolbar at the top shows (from left to right)
the memote logo, a button which expand/ collapses all test results, a button
which displays the readme and the github icon which links to memote’s github
page. On the snapshot report, the toolbar will also display the identifier of
the tested GSM and a timestamp showing when the test run was initiated.

### Main Body[¶](#main-body "Permalink to this headline")

The main body of the reports is divided into an independent section to the left
and a specific section to the right.

The tests in the independent section are
agnostic of the type of modeled organism, preferred modeling paradigms,
the complexity of a genome-scale metabolic model (GSM) or the types of
identifiers that are used to describe its components. The tests in this section
focus on testing adherence to fundamental principles of
constraint-based modeling: mass, charge and stoichiometric balance as well as
the presence of annotations. The results in this section can be normalized, and
thus enable a comparison of GSMs. The Score\_ at the bottom
of the page summarises the results to further simplify comparison.

The specific section on the right provides model specific statistics
and covers aspects of a metabolic network that can not be normalized
without introducing bias. For instance, dedicated quality control of the biomass
equation only applies to GSMs which are used to investigate cell growth, i.e.,
those for which a biomass equation has been generated. Some tests in this
section are also influenced by whether the tested GSM represents a prokaryote or
a eukaryote. Therefore the results cannot be generalized and direct comparisons
ought to take bias into account.

### Test Results[¶](#test-results "Permalink to this headline")

Test results are arranged in rows with the title visible to the left and the
result on the right. The result is displayed as white text in a coloured
rectangle detailed in Color\_.

By default only the minimum information is visible as indicated by an arrow pointing
down right of the result. Clicking anywhere in the row will expand the result
revealing a description of the concept behind the test, its implementation
and a brief summary of the result.
In addition, there is a text field which contains plaintext representations of
Python objects which can be copy/pasted into Python code for follow up
procedures.

Some tests carry out one operation on several parameters and therefore deviate
slightly from the descriptions above. Expanding the title row reveals only the
description, while rows of the individual parameters reveal the text fields.

In the history report, instead of text fields scatterplots show how the
respective metrics developed over the commit history for each branch of a
repository. By clicking an entry in the legend, it is possible to toggle
its visibility in the plot.

## Interpretation[¶](#interpretation "Permalink to this headline")

The variety of constraints-based modeling approaches and differences between
various organisms compound the assessment of GSMs. While memote facilitates
model assessment it can only do so within limitations. Please bear in mind the
diversity of [Paradigms](#paradigms) that challenge some of memote’s results.

### Color[¶](#color "Permalink to this headline")

**Snapshot Report**

Results without highlights are kept in the main blue color of the memote
color scheme. Scored results will be marked with a gradient ranging from red
to green denoting a low or a high score respectively:

**0%** **100%**

**Diff Report**

The colour in the Diff Report depends on the ratio of the sample minimum to
the sample maxium. Result sets where the sample minimum and the sample
maximum are identical will be coloured in the main blue colour of the
memote colour scheme. Result sets where the sample minimum is very small
relative to the sample maximum will appear red . This ratio is calculated
using \(1 - (Min / Max)) \* 100\).

This is then mapped to the following gradient:

**Identical** **Different**

### Score[¶](#score "Permalink to this headline")

Each test in the independent section provides a relative measure of
completeness with regard to the tested property. The final score is the
weighted sum of all individual test results normalized by the maximally
achievable score, i.e., all individual results at 100%. Individual tests can
be weighted, but it is also possible to apply weighting to entire test
categories. Hence the final score is calculated:

Weights for sections and individual tests are indicated by a white number
inside a magenta badge. No badge means that the weight defaults to 1.

## Paradigms[¶](#paradigms "Permalink to this headline")

### “Reconstructions” and “Models”[¶](#reconstructions-and-models "Permalink to this headline")

Some authors may publish metabolic networks which are parameterized,
ready to run flux balance analysis (FBA), these are referred to simply as
‘models’. Alternatively, others may publish unconstrained metabolic knowledgebases
(referred to as ‘reconstructions’), from which several models can be derived
by applying different constraints. Both can be encoded in SBML. With having
an independent test section, we attempt to make both ‘models’ and
‘reconstructions’ comparable, although a user should be aware that this
difference exists and is subject to [some discussion](https://github.com/opencobra/memote/issues/228). Please note, that some
tests in the specific section may error for a reconstruction as they
require initialization.

### “Lumped” and “Split” Biomass Reaction[¶](#lumped-and-split-biomass-reaction "Permalink to this headline")

There are two basic ways of specifying the biomass composition. The most
common is a single lumped reaction containing all biomass precursors.
Alternatively, the biomass equation can be split into several reactions
each focusing on a different macromolecular component for instance
a (1 gDW ash) + b (1 gDW phospholipids) + c (free fatty acids)+
d (1 gDW carbs) + e (1 gDW protein) + f (1 gDW RNA) + g (1 gDW DNA) +
h (vitamins/cofactors) + xATP + xH2O-> 1 gDCW biomass + xADP + xH + xPi. The
benefit of either approach depends very much on the use cases which are
[discussed by the community](https://github.com/opencobra/memote/issues/243). Memote employs heuristics to identify the type
of biomass which may fail to distinguish edge cases.

### “Average” and “Unique” Metabolites[¶](#average-and-unique-metabolites "Permalink to this headline")

A metabolite consisting of a fixed core with variable branches such as a
membrane lipid are sometimes implemented by averaging over the distribution of
individual lipid species. The resulting pseudo-metabolite is assigned an
average chemical formula, which requires scaling of stoichiometries of
associated reactions to avoid floating point numbers in the chemical formulae.
An alternative approach is to implement each species as a distinct
metabolite in the model, which increases the total count of reactions. Memote
cannot yet distinguish between these paradigms, which means that results
in the specific sections that rely on the total number of reactions or scaling
of stochiometric parameters may be biased.

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.