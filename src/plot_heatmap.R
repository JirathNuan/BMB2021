plot_heatmap <- function(dataset){
  
  library(reshape2)
  library(ggplot2)
  library(hrbrthemes)
  
  dt <- read.table(dataset, header = TRUE, sep="\t")  # load table
  
  
  # extract file name, for naming output and rowname
  f_name <- paste0(tools::file_path_sans_ext(dataset))
  
  p_hm <- ggplot(dt, aes(Prediction, Reference, fill= Freq)) + 
    geom_tile(colour="white",size=0.2) +
    geom_text(aes(label = round(Freq, 2)), size=5, color = "white")+
    scale_fill_gradient(low="#2b2e4a", high="#e84545") +
    labs(x = "Prediction", y = "Actual")
  
  # export heatmap
  ggsave(paste(f_name,"_heatmap.png"), p_hm, 
         width = 12, height = 8, units = "cm", scale = 1.5)
  return(paste("Finish, the result is located in ",f_name))
}

