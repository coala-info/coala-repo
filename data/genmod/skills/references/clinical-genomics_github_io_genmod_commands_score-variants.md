[genmod docs](../..)

* [Home](../..)
* [Genetic Models](../../genetic-models/)
* Commands
  + [Annotating Variants](../annotate-variants/)
  + [Annotate Genetic Models](../annotate-models/)
  + [Filter Variants](../filter-variants/)
  + [Sort Variants](../sort-variants/)
  + [Build References](../build-annotation/)
  + [Score compounds](../score-compounds/)
  + [Score variants](./)

* Search
* [Previous](../score-compounds/)
* Next
* [Edit on GitHub](https://github.com/Clinical-Genomics/genmod/edit/master/docs/commands/score-variants.md)

* [Score Variant](#score-variant)
  + [Rank Score Normalization](#rank-score-normalization)

# Score Variant

## Rank Score Normalization

The rank score is MAXMIN normalized into range (0, 1) according to the following formula:

```
RankScoreNormalized = (RankScore - CategorySumMin) / (CategorySumMax - CategorySumMin)
```

where `RankScore` is the sum of rank score across categories (including rules such as min, max, sum etc)
`RankScore = SUM(Score_category_n) for 0...n categories`
and `CategorySumMin` is the sum of minimal score values for all categories,
i. e `CategorySumMin = SUM(CategoryMin_n) for 0...n categories`.
The same applies to `CategorySumMax = SUM(CategoryMax_n) for 0...n categories`.

Refer to `score_variants.py::score()` method for implementation details.

Additionally, also read in the `score-compounds.md` on compound scoring step that affects
final rank score values.

---

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |