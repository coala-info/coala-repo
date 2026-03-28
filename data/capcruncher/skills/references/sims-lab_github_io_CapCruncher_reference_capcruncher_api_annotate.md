[ ]
[ ]

[Skip to content](#capcruncher.api.annotate)

CapCruncher Documentation

annotate

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](../../../..)
* [Installation](../../../../installation/)
* [Pipeline](../../../../pipeline/)
* [Cluster Setup](../../../../cluster_config/)
* [Hints and Tips](../../../../tips/)
* [Plotting CapCruncher output](../../../../plotting/)
* [CLI Reference](../../../../cli/)
* [x]

  API Reference

  API Reference
  + [x]

    capcruncher

    capcruncher
    - [x]

      api

      api
      * [ ]

        annotate

        [annotate](./)

        Table of contents
        + [annotate](#capcruncher.api.annotate)
        + [increase\_cis\_slice\_priority](#capcruncher.api.annotate.increase_cis_slice_priority)
        + [remove\_duplicates\_from\_bed](#capcruncher.api.annotate.remove_duplicates_from_bed)
      * [deduplicate](../deduplicate/)
      * [filter](../filter/)
      * [io](../io/)
      * [pileup](../pileup/)
      * [plotting](../plotting/)
      * [statistics](../statistics/)
      * [storage](../storage/)

Table of contents

* [annotate](#capcruncher.api.annotate)
* [increase\_cis\_slice\_priority](#capcruncher.api.annotate.increase_cis_slice_priority)
* [remove\_duplicates\_from\_bed](#capcruncher.api.annotate.remove_duplicates_from_bed)

# annotate

## `increase_cis_slice_priority(df, score_multiplier=2)` [¶](#capcruncher.api.annotate.increase_cis_slice_priority "Permanent link")

Prioritizes cis slices by increasing the mapping score.

Source code in `capcruncher/api/annotate.py`

|  |  |
| --- | --- |
| ``` 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 ``` | ``` def increase_cis_slice_priority(df: pd.DataFrame, score_multiplier: float = 2):     """     Prioritizes cis slices by increasing the mapping score.     """      df["parent_name"] = df["name"].str.split("|").str[0]      df_chrom_counts = (         df[["parent_name", "chrom"]].value_counts().to_frame("slices_per_chrom")     )     modal_chrom = (         df_chrom_counts.groupby("parent_name")["slices_per_chrom"]         .transform("max")         .reset_index()         .set_index("parent_name")["chrom"]         .to_dict()     )     df["fragment_chrom"] = df["parent_name"].map(modal_chrom)     df["score"] = np.where(         df["chrom"] == df["fragment_chrom"],         df["score"] * score_multiplier,         df["score"] / score_multiplier,     )      return df.drop(columns="parent_name") ``` |

## `remove_duplicates_from_bed(bed, prioritize_cis_slices=False, chroms_to_prioritize=None)` [¶](#capcruncher.api.annotate.remove_duplicates_from_bed "Permanent link")

Removes duplicate entries from a PyRanges object.

Parameters:

| Name | Type | Description | Default |
| --- | --- | --- | --- |
| `bed` | `PyRanges` | PyRanges object to be deduplicated. | *required* |
| `prioritize_cis_slices` | `bool` | Prioritize cis slices by increasing the mapping score. Defaults to False. | `False` |
| `chroms_to_prioritize` | `Union[list, ndarray]` | Chromosomes to prioritize. Defaults to None. | `None` |

Returns:

| Type | Description |
| --- | --- |
| `PyRanges` | pr.PyRanges: Deduplicated PyRanges object. |

Source code in `capcruncher/api/annotate.py`

|  |  |
| --- | --- |
| ``` 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 ``` | ``` def remove_duplicates_from_bed(     bed: pr.PyRanges,     prioritize_cis_slices: bool = False,     chroms_to_prioritize: Union[list, np.ndarray] = None, ) -> pr.PyRanges:     """     Removes duplicate entries from a PyRanges object.      Args:         bed (pr.PyRanges): PyRanges object to be deduplicated.         prioritize_cis_slices (bool, optional): Prioritize cis slices by increasing the mapping score. Defaults to False.         chroms_to_prioritize (Union[list, np.ndarray], optional): Chromosomes to prioritize. Defaults to None.      Returns:         pr.PyRanges: Deduplicated PyRanges object.     """      df = bed.df.rename(columns=lambda col: col.lower()).rename(         columns={"chromosome": "chrom"}     )      # Shuffle the dataframe to randomize the duplicate removal     df = df.sample(frac=1)      if prioritize_cis_slices:         df = increase_cis_slice_priority(df)      if "score" in df.columns:         df = df.sort_values(["score"], ascending=False)      if chroms_to_prioritize:         df["is_chrom_priority"] = df["chrom"].isin(chroms_to_prioritize).astype(int)         df = df.sort_values(["score", "is_chrom_priority"], ascending=False).drop(             columns="is_chrom_priority"         )      return (         df.drop_duplicates(subset="name", keep="first")         .sort_values(["chrom", "start"])[["chrom", "start", "end", "name"]]         .rename(columns=lambda col: col.capitalize())         .rename(columns={"Chrom": "Chromosome"})         .pipe(pr.PyRanges)     ) ``` |

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)