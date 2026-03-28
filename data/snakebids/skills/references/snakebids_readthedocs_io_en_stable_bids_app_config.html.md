Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](overview.html)[x]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/bids_app/config.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/bids_app/config.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Configuration[¶](#bids-app-config "Link to this heading")

Snakebids is configured with a YAML (or JSON) file that extends the standard [snakemake config file](https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html#standard-configuration) with variables that snakebids uses to parse an input BIDS dataset and expose the snakebids workflow to the command line.

## Config Variables[¶](#config-variables "Link to this heading")

### `pybids_inputs`[¶](#pybids-inputs "Link to this heading")

A dictionary that describes each type of input you want to grab from an input BIDS dataset. Snakebids will parse your dataset with [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs"), converting each input type into a [`BidsComponent`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent"). The value of each item should be a dictionary with keys `filters` and `wildcards`.

#### Filters[¶](#filters "Link to this heading")

The value of `filters` should be a dictionary where each key corresponds to a BIDS entity, and the value specifies which values of that entity should be grabbed. The dictionary for each input is sent to the [PyBIDS’ `get()` function](https://bids-standard.github.io/pybids/generated/bids.layout.BIDSLayout.html#bids.layout.BIDSLayout "PyBIDS 0.16.4") . `filters` can be set according to a few different formats:

* [`string`](https://docs.python.org/3/library/stdtypes.html#str "Python 3.14"): specifies an exact value for the entity. In the following example:

  ```
  1pybids_inputs:
  2  bold:
  3    filters:
  4      suffix: 'bold'
  5      extension: '.nii.gz'
  6      datatype: 'func'
  ```

  the bold component would match any paths under the `func/` datatype folder, with the suffix `bold` and the extension `.nii.gz`.

  ```
  sub-xxx/.../func/sub-xxx_ses-xxx_..._bold.nii.gz
  ```
* [`boolean`](https://docs.python.org/3/library/functions.html#bool "Python 3.14"): constrains presence or absence of the entity without restricting its value. `False` requires that the entity be **absent**, while `True` requires the entity to be **present**, regardless of value.

  ```
  1pybids_inputs:
  2  derivs:
  3    filters:
  4      datatype: 'func'
  5      desc: True
  6      acquisition: False
  ```

  The above example selects all paths in the `func/` datatype folder that have a `_desc-` entity but do not have the `_acq-` entity.
* [`list`](https://docs.python.org/3/library/stdtypes.html#list "Python 3.14"): Specify multiple string or boolean filters. Any path matching any one of the filters will be selected. Using `False` as one of the filters allows the entity to optionally be absent in addition to matching one of the string filters. Using `True` along with text is redundant, as `True` will cause any value to be selected. Using `True` with `False` is equivalent to not providing the filter at all.

  These filters:

  ```
  1pybids_inputs:
  2  derivs:
  3    filters:
  4      acquisition:
  5        - False
  6        - MPRAGE
  7        - MP2RAGE
  ```

  would select all of the following paths:

  ```
  sub-001/ses-1/anat/sub-001_ses-001_acq-MPRAGE_run-1_T1w.nii.gz
  sub-001/ses-1/anat/sub-001_ses-001_acq-MP2RAGE_run-1_T1w.nii.gz
  sub-001/ses-1/anat/sub-001_ses-001_run-1_T1w.nii.gz
  ```
* To use regex for filtering, use an additional subkey set either to [`match`](https://docs.python.org/3/library/re.html#re.match "Python 3.14") or [`search`](https://docs.python.org/3/library/re.html#re.search "Python 3.14"), depending on which regex method you wish to use. This key may be set to any one of the above items (`str`, `bool`, or `list`). Only one such key may be used.

  These filters:

  ```
  1pybids_inputs:
  2  derivs:
  3    filters:
  4      suffix:
  5        search: '[Tt]1'
  6      acquisition:
  7        match: MP2?RAGE
  ```

  would select all of the following paths:

  ```
  sub-001/ses-1/anat/sub-001_ses-001_acq-MPRAGE_run-1_T1.nii.gz
  sub-001/ses-1/anat/sub-001_ses-001_acq-MP2RAGE_run-1_t1w.nii.gz
  sub-001/ses-1/anat/sub-001_ses-001_acq-MPRAGE_run-1_qT1w.nii.gz
  ```

Note

`match` and `search` are both *filtering methods*. In addition to these, `get` is also a valid filtering method and may be used as the subkey for a filter. However, this is equivalent to directly providing the desired filter without a subkey:

```
 1pybids_inputs:
 2  derivs:
 3    filters:
 4      suffix:
 5        get: T1w
 6
 7# is the same as
 8pybids_inputs:
 9  derivs:
10    filters:
11      suffix: T1w
```

In other words, `get` is the default filtering method.

#### Wildcards[¶](#wildcards "Link to this heading")

The value of `wildcards` should be a list of BIDS entities. Snakebids collects the values of any entities specified and saves them in the [`entities`](../api/structures.html#snakebids.BidsComponent.entities "snakebids.BidsComponent.entities") and [`zip_lists`](../api/structures.html#snakebids.BidsComponent.zip_lists "snakebids.BidsComponent.zip_lists") entries of the corresponding [`BidsComponent`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent"). In other words, these are the entities to be preserved in output paths derived from the input being described. Placing an entity in `wildcards` does not require the entity be present. If an entity is not found, it will be left out of [`entities`](../api/structures.html#snakebids.BidsComponent.entities "snakebids.BidsComponent.entities"). To require the presence of an entity, place it under `filters` set to `true`.

In the following (YAML-formatted) example, the `bold` input type is specified. BIDS files with the datatype `func`, suffix `bold`, and extension `.nii.gz` will be grabbed, and the `subject`, `session`, `acquisition`, `task`, and `run` entities of those files will be left as wildcards. The `task` entity must be present, but there must not be any `desc`.

```
 1pybids_inputs:
 2  bold:
 3    filters:
 4      suffix: 'bold'
 5      extension: '.nii.gz'
 6      datatype: 'func'
 7      task: true
 8      desc: false
 9    wildcards:
10      - subject
11      - session
12      - acquisition
13      - task
14      - run
```

### `pybidsdb_dir`[¶](#pybidsdb-dir "Link to this heading")

PyBIDS allows for the use of a cached layout to be used in order to reduce the time required to index a BIDS dataset. A path (if provided) to save the *pybids* [layout](https://bids-standard.github.io/pybids/generated/bids.layout.BIDSLayout.html#bids.layout.BIDSLayout "PyBIDS 0.16.4"). If `None` or `''` is provided, the layout is not saved or used. The path provided must be absolute, otherwise the database will not be used.

### `pybidsdb_reset`[¶](#pybidsdb-reset "Link to this heading")

A boolean determining whether the existing layout should be be updated. Default behaviour does not update the existing database if one is used.

### `analysis_levels`[¶](#analysis-levels "Link to this heading")

A list of analysis levels in the BIDS app. Typically, this will include participant and/or group. Note that the default (YAML) configuration file expects this mapping to be identified with the anchor `analysis_levels` to be aliased by `parse_args`.

### `targets_by_analysis_level`[¶](#targets-by-analysis-level "Link to this heading")

A mapping from the name of each `analysis_level` to the list of rules or files to be run for that analysis level.

### `parse_args`[¶](#parse-args "Link to this heading")

A dictionary of command-line parameters to make available as part of the BIDS app. Each item of the mapping is passed to [argparse’s `add_argument` function](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument "Python 3.14"). A number of default entries are present in a new snakebids project’s config file that structure the BIDS app’s CLI, but additional command-line arguments can be added as necessary.

As in [`ArgumentParser.add_argument()`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument "Python 3.14"), `type` may be used to convert the argument to the specified type. It may be set to any type that can be serialized into yaml, for instance, `str`, `int`, `float`, and `boolean`.

```
 1parse_args:
 2  --a-string:
 3    help: args are string by default
 4  --a-path:
 5    help: |
 6      A path pointing to data needed for the pipeline. These are still converted
 7      into strings, but are first resolved into absolute paths (see below)
 8    type: Path
 9  --another-path:
10    help: This type annotation does the same thing as above
11    type: pathlib.Path
12  --a-number:
13    help: A number important for the analysis
14    type: float
```

When CLI parameters are used to collect paths, `type` should be set to [`Path`](https://docs.python.org/3/library/pathlib.html#pathlib.Path "Python 3.14") (or [`pathlib.Path`](https://docs.python.org/3/library/pathlib.html#pathlib.Path "Python 3.14")). These arguments will still be serialized as strings (since yaml doesn’t have a path type), but snakebids will automatically resolve all arguments into absolute paths. This is important to prevent issues with snakebids and relative paths.

### `debug`[¶](#debug "Link to this heading")

A boolean that determines whether debug statements are printed during parsing. Should be disabled (False) if you’re generating DAG visualization with snakemake.

### `derivatives`[¶](#derivatives "Link to this heading")

A boolean (or path(s) to derivatives datasets) that determines whether snakebids will search in the derivatives subdirectory of the input dataset.

[Next

Workflows](workflow.html)
[Previous

Bids Apps](overview.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Configuration
  + [Config Variables](#config-variables)
    - [`pybids_inputs`](#pybids-inputs)
      * [Filters](#filters)
      * [Wildcards](#wildcards)
    - [`pybidsdb_dir`](#pybidsdb-dir)
    - [`pybidsdb_reset`](#pybidsdb-reset)
    - [`analysis_levels`](#analysis-levels)
    - [`targets_by_analysis_level`](#targets-by-analysis-level)
    - [`parse_args`](#parse-args)
    - [`debug`](#debug)
    - [`derivatives`](#derivatives)