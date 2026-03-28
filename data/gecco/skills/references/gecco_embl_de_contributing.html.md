[![](_static/gecco.png)
GECCO](index.html)
**v0.9.10**

* [Repository](https://github.com/zellerlab/GECCO)
* [Documentation](index.html)

  - [Installation](install.html)
  - [Integrations](integrations.html)
  - [Training](training.html)
  - Contributing
  - [API reference](api/index.html)
  - [Changelog](changes.html)
* [« Training](training.html "Previous Chapter: Training")
* [API Reference »](api/index.html "Next Chapter: API Reference")

* Contributing
  + [Running tests](#running-tests)
  + [Managing versions](#managing-versions)
    - [Upgrading the internal HMMs](#upgrading-the-internal-hmms)
    - [Upgrading the internal CRF model](#upgrading-the-internal-crf-model)

# Contributing[¶](#contributing "Permalink to this heading")

For bug fixes or new features, please file an issue before submitting a pull request.
If the change is not trivial, it may be best to wait for feedback.

## Running tests[¶](#running-tests "Permalink to this heading")

Tests are written as usual Python unit tests with the `unittest` module of the
Python standard library. Running them can be done as follow:

```
$ python -m unittest discover -vv
```

## Managing versions[¶](#managing-versions "Permalink to this heading")

As it is a good project management practice, we should follow
[semantic versioning](https://semver.org/), so remember the following:

* As long as the model predicts the same thing, retraining/updating the model
  should be considered a non-breaking change, so you should bump the MINOR
  version of the program.
* Upgrading the internal HMMs could potentially change the output but won’t
  break the program, they should be treated as non-breaking change, so you
  should bump the MINOR version of the program.
* If the model changes prediction (e.g. predicted classes change), then you
  should bump the MAJOR version of the program as it it a breaking change.
* Changes in the code should be treated following semver the usual way.
* Changed in the CLI should be treated as changed in the API (e.g. a new
  CLI option or a new command bumps the MINOR version, removal of an option
  bumps the MAJOR version).

### Upgrading the internal HMMs[¶](#upgrading-the-internal-hmms "Permalink to this heading")

To bump the version of the internal HMMs (for instance, to switch to a newer
version of Pfam), simply edit the INI file for that HMM in the
`gecco/hmmer` folder.

Then clean and rebuild data files to download the latest version of
the HMMs:

```
$ python setup.py clean build_data --inplace
```

### Upgrading the internal CRF model[¶](#upgrading-the-internal-crf-model "Permalink to this heading")

After having trained a new version of the model, run the following
command to update the internal GECCO model as well as the hash signature file:

```
$ python setup.py update_model --model <path_to_new_crf.model>
```

Back to top

© Copyright 2020-2024, Zeller group, EMBL.
Created using [Sphinx](http://sphinx-doc.org/) 5.3.0.