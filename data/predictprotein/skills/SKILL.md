---
name: predictprotein
description: PredictProtein predicts protein secondary structure, solvent accessibility, transmembrane helices, and functional sites from amino acid sequences using a comprehensive bioinformatics suite. Use when user asks to predict protein structural features, manage a local results cache, or convert prediction outputs into XML format.
homepage: https://github.com/Rostlab/predictprotein-docker
---


# predictprotein

## Overview

PredictProtein is a comprehensive bioinformatics suite that integrates multiple methods to predict protein secondary structure, solvent accessibility, transmembrane helices, and functional sites from amino acid sequences. This skill provides guidance on operating the Dockerized version of the suite, which includes the core prediction methods and the `pp-cache-mgr` utility for efficient result storage and retrieval. It is designed for researchers needing to process protein sequences locally while maintaining a persistent, hashed-indexed cache of results.

## Setup and Requirements

Before running predictions, ensure the environment is prepared:

1.  **Database Acquisition**: The suite requires the PredictProtein database. Download it using:
    `wget -O rostlab-data.txz "http://www.rostlab.org/services/ppmi/download_file?format=gzip&file_to_download=db"`
2.  **MySQL Instance**: A running MySQL server is required to connect to the container for result storage.
3.  **Docker Image**: Use the official image from Rostlab: `quay.io/rostlab/predictprotein-docker`.

## Directory Structure for Bind Mounts

PredictProtein relies on specific host directories to persist data and configurations. Use the following structure for bind mounts:

*   `/var/tmp/pp-data/config`: Configuration files for MySQL and runtime behavior.
*   `/var/tmp/pp-data/ppcache/ppcache-data`: The primary storage for computed results.
*   `/var/tmp/pp-data/ppcache/rost_db`: Location for the extracted PredictProtein database.
*   `/var/tmp/pp-data/ppcache/sequence-submit`: Directory for submitting sequence files for processing.

## Cache Management Utilities (pp-cache-mgr)

The suite includes specialized tools for interacting with the results cache. These are executed within the container environment:

*   **Verify Configuration**: Run `ppc_configtest` to ensure the cache configuration file is valid.
*   **Retrieve Results**: Use `ppc_fetch` to extract specific results from the cache based on sequence hashes.
*   **Generate Hashes**: Use `ppc_hash` to determine the unique PredictProtein hash for a given protein sequence.
*   **Locking**: Use `ppc_lock` to prevent concurrent writes to a specific cache slot during long-running computations.
*   **Manual Storage**: Use `ppc_store` to manually inject results into the cache.

## Data Transformation

To convert the raw output from various PredictProtein methods into a standardized format for downstream analysis, use the `ppflat2xml` utility. This tool parses the flat-file outputs and generates structured XML data.

## Expert Tips

*   **Persistence**: Always use Docker bind mounts for `/mnt/ppcache` to ensure that computed results are not lost when the container is stopped or removed.
*   **Database Updates**: The PredictProtein database is updated monthly. Automate the `wget` download and extraction process to keep predictions current with the latest biological data.
*   **Resource Allocation**: The Docker image is large (>12GB). Ensure the host system has sufficient disk space for both the image and the multi-gigabyte databases.
*   **Overriding Algorithms**: You can override the default data files for specific algorithms like `loctree3` or `metastudent` by bind-mounting your own data directories to the container's method-data paths.

## Reference documentation

- [PredictProtein Docker README](./references/github_com_Rostlab_predictprotein-docker.md)