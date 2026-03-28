![](_static/memote-logo.png)
**0.11.1**

* Site

  - [Installation](installation.html)
  - [Getting Started](getting_started.html)
  - [Flowchart](flowchart.html)
  - [Understanding the reports](understanding_reports.html)
  - [Experimental Data](experimental_data.html)
  - [Custom Tests](custom_tests.html)
  - [Test Suite](test_suite.html)
  - [Contributing](contributing.html)
  - [Credits](authors.html)
  - [History](history.html)
  - [API Reference](autoapi/index.html)
* Page

  - memote - the genome-scale metabolic model test suite
    * [Contact](#contact)
    * [Copyright](#copyright)
    * [Contents](#contents)
    * [Indices and tables](#indices-and-tables)
* [Installation »](installation.html "Next Chapter: Installation")
* [Source](_sources/index.rst.txt)

# memote - the genome-scale metabolic model test suite[¶](#memote-the-genome-scale-metabolic-model-test-suite "Permalink to this headline")

Our goal in promoting this tool is to achieve two major shifts in the metabolic
model building community:

1. Models should be version-controlled such that changes can be tracked and if
   necessary reverted. Ideally, they should be available through a public
   repository such as GitHub that will allow other researchers to inspect,
   share, and contribute to the model.
2. Models should, for the benefit of the community and for research gain, live
   up to certain standards and minimal functionality.

The MEMOTE tool therefore performs four subfunctions:

1. Create a skeleton git repository for the model.
2. Run the current model through a [test suite that represents the community
   standard](https://github.com/opencobra/memote/wiki/Test-Catalog).
3. Generate an informative report which details the results of the test suite in
   a visually appealing manner.
4. (Re-)compute test statistics for an existing version controlled history of
   a metabolic model.

And in order to make this process as easy as possible the generated repository
can easily be integrated with continuous integration testing providers such as
Travis CI, which means that anytime you push a model change to GitHub, the test
suite will be run automatically and a report will be available for you to look
at via GitHub pages for your repository.

## Contact[¶](#contact "Permalink to this headline")

For comments and questions get in touch via

* our [gitter chatroom](https://gitter.im/opencobra/memote)
* or open a [GitHub issue](https://github.com/opencobra/memote/issues/new).

Are you excited about this project? Consider [contributing](https://memote.readthedocs.io/en/latest/contributing.html) by adding novel
tests, reporting or fixing bugs, and generally help us make this a better
software for everyone.

## Copyright[¶](#copyright "Permalink to this headline")

* Copyright (c) 2017, Novo Nordisk Foundation Center for Biosustainability,
  Technical University of Denmark.
* Free software: [Apache Software License 2.0](LICENSE)

## Contents[¶](#contents "Permalink to this headline")

* [Installation](installation.html)
  + [Stable release](installation.html#stable-release)
  + [From sources](installation.html#from-sources)
* [Getting Started](getting_started.html)
  + [Benchmark](getting_started.html#benchmark)
  + [Reconstruction](getting_started.html#reconstruction)
* [Flowchart](flowchart.html)
* [Understanding the reports](understanding_reports.html)
  + [Orientation](understanding_reports.html#orientation)
  + [Interpretation](understanding_reports.html#interpretation)
  + [Paradigms](understanding_reports.html#paradigms)
* [Experimental Data](experimental_data.html)
  + [Configuration](experimental_data.html#configuration)
  + [Media](experimental_data.html#media)
  + [Growth](experimental_data.html#growth)
  + [Essentiality](experimental_data.html#essentiality)
* [Custom Tests](custom_tests.html)
  + [Custom Test Setup](custom_tests.html#custom-test-setup)
  + [Custom Test Configuration](custom_tests.html#custom-test-configuration)
  + [Guidelines](custom_tests.html#guidelines)
* [Test Suite](test_suite.html)
  + [Core Tests](core.html)
  + [Experimental Tests](experimental.html)
* [Contributing](contributing.html)
  + [Report Bugs](contributing.html#report-bugs)
  + [Fix Bugs](contributing.html#fix-bugs)
  + [Implement Features](contributing.html#implement-features)
  + [Write Documentation](contributing.html#write-documentation)
  + [Submit Feedback](contributing.html#submit-feedback)
  + [Get Started!](contributing.html#get-started)
  + [Pull Request Guidelines](contributing.html#pull-request-guidelines)
* [Credits](authors.html)
  + [Development Leads](authors.html#development-leads)
  + [Contributors](authors.html#contributors)
* [History](history.html)
  + [Next Release](history.html#next-release)
  + [0.14.0 (2023-09-13)](history.html#id1)
  + [0.13.0 (2021-06-12)](history.html#id2)
  + [0.12.1 (2021-06-12)](history.html#id3)
  + [0.12.0 (2020-10-20)](history.html#id4)
  + [0.11.1 (2020-08-10)](history.html#id5)
  + [0.11.0 (2020-06-26)](history.html#id6)
  + [0.10.2 (2020-03-24)](history.html#id7)
  + [0.10.1 (2020-03-24)](history.html#id8)
  + [0.10.0 (2020-03-24)](history.html#id9)
  + [0.9.13 (2019-12-04)](history.html#id10)
  + [0.9.11 (2019-04-23)](history.html#id11)
  + [0.9.10 (2019-04-23)](history.html#id12)
  + [0.9.9 (2019-04-17)](history.html#id13)
  + [0.9.8 (2019-04-01)](history.html#id14)
  + [0.9.7 (2019-03-29)](history.html#id15)
  + [0.9.6 (2019-03-06)](history.html#id16)
  + [0.9.5 (2019-02-21)](history.html#id17)
  + [0.9.4 (2019-02-20)](history.html#id18)
  + [0.9.3 (2019-01-30)](history.html#id19)
  + [0.9.2 (2019-01-28)](history.html#id20)
  + [0.9.1 (2019-01-28)](history.html#id21)
  + [0.9.0 (2019-01-28)](history.html#id22)
  + [0.8.11 (2019-01-07)](history.html#id23)
  + [0.8.10 (2018-12-21)](history.html#id24)
  + [0.8.9 (2018-12-11)](history.html#id25)
  + [0.8.8 (2018-12-10)](history.html#id26)
  + [0.8.7 (2018-11-21)](history.html#id27)
  + [0.8.6 (2018-09-13)](history.html#id28)
  + [0.8.5 (2018-08-20)](history.html#id29)
  + [0.8.4 (2018-07-18)](history.html#id30)
  + [0.8.3 (2018-07-16)](history.html#id31)
  + [0.8.2 (2018-07-16)](history.html#id32)
  + [0.8.1 (2018-06-27)](history.html#id33)
  + [0.8.0 (2018-06-22)](history.html#id34)
  + [0.7.6 (2018-05-28)](history.html#id35)
  + [0.7.5 (2018-05-25)](history.html#id36)
  + [0.7.4 (2018-05-23)](history.html#id37)
  + [0.7.3 (2018-05-23)](history.html#id38)
  + [0.7.2 (2018-05-22)](history.html#id39)
  + [0.7.1 (2018-05-16)](history.html#id40)
  + [0.7.0 (2018-05-15)](history.html#id41)
  + [0.6.2 (2018-03-12)](history.html#id42)
  + [0.6.1 (2018-03-01)](history.html#id43)
  + [0.6.0 (2018-02-27)](history.html#id44)
  + [0.5.0 (2018-01-16)](history.html#id45)
  + [0.4.6 (2017-10-31)](history.html#id46)
  + [0.4.5 (2017-10-09)](history.html#id47)
  + [0.4.4 (2017-09-26)](history.html#id48)
  + [0.4.3 (2017-09-25)](history.html#id49)
  + [0.4.2 (2017-08-22)](history.html#id50)
  + [0.4.1 (2017-08-22)](history.html#id51)
  + [0.4.0 (2017-08-21)](history.html#id52)
  + [0.3.6 (2017-08-15)](history.html#id53)
  + [0.3.4 (2017-08-12)](history.html#id54)
  + [0.3.3 (2017-08-12)](history.html#id55)
  + [0.3.2 (2017-08-12)](history.html#id56)
  + [0.3.0 (2017-08-12)](history.html#id57)
  + [0.2.0 (2017-02-09)](history.html#id58)
  + [0.1.0 (2017-01-30)](history.html#id59)
* [API Reference](autoapi/index.html)
  + [`memote`](autoapi/memote/index.html)
  + [`test_consistency`](autoapi/test_consistency/index.html)
  + [`test_sbo`](autoapi/test_sbo/index.html)
  + [`conftest`](autoapi/conftest/index.html)
  + [`test_growth`](autoapi/test_growth/index.html)
  + [`test_thermodynamics`](autoapi/test_thermodynamics/index.html)
  + [`test_matrix`](autoapi/test_matrix/index.html)
  + [`test_basic`](autoapi/test_basic/index.html)
  + [`test_essentiality`](autoapi/test_essentiality/index.html)
  + [`test_biomass`](autoapi/test_biomass/index.html)
  + [`test_sbml`](autoapi/test_sbml/index.html)
  + [`test_annotation`](autoapi/test_annotation/index.html)

## Indices and tables[¶](#indices-and-tables "Permalink to this headline")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.