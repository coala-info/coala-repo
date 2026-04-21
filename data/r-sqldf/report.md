# sqldf: Manipulate R Data Frames Using SQL

The sqldf() function is typically passed a single argument which 
	is an SQL select statement where the table names are ordinary R data 
	frame names.  sqldf() transparently sets up a database, imports the 
	data frames into that database, performs the SQL select or other
	statement and returns the result using a heuristic to determine which 
	class to assign to each column of the returned data frame.  The sqldf() 
	or read.csv.sql() functions can also be used to read filtered files 
	into R eve...

### Metadata
- **Conda**: https://anaconda.org/channels/r/packages/r-sqldf/overview
- **R-project (CRAN)**: https://cloud.r-project.org/web/packages/sqldf/index.html
- **Home (project)**: https://github.com/ggrothendieck/sqldf, https://groups.google.com/group/sqldf
- **Package**: sqldf
- **Version**: 0.4-12
- **Author**: G. Grothendieck [aut, cre]
- **Maintainer**: G. Grothendieck <ggrothendieck at gmail.com>
- **Docker Image**: quay.io/biocontainers/r-sqldf:0.4_10--r3.3.1_0
- **Skill**: generated
- **Total Downloads**: 73
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ggrothendieck/sqldf
- **Stars**: N/A

