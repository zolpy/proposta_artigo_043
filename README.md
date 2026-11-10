# proposta_artigo_043

<p align="center">
  <a href="#-português">🇧🇷 Português</a> |
  <a href="#-english">🇺🇸 English</a>
</p>

---

# 🇧🇷 Português

**Non-destructive prediction of leaf water potential in coffee by VIS-NIR spectroscopy using machine learning ensembles**

Este repositório contém o pipeline completo de pré-processamento, modelagem e análise estatística para a predição não destrutiva do potencial hídrico foliar (\(\Psi_w\)) em *Coffea arabica* L., utilizando espectroscopia de reflectância VIS-NIR (406–900 nm).

O pipeline foi desenvolvido para responder às revisões do manuscrito submetido à *Engineering Applications of Artificial Intelligence* (EAAI-26-21747), implementando as seguintes melhorias metodológicas em relação à versão originalmente submetida:

- **Validação Leave-One-Replicate-Out (LORO) de 4 folds:** avaliação com média e desvio padrão entre os folds.
- **Pipeline nested (sem vazamento de dados):** SNV, seleção de features (Extra Trees) e PCA são ajustados exclusivamente nos conjuntos de treinamento de cada fold.
- **Modelo final:** combinação ET+MLP (média das predições de Extra Trees e de um ensemble de 5 MLPs), alcançando R² = 0.7721 ± 0.0415 e RPD = 2.10.
- **Ablação de metadados:** comparação entre espectros, metadados isolados e fusão de dados, com intervalos de confiança de 95% via bootstrap em blocos.
- **Análise de resíduos:** avaliação por faixas de estresse hídrico (\(\Psi_w\) < −4 MPa, −4 a −2 MPa, −2 a −1 MPa e > −1 MPa).
- **Importância espectral direta:** importância por impureza do Extra Trees e permutation importance, substituindo a interpretação indireta das cargas do PCA.

## 📊 Resultados principais

| Modelo | R² (média ± DP) | RMSE (média ± DP) | MAE (média ± DP) | RPD (média ± DP) |
|---|---|---|---|---|
| **Blend ET+MLP (final)** | **0.7721 ± 0.0415** | **0.6221 ± 0.0455** | **0.4480 ± 0.0321** | **2.10 ± 0.13** |
| MLP (melhor individual) | 0.7637 ± 0.0632 | 0.6340 ± 0.0602 | 0.4576 ± 0.0405 | 2.06 ± 0.15 |
| Extra Trees | 0.7311 ± 0.0309 | 0.6754 ± 0.0423 | 0.4759 ± 0.0354 | 1.93 ± 0.10 |
| XGBoost | 0.6784 ± 0.0508 | 0.7657 ± 0.0551 | 0.5098 ± 0.0420 | 1.76 ± 0.12 |
| PLS (SNV spectra) | 0.5719 ± 0.0584 | 0.8610 ± 0.0621 | 0.6529 ± 0.0487 | 1.52 ± 0.09 |
| Baseline (ET, raw spectra) | 0.2577 ± 0.0332 | 1.1251 ± 0.0812 | 0.7903 ± 0.0654 | 1.16 ± 0.08 |

### Ablação de metadados (V4)

| Cenário | R² (IC 95%) | RPD |
|---|---|---|
| Espectro + metadados (mês + manejo) | **0.772 (0.655–0.837)** | 2.10 |
| Só espectro (sem metadados) | 0.602 (0.484–0.668) | 1.59 |
| Só metadados (mês + manejo) | 0.573 (0.438–0.640) | 1.53 |

A fusão de espectros e metadados apresenta desempenho superior ao uso isolado de cada fonte de informação (IC 95% das diferenças não inclui zero).

## 📁 Estrutura do repositório

<!-- Adicione aqui a estrutura de diretórios e arquivos do projeto. -->

---

# 🇺🇸 English

**Non-destructive prediction of leaf water potential in coffee by VIS-NIR spectroscopy using machine learning ensembles**

This repository contains the complete preprocessing, modeling, and statistical analysis pipeline for the non-destructive prediction of leaf water potential (\(\Psi_w\)) in *Coffea arabica* L. using VIS-NIR reflectance spectroscopy (406–900 nm).

The pipeline was developed to address the reviewers' comments on the manuscript submitted to *Engineering Applications of Artificial Intelligence* (EAAI-26-21747), implementing the following methodological improvements over the originally submitted version:

- **Four-fold Leave-One-Replicate-Out (LORO) validation:** model evaluation using the mean and standard deviation across folds.
- **Nested pipeline (leakage-free):** SNV, feature selection (Extra Trees), and PCA are fitted exclusively on the training data within each fold.
- **Final model:** ET+MLP blend (average of Extra Trees predictions and an ensemble of 5 MLPs), achieving R² = 0.7721 ± 0.0415 and RPD = 2.10.
- **Metadata ablation study:** comparison of spectral data, metadata alone, and data fusion, with 95% confidence intervals obtained through block bootstrap.
- **Residual analysis:** evaluation across water-stress ranges (\(\Psi_w\) < −4 MPa, −4 to −2 MPa, −2 to −1 MPa, and > −1 MPa).
- **Direct spectral importance:** Extra Trees impurity-based feature importance and permutation importance, replacing the indirect interpretation of PCA loadings.

## 📊 Main results

| Model | R² (mean ± SD) | RMSE (mean ± SD) | MAE (mean ± SD) | RPD (mean ± SD) |
|---|---|---|---|---|
| **ET+MLP Blend (final)** | **0.7721 ± 0.0415** | **0.6221 ± 0.0455** | **0.4480 ± 0.0321** | **2.10 ± 0.13** |
| MLP (best individual model) | 0.7637 ± 0.0632 | 0.6340 ± 0.0602 | 0.4576 ± 0.0405 | 2.06 ± 0.15 |
| Extra Trees | 0.7311 ± 0.0309 | 0.6754 ± 0.0423 | 0.4759 ± 0.0354 | 1.93 ± 0.10 |
| XGBoost | 0.6784 ± 0.0508 | 0.7657 ± 0.0551 | 0.5098 ± 0.0420 | 1.76 ± 0.12 |
| PLS (SNV spectra) | 0.5719 ± 0.0584 | 0.8610 ± 0.0621 | 0.6529 ± 0.0487 | 1.52 ± 0.09 |
| Baseline (ET, raw spectra) | 0.2577 ± 0.0332 | 1.1251 ± 0.0812 | 0.7903 ± 0.0654 | 1.16 ± 0.08 |

### Metadata ablation study (V4)

| Scenario | R² (95% CI) | RPD |
|---|---|---|
| Spectra + metadata (month + management) | **0.772 (0.655–0.837)** | 2.10 |
| Spectra only (without metadata) | 0.602 (0.484–0.668) | 1.59 |
| Metadata only (month + management) | 0.573 (0.438–0.640) | 1.53 |

The fusion of spectral data and metadata achieves superior performance compared with either information source used independently (the 95% confidence intervals of the differences do not include zero).

## 📁 Repository structure

<!-- Add the project directory and file structure here. -->

---

<p align="center">
  🇧🇷 Português | 🇺🇸 English
  <br>
  <sub>Research code and computational resources for reproducible scientific analysis.</sub>
</p>
