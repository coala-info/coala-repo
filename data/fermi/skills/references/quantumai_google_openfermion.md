[Skip to main content](#main-content)

[![Google Quantum AI](https://www.gstatic.com/devrel-devsite/prod/vd3309c0d80f416d7367081c5c5ffd3cd171f6ea37becda6136423538d770ce20/quantum/images/lockup.svg)](/)

[Software](https://quantumai.google/software)

* Tools for quantum computing research and development
* Learn about our software stack and available resources to help you with your work
* [See all tools](https://quantumai.google/software)

* Programming framework
* [Cirq

  An open source Python framework and simulators for writing, optimizing, and running quantum programs](https://quantumai.google/cirq)

* Computing service
* [Quantum Virtual Machine

  Run your quantum program on a virtual grid on our quantum hardware](https://quantumai.google/quantum-virtual-machine)

* Libraries and extensions
* [OpenFermion

  The electronic structure package for quantum computers](https://quantumai.google/openfermion)
* [qsim

  Schrödinger and Schrödinger-Feynman simulators for quantum circuits](https://quantumai.google/qsim)
* [TensorFlow Quantum

  A library for hybrid quantum-classical machine learning](https://www.tensorflow.org/quantum)

[Hardware](https://quantumai.google/hardware)

* [Overview](https://quantumai.google/hardware)
* [Our lab](https://quantumai.google/hardware/our-lab)

[Research](https://quantumai.google/research)

* [Overview](https://quantumai.google/research)
* [Publications](https://quantumai.google/research/publications)
* [Conferences](https://quantumai.google/research/conferences)
* [Outreach](https://quantumai.google/research/outreach)
* [Diversity](https://quantumai.google/research/diversity)

[Education](https://quantumai.google/education)

[Team](https://quantumai.google/team)

* [Overview](https://quantumai.google/team)
* [Careers](https://quantumai.google/team/careers)

`/`

Sign in

* [OpenFermion](https://quantumai.google/openfermion)

OpenFermion is a library for compiling and analyzing quantum algorithms to simulate fermionic systems, including quantum chemistry.

[Overview](https://quantumai.google/openfermion)

[Guide & Tutorials](https://quantumai.google/openfermion/overview)

[Reference](https://quantumai.google/reference/python/openfermion/all_symbols)

[![Google Quantum AI](https://www.gstatic.com/devrel-devsite/prod/vd3309c0d80f416d7367081c5c5ffd3cd171f6ea37becda6136423538d770ce20/quantum/images/lockup.svg)](/)

* [Software](/software)
  + More
  + [Overview](/openfermion)
  + [Guide & Tutorials](/openfermion/overview)
  + [Reference](/reference/python/openfermion/all_symbols)
* [Hardware](/hardware)
  + More
* [Research](/research)
  + More
* [Education](/education)
* [Team](/team)
  + More

* Tools for quantum computing research and development
* [See all tools](/software)
* Programming framework
* [Cirq](/cirq)
* Computing service
* [Quantum Virtual Machine](/quantum-virtual-machine)
* Libraries and extensions
* [OpenFermion](/openfermion)
* [qsim](/qsim)
* [TensorFlow Quantum](https://www.tensorflow.org/quantum)

* [Overview](/hardware)
* [Our lab](/hardware/our-lab)

* [Overview](/research)
* [Publications](/research/publications)
* [Conferences](/research/conferences)
* [Outreach](/research/outreach)
* [Diversity](/research/diversity)

* [Overview](/team)
* [Careers](/team/careers)

* [Google Quantum AI](https://quantumai.google/)
* [Software](https://quantumai.google/software)
* [OpenFermion](https://quantumai.google/openfermion)

![](https://quantumai.google/static/site-assets/images/icons/icon_openfermion.png)

## OpenFermion

The open source chemistry package for quantum computers

```
from openfermion import FermionOperator, MolecularData
from openfermion import fermi_hubbard, get_ground_state, get_sparse_operator

# Construct a fermion operators
my_first_fermion = FermionOperator(‘1^ 0 2^ 3’)
print(my_first_fermion)

# Build a Molecule
geometry = [[‘H’, [0, 0, 0]], [‘H’, [0, 0, 1.4]]]
multiplicity = 1
basis = ‘cc-pvdz’
charge = 0
molecule = MolecularData(geometry, basis, multiplicity, charge)

# Create model hamiltonians on a 1 x 10 lattice
hubbard = fermi_hubbard(1, 10, tunneling=1, coulomb=4, periodic=True)
print(hubbard)

# Get ground states
gs_energy, gs_eigvec = get_ground_state(get_sparse_operator(hubbard))
```

OpenFermion is a library for compiling and analyzing quantum algorithms to simulate fermionic systems, including quantum chemistry. The package provides everything from efficient data structures for representing fermionic operators to fermionic circuit primitives for execution on quantum devices. Plugins to OpenFermion provide users with an efficient, and low overhead, means of translating electronic structure calculations into quantum circuit calculations.

[Get started with OpenFermion](https://quantumai.google/openfermion/tutorials/intro_to_openfermion)
[GitHub repository](//github.com/quantumlib/OpenFermion)

## Features and updates

[![](https://quantumai.google/static/site-assets/images/cards/open-fermion-card-paper.png)](https://arxiv.org/abs/1710.07629)

### [Release paper](https://arxiv.org/abs/1710.07629)

Learn more about the OpenFermion data structures, organization, capabilities, and contributing guidelines in our release paper.

[View paper](https://arxiv.org/abs/1710.07629)

[![](https://quantumai.google/static/site-assets/images/cards/open-fermion-card-announcement.png)](https://ai.googleblog.com/2017/10/announcing-openfermion-open-source.html)

### [Announcing OpenFermion: The Open Source Chemistry Package for Quantum Computers](https://ai.googleblog.com/2017/10/announcing-openfermion-open-source.html)

Announcing Openfermion, an open source platform for translating problems in chemistry and materials science into quantum circuits that can be executed on existing platforms.

[Read more](https://ai.googleblog.com/2017/10/announcing-openfermion-open-source.html)

[![](https://quantumai.google/static/site-assets/images/cards/open-fermion-card-of-in-research16x9.jpg)](https://quantumai.google/cirq/experiments/hfvqe)

### [OpenFermion used in research](https://quantumai.google/cirq/experiments/hfvqe)

Learn how to use OpenFermion to run chemistry simulations on Sycamore.

[Learn more](https://quantumai.google/cirq/experiments/hfvqe)

[![](https://quantumai.google/static/site-assets/images/cards/open-fermion-card-plugins.png)](https://quantumai.google/openfermion/overview#electronic_structure_package_plugins)

### [Plugins](https://quantumai.google/openfermion/overview#electronic_structure_package_plugins)

OpenFermion interfaces with common electronic structure codes and allows users to easily execute chemistry simulation processing. Currently supported plugins are to open source codes [Psi4](https://github.com/quantumlib/OpenFermion-Psi4), [Pyscf](https://github.com/quantumlib/OpenFermion-PySCF), and [Dirac](https://github.com/bsenjean/Openfermion-Dirac).

[Learn more](https://quantumai.google/openfermion/overview#electronic_structure_package_plugins)

[[["Easy to understand","easyToUnderstand","thumb-up"],["Solved my problem","solvedMyProblem","thumb-up"],["Other","otherUp","thumb-up"]],[["Missing the information I need","missingTheInformationINeed","thumb-down"],["Too complicated / too many steps","tooComplicatedTooManySteps","thumb-down"],["Out of date","outOfDate","thumb-down"],["Samples / code issue","samplesCodeIssue","thumb-down"],["Other","otherDown","thumb-down"]],[],[],[]]

* ### Connect with us

  + [Twitter](//twitter.com/googlequantumai)
  + [YouTube](//www.youtube.com/c/QuantumAI)

[![Google Developers](https://www.gstatic.com/devrel-devsite/prod/vd3309c0d80f416d7367081c5c5ffd3cd171f6ea37becda6136423538d770ce20/quantum/images/lockup-google-for-developers.svg)](https://developers.google.com/)

* [About Google](//about.google/)
* [Google Products](//about.google/products/)
* [Privacy](//policies.google.com/privacy)
* [Terms](//policies.google.com/terms)

* [Terms](//policies.google.com/terms)
* [Privacy](//policies.google.com/privacy)
* Manage cookies