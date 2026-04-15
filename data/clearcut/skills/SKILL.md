---
name: clearcut
description: Clearcut is a machine learning tool designed to filter large volumes of network log data to detect security incidents and suspicious traffic. Use when user asks to train models for anomaly detection, classify network flow data, or identify high-interest security events in Bro/Zeek logs.
homepage: https://github.com/DavidJBianco/Clearcut
metadata:
  docker_image: "biocontainers/clearcut:v1.0.9-3-deb_cv1"
---

# clearcut

## Overview
Clearcut is a machine learning tool designed to streamline incident detection by filtering large volumes of log data. It helps security analysts focus on the most suspicious entries by classifying traffic based on trained models. You should use this skill when you have network flow data (specifically Bro/Zeek logs) and need to distinguish between normal background noise and high-interest security events without manually reviewing every line.

## Environment Setup
Before running the scripts, ensure the following Python dependencies are installed:
- `scikit-learn` (Note: IForest support may require version 0.18.0+)
- `sklearn-extensions`
- `pandas`
- `httpagentparser`
- `tldextract`
- `treeinterpreter`

## Command Line Usage

### 1. Training a Model
Clearcut supports two primary machine learning modes: Random Forest (RF) and Isolation Forest (IForest).

**Random Forest Mode:**
Use this when you have labeled datasets for both normal and malicious traffic.
```bash
./train_flows_rf.py <normal_training_data> -o <malicious_training_data>
```

**Isolation Forest Mode:**
Use this for anomaly detection, particularly when looking for outliers in the dataset.
```bash
./train_flows_iforest.py <normal_training_data> -o <malicious_training_data>
```

### 2. Analyzing Logs
Once a model is trained, use the analysis script to process live or captured logs (e.g., Bro/Zeek HTTP logs).
```bash
./analyze_flows.py <bro_http_log>
```

## Best Practices and Tips
- **Data Quality**: The effectiveness of Clearcut depends heavily on the quality of the `normal_training_data`. Ensure your "normal" baseline is clean and representative of your specific environment.
- **Algorithm Selection**: 
    - Use **Random Forest** if you have a well-defined set of known-malicious examples to train against.
    - Use **Isolation Forest** if you are hunting for "unknown unknowns" or novel attack patterns that deviate from standard behavior.
- **Log Format**: The tool is optimized for Bro/Zeek HTTP logs. If using other log sources, ensure they are pre-processed to match the expected feature set (e.g., headers, TLDs, and user agents).
- **Feature Extraction**: The tool utilizes `featureizer.py` and `flowenhancer.py` internally to process logs. If analysis is failing, verify that the input log fields are correctly delimited and contain the expected metadata.

## Reference documentation
- [Clearcut README](./references/github_com_DavidJBianco_Clearcut.md)