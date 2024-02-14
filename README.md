# exceptional behaviors in accidents will receive more social sympathy but will not receive any actual benefits

This repo contains the code and data to produce the following:

1) a paper which is a reproduction of Kutscher and Feldman (2019) 's paper, "The impact of past behaviour normality on regret: replication and extension of three experiments of the exceptionality effect" and 2) replications of the figures 1, 2, 3, 4 and table 1, 2 of this paper.

It is organised as follows:

inputs
- data - contains all the data files to be used for analysis and in the tables and figures
  - osf-past-normality-regret-replication-exp1-data - data for table 1, 2 and figure 1, 2, 3, 4
  - osf-past-normality-regret-replication-exp2-data-v2 - data for figure 3, 4
- literature
  - Kutscher &amp; Feldman 2019 CogEmo past behavior &amp; regret-exceptionality replication &amp; extension-w-supplement - the original paper of which we make a reproduction.
  
outputs

- paper
  - exceptional_behavior.pdf - the reproduction paper
  - exceptional_behavior.qmd - paper.Rmd - R markdown file to produce exceptional_behavior.pdf
  - references.bib - reference list for paper.pdf
  
replication

- plots - stores the replicated figures
  -figure1.png
  -figure2.png
  -figure3.png
  -figure4.png
- scripts - stores the code to replicate each of the figures.
  - fig1_replication.R
  - fig2_replication.R
  - fig3_replication.R
  - fig4_replication.R
  - tab1_replication.R
  - tab2_replication.R
  - tab3_replication.R
- tables - stores the replicated tables
  -table1.csv
  -table2.csv
  -table3.csv
  
## LLMs statement

Most of the code in the paper and in R markdown is written by ChatGPT. And all conversations I had with ChatGPT can be viewed from inputs/llm/usage.txt.
  
## Reproducibility

Download all files and open the R project exceptional-behavior.Rproj in R Studio.

To reproduce the paper, render to pdf exceptional_behavior.qmd found at outputs/exceptional_behavior.qmd.

To replicate a figure, run the corresponding R file stored in replication/scripts/fig{number}_replication.R. The output will be saved as an image in replication/plots/figure{number}.png .

To replicate a table, run the corresponding R file stored in replication/scripts/tab{number}_replication.R. The output will be saved as an image in replication/plots/tab{number}.csv .

The replication on the Social Science Reproduction Platform can be found at