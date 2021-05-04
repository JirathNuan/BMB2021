setwd("D:/Google Drive/Thesis/BMB_2021/1_experiment/Evaluate")

# --------------- Create a confusion matrix ---------------------
source("src/calc_confusion_matrix.r")

evaluate("01_signalp_alone/signalp-alone_y_pred.tsv")
evaluate("02_deeploc_alone/deeploc-alone_y_pred.tsv")
evaluate("03_signalp-deeploc/signalp-deeploc_y_pred.tsv")

rm(evaluate)

# -----------Manipulate row names and merge data ------------------------------

sp_alone <- read.table("01_signalp_alone/signalp-alone_y_pred_evaluation_table.tsv", 
                       header = TRUE, sep="\t")
dl_alone <- read.table("02_deeploc_alone/deeploc-alone_y_pred_evaluation_table.tsv", 
                       header = TRUE, sep="\t")
sp_dl <- read.table("03_signalp-deeploc/signalp-deeploc_y_pred_evaluation_table.tsv", 
                    header = TRUE, sep="\t")


Methods <- c("SignalP_alone","Deeploc_alone","SignalP_Deeploc")
indices <- rbind(sp_alone,dl_alone,sp_dl)

indices <- rbind.data.frame(sp_alone,dl_alone,sp_dl, make.row.names = FALSE)
indices <- data.frame(Methods, indices)

rm(Methods, sp_alone, dl_alone, sp_dl)


# ----------------------------------------------------------------------
# --------------- Calculate FPRtm ---------------------

source("src/calc_fprtm.R")  # call function

# load dataset
dataset <- c("01_signalp_alone/signalp-alone_y_pred.tsv",
             "02_deeploc_alone/deeploc-alone_y_pred.tsv",
             "03_signalp-deeploc/signalp-deeploc_y_pred.tsv")

# declare blank variable
FPRtm <- NULL

# calculate FPRtm
for (i in 1:length(dataset)) {
  FPRtm[i] = calc_fprtm(dataset[i])
}

# as dataframe
FPRtm_df <- data.frame(FPRtm)

# Merge FPRtm to indices table
indices <- data.frame(indices, FPRtm_df)

rm(dataset, i, FPRtm, Methods, calc_fprtm,FPRtm_df)

# -------------------------------------------------------------------
# ---------------- Plot overall performance heatmap------------------
# -------------------------------------------------------------------
library(reshape2)
library(ggplot2)
library(hrbrthemes)

indices_melt <- melt(indices)
Methods <- c("SignalP_alone", "DeepLoc_alone", "SignalP_DeepLoc")

ggplot(indices_melt, aes(Methods, variable, fill= value, colour = "black")) + 
  geom_tile(colour="white",size=0.2) +
  geom_text(aes(label = round(value, 3)), size=3.5, color = "black")+
  # scale_fill_gradient(low="#d2e69c", high="#28b5b5")
  scale_fill_gradient(low="#E32600", high="#1BD1AD") +
  labs(x = "", y = "")
  

# Plot heatmap
source("plot_heatmap.R")

plot_heatmap("01_signalp_alone/signalp-alone_y_pred_confusion_matrix.tsv")
plot_heatmap("02_deeploc_alone/deeploc-alone_y_pred_confusion_matrix.tsv")
plot_heatmap("03_signalp-deeploc/signalp-deeploc_y_pred_confusion_matrix.tsv")


# --------------- FPRtm lollipop plot -----------------------

p_fprtm <- ggplot(FPRtm_df, aes(x=Methods, y=FPRtm)) +
  geom_segment( aes(x=Methods, xend=Methods, y=0, yend=1), 
                color="#233142", linetype = 2, size=0.5, alpha=0.7) +
  geom_point(color="#ff3434", size=15) +
  geom_text(aes(label = round(FPRtm, 3)), size=3.5, color = "black") +
  theme_light() +
  coord_flip()+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank())+
  labs(x = "", y = expression(FPR[TM]))

p_fprtm

# save plot
ggsave("Rplot_FPRtm.png",plot=p_fprtm, scale=1, 
       width=6, height=4, units="in", dpi=150)


# --------- lollipop plot of main indices in manuscript proceeding ------

main_indices <- indices %>% dplyr::select(Methods,Precision,Recall,F1,MCC)
  
main_indices_melt <- melt(main_indices)

palette <- c("#5F0F40","#9A031E","#0F4C5C","#5F0F40","#9A031E","#0F4C5C",
             "#5F0F40","#9A031E","#0F4C5C","#5F0F40","#9A031E","#0F4C5C")

p_main <- ggplot(main_indices_melt, aes(x=Methods, y=value)) +
  geom_segment(aes(x=Methods, xend=Methods, y=0, yend=value), 
                linetype= 8, size=0.4, alpha=0.9, color = palette) +
  geom_point(size=10, color = palette) +
  geom_text(aes(label = round(value, 3)), size=2.5, color = "white") +
  theme_grey() +
  coord_flip()+
  facet_wrap(~variable, nrow = 2, ncol = 2)+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank())+
  labs(x = "", y="")


p_main

ggsave("Figure_main_Precision-Recall-F1-MCC.pdf", p_main,
       width=8.5, height = 4.5, units = "in")
ggsave("Figure_main_Precision-Recall-F1-MCC.png", p_main,
       width=8.5, height = 4.5, units = "in")


rm(main_indices, main_indices_melt, palette, p_main)

# --------------------------- Plot detection rate and FDR ------------------------

library(tidyverse)
library(reshape2)

Det_Fdr <- indices %>% dplyr::select(Methods, Detection.Rate, False.Discovery.Rate)
Det_Fdr_melt <- melt(Det_Fdr)

palette <- c("#5F0F40","#9A031E","#0F4C5C","#5F0F40","#9A031E","#0F4C5C")


p_Det_Fdr <- ggplot(Det_Fdr_melt, aes(x=Methods, y=value)) +
  geom_segment(aes(x=Methods, xend=Methods, y=0, yend=value), 
               linetype= 8, size=0.4, alpha=0.9, color = palette) +
  geom_point(size=10, color = palette) +
  geom_text(aes(label = round(value, 3)), size=2.5, color = "white") +
  theme_grey() +
  coord_flip()+
  facet_wrap(~variable, ncol = 2)+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank())+
  labs(x = "", y="")

ggsave("Figure_DetectionRate-FalseDiscoveryRate.pdf", p_Det_Fdr, 
       width = 5.5, height = 4.0, units = "in")
ggsave("Figure_DetectionRate-FalseDiscoveryRate.png", p_Det_Fdr, 
       width = 7.5, height = 2.5, units = "in", scale = 1.15)

rm(p_Det_Fdr,palette, Det_Fdr, Det_Fdr_melt)


# -------------------------- Plot FRPTM -------------------------------------

FPRtm <- indices %>% dplyr::select(Methods, FPRtm)
FPRtm_melt <- melt(FPRtm)

palette <- c("#5F0F40","#9A031E","#0F4C5C")


p_FPRtm <- ggplot(FPRtm_melt, aes(x=Methods, y=value)) +
  geom_segment(aes(x=Methods, xend=Methods, y=0, yend=value), 
               linetype= 8, size=0.4, alpha=0.9, color = palette) +
  geom_point(size=10, color = palette) +
  geom_text(aes(label = round(value, 3)), size=2.5, color = "white") +
  theme_grey() +
  coord_flip()+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank())+
  labs(x = "", y=expression(FPR[TM]))

ggsave("Figure_FPRtm.pdf", p_FPRtm, 
       width = 5.5, height = 3.0, units = "in")
ggsave("Figure_FPRtm.png", p_FPRtm, 
       width = 5.5, height = 3.0, units = "in")

rm(p_FPRtm,palette, FPRtm, FPRtm_melt)


