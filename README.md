# Characterizing the HPIV 3 HN gene RNA secondary structure 

## Project Summary 
The HPIV3 Hemaglutinin-neuraminidase (HN) is essential in viral release from cells by dissociating the mature virions from the neuraminic acid containing glycoproteins. (need to fill this part in) 

## Methods 
### Wet-lab
#### RNA extraction 

Reverse transcription on a 1.89 kb amplicon of the Hemaglutinin-neurominidase (HN) gene of HPIV-3. After PCR amplification, DNA was purified via spin column DNA Clean & Concentrator-5 and eluted into RNase-free water. DNA was in vitro transcribed using a MEGAscript T7 Transcription kit. RNA was treated with 1 uL of Turbo DNase immediately after transcription for 15 min at 37◦C to remove original DNA template, and residual genomic DNA that may alter apparent mutation rates. RNA Clean and Concentrator-5 exploited spin column purification to remove unincorporated nucleotides and salts. 

|Primer| Sequence | Tm (C)| 
|------|----------|----|
|HPIV3-HN-T7-|TAATACGACTCACTATAGGAGTAAAGTTACGCAACTCAA|60.5| 
|HPIV3-HN-R | TTTTTTATATTCCCTTTTTGTCTATTGTC|51.3| 
|Ecoli-16S-T7-F|TAATACGACTCACTATAGAAATTGAAGAGTTTGATCATGG| 59.0|
|Ecoli-16S_R|TAAGGAGGTGATCCAACCGC|56.9|

#### SHAPE experiment
Two control reactions, a denaturing and no-reagent standard (DMSO), were performed in parallel to account for background mutation rates of reverse transcription and naturally occurring RNA modification events. For the denaturing control, RNA was suspended in formamide and incubated at 95◦C prior to the modification step. Duly, to validate our experimental hPIV-3 HN RNA secondary structure, a positive control E. coli 16s rRNA from Orcinus orca (Melendez et al., 2019) was amplified and subjected to SHAPE modification.

The modified RNA was reverse transcribed with SuperScript II reverse transcriptase and 200 ng random nonamer primers to profile adduct-induced mutations. CDNA was subsequently purified with MicroSpin G-25 spin column prior to randomer workflow library prep. Second strand synthesis reactions transformed the modified cDNA into dsDNA and were spin column purified quantitated, and adjusted to a concentration of 0.2 ng/uL for Nextera tagmentation and indexing PCR. Size selection target capture and purification was executed with Agencourt AMpure XP beads at a 0.8:1.0 volumetric ratio of paramagnetic beads to sample library.

#### Sequencing 
After MaP and library construction, sequencing was performed on the Illumina MiSeq System

### In-silico 
Shapemapper 2 (https://github.com/Weeks-UNC/shapemapper2) was run on a 16 core Mac Pro running Ubuntu. Reads were adapter trimmed using Cutadapt before being organized into folders (positive, denatured control, negative) for subsequent Shapemapper2 and Superfold analyses. Default settings were used for Shapemapper2 as well as Superfold. Shapemapper2 commands for each run are found as .sh files in their respective folders and follow the general syntax in `shapemapper_general_command.sh`. 
