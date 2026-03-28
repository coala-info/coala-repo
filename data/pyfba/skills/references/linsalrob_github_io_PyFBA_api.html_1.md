# [PyFBA 0.951 documentation](index.html%20)

[![sampledoc](static/PyFBA.png)](index.html)

* ←
  [Welcome to PyFBA](index.html "Previous document")
* [Metabolism : The Enzyme class](enzyme.html "Next document")
  →

* [PyFBA](index.html)

### [Table Of Contents](index.html)

* PyFBA Documentation
  + [The metabolism data](#the-metabolism-data)
  + [The FBA modules](#the-fba-modules)
  + [Filters for manipulating data](#filters-for-manipulating-data)
  + [Gapfilling](#gapfilling)
  + [The parsing modules](#the-parsing-modules)

#### Previous topic

[Welcome to PyFBA](index.html "previous chapter")

#### Next topic

[Metabolism : The Enzyme class](enzyme.html "next chapter")

[Show page source](sources/api.txt)

### Quick search

Enter search terms or a module, class or function name.

# PyFBA Documentation[¶](#module-PyFBA "Permalink to this headline")

## The metabolism data[¶](#the-metabolism-data "Permalink to this headline")

Classes for handling the data

* [Metabolism : The Enzyme class](enzyme.html)
* [Metabolism : The Reaction Class](reaction.html)
* [Metabolism : The Compound Class](compound.html)

## The FBA modules[¶](#the-fba-modules "Permalink to this headline")

Code for generating the stoichiometric matrix and running the FBA

* [Flux Balance Analysis](fba.html)
  + [Methods associated with creating the stoichiometric matrix](fba.html#module-PyFBA.fba.create_stoichiometric_matrix)
  + [Adding the limits to the reactions and compounds](fba.html#module-PyFBA.fba.bounds)
  + [Identifying the reactions that are uptake and secretion reactions](fba.html#module-PyFBA.fba.external_reactions)
  + [Running the FBA and retrieving the results](fba.html#module-PyFBA.fba.run_fba)

## Filters for manipulating data[¶](#filters-for-manipulating-data "Permalink to this headline")

Converting between reactions and roles, identifying roles with no proteins, etc

* [Filters for manipulating data](filters.html)
  + [Identifying reactions with/without proteins](filters.html#module-PyFBA.filters.reactions_and_proteins)
  + [Converting between roles and reactions and vice-versa](filters.html#module-PyFBA.filters.roles_and_reactions)

## Gapfilling[¶](#gapfilling "Permalink to this headline")

* [Gapfilling](gapfilling.html)

## The parsing modules[¶](#the-parsing-modules "Permalink to this headline")

Parsing data from different sources

* [Parsing modules](parse.html)

* ←
  [Welcome to PyFBA](index.html "Previous document")
* [Metabolism : The Enzyme class](enzyme.html "Next document")
  →

* [PyFBA](index.html)

© 2015, Daniel Cuevas, Taylor O'Connell and Robert Edwards.
Created using [Sphinx](http://sphinx-doc.org/)
1.3.1
with the [better](http://github.com/irskep/sphinx-better-theme) theme.