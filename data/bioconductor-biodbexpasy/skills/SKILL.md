---
name: bioconductor-biodbexpasy
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.16/bioc/html/biodbExpasy.html
---

# bioconductor-biodbexpasy

name: bioconductor-biodbexpasy
description: Access and query the Expasy ENZYME database using the biodb framework. Use this skill to retrieve enzyme information, search by name or comment, and convert enzyme entries into R data frames for biological data analysis.

## Overview

The `biodbExpasy` package is a Bioconductor extension that provides a connector to the Expasy ENZYME database. It allows users to programmatically search for enzymes by name or description and retrieve detailed catalytic activity and nomenclature data. It operates within the `biodb` framework, ensuring a consistent API for database interactions.

## Initialization and Connection

To use the package, you must first initialize a `biodb` instance and then create a connector specifically for Expasy ENZYME.

```R
# Load the package
library(biodbExpasy)

# Initialize the biodb instance
mybiodb <- biodb::newInst()

# Create the connector to Expasy ENZYME
conn <- mybiodb$getFactory()$createConn('expasy.enzyme')
```

## Accessing Entries

You can retrieve specific entries using their accession numbers (EC numbers).

```R
# Get a few example IDs
ids <- conn$getEntryIds(n = 2) # Returns e.g., "1.1.1.1", "1.1.1.2"

# Retrieve full entry objects
entries <- conn$getEntry(ids)

# Convert entries to a standard R data frame for analysis
df <- mybiodb$entriesToDataframe(entries)
# Resulting columns typically include: accession, name, catalytic.activity, and expasy.enzyme.id
```

## Searching the Database

The package provides specialized methods to search the Expasy ENZYME web services.

### Search by Name
Find enzymes based on their recommended or alternative names.

```R
# Search for enzymes related to "Alcohol"
alcohol_ids <- conn$wsEnzymeByName(name = "Alcohol", retfmt = "ids")
```

### Search by Comment
Find enzymes based on descriptions or comments in the database.

```R
# Search for enzymes with specific keywords in comments
specific_ids <- conn$wsEnzymeByComment(comment = "best", retfmt = "ids")
```

## Resource Management

It is important to terminate the `biodb` instance to release system resources and close cache connections.

```R
# Close the instance when finished
mybiodb$terminate()
```

## Workflow Summary
1. **Initialize**: `biodb::newInst()`
2. **Connect**: `createConn('expasy.enzyme')`
3. **Search**: `wsEnzymeByName()` or `wsEnzymeByComment()`
4. **Retrieve**: `getEntry()`
5. **Process**: `entriesToDataframe()`
6. **Terminate**: `terminate()`

## Reference documentation

- [An introduction to biodbExpasy](./references/biodbExpasy.md)