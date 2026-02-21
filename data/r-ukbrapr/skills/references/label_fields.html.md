[Skip to contents](#main)

[ukbrapR](../index.html)
0.3.10

* [Reference](../reference/index.html)
* Articles
  + [Ascertain diagnoses](../articles/ascertain_diagnoses.html)
  + [Label fields](../articles/label_fields.html)
  + [Spark functions](../articles/spark_functions.html)
* [Changelog](../news/index.html)

* + Light
  + Dark
  + Auto

# Label fields

Source: [`vignettes/label_fields.Rmd`](https://github.com/lcpilling/ukbrapR/blob/HEAD/vignettes/label_fields.Rmd)

`label_fields.Rmd`

Categorical fields are exported as integers but are encoded with
labels.

For example [20116
“Smoking status”](https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=20116):

| Coding | Meaning |
| --- | --- |
| -3 | Prefer not to answer |
| 0 | Never |
| 1 | Previous |
| 2 | Current |

This package includes two functions to label a single UK Biobank
field or a data frame of them using the [UK Biobank
encoding schema](https://biobank.ctsu.ox.ac.uk/crystal/schema.cgi). Examples:

```
# update the Smoking status field
ukb <- label_ukb_field(ukb, field="p20116_i0")

table(ukb$p20116_i0)                   # tabulates the values
#>    -3      0      1      2
#>  2057 273405 172966  52949

table(haven::as_factor(ukb$p20116_i0)) # tabulates the labels
#> Prefer not to answer                Never             Previous              Current
#>                 2057               273405               172966                52949

haven::print_labels(ukb$p20116_i0)     # show the value:label mapping for this variable
#> Labels:
#>  value                label
#>     -3 Prefer not to answer
#>      0                Never
#>      1             Previous
#>      2              Current

#
# if you have a whole data frame of exported fields, you can use the wrapper function label_ukb_fields()

# say the `ukb` data frame contains 4 variables: `eid`, `p54_i0`, `p31` and `age_at_assessment`

# update the variables that looks like UK Biobank fields with titles and, where cateogrical, labels
# i.e., `p54_i0` and `p31` only -- `eid` and `age_at_assessment` are ignored
ukb <- label_ukb_fields(ukb)

table(ukb$p31)                   # tabulates the values
#>      0      1
#> 273238 229031

table(haven::as_factor(ukb$p31)) # tabulates the labels
#> Female   Male
#> 273238 229031
```

Developed by [Luke Pilling](https://lcpilling.github.io).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.2.0.