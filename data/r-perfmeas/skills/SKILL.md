---
name: r-perfmeas
description: This R package calculates performance metrics for ranking and classification tasks, including AUROC, AUPRC, and F-scores. Use when user asks to calculate area under the curve metrics, determine precision at specific recall levels, or compute F-scores for single or multiple classes.
homepage: https://cran.r-project.org/web/packages/perfmeas/index.html
---


# r-perfmeas

name: r-perfmeas
description: Performance measures for ranking and classification tasks in R. Use this skill to calculate Area Under the Receiving Characteristic Curve (AUROC), Area Under the Precision Recall Curve (AUPRC), precision at specific recall levels, and F-scores for single or multiple classes.

# r-perfmeas

## Overview
The PerfMeas package implements various performance metrics for evaluating classification and ranking algorithms. It is designed to handle both single-label and multi-label/multi-class problems, providing efficient computation of AUROC, AUPRC, and threshold-specific metrics like precision-at-recall.

## Installation
To install the package from CRAN:
install.packages("PerfMeas")

Note: This package depends on Bioconductor packages (limma, graph, RBGL). Ensure BiocManager is installed if dependencies are missing.

## Main Functions
- AUC.measures(perf, labels, name="Experiment"): Computes AUROC and AUPRC for one or more classes. perf is a matrix of scores, and labels is a matrix of ground truth (0/1 or TRUE/FALSE).
- precision.at.recall.level(scores, labels, rec.level=0.5): Calculates the precision for a specific recall level for a single class.
- precision.at.given.recall.level.over.classes(target, predicted, recall.level=0.5): Calculates precision at a given recall level across multiple classes.
- F.measure.single.over.classes(target, predicted, positive=TRUE): Computes the F-score (harmonic mean of precision and recall) for multiple classes.

## Workflows

### Evaluating Ranking Performance (AUROC/AUPRC)
1. Prepare a score matrix where rows are samples and columns are classes.
2. Prepare a corresponding binary label matrix.
3. Execute:
results <- AUC.measures(score_matrix, label_matrix)
4. Access results using results$average (for mean values) or results$per.class.

### Calculating Precision at Specific Recall
For tasks where a specific recall target is required (e.g., finding 10% of all positives):
prec <- precision.at.given.recall.level.over.classes(label_matrix, score_matrix, recall.level=0.1)

### Multi-class F-measure
To evaluate the overall F-score across a set of predictions:
f_score <- F.measure.single.over.classes(label_matrix, prediction_matrix)

## Tips
- Input Matrices: Ensure that the score matrix and label matrix have the same dimensions and matching row/column names.
- Precision-Recall: AUPRC is often more informative than AUROC for highly imbalanced datasets (where positives are rare).
- Multi-label: The package is optimized for bioinformatics applications where samples often belong to multiple functional classes simultaneously.

## Reference documentation
- [PerfMeas Home Page](./references/home_page.md)