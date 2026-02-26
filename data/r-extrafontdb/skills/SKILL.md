---
name: r-extrafontdb
description: This package manages the persistent font database and metadata storage for the R 'extrafont' package. Use when user asks to store imported system fonts, maintain font configurations across package updates, or reset the font mapping database.
homepage: https://cloud.r-project.org/web/packages/extrafontdb/index.html
---


# r-extrafontdb

name: r-extrafontdb
description: Manage the font database for the 'extrafont' package in R. Use this skill when you need to provide a persistent storage location for imported system fonts, ensuring that font metadata remains available even when the main 'extrafont' package is updated.

# r-extrafontdb

## Overview
The `extrafontdb` package serves as a dedicated container for the font database used by the `extrafont` package. By separating the database from the functional code, users can update the `extrafont` package without losing their imported font configurations. 

**Note:** This package is essentially empty upon initial installation. The database is populated only after running font import commands from the `extrafont` package.

## Installation
To install the package from CRAN:
```r
install.packages("extrafontdb")
```

## Workflow and Usage
The `extrafontdb` package is rarely called directly by the user. Instead, it acts as a backend for `extrafont`.

### Initializing/Resetting the Database
Re-installing `extrafontdb` will wipe the existing font database. Use this if you need to perform a clean reset of your font mappings:
```r
# This clears all previously imported fonts
install.packages("extrafontdb")
```

### Integration with extrafont
When using `extrafont` to import fonts, the metadata is automatically stored within the `extrafontdb` directory structure:
```r
library(extrafont)
# Fonts are imported and stored in the extrafontdb package path
font_import() 
# Check available fonts stored in the database
fonts()
```

### Persistence
Because the database resides in `extrafontdb`, you can safely run `install.packages("extrafont")` to update the functional code without having to re-run the time-consuming `font_import()` process.

## Tips
- If `extrafont` fails to find fonts that you know were previously imported, ensure `extrafontdb` is installed and has not been recently re-installed or overwritten.
- The package contains the directory structure required by `extrafont` to organize .afm files and font table mappings.

## Reference documentation
- [extrafontdb Overview](./references/README.md)