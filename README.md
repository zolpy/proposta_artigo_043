# proposta_artigo_043

**Non-destructive prediction of leaf water potential in coffee by VIS-NIR spectroscopy using machine learning ensembles**

Este repositório contém o pipeline completo de pré-processamento, modelagem e análise estatística para a predição não destrutiva do potencial hídrico foliar ($\Psi_w$) em *Coffea arabica* L. a partir de espectroscopia de reflectância VIS-NIR (406–900 nm).

O pipeline foi desenvolvido para responder às revisões do manuscrito submetido à *Engineering Applications of Artificial Intelligence* (EAAI-26-21747), e implementa as seguintes correções metodológicas em relação à versão submetida:

- **Validação Leave-One-Replicate-Out (LORO) de 4 folds**, com média ± desvio padrão entre folds.
- **Pipeline nested (sem vazamento)**: SNV, seleção de features (Extra Trees) e PCA são ajustados **exclusivamente nos folds de treinamento**.
- **Modelo final**: blend ET+MLP (média das predições de Extra Trees e de um ensemble de 5 MLPs), com R² = 0.7721 ± 0.0415 e RPD = 2.10.
- **Ablação de metadados** (espectro vs. só metadados vs. fusão), com intervalos de confiança de 95% via bootstrap em blocos.
- **Análise de resíduos** por faixa de estresse ($\Psi_w$ < −4 MPa, −4 a −2, −2 a −1, > −1 MPa).
- **Importância espectral direta** (importância por impureza do Extra Trees + permutation importance), substituindo a interpretação das cargas do PCA.

---

## 📊 Resultados principais

| Modelo | R² (média ± DP) | RMSE (média ± DP) | MAE (média ± DP) | RPD (média ± DP) |
|---|---|---|---|---|
| **Blend ET+MLP (final)** | **0.7721 ± 0.0415** | **0.6221 ± 0.0455** | **0.4480 ± 0.0321** | **2.10 ± 0.13** |
| MLP (melhor individual) | 0.7637 ± 0.0632 | 0.6340 ± 0.0602 | 0.4576 ± 0.0405 | 2.06 ± 0.15 |
| Extra Trees | 0.7311 ± 0.0309 | 0.6754 ± 0.0423 | 0.4759 ± 0.0354 | 1.93 ± 0.10 |
| XGBoost | 0.6784 ± 0.0508 | 0.7657 ± 0.0551 | 0.5098 ± 0.0420 | 1.76 ± 0.12 |
| PLS (SNV spectra) | 0.5719 ± 0.0584 | 0.8610 ± 0.0621 | 0.6529 ± 0.0487 | 1.52 ± 0.09 |
| Baseline (ET, raw spectra) | 0.2577 ± 0.0332 | 1.1251 ± 0.0812 | 0.7903 ± 0.0654 | 1.16 ± 0.08 |

**Ablação de metadados (V4):**

| Cenário | R² (IC 95%) | RPD |
|---|---|---|
| Espectro + metadados (mês + manejo) | **0.772** (0.655–0.837) | 2.10 |
| Só espectro (sem metadados) | 0.602 (0.484–0.668) | 1.59 |
| Só metadados (mês + manejo) | 0.573 (0.438–0.640) | 1.53 |

A fusão de espectro + metadados é **significativamente superior** a cada um isoladamente (IC 95% das diferenças não inclui zero).

---

## 📁 Estrutura do repositório
