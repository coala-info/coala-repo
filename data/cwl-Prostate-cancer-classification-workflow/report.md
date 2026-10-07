# Prostate cancer classification workflow CWL Workflow Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| classify_tumor | Not completed | pipeline, skipped: WorkflowHub CWL workflow step (CommandLineTool) package, not a single command-line tool |
| extract_tissue | Not completed | pipeline, skipped: WorkflowHub CWL workflow step (CommandLineTool) package, not a single command-line tool |
| pca_classification_workflow | Not completed | pipeline, skipped: WorkflowHub CWL workflow package, not a single command-line tool |

## Description

# Prostate cancer classification workflow

This workflow segments tissue regions and classifies prostate cancer on H&E whole slide images, using AI. It consists of three steps:

1. low-resolution tissue segmentation to select areas for further processing;

2. high-resolution tissue segmentation to refine borders - it uses step 1 as input;

3. high-resolution normal/cancer classification - it uses step 1 as input.
