# How to merge/standardize GatingSets

#### Greg Finak greg@ozette.ai, Mike Jiang mike@ozette.ai

# 1 How to merge/standardize GatingSets

## 1.1 Usage

```
gs_split_by_tree(x)
gs_check_redundant_nodes(x)
gs_remove_redundant_nodes(x,toRemove)
gs_remove_redundant_channels(gs, ...)
```

## 1.2 Arguments

**x**
‘GatingSet’ objects or or list of groups (each group member is a list of ’GatingSet`)

**toRemove** list of the node sets to be removed. its length must equals to the length of argument **x**

**…** other arguments

## 1.3 Remove the redudant leaf/terminal nodes

![](data:image/png;base64...)![](data:image/png;base64...)

Leaf nodes **DNT** and **DPT** are redudant for the analysis and should be **removed** before merging.

## 1.4 Hide the non-leaf nodes

![](data:image/png;base64...)![](data:image/png;base64...)

**singlets** node is not present in the second tree. But we **can’t** remove it because it will remove all its descendants. We can **hide** it instead.

```
invisible(gs_pop_set_visibility(gs2, "singlets", FALSE))
plot(gs2)
plot(gs3)
```

![](data:image/png;base64...)![](data:image/png;base64...)

Note that even gating trees look the same but **singlets** still physically exists so we must refer the populations by **relative path** (`path = "auto"`) instead of **full path**.

```
gs_get_pop_paths(gs2)[5]
gs_get_pop_paths(gs3)[5]
```

```
## [1] "/not debris/singlets/CD3+/CD4/38- DR+"
## [1] "/not debris/CD3+/CD4/38- DR+"
```

```
gs_get_pop_paths(gs2, path = "auto")[5]
gs_get_pop_paths(gs3, path = "auto")[5]
```

```
## [1] "CD4/38- DR+"
## [1] "CD4/38- DR+"
```

## 1.5 Isomorphism

![](data:image/png;base64...)![](data:image/png;base64...)

These two trees are **not identical** due to the **different order** of **CD4** and **CD8**. However they are still mergable thanks to the **reference by gating path** instead of `by numeric indices`

## 1.6 convenient wrapper for merging

To ease the process of merging large number of batches of experiments, here is some **internal wrappers** to make it **semi-automated**.

### 1.6.1 Grouping by tree structures

```
gslist <- list(gs1, gs2, gs3, gs4, gs5)
gs_groups <- gs_split_by_tree(gslist)
```

```
## Grouping by Gating tree...
```

```
length(gs_groups)
```

[1] 4

This divides all the `GatingSet`s into different groups, each group shares the same tree structure. Here we have `4` groups, ## Check if the discrepancy can be resolved by dropping leaf nodes

```
res <- try(gs_check_redundant_nodes(gs_groups), silent = TRUE)
print(res[[1]])
```

[1] “Error in (function (thisNodeSet, thisObj) : Can’t drop the non-terminal nodes: singlets”

Apparently the non-leaf node (`singlets`) fails this check, and it is up to user to decide whether to hide this node or keep this group separate from further merging.Here we try to hide it.

```
for(gp in gs_groups)
  plot(gp[[1]])
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Based on the tree structure of each group (usually there aren’t as many groups as `GatingSet` objects itself), we will hide `singlets` for `group 2` and `group 4`.

```
for(i in c(2,4))
  for(gs in gs_groups[[i]])
    invisible(gs_pop_set_visibility(gs, "singlets", FALSE))
```

Now check again with `.gs_check_redundant_nodes`

```
toRm <- gs_check_redundant_nodes(gs_groups)
toRm
```

[[1]] [1] “CCR7+ 45RA+” “CCR7+ 45RA-”

[[2]] [1] “DNT” “DPT”

[[3]] character(0)

[[4]] character(0)

Based on this, these groups can be consolidated by dropping \* `CCR7+ 45RA+` and `CCR7+ 45RA-` from `group 1`. \* `DNT` and `DPT` from `group 2`.

Sometime it could be difficult to inspect and distinguish tree difference by simply plotting the enire gating tree or looking at this simple flat list of nodes (especially when the entire subtree is missing from cerntain groups). It is helpful to visualize and highlight only the tree hierarchy difference with the helper function `gs_plot_diff_tree`

```
gs_plot_diff_tree(gs_groups)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

To proceed the deletion of these nodes, `.gs_remove_redundant_nodes` can be used instead of doing it manually

```
gs_remove_redundant_nodes(gs_groups, toRm)
```

```
## Removing CCR7+ 45RA+
```

```
## Removing CCR7+ 45RA-
```

```
## Removing DNT
```

```
## Removing DPT
```

Now they can be merged into a single `GatingSetList`.

```
GatingSetList(gslist)
```

```
## Warning in GatingSetList(gslist): 'GatingSetList' is deprecated.
## Use 'merge_list_to_gs' instead.
## See help("Deprecated")
```

An GatingSetList with 5 GatingSet containing 5 unique samples.

## 1.7 Remove the redundant channels from `GatingSet`

Sometime there may be the extra `channels` in one data set that prevents it from being merged with other. If these channels are not used by any gates, then they can be safely removed.

```
gs_remove_redundant_channels(gs1)
```

```
## drop FSC-H, FSC-W, <G560-A>, <G780-A>, Time
```

A GatingSet with 1 samples