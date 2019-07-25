# Characterization of the HPIV 3 HN gene RNA secondary structure 

## Project Summary 
The HPIV-3 Hemaglutinin-neuraminidase (HN) is essential in viral release from cells by dissociating the mature virions from the neuraminic acid containing glycoproteins. Viral passage in cultural, although similar to replication in vivo, results in different nucleic acid mutations from replication. Selective 2'-hydroxyl acylation analyzed by primer extension and mutational profiling (SHAPE-MaP) permits accurate representation of RNA secondary structure at single nucleotide resolution. Here, we performed SHAPE chemistry on a clinical specimen from an individual infected with a high titer HPIV-3 to accurately model paramyxivirus RNA architecture in vivo at the HN gene.

## Methods 
### Wet-lab
#### RNA extraction & SHAPE preamble

RNA was extracted from a clinical nasal swab using magnetic bead technology on a MagNA Pure LC platform (Roche). Reverse transcription was performed on a 1.89 kb amplicon of the Hemaglutinin-neurominidase (HN) gene of HPIV-3 with a T7 promoter flanking the amplicon. After PCR amplification, DNA was purified via spin column DNA Clean & Concentrator-5 (Zymo) and eluted into RNase-free water. DNA was in vitro transcribed overnight using a MEGAscript T7 Transcription kit (Invitrogen). RNA was treated with 1 uL of Turbo DNase immediately after transcription for 15 min at 37◦C to remove original DNA template, and residual genomic DNA that may alter apparent mutation rates. RNA Clean and Concentrator-5 (Zymo) exploited spin column purification to remove unincorporated nucleotides and salts. 

|Primer| Sequence | Tm (C)| 
|------|----------|----|
|HPIV3-HN-T7-F|TAATACGACTCACTATAGGAGTAAAGTTACGCAACTCAA|60.5| 
|HPIV3-HN-R | TTTTTTATATTCCCTTTTTGTCTATTGTC|51.3| 
|Ecoli-16S-T7-F|TAATACGACTCACTATAGAAATTGAAGAGTTTGATCATGG| 59.0|
|Ecoli-16S_R|TAAGGAGGTGATCCAACCGC|56.9|

#### SHAPE experiment
Two control reactions, a denaturing and no-reagent standard (DMSO), were performed in parallel to account for background mutation rates of reverse transcription and naturally occurring RNA modification events. For the denaturing control, RNA was suspended in formamide and incubated at 95◦C prior to the modification step. Duly, to validate our experimental HPIV-3 HN RNA secondary structure, a positive control E. coli 16s rRNA from Orcinus orca (Melendez et al., 2019) was amplified and subjected to SHAPE modification. Modification was facilitated by nucleophilic attack by 10 mM 1-methyl-7-nitroisotoic anhydride solubalized in neat DMSO. 

The modified RNA was reverse transcribed with SuperScript II reverse transcriptase and 200 ng random nonamer primers to profile adduct-induced mutations. CDNA was subsequently purified with MicroSpin G-25 spin column (GE Healthcare) prior to randomer workflow library prep. Second strand synthesis (NEB) reactions transformed the modified cDNA into dsDNA and were spin column purified (Zymo), quantitated on Qubit 3.0 (Invitrogen), and adjusted to a concentration of 0.2 ng/uL for Nextera tagmentation and indexing PCR (Illumina). Size selection target capture and purification was executed with AMpure XP beads (Agencourt) at a 0.8:1.0 volumetric ratio of paramagnetic beads to sample library.

#### Sequencing 
After MaP and library construction, NGS sequencing was performed on the Illumina MiSeq Platform.

### In-silico 
Shapemapper 2 (https://github.com/Weeks-UNC/shapemapper2) was run on a 16 core Mac Pro running Ubuntu. Reads were adapter trimmed using Cutadapt before being organized into folders (positive, denatured control, negative) for subsequent Shapemapper2 and Superfold analyses. Default settings were used for Shapemapper2 as well as Superfold. Shapemapper2 commands for each run are found as .sh files in their respective folders and follow the general syntax in `shapemapper_general_command.sh`. 

![alt text](https://github.com/vpeddu/HPIV3-HN-secondary-structure/blob/master/prep_5_hpiv/results_prep5_hpiv_hpiv3_amplicon_from_s29.map_53a9/regions/region_prep5_hpiv_hpiv3_amplicon_from_s29.map_53a9_0001_1720.eps)
