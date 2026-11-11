# PTE-A234-data-
This repository contains computational data supporting the manuscript:

**Mechanism-Guided Recombination of Complementary Phosphotriesterase
Variants for Dual-Enantiomer Hydrolysis of A234**

Authors: Xiaoyuan Liu, Yuan Zhao, and Zexing Cao

Publication DOI: [DOI]

## 1. Study Overview

This study compares the binding modes and hydrolysis pathways of (R)-A234 and (S)-A234 in the phosphotriesterase variants GG1 and GG2 and evaluates the recombined variant GGM.

The analyses include molecular dynamics simulations, MM/GBSA binding energy calculations, residue energy decomposition, dynamic cross-correlation analysis, protein electric field projections, and QM/MM reaction-path calculations.

## 2. System Names

| System | Enzyme | Substrate | file name |
|--------|--------|-----------|-----------|
| GG1-S | GG1 | (S)-A234 | gg1s |
| GG1-R | GG1 | (R)-A234 | gg1r |
| GG2-S | GG2 | (S)-A234 | gg2s |
| GG2-R | GG2 | (R)-A234 | gg2r |
| GGM-S | GGM | (S)-A234 | ggms |
| GGM-R | GGM | (R)-A234 | ggmr |

## 3. Repository Contents

| Directory | Contents |
|-----------|----------|
| structures/ | Representative protein–substrate complex structures |
| md/ | MD trajectory, representative_structures, and analysis data |
| mmgbsa/ | Binding free energies and residue decomposition data |
| qmmm/ | QM/MM optimized structures, cartesian coordinates and energy data |
| electric_fields/ | Protein and residue electric field projection data and analysis data |
| dccm/ | Dynamic cross-correlation matrices |
| visualization/ | MATLAB scripts |

## 4. File Formats and Conventions

- PDB files contain protein–substrate complex structures.
- XYZ files contain Cartesian coordinates of the QM regions.
- CSV, XLSX and TXT files contain numerical analysis results.
- OPJU files contain plotting data and can be opened with Origin.
- M files contain plotting data and can be opened with MATLAB.

Cartesian coordinates and distances are reported in angstroms.
Reaction energies and binding free energies are reported in kcal/mol.
Electric fields are reported in MV/cm.

The positive electric field projection direction is defined from the substrate phosphorus atom toward the fluorine atom.

Residue numbering in datas follows chainA:1-329, chainB:330-658. 
Model residue 1 corresponds to residue 34 in the original crystal structure.
Residue labels in the manuscript follow the original crystal structure numbering.

## 5. Structure Files

Each structure file is labeled by system and calculation stage.
The accompanying file descriptions specify whether a structure is an initial model, an MD representative structure, or a QM/MM-optimized structure.

QM/MM structure labels are defined as follows:

- RC: reactant complex
- TS: transition state
- IM: intermediate
- P: product complex

XYZ files contain the QM region only and do not represent the complete protein–solvent system.

## 6. Numerical Data

### MM/GBSA

binding_energies/mmgbsa contains calculated binding free energies.
residue_decomposition/mmgbsa contains per-residue energy contributions.

### Electric Fields

electric_field_proj_total/electric_fields contains total electric field projections along the substrate P–F direction.
electric_field_proj_by_frame_residue/electric_fields contains electric field projections along the substrate P–F direction by frame and residues.

### Dynamic Cross-Correlation

CSV files/dccm contains dynamic cross-correlation matrices.

### QM/MM Reaction Profiles

energies/qmmm contains reaction-path energies include zero-point energy corrections.
optimized_structures/qmmm contains optimized structures of the reactant complexes, transition states, intermediates, and product complexes.
Cartesian coordinates/qmmm contains cartesian coordinates of the QM regions.
Relative energies are referenced to the corresponding reactant complex.

## 7. Mapping to Manuscript Figures and Tables

| Figure or table | Data files | Description |
|-----------------|------------|-------------|
| Figure 1 | structures/PDB files | Structures used to illustrate coordination mode of Zn and the mutation sites in GG1 and GG2. |
| Figure 2 | md/representative_structures/PDB files | Structures used to illustrate binding modes of substrate A234 in the PTE variants GG1 and GG2. |
| Figure 3 | mmgbsa/residue_decomposition/DAT files | Data used to illustrate contributions of key residues to A234 binding in GG1 and GG2. |
| Figure 4 | qmmm/optimized_structures/PDB files | Structures used to illustrate the optimized geometries of key species in GG1-S and GG2-R at the QM/MM level. |
| Figure 4 | qmmm/energies/energy correct.xlsx | Datas used to illustrate optimal relative energy profiles for GG1 and GG2. |
| Figure 5 | electric_fields/electric_field_proj_by_frame_residue/DAT files | Electric field distributions from mutated residues projected along the P→F across 1000 MD Trajectory Frames. |
| Figure 6 | visualization/matlab/GGM_mutation_sankey.m | Plot used to illustrate mechanism-Guided Selection of Mutations for GGM. |
| Figure 7 | md/representative_structures/PDB files | Structures used to illustrate binding modes of substrate A234 in GGM. |
| Figure 7 | mmgbsa/binding_energies/DAT files | Datas of binding free energies for GGM. |
| Figure 7 | md/pocket_analysis | Datas of active site pocket volumes for GGM. |
| Figure 8 | qmmm/optimized_structures/PDB files | Structures used to illustrate the optimized geometries of key species in GGM at the QM/MM level. |
| Figure 8 | qmmm/energies/energy correct.xlsx | Datas used to illustrate optimal relative energy profiles for GGM. |
| Figure 9 | dccm/CSV files | Datas used to illustrate dynamic correlations between mutated residues and the coordinating residues of the active site in GGM. |
| Table 1 | md/pocket_analysis | Datas of active site pocket volumes for parent systems. |
| Table 1 | mmgbsa/binding_energies/DAT files | Datas of binding free energies for parent systems. |
| Table 1 | electric_fields/electric_field_proj_total/DAT files | Datas of median electric field projection for parent systems. |
| Table 1 | qmmm/optimized_structures/PDB files | Angles measured by PyMOL for parent systems. |
| Table 2 | md/pocket_analysis | Datas of active site pocket volumes for GGM. |
| Table 2 | mmgbsa/binding_energies/DAT files | Datas of binding free energies for GGM. |
| Table 2 | electric_fields/electric_field_proj_total/DAT files | Datas of median electric field projection for GGM. |
| Table 2 | qmmm/optimized_structures/PDB files | Angles measured by PyMOL for GGM. |

## 8. Software

The calculations and analyses used the following software:

| Software | Version | Purpose | Access |
|----------|---------|---------|--------|
| AMBER | 18 | MD simulations and MM/GBSA calculations | https://ambermd.org/
| Gaussian | 09, Revision D.01 | Charge calculations | https://gaussian.com/
| ChemShell | 3.7.0 | QM/MM calculations | https://chemshell.org/
| ORCA | 4.2.0 | QM electronic structure calculations | https://orcaforum.kofo.mpg.de/
| DL_POLY | Bundled with ChemShell 3.7.0 | MM calculations within QM/MM | Included in the ChemShell installation used in this study
| H++ | Web server | Protonation-state assignment | http://biophysics.cs.vt.edu/H++
| AlphaTraj | 1.2 | Pocket analysis | https://github.com/dooo12332/AlphaTraj
| R | 4.4.3 | Dynamic cross-correlation analysis | https://www.r-project.org/
| MDAnalysis | 2.10.0 | Electric field analysis | https://www.mdanalysis.org/
| PyMOL | 3.1.5.1 | Molecular visualization | https://pymol.org/
| MATLAB | R2026b | Sankey visualization | https://www.mathworks.com/products/matlab.html
| Origin | 2026b | Plot visualization | https://www.originlab.com/
| ChemDraw | 19.0 | Structure visualization | https://revvitysignals.com/products/research/chemdraw

Software references and computational settings are provided in the manuscript. 
Third-party software is obtained from its respective developer, subject to applicable licensing terms.

## 9. Using the Files

Structure files can be inspected with molecular visualization software.
Numerical data can be read with standard spreadsheet or analysis tools.

## 10. Data Coverage

This repository includes:
- PDB structures for the six enzyme–substrate models: GG1-S, GG1-R, GG2-S, GG2-R, GGM-S, and GGM-R.
- MD analysis data, including pocket analysis, representative structures, RMSD results, and the data in `md/traj_1000/`.
- MM/GBSA binding energy results and per-residue energy decomposition data.
- QM/MM Cartesian coordinates, optimized structures, and reaction-path energy data.
- Protein electric field projection data by frame and residue, total electric field projection data, and an Origin project containing median field data and plots.
- Dynamic cross-correlation matrices.
- A MATLAB script for generating the GGM mutation-selection Sankey diagram.

This repository does not include:
Complete MD trajectories.
They are available from the corresponding authors upon reasonable request.

## 11. Citation

Please cite the associated manuscript when using these data.

[DOI]

## 12. License and Contact

License: 
The data are licensed under CC BY 4.0. Reanalysis is permitted with appropriate attribution. Any modifications must be clearly indicated, and modified datasets must not be represented as the original data provided by the authors.
Third-party materials remain subject to their original licenses.

For questions about the data, contact:

Yuan Zhao: zhaoyuan@henu.edu.cn
Zexing Cao: zxcao@xmu.edu.cn
