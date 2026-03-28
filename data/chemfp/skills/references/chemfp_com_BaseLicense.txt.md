Chemfp Base License Agreement v1.3
30 April 2024
This is the default License Agreement for chemfp, a high-performance
similarity search tool for cheminformatics fingerprints. It applies to
anyone who has a copy of a pre-compiled chemfp distribution and who
did not purchase or otherwise acquire an alternate License Agreement
from Andrew Dalke Scientific AB ("Dalke Scientific") or its authorized
redistributors.
This License Agreement, which covers the chemfp source code, is
neither open source nor free software. It is a proprietary License
Agreement for software made available to you at no cost.
1. Reservation of Rights and Ownership
Chemfp is licensed, not sold. Dalke Scientific, its affiliates and
suppliers own and retain all right, title and interest in and to
chemfp, including all copyrights, patents, trade secret rights,
trademarks and other intellectual property rights therein, except as
explicitly described below or explicitly covered under another License
Agreement as stated in the relevant part of the source code.
The chemfp distribution is protected by Swedish copyright laws and
other intellectual property laws and international treaty provisions.
You may make copies for internal use of chemfp, including for use on
third-party hardware such as cloud providers, so long as the users of
chemfp are internal to your organization (i.e. employees,
contractors, interns, agents, and other persons under your control and
direction).
You may not distribute modified copies of chemfp, in whole or in part,
to any third party, nor may you rent, sublicense, or lease, with or
without consideration, chemfp to third parties. You further may not
use chemfp to act as a service bureau or application service provider
or use chemfp for commercial software hosting services.
In addition, you may not publish chemfp for others to use it in any
way that is against the law.
2. Other License Restrictions and Grants
If you develop software for internal use then you may use any chemfp
functionality, except that you may not use chemfp to:
- generate FPB files;
- create in-memory fingerprint arenas with more than
50,000 fingerprints;
- use the simarray functionality to process fingerprint
sets with more than 20,000 fingerprints, unless they
are licensed FPB files as described below;
- use other search methods on fingerprint arenas with more
than 50,000 fingerprints, unless they are licensed FPB
files as described below;
- perform Tversky searches;
- perform Tanimoto searches of FPS files with
more than 20 queries at a time.
In the interest of clarity, you are explicitly permitted to use
chemfp's "toolkit" API implementations, fingerprint type API
implementations, and "bitops" functions.
You may modify, reverse-engineer, decompile, or disassemble chemfp.
However, you may not do so for the purpose of circumventing the
license key system or circumventing any of the terms and restrictions
of this license or any other provision of law.
(Look, I know the license key is not hard to break - it's there to
keep honest people honest.)
Modifications must not remove relevant copyright statements and
license information.
Within the restrictions given above, you may use chemfp to validate the
accuracy of your fingerprint generation and search software, including
in the development of for-profit and commercial applications which may
be a direct competitor to chemfp.
Within the restrictions given above, you may use chemfp to generate
fingerprint data sets in FPS format for any internal use, and to
generate fingerprint data sets published at no cost for general public
download.
Within the restrictions given above, you may use chemfp for in-memory
Tanimoto searches of licensed FPB files that contain over 50,000
fingerprints. A licensed FPB file is an FPB file containing an
embedded access code authorized by Dalke Scientific.
3. Patent Grant
You are granted a non-exclusive, worldwide, royalty-free license to
any patents that Dalke Scientific may assert on this release of
chemfp.
If you bring a patent claim against Dalke Scientific or any of its
affliates or suppliers over patents that you claim are infringed by
any version of chemfp then your license to use chemfp is terminated as
of the date such litigation is filed.
4. Disclaimers and Limitation of Liability
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
NEITHER DALKE SCIENTIFIC NOR ITS AFFILIATES OR SUPPLIERS MAKE ANY
ASSURANCES WITH REGARD TO THE ACCURACY OF THE RESULTS OR OUTPUT THAT
DERIVES FROM ANY USE OF THIS SOFTWARE.
If your jurisdiction does not allow the exclusion or limitation of the
liability for consequential or incidental damages, then you may not
use chemfp.
NOTWITHSTANDING ANY DAMAGES THAT YOU MIGHT INCUR FOR ANY REASON
WHATSOEVER (INCLUDING, WITHOUT LIMITATION, ALL DAMAGES REFERENCED
ABOVE AND ALL DIRECT OR GENERAL DAMAGES), THE ENTIRE CUMULATIVE
LIABILITY OF DALKE SCIENTIFIC, ITS AFFILIATES AND ANY OF THEIR
SUPPLIERS, WHETHER IN CONTRACT (INCLUDING ANY PROVISION OF THIS
LICENSE AGREEMENT), TORT, OR OTHERWISE, AND YOUR EXCLUSIVE REMEDY FOR
ALL OF THE FOREGOING, SHALL BE LIMITED TO THE GREATER OF DIRECT
DAMAGES IN THE AMOUNT ACTUALLY PAID BY YOU FOR THE SOFTWARE AND/OR
SERVICES OR U.S.$5.00. THE FOREGOING LIMITATIONS, EXCLUSIONS, AND
DISCLAIMERS SHALL APPLY TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE
LAW, EVEN IF DALKE SCIENTIFIC, ITS AFFILIATES OR SUPPLIERS HAVE BEEN
ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND EVEN IF ANY REMEDY
FAILS ITS ESSENTIAL PURPOSE.
5. Your Warranty to Dalke Scientific
You warrant that all individuals having access to and/or using chemfp
will observe and perform all the terms and conditions of this License
Agreement. You shall use all reasonable efforts to see that employees,
agents, or other persons under your direction or control who have
access to and/or use the chemfp distribution abide by the terms and
conditions of this License Agreement. You shall, at your own expense,
promptly enforce the restrictions in this License Agreement against
any person who gains access to your copy of chemfp (i.e. the copy you
obtain upon agreeing to this License Agreement or any other lawful
copy you have made from such copy) with your permission or while your
employee or agent and who violates such restrictions, by instituting
and diligently pursuing all legal and equitable remedies against him
or her.
You agree to immediately notify Dalke Scientific in writing of any
misuse, misappropriation or unauthorized use of the chemfp
distribution that may come to your attention. If you authorize,
assist, encourage or facilitate another person or entity to take any
action related to the subject matter of this License Agreement, you
shall be deemed to have taken the action yourself. You agree to
defend, indemnify and hold harmless Dalke Scientific, its affiliates
and their suppliers from any and all claims resulting from or arising
out of any your, including any employee's or agent's (a) use or misuse
of chemfp, (b) violation of any law or the rights of any third party,
including but not limited to infringement or misappropriation of any
intellectual or proprietary rights of any third party, or (c) breach
of this License Agreement, including any breach of any warranty or
representation you make to Dalke Scientific.
6. Injunctive Relief
Because of the unique nature of chemfp, you understand and agree
that Dalke Scientific will suffer irreparable injury in the event you
fail to comply with any of the terms and conditions this License
Agreement and that monetary damages may be inadequate to compensate
Dalke Scientific for such breach. Accordingly, you agree that Dalke
Scientific will, in addition to any other remedies available to it at
law or in equity, be entitled to injunctive relief, without posting a
bond, to enforce the terms and conditions of this License Agreement.
7. Termination
You may terminate this License agreement at any time. Dalke Scientific
may immediately terminate this License Agreement if you breach any
representation, warranty, agreement or obligation contained or
referred to in this License Agreement. Upon termination, you must
dispose of chemfp and all copies or versions of chemfp.
The provisions of Sections 4, 5, 6, 7, and 8 shall survive
termination or expiration of this Agreement for any reason.
8. Venue
In any suit or other action to enforce any right or remedy under or
arising out of this License Agreement, the prevailing party shall be
entitled reasonable attorneys' fees together with expenses and costs
that such prevailing party incurs. This License Agreement shall be
governed by the laws Sweden, provided that Dalke Scientific may pursue
injunctive relief in any forum in order to protect intellectual
property rights. You consent to the personal jurisdiction of the
courts of such venue. This License Agreement will be binding upon, and
inure to the benefit of the parties and their respective successors
and assigns.
The failure by Dalke Scientific to enforce any provision of this
License Agreement shall in no way be construed to be a present or
future waiver of such provision nor in any way affect our right to
enforce such provision thereafter. All waivers by us must be in
writing to be effective. If you have not received a different license
agreement from Dalke Scientific or its authorized redistributors then
this License Agreement, together with any addendum or amendment
included with chemfp, is the complete agreement between Dalke
Scientific and you and supersedes all prior agreements, oral or
written, with respect to the subject matter hereof.
All communications and notices to be made or given pursuant to this
License Agreement shall be in the English language.
9. Copyright Notices
Copyright (c) 2010-2024 Andrew Dalke Scientific AB, Storgatan 50, 461 30
Trollhattan, Sweden. All rights reserved. Any rights not expressly
granted in this License Agreement are reserved.
Other copyright holders are:
- Kim Walisch,  (several popcount implementations,
under the MIT license)
- Python Software Foundation (the ascii\_buffer\_converter, the heap
functions, and more, under the Python license)
- Christopher Swenson, Vojtech Fried, Google Inc. et al. (the sort code
in sort.h, under the MIT license)
- Daniel Lemire, Nathan Kurz, Owen Kaser, et al. (the AVX2 popcount
implementation, under the Apache 2 license)
- Rational Discovery LLC, Greg Landrum, and Julie Penzotti (the MACCS
pattern definitions in rdmaccs.patterns and rdmaccs2.patterns)
- Sebastiano Vigna (the xoshiro256\*\* PRNG, contributed to the public
domain via the CC0 1.0 Universal (CC0 1.0) Public Domain Dedication)
- David Eppstein (the double to rational approximation function, under
the MIT license)
- Thomas Smith (the vendored version of prettyspecialmethods.py used
to generate the documentation, under the MIT license)
- Tom St Denis (the hash method used for license management, contributed
to the public domain via the Unlicense disclaimer)
10. CHANGES
NOTE: the version will not change if only the list of copyright
holders and authors is changed.
Version 1.0 (11 May 2020) original version
Version 1.1 (18 June 2020) cleaned up some of the wording.
Version 1.2 (4 February 2024) added information about licensed FPB
files.
Version 1.3 (30 April 2024) added the limit for simarray searches and
removed the copyright date range.