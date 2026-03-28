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

* [Overview](/openfermion/overview)
* [Install](/openfermion/install)
* [Projects](/openfermion/projects)
* Tutorials
* [Introduction to OpenFermion](/openfermion/tutorials/intro_to_openfermion)
* [The Jordan-Wigner and Bravyi-Kitaev transforms](/openfermion/tutorials/jordan_wigner_and_bravyi_kitaev_transforms)
* [Lowering qubit requirements using binary codes](/openfermion/tutorials/binary_code_transforms)
* [Bosonic operators](/openfermion/tutorials/bosonic_operators)
* [Constructing a Basis Change Circuits](/openfermion/tutorials/circuits_1_basis_change)
* [Constructing a Diagonal Coulomb Trotter Step](/openfermion/tutorials/circuits_2_diagonal_coulomb_trotter)
* [Constructing Trotter Steps With Low-Rank Decomposition](/openfermion/tutorials/circuits_3_arbitrary_basis_trotter)
* [Intro Workshop with Exercises](/openfermion/tutorials/intro_workshop_exercises)
* OpenFermion-FQE Guide & Tutorials
* [Overview](/openfermion/fqe)
* [Introduction](/openfermion/fqe/guide/introduction)
* [Hamiltonian time evolution and expectation estimation](/openfermion/fqe/tutorials/hamiltonian_time_evolution_and_expectation_estimation)
* [Quadratic Hamiltonian evolution](/openfermion/fqe/tutorials/fqe_vs_openfermion_quadratic_hamiltonians)
* [Diagonal Coulomb evolution](/openfermion/fqe/tutorials/diagonal_coulomb_evolution)
* [Simulating the Fermi-Hubbard model](/openfermion/fqe/tutorials/fermi_hubbard)

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
* [Guide & Tutorials](https://quantumai.google/openfermion/overview)

# OpenFermion

OpenFermion is an open source library for compiling and analyzing quantum
algorithms to simulate fermionic systems, including quantum chemistry. Among
other functionalities, this version features data structures and tools for
obtaining and manipulating representations of fermionic and qubit Hamiltonians.
For more information, see the
[release paper](https://arxiv.org/abs/1710.07629).

## Plugins

OpenFermion relies on modular plugin libraries for significant functionality.
Specifically, plugins are used to simulate and compile quantum circuits and to
perform classical electronic structure calculations. Follow the links below to
learn more!

### Circuit compilation and simulation plugins

* [Forest-OpenFermion](https://github.com/rigetticomputing/forestopenfermion) to
  support integration with [Forest](https://www.rigetti.com/forest).
* [SFOpenBoson](https://github.com/XanaduAI/SFOpenBoson) to support integration
  with [Strawberry Fields](https://github.com/XanaduAI/strawberryfields).

### Electronic structure package plugins

* [OpenFermion-Psi4](http://github.com/quantumlib/OpenFermion-Psi4) to support
  integration with [Psi4](http://psicode.org).
* [OpenFermion-PySCF](http://github.com/quantumlib/OpenFermion-PySCF) to support
  integration with [PySCF](https://github.com/sunqm/pyscf).
* [OpenFermion-Dirac](https://github.com/bsenjean/Openfermion-Dirac) to support
  integration with [DIRAC](http://diracprogram.org/doku.php).

Except as otherwise noted, the content of this page is licensed under the [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/), and code samples are licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0). For details, see the [Google Developers Site Policies](https://developers.google.com/site-policies). Java is a registered trademark of Oracle and/or its affiliates.

Last updated 2024-04-26 UTC.

[[["Easy to understand","easyToUnderstand","thumb-up"],["Solved my problem","solvedMyProblem","thumb-up"],["Other","otherUp","thumb-up"]],[["Missing the information I need","missingTheInformationINeed","thumb-down"],["Too complicated / too many steps","tooComplicatedTooManySteps","thumb-down"],["Out of date","outOfDate","thumb-down"],["Samples / code issue","samplesCodeIssue","thumb-down"],["Other","otherDown","thumb-down"]],["Last updated 2024-04-26 UTC."],[],[]]

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