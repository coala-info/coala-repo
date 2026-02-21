# Finding Ideal K

#### Tyler J Burns

#### October 11, 2017

### Selection of the number of nearest neighbors

This vignette shows how to objectively determine the size of your k-nearest neighborhoods. As one might expect, this number can depend on the input dataset being analyzed. Given that Scone makes comparisons between functional markers across multiple biological conditions, we select our ideal k by determining how well KNN can impute these fuctional marker vales for a range of values of k. Our imputation error is the euclidean distance between an actual cell and imputed cell within “functional marker” space. For the example below, we use the Wanderlust dataset (see PreProcessing.Rmd “data” section).

```
# Multiples of 10 from 10 to 100, for dataset of 1000 cells
wand.k.titration <- 1:100 %>% .[. %% 10 == 0]
wand.ideal.k <- ImputeTesting(k.titration = wand.k.titration,
                              cells = wand.il7,
                              input.markers = input.markers,
                              test.markers = funct.markers)
```

The output looks like this:

```
wand.ideal.k
```

```
##       10       20       30       40       50       60       70       80
## 2.834636 2.797494 2.796010 2.797125 2.799908 2.805776 2.814342 2.819553
##       90      100
## 2.824756 2.831179
```

Notice that the output is convex, with a single local minimum at k = 30. This suggests that the selection of k is a bias-variance tradeoff. What I have found is that for datasets of 10,000 cells, the ideal k is between 100 and 200. I would nontheleless recommend utilizing this function for each new dataset used. If the ideal k varies across each biological condition, then I would recommend choosing the k that is the average of these values. In my experience, the ideal value k does not vary by more than a factor of two between conditions.

Note also that in our example, the imputation error between k = 30 and k = 40 varies by just over 0.001. This is to say that choosing a SLIGHTLY sub-ideal k in some cases might not change the output substantially. This is relevant if a smaller or larger k with a negligably higher imputation error more accurrately reflects the size of the smallest expected cell subset in the data.