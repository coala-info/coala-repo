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
* Bids Function
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/bids_function/overview.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/bids_function/overview.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Bids Function[¶](#bids-function "Link to this heading")

The `bids` function generates a BIDS-like filepath corresponding to its keyword arguments. The generated filepath has the form:

```
[root]/[sub-{subject}]/[ses-{session]/[prefix]_[sub-{subject}]_[ses-{session}]_[{key}-{val}_ ... ]_[suffix]
```

Use cases of the `bids` function include, at simplest, replacing a hard-coded BIDS file with an invocation of the `bids` function, so

```
"data/sub-01/ses-01/func/sub-01_ses-01_task-rest_acq-01_run-1_bold.nii.gz"
```

could become

```
bids(
    root="data",
    subject="01",
    session="01",
    datatype="func",
    task="rest",
    acq="01",
    run="1",
    suffix="bold.nii.gz"
)
```

If you wanted to specify that a rule should run on a BIDS file from any subject, session, acquisition, task, and run, you could change those keyword arguments to be snakemake wildcards:

```
bids(
    root="data",
    subject="{subject}",
    session="{session}",
    datatype="func",
    task="{task}",
    acq="{acq}",
    run="{run}",
    suffix="bold.nii.gz"
)
```

Using the subject and session keywords as wildcards is common enough that snakebids pre-populates a config variable (`subj_wildcards`) with these wildcards, allowing the `bids` call to look like the following:

```
bids(
    root="data",
    datatype="func",
    task="{task}",
    acq="{acq}",
    run="{run}",
    suffix="bold.nii.gz",
    **inputs.subj_wildcards
)
```

Now if you want to process all inputs of a given form regardless of how their wildcards resolve, you can use [`BidsComponent.expand`](../api/structures.html#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") to expand over the entity-values found in your input dataset. As an example, to specify the output of a rule that preprocesses BOLD images (as specified in the example configuration), the following would resolve the subject, session, acquisition, task, and run wildcards:

```
inputs["bold"].expand(
    bids(
        root="output",
        datatype="func",
        desc="preproc",
        acq="{acq}",
        task="{task}",
        run="{run}",
        **inputs.subj_wildcards
    ),
)
```

## Specs[¶](#specs "Link to this heading")

The structure of the built path is based on the currently active BIDS spec. More information can be found on the [specs](../api/paths.html#specs) page.

[Next

Bids Apps](../bids_app/overview.html)
[Previous

Tutorial](../tutorial/tutorial.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Bids Function
  + [Specs](#specs)