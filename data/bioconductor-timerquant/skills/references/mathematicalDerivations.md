Supplementary Methods - mathematical derivations

Joseph D. Barry, Erika Donà, Darren Gilmour, Wolfgang
Huber

Contents

1

2

3

4

5

6

Model definition .

Model solutions .

.

.

.

.

.

.

.

.

Timer ratio with FRET .

.

.

.

.

.

.

.

.

.

Time to reach steady state .

Timer signal .

.

.

.

.

.

.

.

Timer signal and FRET .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

2

2

3

3

1

Model definition

The fluorophore maturation kinetics was described as a one-step process. Each fluorescence
channel was modelled separately but due to tandem timer design each channel shared the same
constant protein production rate p and constant degradation rate k. The time-dependent
rate equations used are therefore
˙X 0
˙Xi(t) = miX 0

i (t) = p − (k + mi)X 0

i (t)
i (t) − kXi(t)

1

where X 0
i (t) and Xi(t) are the molecular populations of the non-mature and mature fluo-
rophore populations respectively at time t for the ith fluorescence channel with i ∈ {1, 2}.
We chose the convention that i = 1 is the fast-maturing fluorescence channel and i = 2 is
the slow-maturing fluorescence channel.

2

Model solutions

The time-dependent solutions to eq. 1 with the boundary conditions X 0
0 were calculated to be

i (0) = 0 and Xi(0) =

i (t) = p(1 − e−(k+mi)t)/(k + mi)

X 0
Xi(t) = pe−(k+mi)t(k − emit(k + mi − ektmi))/(k(k + mi)) .

The corresponding steady state solutions to eq. 2 are

limt→∞ X 0
i (t) = p/(k + mi)
limt→∞ Xi(t) = pmi/(k(k + mi)) .

2

3

Supplementary Methods - mathematical derivations

3

Timer ratio with FRET

Fluorescence intensity Ii is proportional to the number of mature fluorescent molecules Xi. If
FRET occurs between channel 1 and channel 2 the fluorescence intensity of channel 1 will be
reduced by an amount proportional to the FRET efficiency E and the proportion b of channel
2 fluorophores available as acceptors. In the time-dependent model this was described as

I1(t) = f1X1(t)(1 − b(t)E)
I2(t) = f2X2(t)

4

where the proportionality constant fi incorporates multiplicative effects such as fluorophore
brightness and quantum yield, and b(t) = X2(t)/(X 0
2 (t) + X2(t)). We did not consider
FRET from channel 2 to channel 1 since it is physiologically improbable to encounter such
cases as slower-maturing fluorophores tend to have longer wavelengths than faster-maturing
fluorophores.

The time-dependent timer ratio R incorporating FRET was defined as

R(t) = I2(t)/I1(t) = f X2(t)/(X1(t)(1 − b(t)E))

where f = f2/f1.

In full the the timer ratio is therefore

R(t) = f

e(m1−m2)t(k + m1)(k − em2t(k + m2 − ektm2))
(k − em1t(k + m1 − ektm1))(k + m2)(1 − E k−e−m2tk+m2−ektm2

(1−ekt)(k+m2)

)

, which in steady state reduces to

lim
t→∞

R(t) = f

m2(k + m1)
m1(k + m2 − Em2)

.

5

6

7

4

Time to reach steady state

The time to reach steady state for the ratio was determined from the kinetics of the slower
maturing fluorophore, FP2. Since FP2 is not affected by FRET from FP1 we may calculate
this either from the fluorescence intensity in eq. 4 or the molecular population in eq. 2. Here
we focus on the latter. We choose to define the time to reach steady-state as the point of
intersection chose the line tangent to the point of inflection and the steady state value (see
Fig. S4A) given by eq. 3. The time coordinate t∗ at the point of inflection was calculated
to be

The slope s of the tangent to the FP2 profile is given by

t∗ = (1/m2) log(1 + m2/k) .

s = pm2(1 + m2/k)k/m2 /(k + m2) .

8

9

Calculating the point of intersection between the tangent line and the steady state value led
to the following definition for the time to reach steady state, Tss.

Tss = 1/k + 1/(k + m2) + log(1 + m2/k)/m2

10

2

Supplementary Methods - mathematical derivations

5

Timer signal

The timer signal was defined between two protein half-lives, T A
. We considered the log fold-change between the corresponding timer ratios RB = I B
and RA = I A

1/2 where T B

1/2 and T B

1/2 > T A
1/2
2 /I B
1

2 /I A
1 .

To investigate the effect of background noise on our ability to detect differences in timer
signal we defined the following additive error model.

S = log2

(cid:18) I B
2 + ϵB
2
1 + ϵB
I B
1

(cid:30) I A
2 + ϵA
2
1 + ϵA
I A
1

(cid:19)

11

1 , ϵA

2 , ϵB

1 , ϵB

where ϵA
2 ∼ N (0, σ2) are independent. Computer simulations were used to obtain
an estimate of the population mean µS and standard deviation σS. From this we formed the
coefficient of variation term

CV = σS/µS .

12

6

Timer signal and FRET

To explain why an increase in FRET increases timer timer signal we considered timer signal
without additive noise and denoted timer signal without FRET (E = 0) as D0 and timer
signal with positive FRET (E > 0) as DE. We calculated that

DE/D0 = 1 +

1
D0

log2

(cid:19)

(cid:18) 1 − bAE
1 − bBE

13

where bA and bB are the proportions of FP2 fluorophores available as acceptors for the
shorter-living and longer-living proteins, respectively. Since the population of mature FP2
fluorophores is relatively more abundant for the long-living protein, bB > bA, which implies
that 1 − bBE < 1 − bAE. Therefore log2((1 − bAE)/(1 − bBE)) is a positive quantity and
eq. 13 is greater than one.

3

