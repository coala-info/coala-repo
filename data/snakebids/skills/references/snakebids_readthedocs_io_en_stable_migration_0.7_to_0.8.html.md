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
* [Migrations](index.html)[x]

Reference

* [API](../api/main.html)[ ]
* [Internals](../api/internals.html)
* [Plugins](../api/plugins.html)

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/migration/0.7_to_0.8.md?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/migration/0.7_to_0.8.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# 0.7 to 0.8+[¶](#to-0-8 "Link to this heading")

Warning

If your code still has bits like this:

```
1config.update(generate_inputs(
2    bids_dir=config['bids_dir'],
3    pybids_inputs=config['pybids_inputs'],
4))
```

Check out the [pre-0.6 migration guide](0.5_to_0.8.html) to a guide on how to upgrade!

Note

Be sure to also [migrate](0.11_to_0.12.html) your `run.py` file to the new snakebids 0.12 syntax!

## Default return of [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs")[¶](#default-return-of-generate-inputs "Link to this heading")

V0.8 switches the default return value of [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs") from [`BidsDatasetDict`](../api/structures.html#snakebids.BidsDatasetDict "snakebids.BidsDatasetDict") to [`BidsDataset`](../api/structures.html#snakebids.BidsDataset "snakebids.BidsDataset"). Legacy code still relying on the old dictionary can avoid the update by setting the `use_bids_inputs` parameter in [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs") to `False`:

```
1config.update(generate_inputs(
2    bids_dir=config['bids_dir'],
3    pybids_inputs=config['pybids_inputs'],
4    use_bids_inputs=False,
5))
```

Code that previously set `use_bids_inputs=True` should remove that line from [`generate_inputs()`](../api/creation.html#snakebids.generate_inputs "snakebids.generate_inputs"). Such manual assignment is deprecated.

## Properties of [`BidsDataset`](../api/structures.html#snakebids.BidsDataset "snakebids.BidsDataset")[¶](#properties-of-bidsdataset "Link to this heading")

The behaviour of the properties of [`BidsDataset`](../api/structures.html#snakebids.BidsDataset "snakebids.BidsDataset"), including [`path`](../api/structures.html#snakebids.BidsDataset.path "snakebids.BidsDataset.path"), [`zip_lists`](../api/structures.html#snakebids.BidsDataset.zip_lists "snakebids.BidsDataset.zip_lists"), [`entities`](../api/structures.html#snakebids.BidsDataset.entities "snakebids.BidsDataset.entities"), and [`wildcards`](../api/structures.html#snakebids.BidsDataset.wildcards "snakebids.BidsDataset.wildcards") is set to change in an upcoming release, thus, their current use is deprecated. Code should now access these properties via the [`BidsComponent`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent"). For instance:

```
# deprecated in v0.8
inputs.wildcards["t1w"]
inputs.entities["t1w"]

# should now use
inputs["t1w"].wildcards
inputs["t1w"].entities
```

## New [`expand()`](../api/structures.html#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") method[¶](#migration-expand-func "Link to this heading")

V0.8 features a new [`expand()`](../api/structures.html#snakebids.BidsComponent.expand "snakebids.BidsComponent.expand") method on [`BidsComponent`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent"). This method automatically ensures only entity-values actually contained in your dataset are used when expanding over a path. It supports the addition of extra wildcards, and can expand over the component [`path`](../api/structures.html#snakebids.BidsComponent.path "snakebids.BidsComponent.path") or any number of provided paths. It should generally be preferred over snakemake’s [`expand()`](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "Snakemake 9.13.7") when [`BidsComponents`](../api/structures.html#snakebids.BidsComponent "snakebids.BidsComponent") are involved, due to the increased safety and ease of use.

An [`expand`](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#snakefiles-expand "Snakemake 9.13.7") call that used to look like this:

```
rule all:
    input:
        expand(
            expand(
                bids(
                    root=root,
                    desc="{smooth}",
                    **inputs["bold"].wildcards,
                ),
                allow_missing=True,
                smooth=[1, 2, 3, 4],
            ),
            zip,
            **inputs["bold"].zip_lists,
        )
```

can now be written like this:

```
rule all:
    input:
        inputs['bold'].expand(
            bids(
                root=root,
                desc="{smooth}",
                **inputs["bold"].wildcards,
            ),
            smooth=[1, 2, 3, 4],
        )
```

[Next

0.11 to 0.12+](0.11_to_0.12.html)
[Previous

0.5 to 0.8+](0.5_to_0.8.html)

Copyright © 2025, Ali R. Khan

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* 0.7 to 0.8+
  + [Default return of `generate_inputs()`](#default-return-of-generate-inputs)
  + [Properties of `BidsDataset`](#properties-of-bidsdataset)
  + [New `expand()` method](#migration-expand-func)