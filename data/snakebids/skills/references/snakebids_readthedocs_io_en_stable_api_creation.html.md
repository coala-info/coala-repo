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
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](main.html)[x]
* [Internals](internals.html)
* [Plugins](plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/creation.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/creation.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Dataset Creation[¶](#dataset-creation "Link to this heading")

snakebids.generate\_inputs(*bids\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*, *pybids\_inputs: [InputsConfig](internals.html#snakebids.types.InputsConfig "snakebids.types.InputsConfig")*, *\**, *pybidsdb\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *pybidsdb\_reset: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = None*, *derivatives: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") | [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") = False*, *pybids\_config: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *limit\_to: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *participant\_label: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *exclude\_participant\_label: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *use\_bids\_inputs: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal "(in Python v3.14)")[True] | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *index\_metadata: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = False*, *validate: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = False*, *pybids\_database\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *pybids\_reset\_database: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = None*) → [BidsDataset](structures.html#snakebids.BidsDataset "snakebids.core.datasets.BidsDataset")[¶](#snakebids.generate_inputs "Link to this definition")

snakebids.generate\_inputs(*bids\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*, *pybids\_inputs: [InputsConfig](internals.html#snakebids.types.InputsConfig "snakebids.types.InputsConfig")*, *\**, *pybidsdb\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *pybidsdb\_reset: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = None*, *derivatives: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") | [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") = False*, *pybids\_config: [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *limit\_to: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *participant\_label: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *exclude\_participant\_label: [Iterable](https://docs.python.org/3/library/collections.abc.html#collections.abc.Iterable "(in Python v3.14)")[[str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")] | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *use\_bids\_inputs: [Literal](https://docs.python.org/3/library/typing.html#typing.Literal "(in Python v3.14)")[False]*, *index\_metadata: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = False*, *validate: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = False*, *pybids\_database\_dir: [Path](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") | [str](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") | [None](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") = None*, *pybids\_reset\_database: [bool](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)") = None*) → [BidsDatasetDict](structures.html#snakebids.BidsDatasetDict "snakebids.core.datasets.BidsDatasetDict")
:   Dynamically generate snakemake inputs using pybids\_inputs.

    Pybids is used to parse the bids\_dir. Custom paths can also be parsed by including
    the custom\_paths entry under the pybids\_inputs descriptor.

    Parameters:
    :   * **bids\_dir** – Path to bids directory
        * **pybids\_inputs** –

          Configuration for bids inputs, with keys as the names (`str`)

          Nested dicts with the following required keys (for complete info, see
          [`InputConfig`](internals.html#snakebids.types.InputConfig "snakebids.types.InputConfig")):

          + `"filters"`: Dictionary of entity: “values” (dict of str -> str or list of
            str). The entity keywords should the bids tags on which to filter. The values
            should be an acceptable str value for that entity, or a list of acceptable str
            values.
          + `"wildcards"`: List of (str) bids tags to include as wildcards in
            snakemake. At minimum this should usually include
            `['subject','session']`, plus any other wildcards that you may
            want to make use of in your snakemake workflow, or want to retain
            in the output paths. Any wildcards in this list that are not in the
            filename will just be ignored.
          + `"custom_path"`: Custom path to be parsed with wildcards wrapped in braces,
            as in `/path/to/sub-{subject}/{wildcard_1}-{wildcard_2}`. This path will be
            parsed without pybids, allowing the use of non-bids-compliant paths.
        * **pybidsdb\_dir** – Path to database directory. If None is provided, database
          is not used
        * **pybidsdb\_reset** – A boolean that determines whether to reset / overwrite
          existing database.
        * **derivatives** – Indicates whether pybids should look for derivative datasets under bids\_dir.
          These datasets must be properly formatted according to bids specs to be
          recognized. Defaults to False.
        * **limit\_to** – If provided, indicates which input descriptors from pybids\_inputs should be
          parsed. For example, if pybids\_inputs describes `"bold"` and `"dwi"` inputs,
          and `limit_to = ["bold"]`, only the “bold” inputs will be parsed. “dwi” will
          be ignored
        * **participant\_label** – Indicate one or more participants to be included from input parsing. This may
          cause errors if subject filters are also specified in pybids\_inputs. It may not
          be specified if exclude\_participant\_label is specified
        * **exclude\_participant\_label** – Indicate one or more participants to be excluded from input parsing. This may
          cause errors if subject filters are also specified in pybids\_inputs. It may not
          be specified if participant\_label is specified
        * **use\_bids\_inputs** – If False, returns the classic [`BidsDatasetDict`](structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict") instead of
          :class`BidsDataset`. Setting to True is deprecated as of v0.8, as this is now
          the default behaviour
        * **index\_metadata** – If True indexes metadata of BIDS directory using pybids, otherwise skips
          indexing.
        * **validate** – If True performs validation of BIDS directory using pybids, otherwise
          skips validation.

    Returns:
    :   Object containing organized information about the bids inputs for consumption in
        snakemake. See the documentation of [`BidsDataset`](structures.html#snakebids.BidsDataset "snakebids.BidsDataset") for details and
        examples.

    Return type:
    :   [BidsDataset](structures.html#snakebids.BidsDataset "snakebids.BidsDataset") | [BidsDatasetDict](structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict")

    Example

    As an example, consider the following BIDS dataset:

    ```
    example
    ├── README.md
    ├── dataset_description.json
    ├── participant.tsv
    ├── sub-001
    │   ├── ses-01
    │   │   ├── anat
    │   │   │   ├── sub-001_ses-01_run-01_T1w.json
    │   │   │   ├── sub-001_ses-01_run-01_T1w.nii.gz
    │   │   │   ├── sub-001_ses-01_run-02_T1w.json
    │   │   │   └── sub-001_ses-01_run-02_T1w.nii.gz
    │   │   └── func
    │   │       ├── sub-001_ses-01_task-nback_bold.json
    │   │       ├── sub-001_ses-01_task-nback_bold.nii.gz
    │   │       ├── sub-001_ses-01_task-rest_bold.json
    │   │       └── sub-001_ses-01_task-rest_bold.nii.gz
    │   └── ses-02
    │       ├── anat
    │       │   ├── sub-001_ses-02_run-01_T1w.json
    │       │   └── sub-001_ses-02_run-01_T1w.nii.gz
    │       └── func
    │           ├── sub-001_ses-02_task-nback_bold.json
    │           ├── sub-001_ses-02_task-nback_bold.nii.gz
    │           ├── sub-001_ses-02_task-rest_bold.json
    │           └── sub-001_ses-02_task-rest_bold.nii.gz
    └── sub-002
        ├── ses-01
        │   ├── anat
        │   │   ├── sub-002_ses-01_run-01_T1w.json
        │   │   ├── sub-002_ses-01_run-01_T1w.nii.gz
        │   │   ├── sub-002_ses-01_run-02_T1w.json
        │   │   └── sub-002_ses-01_run-02_T1w.nii.gz
        │   └── func
        │       ├── sub-002_ses-01_task-nback_bold.json
        │       ├── sub-002_ses-01_task-nback_bold.nii.gz
        │       ├── sub-002_ses-01_task-rest_bold.json
        │       └── sub-002_ses-01_task-rest_bold.nii.gz
        └── ses-02
            └── anat
                ├── sub-002_ses-02_run-01_T1w.json
                ├── sub-002_ses-02_run-01_T1w.nii.gz
                ├── sub-002_ses-02_run-02_T1w.json
                └── sub-002_ses-02_run-02_T1w.nii.gz
    ```

    With the following `pybids_inputs` defined in the config file:

    ```
    pybids_inputs:
      bold:
        filters:
          suffix: 'bold'
          extension: '.nii.gz'
          datatype: 'func'
        wildcards:
          - subject
          - session
          - acquisition
          - task
          - run
    ```

    Then `generate_inputs(bids_dir, pybids_input)` would return the following values:

    ```
    BidsDataset({
        "bold": BidsComponent(
            name="bold",
            path="bids/sub-{subject}/ses-{session}/func/sub-{subject}_ses-{session}_task-{task}_bold.nii.gz",
            zip_lists={
                "subject": ["001",   "001",  "001",   "001",  "002",   "002" ],
                "session": ["01",    "01",   "02",    "02",   "01",    "01"  ],
                "task":    ["nback", "rest", "nback", "rest", "nback", "rest"],
            },
        ),
        "t1w": BidsComponent(
            name="t1w",
            path="example/sub-{subject}/ses-{session}/anat/sub-{subject}_ses-{session}_run-{run}_T1w.nii.gz",
            zip_lists={
                "subject": ["001", "001", "001", "002", "002", "002", "002"],
                "session": ["01",  "01",  "02",  "01",  "01",  "02",  "02" ],
                "run":     ["01",  "02",  "01",  "01",  "02",  "01",  "02" ],
            },
        ),
    })
    ```

[Next

Dataset Manipulation](manipulation.html)
[Previous

Path Building](paths.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Dataset Creation
  + [`generate_inputs()`](#snakebids.generate_inputs)