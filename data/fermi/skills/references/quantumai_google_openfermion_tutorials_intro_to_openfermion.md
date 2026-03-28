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

# Introduction to OpenFermion

[![](https://quantumai.google/site-assets/images/buttons/quantumai_logo_1x.png)View on QuantumAI](https://quantumai.google/openfermion/tutorials/intro_to_openfermion) | [![](https://quantumai.google/site-assets/images/buttons/colab_logo_1x.png)Run in Google Colab](https://colab.research.google.com/github/quantumlib/OpenFermion/blob/main/docs/tutorials/intro_to_openfermion.ipynb) | [![](https://quantumai.google/site-assets/images/buttons/github_logo_1x.png)View source on GitHub](https://github.com/quantumlib/OpenFermion/blob/main/docs/tutorials/intro_to_openfermion.ipynb) | [![](https://quantumai.google/site-assets/images/buttons/download_icon_1x.png)Download notebook](https://storage.googleapis.com/tensorflow_docs/OpenFermion/docs/tutorials/intro_to_openfermion.ipynb) |

**Note:** The examples below must be run sequentially within a section.

## Setup

Install the OpenFermion package:

```
try:
    import openfermion
except ImportError:
    !pip install git+https://github.com/quantumlib/OpenFermion.git@main#egg=openfermion
```

## Initializing the FermionOperator data structure

Fermionic systems are often treated in second quantization where arbitrary operators can be expressed using the fermionic creation and annihilation operators, \(a^\dagger\_k\) and \(a\_k\). The fermionic ladder operators play a similar role to their qubit ladder operator counterparts, \(\sigma^+\_k\) and \(\sigma^-\_k\) but are distinguished by the canonical fermionic anticommutation relations, \(\{a^\dagger\_i, a^\dagger\_j\} = \{a\_i, a\_j\} = 0\) and \(\{a\_i, a\_j^\dagger\} = \delta\_{ij}\). Any weighted sums of products of these operators are represented with the FermionOperator data structure in OpenFermion. The following are examples of valid FermionOperators:

\[
\begin{align}
& a\_1 \nonumber \\
& 1.7 a^\dagger\_3 \nonumber \\
&-1.7 \, a^\dagger\_3 a\_1 \nonumber \\
&(1 + 2i) \, a^\dagger\_4 a^\dagger\_3 a\_9 a\_1 \nonumber \\
&(1 + 2i) \, a^\dagger\_4 a^\dagger\_3 a\_9 a\_1 - 1.7 \, a^\dagger\_3 a\_1 \nonumber
\end{align}
\]

The FermionOperator class is contained in \(\textrm{ops/\_fermion\_operator.py}\). In order to support fast addition of FermionOperator instances, the class is implemented as hash table (python dictionary). The keys of the dictionary encode the strings of ladder operators and values of the dictionary store the coefficients. The strings of ladder operators are encoded as a tuple of 2-tuples which we refer to as the "terms tuple". Each ladder operator is represented by a 2-tuple. The first element of the 2-tuple is an int indicating the tensor factor on which the ladder operator acts. The second element of the 2-tuple is Boole: 1 represents raising and 0 represents lowering. For instance, \(a^\dagger\_8\) is represented in a 2-tuple as \((8, 1)\). Note that indices start at 0 and the identity operator is an empty list. Below we give some examples of operators and their terms tuple:

\[
\begin{align}
I & \mapsto () \nonumber \\
a\_1 & \mapsto ((1, 0),) \nonumber \\
a^\dagger\_3 & \mapsto ((3, 1),) \nonumber \\
a^\dagger\_3 a\_1 & \mapsto ((3, 1), (1, 0)) \nonumber \\
a^\dagger\_4 a^\dagger\_3 a\_9 a\_1 & \mapsto ((4, 1), (3, 1), (9, 0), (1, 0)) \nonumber
\end{align}
\]

Note that when initializing a single ladder operator one should be careful to add the comma after the inner pair. This is because in python ((1, 2)) = (1, 2) whereas ((1, 2),) = ((1, 2),). The "terms tuple" is usually convenient when one wishes to initialize a term as part of a coded routine. However, the terms tuple is not particularly intuitive. Accordingly, OpenFermion also supports another user-friendly, string notation below. This representation is rendered when calling "print" on a FermionOperator.

\[
\begin{align}
I & \mapsto \textrm{""} \nonumber \\
a\_1 & \mapsto \textrm{"1"} \nonumber \\
a^\dagger\_3 & \mapsto \textrm{"3^"} \nonumber \\
a^\dagger\_3 a\_1 & \mapsto \textrm{"3^}\;\textrm{1"} \nonumber \\
a^\dagger\_4 a^\dagger\_3 a\_9 a\_1 & \mapsto \textrm{"4^}\;\textrm{3^}\;\textrm{9}\;\textrm{1"} \nonumber
\end{align}
\]

Let's initialize our first term! We do it two different ways below.

```
from openfermion.ops import FermionOperator

my_term = FermionOperator(((3, 1), (1, 0)))
print(my_term)

my_term = FermionOperator('3^ 1')
print(my_term)
```

```
1.0 [3^ 1]
1.0 [3^ 1]
```

The preferred way to specify the coefficient in openfermion is to provide an optional coefficient argument. If not provided, the coefficient defaults to 1. In the code below, the first method is preferred. The multiplication in the second method actually creates a copy of the term, which introduces some additional cost. All inplace operands (such as +=) modify classes whereas binary operands such as + create copies. Important caveats are that the empty tuple FermionOperator(()) and the empty string FermionOperator('') initializes identity. The empty initializer FermionOperator() initializes the zero operator.

```
good_way_to_initialize = FermionOperator('3^ 1', -1.7)
print(good_way_to_initialize)

bad_way_to_initialize = -1.7 * FermionOperator('3^ 1')
print(bad_way_to_initialize)

identity = FermionOperator('')
print(identity)

zero_operator = FermionOperator()
print(zero_operator)
```

```
-1.7 [3^ 1]
-1.7 [3^ 1]
1.0 []
0
```

Note that FermionOperator has only one attribute: .terms. This attribute is the dictionary which stores the term tuples.

```
my_operator = FermionOperator('4^ 1^ 3 9', 1. + 2.j)
print(my_operator)
print(my_operator.terms)
```

```
(1+2j) [4^ 1^ 3 9]
{((4, 1), (1, 1), (3, 0), (9, 0)): (1+2j)}
```

## Manipulating the FermionOperator data structure

So far we have explained how to initialize a single FermionOperator such as \(-1.7 \, a^\dagger\_3 a\_1\). However, in general we will want to represent sums of these operators such as \((1 + 2i) \, a^\dagger\_4 a^\dagger\_3 a\_9 a\_1 - 1.7 \, a^\dagger\_3 a\_1\). To do this, just add together two FermionOperators! We demonstrate below.

```
from openfermion.ops import FermionOperator

term_1 = FermionOperator('4^ 3^ 9 1', 1. + 2.j)
term_2 = FermionOperator('3^ 1', -1.7)
my_operator = term_1 + term_2
print(my_operator)

my_operator = FermionOperator('4^ 3^ 9 1', 1. + 2.j)
term_2 = FermionOperator('3^ 1', -1.7)
my_operator += term_2
print('')
print(my_operator)
```

```
-1.7 [3^ 1] +
(1+2j) [4^ 3^ 9 1]

-1.7 [3^ 1] +
(1+2j) [4^ 3^ 9 1]
```

The print function prints each term in the operator on a different line. Note that the line my\_operator = term\_1 + term\_2 creates a new object, which involves a copy of term\_1 and term\_2. The second block of code uses the inplace method +=, which is more efficient. This is especially important when trying to construct a very large FermionOperator. FermionOperators also support a wide range of builtins including, str(), repr(), ==, !=, \*=, \*, /, /=, +, +=, -, -=, - and \*\*. Note that since FermionOperators involve floats, == and != check for (in)equality up to numerical precision. We demonstrate some of these methods below.

```
term_1 = FermionOperator('4^ 3^ 9 1', 1. + 2.j)
term_2 = FermionOperator('3^ 1', -1.7)

my_operator = term_1 - 33. * term_2
print(my_operator)

my_operator *= 3.17 * (term_2 + term_1) ** 2
print('')
print(my_operator)

print('')
print(term_2 ** 3)

print('')
print(term_1 == 2.*term_1 - term_1)
print(term_1 == my_operator)
```

```
56.1 [3^ 1] +
(1+2j) [4^ 3^ 9 1]

513.9489299999999 [3^ 1 3^ 1 3^ 1] +
(-302.32289999999995-604.6457999999999j) [3^ 1 3^ 1 4^ 3^ 9 1] +
(-302.32289999999995-604.6457999999999j) [3^ 1 4^ 3^ 9 1 3^ 1] +
(-533.511+711.348j) [3^ 1 4^ 3^ 9 1 4^ 3^ 9 1] +
(9.161299999999999+18.322599999999998j) [4^ 3^ 9 1 3^ 1 3^ 1] +
(16.166999999999998-21.555999999999997j) [4^ 3^ 9 1 3^ 1 4^ 3^ 9 1] +
(16.166999999999998-21.555999999999997j) [4^ 3^ 9 1 4^ 3^ 9 1 3^ 1] +
(-34.87-6.34j) [4^ 3^ 9 1 4^ 3^ 9 1 4^ 3^ 9 1]

-4.912999999999999 [3^ 1 3^ 1 3^ 1]

True
False
```

Additionally, there are a variety of methods that act on the FermionOperator data structure. We demonstrate a small subset of those methods here.

```
from openfermion.utils import commutator, count_qubits, hermitian_conjugated
from openfermion.transforms import normal_ordered

# Get the Hermitian conjugate of a FermionOperator, count its qubit, check if it is normal-ordered.
term_1 = FermionOperator('4^ 3 3^', 1. + 2.j)
print(hermitian_conjugated(term_1))
print(term_1.is_normal_ordered())
print(count_qubits(term_1))

# Normal order the term.
term_2 = normal_ordered(term_1)
print('')
print(term_2)
print(term_2.is_normal_ordered())

# Compute a commutator of the terms.
print('')
print(commutator(term_1, term_2))
```

```
(1-2j) [3 3^ 4]
False
5

(1+2j) [4^] +
(-1-2j) [4^ 3^ 3]
True

(-3+4j) [4^ 3 3^ 4^] +
(3-4j) [4^ 3 3^ 4^ 3^ 3] +
(-3+4j) [4^ 3^ 3 4^ 3 3^] +
(3-4j) [4^ 4^ 3 3^]
```

## The QubitOperator data structure

The QubitOperator data structure is another essential part of openfermion. As the name suggests, QubitOperator is used to store qubit operators in almost exactly the same way that FermionOperator is used to store fermion operators. For instance \(X\_0 Z\_3 Y\_4\) is a QubitOperator. The internal representation of this as a terms tuple would be \(((0, \textrm{"X"}), (3, \textrm{"Z"}), (4, \textrm{"Y"}))\). Note that one important difference between QubitOperator and FermionOperator is that the terms in QubitOperator are always sorted in order of tensor factor. In some cases, this enables faster manipulation. We initialize some QubitOperators below.

```
from openfermion.ops import QubitOperator

my_first_qubit_operator = QubitOperator('X1 Y2 Z3')
print(my_first_qubit_operator)
print(my_first_qubit_operator.terms)

operator_2 = QubitOperator('X3 Z4', 3.17)
operator_2 -= 77. * my_first_qubit_operator
print('')
print(operator_2)
```

```
1.0 [X1 Y2 Z3]
{((1, 'X'), (2, 'Y'), (3, 'Z')): 1.0}

-77.0 [X1 Y2 Z3] +
3.17 [X3 Z4]
```

## Jordan-Wigner and Bravyi-Kitaev

openfermion provides functions for mapping FermionOperators to QubitOperators.

```
from openfermion.ops import FermionOperator
from openfermion.transforms import jordan_wigner, bravyi_kitaev
from openfermion.utils import hermitian_conjugated
from openfermion.lina