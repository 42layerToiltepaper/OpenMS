//--------------------------------------------------------------------------
//                   OpenMS -- Open-Source Mass Spectrometry
// --------------------------------------------------------------------------
// Copyright The OpenMS Team -- Eberhard Karls University Tuebingen,
// ETH Zurich, and Freie Universitaet Berlin 2002-2023.
//
// This software is released under a three-clause BSD license:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//  * Neither the name of any author or any participating institution
//    may be used to endorse or promote products derived from this software
//    without specific prior written permission.
// For a full list of authors, refer to the file AUTHORS.
// --------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL ANY OF THE AUTHORS OR THE CONTRIBUTING
// INSTITUTIONS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// --------------------------------------------------------------------------
// $Maintainer: Kyowon Jeong$
// $Authors: Kyowon Jeong$
// --------------------------------------------------------------------------

#include <OpenMS/ANALYSIS/TOPDOWN/FLASHDeconvHelperStructs.h>
#include <OpenMS/ANALYSIS/TOPDOWN/PeakGroup.h>
#include <OpenMS/ANALYSIS/TOPDOWN/Qscore.h>
#include <iomanip>

namespace OpenMS
{
  float Qscore::getQscore(const PeakGroup* pg)
  {
    if (pg->empty())
    { // all zero
      return .0f;
    }
    // the weights for per cosine, SNR, PPM error, charge score, and intercept.
    // Cos    -8.9494
    // SNR    -2.2977
    // PPM error           0.3269
    // charge score        -3.1663
    // Intercept    12.3131
    // const std::vector<double> weights({-8.9494, -2.2977, 0.3269, -3.1663, 12.3131});
    const std::vector<double> weights({-2.2833, -3.2881, 0, 0, 4.5425});
    double score = weights.back();
    auto fv = toFeatureVector_(pg);

    for (Size i = 0; i < weights.size() - 1; i++)
    {
      score += fv[i] * weights[i];
    }
    float qscore = 1.0f / (1.0f + (float)exp(score));

    return qscore;
  }

  std::vector<double> Qscore::toFeatureVector_(const PeakGroup* pg)
  {
    std::vector<double> fvector(4); // length of weights vector - 1, excluding the intercept weight.

    double a = pg->getIsotopeCosine();
    double d = 1;
    int index = 0;
    fvector[index++] = (log2(a + d));

    a = pg->getSNR();
    fvector[index++] = (log2(d + a / (d + a)));

    a = pg->getAvgPPMError();
    fvector[index++] = (log2(d + a / (d + a)));

    a = pg->getChargeScore();
    fvector[index++] = (log2(a + d));

    return fvector;
  }
} // namespace OpenMS
